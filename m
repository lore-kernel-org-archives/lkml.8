Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D83C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E6820578
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgCKHpq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:45:46 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:51619 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgCKHpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:45:46 -0400
X-Originating-IP: 90.89.41.158
Received: from xps13 (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 314AD4000E;
        Wed, 11 Mar 2020 07:45:41 +0000 (UTC)
Date:   Wed, 11 Mar 2020 08:45:41 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        tglx@linutronix.de, juliensu@mxic.com.tw,
        frieder.schrempf@kontron.de, allison@lohutok.net,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        yuehaibing@huawei.com
Subject: Re: [PATCH v5 2/2] dt-bindings: mtd: Document Macronix NAND device
 bindings
Message-ID: <20200311084541.28ff4829@xps13>
In-Reply-To: <1581922600-25461-3-git-send-email-masonccyang@mxic.com.tw>
References: <1581922600-25461-1-git-send-email-masonccyang@mxic.com.tw>
        <1581922600-25461-3-git-send-email-masonccyang@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

Mason Yang <masonccyang@mxic.com.tw> wrote on Mon, 17 Feb 2020 14:56:40
+0800:

> Document the bindings used by the Macronix NAND device.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mtd/nand-macronix.txt      | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/nand-macronix.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/nand-macronix.txt b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> new file mode 100644
> index 0000000..1d7a895
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> @@ -0,0 +1,28 @@
> +Macronix NANDs Device Tree Bindings
> +-----------------------------------
> +
> +Macronix NANDs support randomizer operation for user data scrambled,
> +which can be enabled with a SET_FEATURE. The penalty of randomizer are
> +subpage accesses prohibited and more time period is needed in program
> +operation, i.e., tPROG 300us to 340us(randomizer enabled).
> +Randomizer enabled is a one time persistent and non reversible operatoin.
> +
> +For more high-reliability concern, if subpage write not available with
> +hardware ECC and filesystem and then to enable randomizer is recommended
> +by default.
> +
> +By adding a new specific property in children nodes to enable
> +randomizer function.

I also reworded slightly this text when applying.


Thanks,
Miquèl
