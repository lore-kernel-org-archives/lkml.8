Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6DDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0993207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597931149;
	bh=/pAvMKa+8PzqG9VMQ//rGLClT6PLL9jtalg44Ovo9+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fD+Qrst9umIBRHsH6SQWDGf2w9vPDnwqLtvybrHDo1zDj15hR9F/K8jsvx7Skej5u
	 xeKuKJCkZj+NPBkaxHoaTtMQTvUV9fOdb0XiMW3S65e0TglqexAUQ+KB1gPIftHWje
	 1bTmNlsdk1lD6KNtlpIvHBlX+6SuTHchyXbRVo2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgHTNpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:45:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgHTJ1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:27:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8378B22D06;
        Thu, 20 Aug 2020 09:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915665;
        bh=/pAvMKa+8PzqG9VMQ//rGLClT6PLL9jtalg44Ovo9+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QVZU1qKHy+71+1+A4dMuopodEsCbHenhaEV62JJxQ9+Dqyb5k8eR1DdlgLJQHuM10
         I56gLS1diSM6dZmQJawjS/83meUliwnS//uMmmg2YrDUMdFJSgr7w0o10jlYgY/Nqo
         nifsTJn49sP+912Lz6kNQqX99denlmeS1wGPyN9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.8 063/232] selftests/seccomp: Set NNP for TSYNC ESRCH flag test
Date:   Thu, 20 Aug 2020 11:18:34 +0200
Message-Id: <20200820091615.845518621@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit e4d05028a07f505a08802a6d1b11674c149df2b3 upstream.

The TSYNC ESRCH flag test will fail for regular users because NNP was
not set yet. Add NNP setting.

Fixes: 51891498f2da ("seccomp: allow TSYNC and USER_NOTIF together")
Cc: stable@vger.kernel.org
Reviewed-by: Tycho Andersen <tycho@tycho.ws>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/seccomp/seccomp_bpf.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3258,6 +3258,11 @@ TEST(user_notification_with_tsync)
 	int ret;
 	unsigned int flags;
 
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
 	/* these were exclusive */
 	flags = SECCOMP_FILTER_FLAG_NEW_LISTENER |
 		SECCOMP_FILTER_FLAG_TSYNC;


