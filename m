Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBB9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFF720773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDiO+MQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgGGPje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:39:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55290 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728194AbgGGPjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594136372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FPhWDidqUrnci+8BE71byY1AwL1fK/CPWGk94AdbSks=;
        b=PDiO+MQS3pb85e0JNaHooFBkk4sLwmfCrit8hivecpfjLMrOj5UL9lNh/XFG2Q4mPWDMZV
        EjUc+pZAYwVXgkKJmVH5w+VPVaBlSgnhdtONDeKOOQTOygBXW6A0+iPpsmayrGggEHAmuD
        QCFW3Rx3zMzU6wMPGSHBDEC7/4G8X7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-l90xX1oEOS22Tj3JA7CcUg-1; Tue, 07 Jul 2020 11:39:30 -0400
X-MC-Unique: l90xX1oEOS22Tj3JA7CcUg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 604B0800401;
        Tue,  7 Jul 2020 15:39:29 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBC3410013D7;
        Tue,  7 Jul 2020 15:39:28 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     christian@brauner.io, shuah@kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v4 2/2] selftests: pidfd: skip test if unshare fails with EPERM
Date:   Tue,  7 Jul 2020 11:39:27 -0400
Message-Id: <20200707153927.12802-3-pbonzini@redhat.com>
In-Reply-To: <20200707153927.12802-1-pbonzini@redhat.com>
References: <20200707153927.12802-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to how ENOSYS causes a skip if pidfd_send_signal is not present,
we can do the same for unshare if it fails with EPERM.  This way, running
the test without privileges causes four tests to skip but no early bail out.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
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

