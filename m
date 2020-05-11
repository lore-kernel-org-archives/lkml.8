Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2394C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7DE120720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgEKJWn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:22:43 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:48493 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgEKJWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:22:42 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D238124000F;
        Mon, 11 May 2020 09:22:38 +0000 (UTC)
Date:   Mon, 11 May 2020 11:22:37 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>
Subject: Re: [PATCH v4 00/10] add STM32 FMC2 EBI controller driver
Message-ID: <20200511112237.20751831@xps13>
In-Reply-To: <1588756279-17289-1-git-send-email-christophe.kerello@st.com>
References: <1588756279-17289-1-git-send-email-christophe.kerello@st.com>
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

Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 6 May 2020
11:11:09 +0200:

> The FMC2 functional block makes the interface with: synchronous and
> asynchronous static devices (such as PSNOR, PSRAM or other memory-mapped
> peripherals) and NAND flash memories.
> Its main purposes are:
>   - to translate AXI transactions into the appropriate external device
>     protocol
>   - to meet the access time requirements of the external devices
> All external devices share the addresses, data and control signals with the
> controller. Each external device is accessed by means of a unique Chip
> Select. The FMC2 performs only one access at a time to an external device.
> 
> Changes in v4:
>  - bindings:
>    - fix filename: st,stm32-fmc2-ebi.yaml
> 
> Changes in v3:
>  - NAND:
>    - rename labels used on errors
>    - add in the commit log the reason to increase FMC2_TIMEOUT_MS (patch 3)
>    - add Miquel reviewed-by tag (patches 2/4/5/9)
>  - EBI:
>    - move in memory folder
>    - merge MFD and BUS drivers to avoid a MFD driver
>  - bindings:
>    - pattern name has been modified
>    - vendor properties have been modified
>      - s/_/-/
>      - add unit suffix (-ns) on timing properties
> 
> Christophe Kerello (10):
>   mtd: rawnand: stm32_fmc2: manage all errors cases at probe time
>   mtd: rawnand: stm32_fmc2: remove useless inline comments
>   mtd: rawnand: stm32_fmc2: use FMC2_TIMEOUT_MS for timeouts
>   mtd: rawnand: stm32_fmc2: cleanup
>   mtd: rawnand: stm32_fmc2: use FIELD_PREP/FIELD_GET macros
>   dt-bindings: mtd: update STM32 FMC2 NAND controller documentation
>   dt-bindings: memory-controller: add STM32 FMC2 EBI controller
>     documentation
>   memory: stm32-fmc2-ebi: add STM32 FMC2 EBI controller driver
>   mtd: rawnand: stm32_fmc2: use regmap APIs
>   mtd: rawnand: stm32_fmc2: get resources from parent node
> 
>  .../memory-controllers/st,stm32-fmc2-ebi.yaml      |  261 +++++
>  .../bindings/mtd/st,stm32-fmc2-nand.yaml           |   19 +-
>  drivers/memory/Kconfig                             |   10 +
>  drivers/memory/Makefile                            |    1 +
>  drivers/memory/stm32-fmc2-ebi.c                    | 1206 ++++++++++++++++++++
>  drivers/mtd/nand/raw/Kconfig                       |    1 +
>  drivers/mtd/nand/raw/stm32_fmc2_nand.c             | 1176 ++++++++++---------
>  7 files changed, 2061 insertions(+), 613 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
>  create mode 100644 drivers/memory/stm32-fmc2-ebi.c
> 

I'm fine with the preparation patches 1-5 but the other patches need
Rob's hack and probably more changes. If it's fine with you I can apply
these patches for the next merge window and let more time to work on
the last 5.

Thanks,
Miquèl
