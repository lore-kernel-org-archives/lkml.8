Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC134C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D10920738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jz1lUveW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbgFWAQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:16:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47892 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731536AbgFWAPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592871354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O11bai/WfxTMD0Tokzy2Pw6ubRFmjw4OTVAKl7T1ggw=;
        b=Jz1lUveWTNunvbnY+bJrzHUJUJ1gESxkk1FlDWO9ZSIJExj7wdnobd8kii4eCgOQkRun3U
        WzCfHCxx+KxXnY77OHwIecNqAsbBYfgI7j8+fBjvyERZnBKI+z+5S2IS7ajnbPL2gHs8gm
        DXjORTbvmNqKk9DJU+4GvfiVzWBTLiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372--XcLyiNbOY2WktSFxKBTyQ-1; Mon, 22 Jun 2020 20:15:52 -0400
X-MC-Unique: -XcLyiNbOY2WktSFxKBTyQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 925511005512;
        Tue, 23 Jun 2020 00:15:51 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23F7E60BEC;
        Tue, 23 Jun 2020 00:15:51 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 5/6] selftests: sigaltstack: do not use ksft_exit_skip after ksft_set_plan
Date:   Mon, 22 Jun 2020 20:15:46 -0400
Message-Id: <20200623001547.22255-6-pbonzini@redhat.com>
In-Reply-To: <20200623001547.22255-1-pbonzini@redhat.com>
References: <20200623001547.22255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling ksft_exit_skip after ksft_set_plan results in executing fewer tests
than planned.  Use ksft_test_result_skip when possible, or just bail out if
memory corruption is detected.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/sigaltstack/sas.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
index ad0f8df2ca0a..8934a3766d20 100644
--- a/tools/testing/selftests/sigaltstack/sas.c
+++ b/tools/testing/selftests/sigaltstack/sas.c
@@ -71,7 +71,7 @@ void my_usr1(int sig, siginfo_t *si, void *u)
 	swapcontext(&sc, &uc);
 	ksft_print_msg("%s\n", p->msg);
 	if (!p->flag) {
-		ksft_exit_skip("[RUN]\tAborting\n");
+		ksft_exit_fail_msg("[RUN]\tAborting\n");
 		exit(EXIT_FAILURE);
 	}
 }
@@ -144,7 +144,7 @@ int main(void)
 	err = sigaltstack(&stk, NULL);
 	if (err) {
 		if (errno == EINVAL) {
-			ksft_exit_skip(
+			ksft_test_result_skip(
 				"[NOTE]\tThe running kernel doesn't support SS_AUTODISARM\n");
 			/*
 			 * If test cases for the !SS_AUTODISARM variant were
-- 
2.26.2


