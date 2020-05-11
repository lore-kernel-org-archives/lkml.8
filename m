Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68269C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5485C20661
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbgEKUjG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:39:06 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:42189 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbgEKUjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:39:06 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id B7F22240006;
        Mon, 11 May 2020 20:39:01 +0000 (UTC)
Date:   Mon, 11 May 2020 22:39:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>
Subject: Re: [PATCH v4 04/10] mtd: rawnand: stm32_fmc2: cleanup
Message-ID: <20200511223900.030fe5f4@xps13>
In-Reply-To: <1588756279-17289-5-git-send-email-christophe.kerello@st.com>
References: <1588756279-17289-1-git-send-email-christophe.kerello@st.com>
        <1588756279-17289-5-git-send-email-christophe.kerello@st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 6 May 2020
11:11:13 +0200:

> This patch renames functions and local variables.
> This cleanup is done to get all functions starting by stm32_fmc2_nfc
> in the FMC2 raw NAND driver when all functions will start by
> stm32_fmc2_ebi in the FMC2 EBI driver.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to nand/next as well but for an unknown reason I had to do it
by hand because the patch would not apply.

Thanks,
Miquèl
