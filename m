Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CB6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C7E3207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597928721;
	bh=hxnkYDokfMdzD7JcjugJExZde+jyPY1bN80LzIM4ZMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MdoAWuJHNGnr4a3gQYucylR5mNsjDtiJEe3zYdyktF35lM00XeETsTy9bcjrvEZyc
	 zcZ7UhUNjyIoCHZZCojCgJibRW7A4SC2aMca7x4ooWjG12Yla2ti/7ZSeBGanVJytE
	 zw/HIOlhFH/TmyilhRcBJ8B4LMVaREqlL1qztBkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgHTNFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728934AbgHTJjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:39:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CC15207DE;
        Thu, 20 Aug 2020 09:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916346;
        bh=hxnkYDokfMdzD7JcjugJExZde+jyPY1bN80LzIM4ZMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GRkWixXCdgpsKk3HiNQW0dT0JAvfdC6wg5gowj+Lv56DSml6T8yEhvmqI3PhZU7so
         VoUDtbhl4zxNjXwDosXKYYy75whvcrnnaV5/hFRXMCFTRPDy/u8xvdVNFS9CQHAUWB
         PF1sy0JHecwG28yG67QFO9sZEf7y4TGNImZ//QDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.7 057/204] selftests/seccomp: Set NNP for TSYNC ESRCH flag test
Date:   Thu, 20 Aug 2020 11:19:14 +0200
Message-Id: <20200820091609.117503211@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
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
@@ -3257,6 +3257,11 @@ TEST(user_notification_with_tsync)
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


