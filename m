Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5BAC54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185A02098B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgELG73 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:59:29 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:50805 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgELG73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:59:29 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id A607E20006;
        Tue, 12 May 2020 06:59:24 +0000 (UTC)
Date:   Tue, 12 May 2020 08:59:22 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>
Subject: Re: [PATCH v4 04/10] mtd: rawnand: stm32_fmc2: cleanup
Message-ID: <20200512085922.3fc3e4dd@xps13>
In-Reply-To: <49c51a13-96a1-0241-f4d1-c5ff7d52921d@st.com>
References: <1588756279-17289-1-git-send-email-christophe.kerello@st.com>
        <1588756279-17289-5-git-send-email-christophe.kerello@st.com>
        <20200511223900.030fe5f4@xps13>
        <49c51a13-96a1-0241-f4d1-c5ff7d52921d@st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Christophe Kerello <christophe.kerello@st.com> wrote on Tue, 12 May
2020 08:49:54 +0200:

> Hi Miquel,
> 
> On 5/11/20 10:39 PM, Miquel Raynal wrote:
> > 
> > Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 6 May 2020
> > 11:11:13 +0200:
> >   
> >> This patch renames functions and local variables.
> >> This cleanup is done to get all functions starting by stm32_fmc2_nfc
> >> in the FMC2 raw NAND driver when all functions will start by
> >> stm32_fmc2_ebi in the FMC2 EBI driver.
> >>
> >> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> >> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> > 
> > Applied to nand/next as well but for an unknown reason I had to do it
> > by hand because the patch would not apply.
> > 
> > Thanks,
> > Miquèl
> >   
> This is strange, I can apply this patch on my tree without any conflicts.
> There is a compilation issue line 1301.
> 
> @@ -1302,44 +1298,45 @@ static void stm32_fmc2_write_data(struct nand_chip *chip, const void *buf,
> 
>   	if (force_8bit && chip->options & NAND_BUSWIDTH_16)
>   		/* Reconfigure bus width to 16-bit */
> -		stm32_fmc2_set_buswidth_16(fmc2, true);
> +		stm32_fmc2_nfc_set_buswidth_16(nfc, true);
>   }
> 
> I will rebase on top of nand/next today to check that there is no issues with the driver.

I had to do some changes manually, maibe I missed this one, but I don't
remember touching this helper.

Anyway, I just dropped the two last patches of your series, please
reba&se now on nand/next and just resend patches 4 and 5.

Also, while at it, would you mind changing the commit title to
something more meaningful? "cleanup" is a bit vague and not very
accurate. Maybe something like "Cosmetic change to use nfc instead of
fmc2 where relevant".

Thanks,
Miquèl
