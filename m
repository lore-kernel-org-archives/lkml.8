Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44A2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A8A20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597258936;
	bh=tcY6udWchzBZ1TgyOQ4yi1x0QvjedIv7AcaF/nWHFes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=eOr+7ta7uPNS2IlCSHOIHei3vsV5Abn2Lz11Q2zrX6NGWMDe2a27WMHwvUYb/M9yI
	 5Ax4wbyybS2mcH8nMt3CB1R+l3xlZkvOJxII/K/NB6zb3GezHnlBwwfSg3QBnIOisL
	 NS0SZND7CJZM09PQkqPSfy0bhiz59tYvnoiXvt2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHLTCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgHLTCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:02:15 -0400
Received: from onda.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3C720838;
        Wed, 12 Aug 2020 19:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597258934;
        bh=tcY6udWchzBZ1TgyOQ4yi1x0QvjedIv7AcaF/nWHFes=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0kRPMrl9CzThgdYBaFfV/CeW206xUfNuZc+LwfiHb5rNwIuXoIcVQvwqlQVmTJHiH
         urxL1hofoU2/jGF04F4BPzi4r089PAXsS0jWOL2OKyaOcmjgV6yEPc81j2FkKYyEEo
         JtJm8nM1hws9yA+4HSGLf5Xm7I/39p7xNX5QrOck=
Date:   Wed, 12 Aug 2020 16:02:09 -0300
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 06/44] staging: spmi: hisi-spmi-controller: use le32
 macros where needed
Message-ID: <20200812160209.4871e90d@onda.lan>
In-Reply-To: <fa2d01411982f3f0873a895f4790ce65d9d6d185.camel@perches.com>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
        <910eeee38f1a13b5dc1d423aed3f7dc74bc48029.1597247164.git.mchehab+huawei@kernel.org>
        <fa2d01411982f3f0873a895f4790ce65d9d6d185.camel@perches.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 12 Aug 2020 09:21:54 -0700
Joe Perches <joe@perches.com> escreveu:

> On Wed, 2020-08-12 at 17:56 +0200, Mauro Carvalho Chehab wrote:
> > Instead of manually using bswap_32(), just use the
> > le32 macros.  
> 
> Are you certain this code will now work on any endian cpu?
> 
> Maybe just use __swab32 instead

Well, I didn't test, because this driver is for an specific
hardware (arm64). Yet, what happens in practice is that just
one byte is written by the PMIC drivers. If the order is not
LE, the byte written at the buffer will always be zero.

> 
> > diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c  
> []
> > @@ -43,11 +42,6 @@
> >  #define SPMI_APB_SPMI_CMD_TYPE_OFFSET			24
> >  #define SPMI_APB_SPMI_CMD_LENGTH_OFFSET			20
> >  
> > -#define bswap_32(X)   \
> > -    ((((u32)(X) & 0xff000000) >> 24) | \
> > -     (((u32)(X) & 0x00ff0000) >> 8) | \
> > -     (((u32)(X) & 0x0000ff00) << 8) | \
> > -     (((u32)(X) & 0x000000ff) << 24))
> >  #define SPMI_APB_SPMI_CMD_SLAVEID_OFFSET		16
> >  #define SPMI_APB_SPMI_CMD_ADDR_OFFSET			0
> >  
> > @@ -179,14 +173,15 @@ static int spmi_read_cmd(struct spmi_controller *ctrl,
> >  
> >  	writel(cmd, spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_CMD_BASE_ADDR);
> >  
> > -	rc = spmi_controller_wait_for_done(spmi_controller, spmi_controller->base, sid, addr);
> > +	rc = spmi_controller_wait_for_done(spmi_controller,
> > +					   spmi_controller->base, sid, addr);
> >  	if (rc)
> >  		goto done;
> >  
> >  	i = 0;
> >  	do {
> >  		data = readl(spmi_controller->base + chnl_ofst + SPMI_SLAVE_OFFSET * sid + SPMI_APB_SPMI_RDATA0_BASE_ADDR + i * SPMI_PER_DATAREG_BYTE);
> > -		data = bswap_32(data);
> > +		data = be32_to_cpu((__be32)data);
> >  		if ((bc - i * SPMI_PER_DATAREG_BYTE) >> 2) {
> >  			memcpy(buf, &data, sizeof(data));
> >  			buf += sizeof(data);
> > @@ -210,8 +205,7 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
> >  {
> >  	struct spmi_controller_dev *spmi_controller = dev_get_drvdata(&ctrl->dev);
> >  	unsigned long flags;
> > -	u32 cmd;
> > -	u32 data = 0;
> > +	u32 cmd, data;
> >  	int rc;
> >  	u32 chnl_ofst = SPMI_CHANNEL_OFFSET * spmi_controller->channel;
> >  	u8 op_code, i;
> > @@ -246,7 +240,7 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
> >  
> >  	i = 0;
> >  	do {
> > -		memset(&data, 0, sizeof(data));
> > +		data = 0;
> >  		if ((bc - i * SPMI_PER_DATAREG_BYTE) >> 2) {
> >  			memcpy(&data, buf, sizeof(data));
> >  			buf += sizeof(data);
> > @@ -255,8 +249,8 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
> >  			buf += (bc % SPMI_PER_DATAREG_BYTE);
> >  		}
> >  
> > -		data = bswap_32(data);
> > -		writel(data, spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_WDATA0_BASE_ADDR + SPMI_PER_DATAREG_BYTE * i);
> > +		writel((u32)cpu_to_be32(data),
> > +		       spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_WDATA0_BASE_ADDR + SPMI_PER_DATAREG_BYTE * i);
> >  		i++;
> >  	} while (bc > i * SPMI_PER_DATAREG_BYTE);
> >    
> 
