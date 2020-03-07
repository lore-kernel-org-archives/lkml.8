Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DF9C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 14:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE57820675
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 14:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgCGOuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 09:50:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47784 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgCGOub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 09:50:31 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8CA0B284F72;
        Sat,  7 Mar 2020 14:50:29 +0000 (GMT)
Date:   Sat, 7 Mar 2020 15:50:26 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <bbrezillon@kernel.org>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, kstewart@linuxfoundation.org,
        alexandre.belloni@bootlin.com, linux-aspeed@lists.ozlabs.org,
        thor.thayer@linux.intel.com, jethro@fortanix.com,
        rfontana@redhat.com, miquel.raynal@bootlin.com,
        opensource@jilayne.com, richard@nod.at, michal.simek@xilinx.com,
        Ludovic.Desroches@microchip.com, joel@jms.id.au,
        nishkadg.linux@gmail.com, john.garry@huawei.com, vz@mleia.com,
        alexander.sverdlin@nokia.com, matthias.bgg@gmail.com,
        tglx@linutronix.de, swboyd@chromium.org,
        mika.westerberg@linux.intel.com, allison@lohutok.net,
        linux-arm-kernel@lists.infradead.org, andrew@aj.id.au,
        Nicolas.Ferre@microchip.com, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, michael@walle.cc, ludovic.barre@st.com,
        linux-mediatek@lists.infradead.org, info@metux.net
Subject: Re: [PATCH 03/23] mtd: spi-nor: Move SFDP logic out of the core
Message-ID: <20200307155026.20deb026@collabora.com>
In-Reply-To: <20200302180730.1886678-4-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
        <20200302180730.1886678-4-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020 18:07:46 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> It makes the core file a bit smaller and provides better separation
> between the SFDP parsing and core logic.
> 
> Keep the core.h and sfdp.h definitions private in drivers/mtd/spi-nor/.
> Both expose just the definitions that are required by the core and
> manufacturer drivers. None of the SPI NOR controller drivers should
> include them.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
