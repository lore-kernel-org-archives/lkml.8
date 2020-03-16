Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592BEC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E5F20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgCPKcf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:32:35 -0400
Received: from poy.remlab.net ([94.23.215.26]:33160 "EHLO
        ns207790.ip-94-23-215.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730617AbgCPKcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:32:35 -0400
Received: from basile.remlab.net (87-92-31-51.bb.dnainternet.fi [87.92.31.51])
        (Authenticated sender: remi)
        by ns207790.ip-94-23-215.eu (Postfix) with ESMTPSA id 918F95FAC8;
        Mon, 16 Mar 2020 11:32:31 +0100 (CET)
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, maz@kernel.org, will@kernel.org
Subject: Re: [PATCH] arm64: move kimage_vaddr to .rodata
Date:   Mon, 16 Mar 2020 12:32:30 +0200
Message-ID: <3096066.EsygCdbVZz@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20200312164035.GA21120@lakrids.cambridge.arm.com>
References: <20200312094002.153302-1-remi@remlab.net> <20200312164035.GA21120@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le torstaina 12. maaliskuuta 2020, 18.40.36 EET Mark Rutland a écrit :
> On Thu, Mar 12, 2020 at 11:40:02AM +0200, Rémi Denis-Courmont wrote:
> > From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
> > 
> > This datum is not referenced from .idmap.text: it does not need to be
> > mapped in idmap. Lets move it to .rodata as it is never written to after
> > early boot of the primary CPU.
> > (Maybe .data.ro_after_init would be cleaner though?)
> 
> Can we move this into arch/arm64/mm/mmu.c, where we already have
> 
> kimage_voffset:
> | u64 kimage_voffset __ro_after_init;
> | EXPORT_SYMBOL(kimage_voffset);
> 
> ... or is it not possible to initialize kimage_vaddr correctly in C?

Currently TEXT_OFFSET is defined by the Makefile only for assembler sources and 
the linker script. So that would need to be exposed to CPPFLAGS as well.

-- 
Реми Дёни-Курмон
http://www.remlab.net/



