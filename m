Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5BCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A0F420738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQ5kqT5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbgFWAQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:16:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28039 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731515AbgFWAPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592871354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J7HNJTlk13FVbVYXxMgg61ehL9LTKqH1Bt/QRg8bcjI=;
        b=KQ5kqT5UVdMNAv2QOUktglJ48NsOuZ+m2j110c7DD/fWebcWmbdUSnIg5TTYlCLF1bPC7x
        3nxZ9YZxgebt+K5mb0nZFp2FSuDa+K1LBdbMLug0ZNCfNW+/saCSndX9LLTfYC4bYbSrJB
        e5MAJTJyHaPaOLE6okyAmfEOwQvNL54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-FI_f-5zINEKjNPw_lWEEwg-1; Mon, 22 Jun 2020 20:15:50 -0400
X-MC-Unique: FI_f-5zINEKjNPw_lWEEwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB0B9805EE1;
        Tue, 23 Jun 2020 00:15:49 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D1A260BEC;
        Tue, 23 Jun 2020 00:15:49 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/6] selftests: breakpoints: fix computation of test plan
Date:   Mon, 22 Jun 2020 20:15:43 -0400
Message-Id: <20200623001547.22255-3-pbonzini@redhat.com>
In-Reply-To: <20200623001547.22255-1-pbonzini@redhat.com>
References: <20200623001547.22255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The computation of the test plan uses the available_cpus bitset
before calling sched_getaffinity to fill it in.  The resulting
plan is bogus, fix it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../selftests/breakpoints/step_after_suspend_test.c       | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index b3ead29c6089..983ee6182e25 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -183,6 +183,10 @@ int main(int argc, char **argv)
 		}
 	}
 
+	err = sched_getaffinity(0, sizeof(available_cpus), &available_cpus);
+	if (err < 0)
+		ksft_exit_fail_msg("sched_getaffinity() failed\n");
+
 	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
 		if (!CPU_ISSET(cpu, &available_cpus))
 			continue;
@@ -193,10 +197,6 @@ int main(int argc, char **argv)
 	if (do_suspend)
 		suspend();
 
-	err = sched_getaffinity(0, sizeof(available_cpus), &available_cpus);
-	if (err < 0)
-		ksft_exit_fail_msg("sched_getaffinity() failed\n");
-
 	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
 		bool test_success;
 
-- 
2.26.2


