Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911C9C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7392080A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="U2FPsfoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgIJScA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:32:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44318 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgIJS3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:29:42 -0400
Received: from zn.tnic (p200300ec2f133200806c26bf29ee8a02.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:3200:806c:26bf:29ee:8a02])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDF451EC04BF;
        Thu, 10 Sep 2020 20:29:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599762565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dP+ni+LBnDs0GlONwuOwUFaMin5FUp6zlUoLp1NNoUI=;
        b=U2FPsfoHA+MROxLjG1jMjjpce4IjRdNETxUd5vCInGD8VSN0He8yoto5N0XdsgDuaqP3ek
        P6jz1+LO0K3eGozqlXqylziw6uEL/AwNBu+0N5wvP91T54n20lttO1e9HDCHyoCKmrkzyi
        A1TH16o+NvWGuKTGuZLyAj7fHulN3ZI=
Date:   Thu, 10 Sep 2020 20:29:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/mce: Make mce_rdmsrl() do a plain RDMSR only
Message-ID: <20200910182901.GK8357@zn.tnic>
References: <20200906212130.GA28456@zn.tnic>
 <20200907200622.GA28517@agluck-desk2.amr.corp.intel.com>
 <20200908094650.GA25236@zn.tnic>
 <20200908100837.GC25236@zn.tnic>
 <c845adaad2414e5ba0bc74a51a1d0134@intel.com>
 <20200908152539.GE25236@zn.tnic>
 <20200909113022.GA12237@zn.tnic>
 <20200909182051.GA31883@agluck-desk2.amr.corp.intel.com>
 <20200909200321.GG12237@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200909200321.GG12237@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, with all those changes, I don't think the following nice and juicy
message can be overlooked:

