Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802E8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D35206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgFIQYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:24:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:50608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFIQX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:23:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6EB23AD4A;
        Tue,  9 Jun 2020 16:24:00 +0000 (UTC)
Date:   Tue, 9 Jun 2020 18:23:54 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/vmalloc: track which page-table levels were modified
Message-ID: <20200609162354.GB12636@suse.de>
References: <20200603232311.GA205619@roeck-us.net>
 <20200604083512.GN6857@suse.de>
 <CAHk-=wj2_YdxPaRFqBUUDZvtZKKG5To2KJhciJmDbchW2NFLnw@mail.gmail.com>
 <20200604140617.e340dd507ee68b0a05bd21cb@linux-foundation.org>
 <CAHk-=wjm+RrcTjB7KYCCsOouE2EyzRcwWUE9TVq6OCYYAt9Zyw@mail.gmail.com>
 <20200605081644.GS6857@suse.de>
 <20200605100059.GB7524@linux.ibm.com>
 <20200609121056.GB3871@suse.de>
 <c11fd19b-e5b6-1bc9-6392-04dbab358b67@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c11fd19b-e5b6-1bc9-6392-04dbab358b67@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Tue, Jun 09, 2020 at 07:15:42AM -0700, Guenter Roeck wrote:
> To build csky images, you have to disable CONFIG_FRAME_POINTER or use a
> non-upstream compiler. To build any images reliably, you have to disable
> CONFIG_GCC_PLUGIN_RANDSTRUCT or use a version of gcc old enough to not
> support it (gcc 6.x is fine). For mips, you have to specify ARCH and
> CROSS_COMPILE as environment variables.

My test setup builds defconfigs for all architectures using the gcc-9.3
based cross-compilers from kernel.org (except the ones I have no
compiler for). That used to work for CSky and MIPS(64) when working on
my vmalloc changes.

On MIPS the build failure looks like some Makefile breakage, but I
didn't dive deeper into that.

For CSky the compiler complains about not supporting '-mbacktrace'.

> alpha is a lost case. The offending commit is 0f1c9688a19 ("tty/sysrq:
> alpha: export and use __sysrq_get_key_op()"); it looks like that wasn't
> build tested. It can not be reverted easily because of subsequent changes.

The below diff fixed the alpha build for me, but I am sure another fix
is already queued somewhere.

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 6fa802c495b4..8f4ad63a3a9a 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -431,8 +431,13 @@ register_cpus(void)
 arch_initcall(register_cpus);
 
 #ifdef CONFIG_MAGIC_SYSRQ
+static void sysrq_reboot_handler(int unused)
+{
+	machine_halt();
+}
+
 static const struct sysrq_key_op srm_sysrq_reboot_op = {
-	.handler	= machine_halt,
+	.handler	= sysrq_reboot_handler,
 	.help_msg       = "reboot(b)",
 	.action_msg     = "Resetting",
 	.enable_mask    = SYSRQ_ENABLE_BOOT,

