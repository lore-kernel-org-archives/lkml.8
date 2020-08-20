Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357D4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 199C82087D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgHTWA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgHTWAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:00:52 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AACFC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:00:52 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4BXdrD3wFDz1rt4M;
        Fri, 21 Aug 2020 00:00:44 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4BXdrD1vjSz1qw6h;
        Fri, 21 Aug 2020 00:00:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Ym_BFar1tcee; Fri, 21 Aug 2020 00:00:43 +0200 (CEST)
X-Auth-Info: AaAWNRy8nwRPJM7jJzxHA0w20Zi5hogQa4/6xekBaI6YU6fk6AqWnGyPEgtqCrsv
Received: from igel.home (ppp-46-244-162-139.dynamic.mnet-online.de [46.244.162.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 21 Aug 2020 00:00:43 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id BDB002C28BC; Fri, 21 Aug 2020 00:00:42 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] powerpc/32s: Only leave NX unset on segments
 used for modules
References: <cover.1593428200.git.christophe.leroy@csgroup.eu>
        <7172c0f5253419315e434a1816ee3d6ed6505bc0.1593428200.git.christophe.leroy@csgroup.eu>
X-Yow:  ..Wait 'til those  ITALIAN TEENAGERS get back to their HONDAS &
 discover them to be FILLED to the BRIM with MAZOLA!!
Date:   Fri, 21 Aug 2020 00:00:42 +0200
In-Reply-To: <7172c0f5253419315e434a1816ee3d6ed6505bc0.1593428200.git.christophe.leroy@csgroup.eu>
        (Christophe Leroy's message of "Mon, 29 Jun 2020 11:15:22 +0000
        (UTC)")
Message-ID: <87eeo1kmet.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 29 2020, Christophe Leroy wrote:

> Instead of leaving NX unset on all segments above the start
> of vmalloc space, only leave NX unset on segments used for
> modules.

I'm getting this crash:

kernel tried to execute exec-protected page (f294b000) - exploit attempt (uid: 0)
BUG: Unable to handle kernel instruction fetch
Faulting instruction address: 0xf294b000
Oops: Kernel access of bad area, sig: 11 [#1]
BE PAGE_SIZE=4K MMU=Hash PowerMac
Modules linked in: pata_macio(+)
CPU: 0 PID: 87 Comm: udevd Not tainted 5.8.0-rc2-test #49
NIP:  f294b000 LR: 0005c60 CTR: f294b000
REGS: f18d9cc0 TRAP: 0400  Not tainted  (5.8.0-rc2-test)
MSR:  10009032 <E,ME,IR,DR,RI>  CR: 84222422  XER: 20000000
GPR00: c0005c14 f18d9d78 ef30ca20 00000000 ef0000e0 c00993d0 ef6da038 0000005e
GPR08: c09050b8 c08b0000 00000000 f18d9d78 44222422 10072070 00000000 0fefaca4
GPR16: 1006a00c f294d50b 00000120 00000124 c0096ea8 0000000e ef2776c0 ef2776e4
GPR24: f18fd6e8 00000001 c086fe64 c086fe04 00000000 c08b0000 f294b000 ffffffff
NIP [f294b000] pata_macio_init+0x0/0xc0 [pata_macio]
LR [c0005c60] do_one_initcall+0x6c/0x160
Call Trace:
[f18d9d78] [c0005c14] do_one_initcall+0x20/0x160 (unreliable)
[f18d9dd8] [c009a22c] do_init_module+0x60/0x1c0
[f18d9df8] [c00993d8] load_module+0x16a8/0x1c14
[f18d9ea8] [c0099aa4] sys_finit_module+0x8c/0x94
[f18d9f38] [c0012174] ret_from_syscall+0x0/0x34
--- interrupt: c01 at 0xfdb4318
   LR = 0xfeee9c0
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX <3d20c08b> 3d40c086 9421ffe0 8129106c
---[ end trace 85a98cc836109871 ]---

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