[   32.267830] mce: MSR access error: RDMSR from 0x1234 at rIP: 0xffffffff8102ed62 (mce_rdmsrl+0x12/0x50)
[   32.267838] Call Trace:
[   32.267838]  <#MC>
[   32.267838]  do_machine_check+0xbd/0x9f0
[   32.267839]  ? trigger_mce+0x7/0x10
[   32.267839]  exc_machine_check+0x77/0xd0
[   32.267840]  asm_exc_machine_check+0x19/0x30
[   32.267840] RIP: 0010:trigger_mce+0x7/0x10
[   32.267841] Code: c0 c3 90 0f 1f 44 00 00 48 8b 47 58 48 89 06 31 c0 c3 90 0f 1f 44 00 00 8b 47 44 48 89 06 31 c0 c3 66 90 0f 1f 44 00 00 cd 12 <c3> 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 cd f4 c3 0f 1f 84 00 00
[   32.267841] RSP: 0018:ffffc90000003fc0 EFLAGS: 00000002
[   32.267842] RAX: ffffffff81032940 RBX: 0000000000000000 RCX: ffff88807dce9e80
[   32.267843] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   32.267843] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   32.267844] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   32.267844] R13: ffff88807dce9e80 R14: 0000000000000000 R15: 0000000000000000
[   32.267845]  ? inj_extcpu_get+0x10/0x10
[   32.267845]  </#MC>
[   32.267845]  <IRQ>
[   32.267846]  flush_smp_call_function_queue+0xce/0x1b0
[   32.267846]  __sysvec_call_function_single+0x2c/0xd0
[   32.267846]  asm_call_on_stack+0x12/0x20
[   32.267847]  </IRQ>
[   32.267847]  sysvec_call_function_single+0x6e/0x80
[   32.267847]  asm_sysvec_call_function_single+0x12/0x20
[   32.267848] RIP: 0010:default_idle+0x13/0x20
[   32.267849] Code: 0f ae 38 0f ae f0 eb b9 fb eb e3 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 e9 07 00 00 00 0f 00 2d c1 9c 5e 00 fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00 65 8b 15 04
[   32.267849] RSP: 0018:ffffffff82203ec0 EFLAGS: 00000212
[   32.267850] RAX: ffffffff81819730 RBX: 0000000000000000 RCX: 0000000000029d00
[   32.267851] RDX: 000000000007de7e RSI: 7ffffff880b4b40b RDI: ffffffff8220f880
[   32.267851] RBP: ffffffff8220f880 R08: 0000000473333333 R09: 00000049ae089af4
[   32.267852] R10: 000000000006fecd R11: 0000000000006f96 R12: ffffffff8220f880
[   32.267852] R13: ffffffff8220f880 R14: 0000000000000000 R15: 0000000000000000
[   32.267852]  ? mwait_idle+0x80/0x80
[   32.267853]  default_idle_call+0x34/0xf0
[   32.267853]  do_idle+0x1ba/0x210
[   32.267853]  cpu_startup_entry+0x19/0x20
[   32.267854]  start_kernel+0x4f5/0x502
[   32.267854]  secondary_startup_64+0xa4/0xb0
[   32.267855] Kernel panic - not syncing: MCA architectural violation!
[   32.267855] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc4+ #4
[   32.267856] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
[   32.267856] Call Trace:
[   32.267856]  <#MC>
[   32.267856]  dump_stack+0x57/0x6a
[   32.267857]  panic+0xf2/0x2c2
[   32.267857]  ? secondary_startup_64+0xa3/0xb0
[   32.267857]  ex_handler_rdmsr_fault+0x36/0x36
[   32.267858]  fixup_exception+0x56/0x80
[   32.267858]  exc_general_protection+0xb6/0x2d0
[   32.267858]  asm_exc_general_protection+0x1e/0x30
[   32.267859] RIP: 0010:mce_rdmsrl+0x12/0x50
[   32.267860] Code: 54 b9 15 82 48 c7 c1 20 e4 02 81 48 c7 c2 00 e4 02 81 e9 01 17 20 00 90 0f 1f 44 00 00 65 8a 05 07 81 fe 7e 84 c0 75 10 89 f9 <0f> 32 48 89 d7 48 c1 e7 20 48 09 f8 f3 c3 e8 7b f5 ff ff 48 63 d0
[   32.267860] RSP: 0018:fffffe000000fe30 EFLAGS: 00010046
[   32.267861] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000001234
[   32.267861] RDX: 0000001d39aa4ebc RSI: fffffe000000ff08 RDI: 0000000000001234
[   32.267862] RBP: fffffe000000fe88 R08: 0000000000000000 R09: 0000000000000000
[   32.267862] R10: 0000000000000000 R11: 0000000000000000 R12: fffffe000000ff58
[   32.267863] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   32.267863]  do_machine_check+0xbd/0x9f0
[   32.267864]  ? trigger_mce+0x7/0x10
[   32.267864]  exc_machine_check+0x77/0xd0
[   32.267864]  asm_exc_machine_check+0x19/0x30
[   32.267865] RIP: 0010:trigger_mce+0x7/0x10
[   32.267866] Code: c0 c3 90 0f 1f 44 00 00 48 8b 47 58 48 89 06 31 c0 c3 90 0f 1f 44 00 00 8b 47 44 48 89 06 31 c0 c3 66 90 0f 1f 44 00 00 cd 12 <c3> 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 cd f4 c3 0f 1f 84 00 00
[   32.267866] RSP: 0018:ffffc90000003fc0 EFLAGS: 00000002
[   32.267867] RAX: ffffffff81032940 RBX: 0000000000000000 RCX: ffff88807dce9e80
[   32.267867] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   32.267868] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   32.267868] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   32.267869] R13: ffff88807dce9e80 R14: 0000000000000000 R15: 0000000000000000
[   32.267869]  ? inj_extcpu_get+0x10/0x10
[   32.267869]  </#MC>
[   32.267870]  <IRQ>
[   32.267870]  flush_smp_call_function_queue+0xce/0x1b0
[   32.267870]  __sysvec_call_function_single+0x2c/0xd0
[   32.267871]  asm_call_on_stack+0x12/0x20
[   32.267871]  </IRQ>
[   32.267871]  sysvec_call_function_single+0x6e/0x80
[   32.267872]  asm_sysvec_call_function_single+0x12/0x20
[   32.267872] RIP: 0010:default_idle+0x13/0x20
[   32.267873] Code: 0f ae 38 0f ae f0 eb b9 fb eb e3 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 e9 07 00 00 00 0f 00 2d c1 9c 5e 00 fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00 65 8b 15 04
[   32.267874] RSP: 0018:ffffffff82203ec0 EFLAGS: 00000212
[   32.267874] RAX: ffffffff81819730 RBX: 0000000000000000 RCX: 0000000000029d00
[   32.267875] RDX: 000000000007de7e RSI: 7ffffff880b4b40b RDI: ffffffff8220f880
[   32.267875] RBP: ffffffff8220f880 R08: 0000000473333333 R09: 00000049ae089af4
[   32.267876] R10: 000000000006fecd R11: 0000000000006f96 R12: ffffffff8220f880
[   32.267876] R13: ffffffff8220f880 R14: 0000000000000000 R15: 0000000000000000
[   32.267877]  ? mwait_idle+0x80/0x80
[   32.267877]  default_idle_call+0x34/0xf0
[   32.267877]  do_idle+0x1ba/0x210
[   32.267878]  cpu_startup_entry+0x19/0x20
[   32.267878]  start_kernel+0x4f5/0x502
[   32.267878]  secondary_startup_64+0xa4/0xb0
[   32.268204] Kernel Offset: disabled

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
