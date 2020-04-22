Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2F4C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1EE2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552861;
	bh=emg9Yop65gmpV8WnaGAa6QGP//H+vngZqB0Pb/B/fdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ced4fpguwHBzeCyvHh6qbtSlsh68gPwBBuSSsDGvoFeYMcxkXcee/WAErzRKLC1E7
	 jZyYuJK8IkJLrG3PkNcIuZ8PObMGG5yjEvDRaZI/wG8EscjBmb7k+6noY5OhS2iiS7
	 iQYYqeLIpvyN7nf7nhjKxVWH/IOD+XpIUkrOCQgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgDVKIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbgDVKH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:07:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9745B20575;
        Wed, 22 Apr 2020 10:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550077;
        bh=emg9Yop65gmpV8WnaGAa6QGP//H+vngZqB0Pb/B/fdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ANKtH0AS9qr8Q3cD2KwLuFGf9ekgA7cA8bQR09t+RF3N3SKLxJWtGaW1ulLN0VxSD
         Dnew1n/tVzBHOvx9uQ+Z4HGs4lxWAh1ko4znxXqMXlaFlvHGo3CnMdLG3erK3joCti
         ZPZoZZ3YN63Tl0iVOXqfPpWS2jwjsrtar/+MZEpg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Samuel Neves <sneves@dei.uc.pt>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Nobuhiro Iwamatsu (CIP)" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 4.9 125/125] x86/vdso: Fix lsl operand order
Date:   Wed, 22 Apr 2020 11:57:22 +0200
Message-Id: <20200422095052.541251374@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
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
@@ -92,7 +92,7 @@ static inline unsigned int __getcpu(void
 	 *
 	 * If RDPID is available, use it.
 	 */
-	alternative_io ("lsl %[p],%[seg]",
+	alternative_io ("lsl %[seg],%[p]",
 			".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
 			X86_FEATURE_RDPID,
 			[p] "=a" (p), [seg] "r" (__PER_CPU_SEG));


