Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10545C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D427E206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596212820;
	bh=He4lRX7qUXd0rGaWvtl8uJvJvotCXPBWhv6zQbIkFB0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NRq6XIBcocu/kvL5KJyAComm6h/REJ8166AxkmOZaRojfIn1rbp5BvTa9F0gS6jlu
	 gK7ZwfHsM1UlZkUSFRW/fiHrvKVw/PI+87sn5R6ckiojxr8HjHOkL8GeS9y04+tceT
	 kyf54Dx+LhEhkkfku3K5PU/yhm8iCyJ9bC83gx+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgGaQ07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgGaQ06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:26:58 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E971206FA;
        Fri, 31 Jul 2020 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596212818;
        bh=He4lRX7qUXd0rGaWvtl8uJvJvotCXPBWhv6zQbIkFB0=;
        h=Date:From:To:Cc:Subject:From;
        b=M0WSFCpKAnhA83bM/pdqVZiLzksxw8fZkLYMLVh91oELvbLa269Is2w3Ji9ubiM4E
         q2L3WvQSStBBHzAfuR81x+wGAPiHadf03qkNLP22jruzQPbhfDJZpiDUeRfYVrYKaV
         s1SuXQYoQ3DR4M1xutQpfYxNcVUk3890SiA6HDig=
Date:   Fri, 31 Jul 2020 11:33:01 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Vivien Didelot <vivien.didelot@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] vim: linux-kernel: Increase columns highlighting to 100+
Message-ID: <20200731163301.GA8004@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase columns highlighting to 100+ once the 80-column warning has
been deprecated in the Linux kernel[1].

[1] commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 plugin/linuxsty.vim | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugin/linuxsty.vim b/plugin/linuxsty.vim
index 6f7e331..c42ce72 100644
--- a/plugin/linuxsty.vim
+++ b/plugin/linuxsty.vim
@@ -62,7 +62,7 @@ function s:LinuxFormatting()
     setlocal tabstop=8
     setlocal shiftwidth=8
     setlocal softtabstop=8
-    setlocal textwidth=80
+    setlocal textwidth=100
     setlocal noexpandtab
 
     setlocal cindent
@@ -80,7 +80,7 @@ function s:LinuxHighlighting()
     highlight default link LinuxError ErrorMsg
 
     syn match LinuxError / \+\ze\t/     " spaces before tab
-    syn match LinuxError /\%>80v[^()\{\}\[\]<>]\+/ " virtual column 81 and more
+    syn match LinuxError /\%>100v[^()\{\}\[\]<>]\+/ " virtual column 101 and more
 
     " Highlight trailing whitespace, unless we're in insert mode and the
     " cursor's placed right after the whitespace. This prevents us from having
-- 
2.27.0

