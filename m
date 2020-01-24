Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57833C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267D920678
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="juHgfbyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392126AbgAXLnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:43:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52392 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729188AbgAXLJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:09:17 -0500
Received: from zn.tnic (p200300EC2F0C660015FB9CFA6160A1DF.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:6600:15fb:9cfa:6160:a1df])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8E7C1EC01AD;
        Fri, 24 Jan 2020 12:09:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579864155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6QRUD1yaQPUyr/7NjvJ/XUfSTFPMJPOv0k6vx6QEWoc=;
        b=juHgfbyBv6GNjVGcVsiCuy9UpEKTuJZtjrsYhHhQg6tgWxXmh+bNxx6vQ5M8Sd/VOYaL3M
        qEj6M7CH3e1U5Jnno9DLQ0mtUp7Pbk8DDQ3M5HOi+HqPW+Q2IbTBh5rTUgLoSBqwddgdtY
        rCWyijhJg8BiUJDxvTZeZIC84P/4cv4=
Date:   Fri, 24 Jan 2020 12:09:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2] x86/boot/KASLR: Fix unused variable warning
Message-ID: <20200124110907.GA6750@zn.tnic>
References: <20200103033929.4956-1-zhenzhong.duan@gmail.com>
 <20200109184055.GI5603@zn.tnic>
 <20200109204638.GA523773@rani.riverdale.lan>
 <CAFH1YnNA9qfM4tPzKKDaQD6DPxnE=tJsB7AUZQBohDTW3zm=Xg@mail.gmail.com>
 <20200110090032.GB19453@zn.tnic>
 <CAFH1YnN8v+8UH3RvaeT7TJEdtEyxhoBA-ZEMk-mRFWNad8e9Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFH1YnN8v+8UH3RvaeT7TJEdtEyxhoBA-ZEMk-mRFWNad8e9Jw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 10:43:14AM +0800, Zhenzhong Duan wrote:
> Just tried Arvind's patch, result is not that bad. Below are all
> warnings during build:
> In fact, only gop.c and kaslr.c have compile warning.

gop.c is not part of arch/x86/boot/compressed/

So I'd take a patch adding -Wunused to arch/x86/boot/compressed/Makefile
and fixing the single warning in kaslr.c

The extrawarn W=1 stuff gives a lot more (below) and there I guess I'd
take only well thought out patches, each fixing all -Wmissing-prototypes
in a single compilation unit.

In file included from arch/x86/boot/compressed/string.c:11:
arch/x86/boot/compressed/../string.c:43:5: warning: no previous prototype for ‘bcmp’ [-Wmissing-prototypes]
arch/x86/boot/compressed/../string.c:146:6: warning: no previous prototype for ‘simple_strtol’ [-Wmissing-prototypes]
arch/x86/boot/compressed/string.c:53:7: warning: no previous prototype for ‘memmove’ [-Wmissing-prototypes]
In file included from arch/x86/boot/compressed/string.c:11:
arch/x86/boot/compressed/../string.c:43:5: warning: no previous prototype for ‘bcmp’ [-Wmissing-prototypes]
arch/x86/boot/compressed/../string.c:146:6: warning: no previous prototype for ‘simple_strtol’ [-Wmissing-prototypes]
arch/x86/boot/compressed/string.c:53:7: warning: no previous prototype for ‘memmove’ [-Wmissing-prototypes]
In file included from arch/x86/boot/compressed/cmdline.c:14:
arch/x86/boot/compressed/../cmdline.c:28:5: warning: no previous prototype for ‘__cmdline_find_option’ [-Wmissing-prototypes]
arch/x86/boot/compressed/../cmdline.c:100:5: warning: no previous prototype for ‘__cmdline_find_option_bool’ [-Wmissing-prototypes]
arch/x86/boot/compressed/cmdline.c:15:15: warning: no previous prototype for ‘get_cmd_line_ptr’ [-Wmissing-prototypes]
arch/x86/boot/compressed/eboot.c:26:28: warning: no previous prototype for ‘efi_system_table’ [-Wmissing-prototypes]
arch/x86/boot/compressed/eboot.c:318:6: warning: no previous prototype for ‘setup_graphics’ [-Wmissing-prototypes]
arch/x86/boot/compressed/eboot.c:357:23: warning: no previous prototype for ‘efi_pe_entry’ [-Wmissing-prototypes]
arch/x86/boot/compressed/pgtable_64.c:110:22: warning: no previous prototype for ‘paging_prepare’ [-Wmissing-prototypes]
arch/x86/boot/compressed/pgtable_64.c:193:6: warning: no previous prototype for ‘cleanup_trampoline’ [-Wmissing-prototypes]
arch/x86/boot/compressed/eboot.c:711:21: warning: no previous prototype for ‘efi_main’ [-Wmissing-prototypes]
arch/x86/boot/compressed/misc.c:340:28: warning: no previous prototype for ‘extract_kernel’ [-Wmissing-prototypes]
...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
