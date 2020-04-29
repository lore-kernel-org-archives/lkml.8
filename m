Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86441C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD1A218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgD2Osh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726348AbgD2Osh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:48:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B450C03C1AD;
        Wed, 29 Apr 2020 07:48:37 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 632B52A224A;
        Wed, 29 Apr 2020 15:48:35 +0100 (BST)
Date:   Wed, 29 Apr 2020 16:48:32 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>, qi-ming.wu@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, cheol.yong.kim@intel.com,
        hauke.mehrtens@intel.com, anders.roxell@linaro.org,
        vigneshr@ti.com, arnd@arndb.de, richard@nod.at,
        brendanhiggins@google.com, linux-mips@vger.kernel.org,
        robh+dt@kernel.org, miquel.raynal@bootlin.com, tglx@linutronix.de,
        masonccyang@mxic.com.tw, andriy.shevchenko@intel.com
Subject: Re: [PATCH v4 2/2] mtd: rawnand: Add NAND controller support on
 Intel LGM SoC
Message-ID: <20200429164832.6800fc70@collabora.com>
In-Reply-To: <9d77c64c-d0f9-7a13-3391-d05bf458bdb1@linux.intel.com>
References: <20200429104205.18780-1-vadivel.muruganx.ramuthevar@linux.intel.com>
        <20200429104205.18780-3-vadivel.muruganx.ramuthevar@linux.intel.com>
        <20200429162249.55d38ee8@collabora.com>
        <9d77c64c-d0f9-7a13-3391-d05bf458bdb1@linux.intel.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 22:33:37 +0800
"Ramuthevar, Vadivel MuruganX"
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:

> Hi Boris,
> 
> On 29/4/2020 10:22 pm, Boris Brezillon wrote:
> > On Wed, 29 Apr 2020 18:42:05 +0800
> > "Ramuthevar, Vadivel MuruganX"
> > <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> >   
> >> +
> >> +#define EBU_ADDR_SEL(n)		(0x20 + (n) * 4)
> >> +#define EBU_ADDR_MASK		(5 << 4)  
> > 
> > It's still unclear what ADDR_MASK is for. Can you add a comment
> > explaining what it does?  
> 
> Thank you Boris, keep review and giving inputs, will update.

Can you please explain it here before sending a new version?

> >   
> >> +#define EBU_ADDR_SEL_REGEN	0x1  
> > 
> >   
> >> +
> >> +	writel(lower_32_bits(ebu_host->cs[ebu_host->cs_num].nand_pa) |
> >> +	       EBU_ADDR_SEL_REGEN | EBU_ADDR_MASK,
> >> +	       ebu_host->ebu + EBU_ADDR_SEL(reg));
> >> +
> >> +	writel(EBU_MEM_BASE_CS_0 | EBU_ADDR_MASK | EBU_ADDR_SEL_REGEN,
> >> +	       ebu_host->ebu + EBU_ADDR_SEL(0));
> >> +	writel(EBU_MEM_BASE_CS_1 | EBU_ADDR_MASK | EBU_ADDR_SEL_REGEN,
> >> +	       ebu_host->ebu + EBU_ADDR_SEL(reg));  
> > 
> > That's super weird. You seem to set EBU_ADDR_SEL(reg) twice. Are you
> > sure that's needed, and are we setting EBU_ADDR_SEL(0) here?  
> 
> You are right, its weird only, but we need it, since different chip 
> select has different memory region access address.

Well, that doesn't make any sense, the second write to
EBU_ADDR_SEL(reg) overrides the first one, meaning that nand_pa is
actually never written to ADDR_SEL(reg).

> 
> Yes , we are setting both CS0 and CS1 memory access region, if you have 
> any concern to optimize, please suggest me, Thanks!

If you want to setup both CS, and the address written in EBU_ADDR_SEL(x)
is really related to the nand_pa address, then retrieve resources for
all CS ranges. If it's not related, please explain what those
EBU_MEM_BASE_CS_X values encode.
