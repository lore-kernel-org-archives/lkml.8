Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD01C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6FE2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgCMJaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:30:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51204 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgCMJaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:30:13 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 83AF0295CF8;
        Fri, 13 Mar 2020 09:30:11 +0000 (GMT)
Date:   Fri, 13 Mar 2020 10:30:07 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     <Tudor.Ambarus@microchip.com>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <michal.simek@xilinx.com>, <ludovic.barre@st.com>,
        <john.garry@huawei.com>, <tglx@linutronix.de>,
        <nishkadg.linux@gmail.com>, <michael@walle.cc>,
        <dinguyen@kernel.org>, <thor.thayer@linux.intel.com>,
        <swboyd@chromium.org>, <opensource@jilayne.com>,
        <mika.westerberg@linux.intel.com>, <kstewart@linuxfoundation.org>,
        <allison@lohutok.net>, <jethro@fortanix.com>, <info@metux.net>,
        <alexander.sverdlin@nokia.com>, <rfontana@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 01/23] mtd: spi-nor: Stop prefixing generic functions
 with a manufacturer name
Message-ID: <20200313103007.7d7ea6af@collabora.com>
In-Reply-To: <91394111-cbd6-c24e-485d-88fcd6825dc7@ti.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
        <20200302180730.1886678-2-tudor.ambarus@microchip.com>
        <91394111-cbd6-c24e-485d-88fcd6825dc7@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 11:34:55 +0530
Vignesh Raghavendra <vigneshr@ti.com> wrote:

> On 02/03/20 11:37 pm, Tudor.Ambarus@microchip.com wrote:
> > From: Boris Brezillon <bbrezillon@kernel.org>
> > 
> > Replace the manufacturer prefix by something describing more precisely
> > what those functions do.
> > 
> > Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> > [tudor.ambarus@microchip.com: prepend spi_nor_ to all modified methods.]
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> > ---
> >  drivers/mtd/spi-nor/spi-nor.c | 88 ++++++++++++++++++-----------------
> >  1 file changed, 45 insertions(+), 43 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> > index caf0c109cca0..b15e262765e1 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -568,14 +568,15 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
> >  }
> >  
> >  /**
> > - * macronix_set_4byte() - Set 4-byte address mode for Macronix flashes.
> > + * spi_nor_en4_ex4_set_4byte() - Enter/Exit 4-byte mode for Macronix like
> > + * flashes.
> >   * @nor:	pointer to 'struct spi_nor'.
> >   * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
> >   *		address mode.
> >   *
> >   * Return: 0 on success, -errno otherwise.
> >   */
> > -static int macronix_set_4byte(struct spi_nor *nor, bool enable)
> > +static int spi_nor_en4_ex4_set_4byte(struct spi_nor *nor, bool enable)  
> 
> 
> Sounds a bit weird, how about simplifying this to:
> 
> 	spi_nor_set_4byte_addr_mode()
> 
> Or if you want to be specific:
> 
> 	spi_nor_en_ex_4byte_addr_mode()

You're right. Maybe we can simplify things by having a single function
that does optional steps based on new flags

SPI_NOR_EN_EX_4B_NEEDS_WEN
SPI_NOR_CLEAR_EAR_ON_4B_EXIT

This should probably be done in a separate patch though, so ack on the
spi_nor_en_ex_4byte_addr_mode() rename, assuming we also change the
bool argument name to enter.

> 
> >  {
> >  	int ret;
> >  
> > @@ -604,14 +605,15 @@ static int macronix_set_4byte(struct spi_nor *nor, bool enable)
> >  }
> >  
> >  /**
> > - * st_micron_set_4byte() - Set 4-byte address mode for ST and Micron flashes.
> > + * spi_nor_en4_ex4_wen_set_4byte() - Set 4-byte address mode for ST and Micron
> > + * flashes.
> >   * @nor:	pointer to 'struct spi_nor'.
> >   * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
> >   *		address mode.
> >   *
> >   * Return: 0 on success, -errno otherwise.
> >   */
> > -static int st_micron_set_4byte(struct spi_nor *nor, bool enable)
> > +static int spi_nor_en4_ex4_wen_set_4byte(struct spi_nor *nor, bool enable)  
> 
> 
> Unrelated to this patch itself, but can we just have one set_4byte
> variant that uses WREN and drop the other one?

Hm, not sure that's a good idea to insert WEN instructions for
everyone, sounds like a recipe for regressions.

> I expect sending WREN should be harmless even for cmds that don't expect
> one.

In theory yes, but you know flash chips are capricious, so let's not
take the risk of breaking things :-).

> 
> Rest looks good to me.
> 
> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> 

