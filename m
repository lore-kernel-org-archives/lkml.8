Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA73AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FC42078D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ls0OMPnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgFRLPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgFRLPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 07:15:32 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77583C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 04:15:30 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r7so5648343wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 04:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0GJVcitDyaEL2jf4WCeTo8g4uf7cIzuyvkTtnJ0mIkM=;
        b=ls0OMPnEqEV0KBcrCJ2lgEK8nRpKgsmP/QP0iu1kFoeB9GaSnkkOKZFi2fmc1uPsLw
         /ToYnxZC7mYzuy3a7Dtj/WOR7I3rN5bcLhsw74TdK7uo++5CQ27TH1e/Uk7HEfPnOO6H
         wzwKodFOH+6Ac5FBrkFux6Wy6p89aBQohMHrGnk38rkgErZKw3d/UcCVvLBng6lKrqtO
         GmaOENyKPcVRQvepyCmxNtVarmmO05esOj1uFMSsiI0U2IYI/zsZs5xKvj9PqbGonvaF
         jFUUkdrlsWyaOrZPST5E4E1C6hjfqeDYTx9/YmZggaCtbNNxqlmKmSwd9w0w0twbhyjS
         Rdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0GJVcitDyaEL2jf4WCeTo8g4uf7cIzuyvkTtnJ0mIkM=;
        b=CENVqqUDia7M5H2Zsoue0d2ZttyFh5IXCx3hCWkNPaEbepl3IChPMeifiplmc7QlsG
         r4oAuGz1ASoi2YbcbFTdmjlUB0hvskQQ6I5qbwRVh6l67+tNJ1g9FrRbLwwcQl0jLmBw
         1GpEHLOOarwAixQdE1z3McNyipcbGz+exLszEErZocuzYM/cPveWrA6CSG+9m3Yh4yX/
         vpKkYSFnt3z00MXLMeinjXq4rHT6vzNvr3lb6pP2KV/2Y6nZqDX5Zf/rrDeECxRACOIt
         G5nNOisOxfupzdEPc3c422zvcvt6QAbrEBhAiIXTi7OTJqxL65QCGdHIZUe2sLC9k+f1
         j9BA==
X-Gm-Message-State: AOAM530486exNYYqJk0bSBjB7mdTzHeDJMNemlhVCDmX501V67G3y3Ux
        3SqkTiN4gsIB69So9eYbnVzJp/iH0iU=
X-Google-Smtp-Source: ABdhPJwCh5MHV4ccM/kG14whc1HjaNqmA1LNLwcS5N9awI6WD2D/iCQk21si3KGFR3gioGFWYgtZCQ==
X-Received: by 2002:adf:a18b:: with SMTP id u11mr4057854wru.102.1592478929101;
        Thu, 18 Jun 2020 04:15:29 -0700 (PDT)
Received: from dell ([95.149.164.118])
        by smtp.gmail.com with ESMTPSA id s2sm3050456wmh.11.2020.06.18.04.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 04:15:28 -0700 (PDT)
Date:   Thu, 18 Jun 2020 12:15:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH v3 1/2] mfd: da9063: Fix revision handling to correctly
 select reg tables
Message-ID: <20200618111526.GG954398@dell>
References: <cover.1587120185.git.Adam.Thomson.Opensource@diasemi.com>
 <a019b698f0c643455e07e7a94dcf0478b1b1f4d4.1587120185.git.Adam.Thomson.Opensource@diasemi.com>
 <20200618101511.GE954398@dell>
 <AM6PR10MB226325A1203A99CE49C364EC809B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR10MB226325A1203A99CE49C364EC809B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020, Adam Thomson wrote:

