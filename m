Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FE1C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B572076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587553167;
	bh=bjvnJTPPAmrWn7sTp40MNKJPn2kc6bhnn19g0wsb8I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lAKAVHZh7CmaA/KM6+WbFfXb/TMEMIXXN6sh/mgWvU8G2T4mlyLNyOwt3Vqf+b62u
	 T9nEko4oYDBeLSsCPIDJzrOzFXzB9rP1+fR4PAOGxQCe9GcYMzyG7MnJsVfJUyPvPi
	 xY6pMaOYV/Ll+1xzy/wIg4e18rIsZcfbrDQEFBx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbgDVK71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbgDVKC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:02:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A33F920774;
        Wed, 22 Apr 2020 10:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549776;
        bh=bjvnJTPPAmrWn7sTp40MNKJPn2kc6bhnn19g0wsb8I0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=16ycsSAgHz9vFCdBDZ36wYFRFrVQsDMiVqwrcyuzKHfbBLIfQhDvV0vNCSTlUsVGl
         jsNLdZ/PZFfoYsmpb6h2aXRLItls05ZyHFfyRa3qmdU2vGzS7llomTmvUCjFZuYb9Z
         hoCvzFcW+b92HtCqLhPuRheN2o5RFHn1m60l3soM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Samuel Neves <sneves@dei.uc.pt>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Nobuhiro Iwamatsu (CIP)" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 4.4 100/100] x86/vdso: Fix lsl operand order
Date:   Wed, 22 Apr 2020 11:57:10 +0200
Message-Id: <20200422095040.834180030@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095022.476101261@linuxfoundation.org>
References: <20200422095022.476101261@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Neves <sneves@dei.uc.pt>

commit e78e5a91456fcecaa2efbb3706572fe043766f4d upstream.

In the __getcpu function, lsl is using the wrong target and destination
registers. Luckily, the compiler tends to choose %eax for both variables,
so it has been working so far.

Fixes: a582c540ac1b ("x86/vdso: Use RDPID in preference to LSL when available")
Signed-off-by: Samuel Neves <sneves@dei.uc.pt>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180901201452.27828-1-sneves@dei.uc.pt
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/vgtod.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -86,7 +86,7 @@ static inline unsigned int __getcpu(void
 	 *
 	 * If RDPID is available, use it.
 	 */
-	alternative_io ("lsl %[p],%[seg]",
+	alternative_io ("lsl %[seg],%[p]",
 			".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
 			X86_FEATURE_RDPID,
 			[p] "=a" (p), [seg] "r" (__PER_CPU_SEG));


