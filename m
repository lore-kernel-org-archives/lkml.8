Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F773C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7826A2065F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NosxYRu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgGGKWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:22:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24353 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728149AbgGGKTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594117182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xfEXOl5JDAHiuWzCx5YNFPGjR852TJKcIIA0Lm3L8Rg=;
        b=NosxYRu38u2qcweele0Xvyk10Yunyjkl+yxgj8uAz6sD4qRRHFSOCqnn7YSX7AyZi6x8f0
        EtjjRwOfqRE4ARaA0aN9LLXOcSKHhPyIp92D3zDbVllRzKIpMk45Lg/60toahPZ01jXxjz
        T7GibYSwOk83KHMwUx/8TDjT9f+O/LA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-u2R3ELclMs6Q9hL0ffEEnA-1; Tue, 07 Jul 2020 06:19:40 -0400
X-MC-Unique: u2R3ELclMs6Q9hL0ffEEnA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00C96800C64;
        Tue,  7 Jul 2020 10:19:39 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DDD1275E47;
        Tue,  7 Jul 2020 10:19:38 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     christian@brauner.io, shuah@kernel.org
Subject: [PATCH v3 2/2] selftests: pidfd: skip test if unshare fails with EPERM
Date:   Tue,  7 Jul 2020 06:19:36 -0400
Message-Id: <20200707101936.12052-3-pbonzini@redhat.com>
In-Reply-To: <20200707101936.12052-1-pbonzini@redhat.com>
References: <20200707101936.12052-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to how ENOSYS causes a skip if pidfd_send_signal is not present,
we can do the same for unshare if it fails with EPERM.  This way, running
the test without privileges causes four tests to skip but no early bail out.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/pidfd/pidfd_test.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index f65ad4e32353..dcc86e8f7a9f 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -162,15 +162,26 @@ static int test_pidfd_send_signal_recycled_pid_fail(void)
 	}
 
 	ret = unshare(CLONE_NEWPID);
-	if (ret < 0)
+	if (ret < 0) {
+		if (errno == EPERM) {
+			ksft_test_result_skip("%s test: Unsharing pid namespace not permitted\n",
+					      test_name);
+			return 0;
+		}
 		ksft_exit_fail_msg("%s test: Failed to unshare pid namespace\n",
 				   test_name);
+	}
 
 	ret = unshare(CLONE_NEWNS);
-	if (ret < 0)
-		ksft_exit_fail_msg(
-			"%s test: Failed to unshare mount namespace\n",
-			test_name);
+	if (ret < 0) {
+		if (errno == EPERM) {
+			ksft_test_result_skip("%s test: Unsharing mount namespace not permitted\n",
+					      test_name);
+			return 0;
+		}
+		ksft_exit_fail_msg("%s test: Failed to unshare mount namespace\n",
+				   test_name);
+	}
 
 	ret = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
 	if (ret < 0)
-- 
2.26.2