> On 18 June 2020 11:15, Lee Jones wrote:
> 
> > > The current implementation performs checking in the i2c_probe()
> > > function of the variant_code but does this immediately after the
> > > containing struct has been initialised as all zero. This means the
> > > check for variant code will always default to using the BB tables
> > > and will never select AD. The variant code is subsequently set
> > > by device_init() and later used by the RTC so really it's a little
> > > fortunate this mismatch works.
> > >
> > > This update adds raw I2C read access functionality to read the chip
> > > and variant/revision information (common to all revisions) so that
> > > it can subsequently correctly choose the proper regmap tables for
> > > real initialisation.
> > >
> > > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > > ---
> > >  drivers/mfd/da9063-core.c            |  31 ------
> > >  drivers/mfd/da9063-i2c.c             | 184 +++++++++++++++++++++++++++++++-
> > ---
> > >  include/linux/mfd/da9063/registers.h |  15 ++-
> > >  3 files changed, 177 insertions(+), 53 deletions(-)
> > 
> > [...]
> > 
> > > + * Raw I2C access required for just accessing chip and variant info before we
> > > + * know which device is present. The info read from the device using this
> > > + * approach is then used to select the correct regmap tables.
> > > + */
> > > +
> > > +#define DA9063_REG_PAGE_SIZE		0x100
> > > +#define DA9063_REG_PAGED_ADDR_MASK	0xFF
> > > +
> > > +enum da9063_page_sel_buf_fmt {
> > > +	DA9063_PAGE_SEL_BUF_PAGE_REG = 0,
> > > +	DA9063_PAGE_SEL_BUF_PAGE_VAL,
> > > +	DA9063_PAGE_SEL_BUF_SIZE,
> > > +};
> > > +
> > > +enum da9063_paged_read_msgs {
> > > +	DA9063_PAGED_READ_MSG_PAGE_SEL = 0,
> > > +	DA9063_PAGED_READ_MSG_REG_SEL,
> > > +	DA9063_PAGED_READ_MSG_DATA,
> > > +	DA9063_PAGED_READ_MSG_CNT,
> > > +};
> > > +
> > > +static int da9063_i2c_blockreg_read(struct i2c_client *client, u16 addr,
> > > +				    u8 *buf, int count)
> > > +{
> > > +	struct i2c_msg xfer[DA9063_PAGED_READ_MSG_CNT];
> > > +	u8 page_sel_buf[DA9063_PAGE_SEL_BUF_SIZE];
> > > +	u8 page_num, paged_addr;
> > > +	int ret;
> > > +
> > > +	/* Determine page info based on register address */
> > > +	page_num = (addr / DA9063_REG_PAGE_SIZE);
> > > +	if (page_num > 1) {
> > > +		dev_err(&client->dev, "Invalid register address provided\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	paged_addr = (addr % DA9063_REG_PAGE_SIZE) &
> > DA9063_REG_PAGED_ADDR_MASK;
> > > +	page_sel_buf[DA9063_PAGE_SEL_BUF_PAGE_REG] =
> > DA9063_REG_PAGE_CON;
> > > +	page_sel_buf[DA9063_PAGE_SEL_BUF_PAGE_VAL] =
> > > +		(page_num << DA9063_I2C_PAGE_SEL_SHIFT) &
> > DA9063_REG_PAGE_MASK;
> > > +
> > > +	/* Write reg address, page selection */
> > > +	xfer[DA9063_PAGED_READ_MSG_PAGE_SEL].addr = client->addr;
> > > +	xfer[DA9063_PAGED_READ_MSG_PAGE_SEL].flags = 0;
> > > +	xfer[DA9063_PAGED_READ_MSG_PAGE_SEL].len =
> > DA9063_PAGE_SEL_BUF_SIZE;
> > > +	xfer[DA9063_PAGED_READ_MSG_PAGE_SEL].buf = page_sel_buf;
> > > +
> > > +	/* Select register address */
> > > +	xfer[DA9063_PAGED_READ_MSG_REG_SEL].addr = client->addr;
> > > +	xfer[DA9063_PAGED_READ_MSG_REG_SEL].flags = 0;
> > > +	xfer[DA9063_PAGED_READ_MSG_REG_SEL].len = sizeof(paged_addr);
> > > +	xfer[DA9063_PAGED_READ_MSG_REG_SEL].buf = &paged_addr;
> > > +
> > > +	/* Read data */
> > > +	xfer[DA9063_PAGED_READ_MSG_DATA].addr = client->addr;
> > > +	xfer[DA9063_PAGED_READ_MSG_DATA].flags = I2C_M_RD;
> > > +	xfer[DA9063_PAGED_READ_MSG_DATA].len = count;
> > > +	xfer[DA9063_PAGED_READ_MSG_DATA].buf = buf;
> > > +
> > > +	ret = i2c_transfer(client->adapter, xfer,
> > DA9063_PAGED_READ_MSG_CNT);
> > > +	if (ret < 0) {
> > > +		dev_err(&client->dev, "Paged block read failed: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	if (ret != DA9063_PAGED_READ_MSG_CNT) {
> > > +		dev_err(&client->dev, "Paged block read failed to complete\n");
> > > +		return -EIO;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > 
> > Rather than open coding this, does it make sense to register a small
> > (temporary?) Device ID Regmap to read from?
> 
> The original patch submission did exactly that but you indicated you weren't
> keen due to overheads, hence the implementation above. Actually what we have
> here is a bit smaller than the regmap approach and I really I'd rather not
> have to respin again just to revert to something that was dismissed in the first
> place over 6 months ago.

Actually the conversation went like:

Lee:
  IIUC, you have a dependency issue whereby the device type is required
  before you can select the correct Regmap configuration.  Is that
  correct?

  If so, using Regmap for the initial register reads sounds like
  over-kill.  What's stopping you simply using raw reads before the
  Regmap is instantiated?

Adam:
  Actually nothing and I did consider this at the start. Nice thing with regmap
  is it's all tidily contained and provides the page swapping mechanism to access
  higher page registers like the variant information. Given this is only once at
  probe time it felt like this was a reasonable solution. However if you're not
  keen I can update to use raw access instead.

Lee:
  It would be nice to compare the 2 solutions side by side.  I can't see
  the raw reads of a few device-ID registers being anywhere near 170
  lines though.

  Ah, they are I2C transactions?  Not the nice readl()s I had in mind.

Adam:
  I can knock something together though just to see what it looks like.

Lee:
  Well, I'd appreciated that, thanks.

So now we can see them side-by-side we can take them on their own
merits.  When I initially requested raw reads, I had readl()s in mind,
rather than the extensive code required to read the required registers
via I2C.

However, it looks like there is very little difference between them,
thus I do not see a benefit to reverting it back.  The current version
seems fine.

I'll conduct a full review shortly, when I have a little more spare
time (looking at my current TODO list, this will probably be Monday
now).  Although everything does look fine at first glance.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
