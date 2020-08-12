Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3EBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258C0207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgHLPSM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:18:12 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:38193 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgHLPSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:18:08 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 1D0541BF20B;
        Wed, 12 Aug 2020 15:18:03 +0000 (UTC)
Date:   Wed, 12 Aug 2020 17:18:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-i3c@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Rajeev Huralikoppi <rajeev.huralikoppi@silvaco.com>,
        Conor Culhane <conor.culhane@silvaco.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 3/4] i3c: master: svc: Add Silvaco I3C master driver
Message-ID: <20200812171802.295b08d8@xps13>
In-Reply-To: <20200812141312.3331-3-miquel.raynal@bootlin.com>
References: <20200812141312.3331-1-miquel.raynal@bootlin.com>
        <20200812141312.3331-3-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor, Rajeev,

> +static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
> +				     struct i3c_dev_desc *dev)
> +{
> +	struct svc_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
> +	struct i3c_ibi_slot *slot;
> +	unsigned int count;
> +	u32 mdatactrl;
> +	int ret = 0;
> +	u8 *buf;
> +
> +	spin_lock(&master->ibi.lock);
> +
> +	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
> +	if (!slot) {
> +		ret = -ENOSPC;
> +		goto unlock;
> +	}
> +
> +	slot->len = 0;
> +	buf = slot->data;
> +	while (readl(master->regs + SVC_I3C_MSTATUS) & SVC_I3C_MINT_RXPEND) {
> +		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
> +		count = SVC_I3C_MDATACTRL_RXCOUNT(mdatactrl);
> +		readsl(master->regs + SVC_I3C_MRDATAB, buf, count);

After discussing with Boris, I have a question about the design: is
there a way to differentiate, from a software point of view, from the
data coming as "IBI" and "regular data"?

Let's say the master initiates a read.
The moment after, an IBI is triggered.
The hanlde_ibi() helper is called to read the IBI payload.
While the IBI interrupted the read operation, it also interrupted the
master dequeuing process of the bytes already in the FIFO. From a
software perspective, we might end up reading a "regular byte" from the
handle_ibi() helper expecting an "IBI byte".

Is there some kind of double queue feature which I missed? Or perhaps a
way to discriminate the origin of the data?

> +		slot->len += count;
> +		buf += count;
> +	}
> +
> +	i3c_master_queue_ibi(dev, slot);
> +
> +unlock:
> +	spin_unlock(&master->ibi.lock);
> +	svc_i3c_master_emit_stop(master);
> +	svc_i3c_master_flush_fifo(master);
> +
> +	return ret;
> +}
> +
> +static void svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
> +				   bool mandatory_byte)
> +{
> +	unsigned int ibi_ack_nack;
> +
> +	ibi_ack_nack = SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK;
> +	if (mandatory_byte)
> +		ibi_ack_nack |= SVC_I3C_MCTRL_IBIRESP_ACK_WITH_BYTE;
> +	else
> +		ibi_ack_nack |= SVC_I3C_MCTRL_IBIRESP_ACK_WITHOUT_BYTE;
> +
> +	writel(ibi_ack_nack, master->regs + SVC_I3C_MCTRL);
> +}
> +
> +static void svc_i3c_master_nack_ibi(struct svc_i3c_master *master)
> +{
> +	writel(SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK |
> +	       SVC_I3C_MCTRL_IBIRESP_NACK,
> +	       master->regs + SVC_I3C_MCTRL);
> +}
> +
> +static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
> +{
> +	struct svc_i3c_master *master = (struct svc_i3c_master *)dev_id;
> +	u32 active = readl(master->regs + SVC_I3C_MINTMASKED);
> +	u32 status = readl(master->regs + SVC_I3C_MSTATUS);
> +	unsigned int ibitype = SVC_I3C_MSTATUS_IBITYPE(status);
> +	unsigned int ibiaddr = SVC_I3C_MSTATUS_IBIADDR(status);
> +	struct i3c_dev_desc *dev;
> +	bool rdata;
> +
> +	if (active & SVC_I3C_MINT_SLVSTART) {
> +		writel(SVC_I3C_MINT_SLVSTART, master->regs + SVC_I3C_MSTATUS);
> +		writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI |
> +		       SVC_I3C_MCTRL_IBIRESP_MANUAL,
> +		       master->regs + SVC_I3C_MCTRL);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (!(active & SVC_I3C_MINT_IBIWON))
> +		return IRQ_NONE;
> +
> +	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
> +
> +	switch (ibitype) {
> +	case SVC_I3C_MSTATUS_IBITYPE_IBI:
> +		dev = svc_i3c_master_dev_from_addr(master, ibiaddr);
> +		if (WARN_ON(!dev)) {
> +			svc_i3c_master_nack_ibi(master);
> +			break;
> +		}
> +
> +		rdata = dev->info.bcr & I3C_BCR_IBI_PAYLOAD;
> +		svc_i3c_master_ack_ibi(master, rdata);
> +		if (rdata) {
> +			svc_i3c_master_disable_interrupts(master);
> +			return IRQ_WAKE_THREAD;
> +		}
> +
> +		break;
> +	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
> +		svc_i3c_master_nack_ibi(master);
> +		break;
> +	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
> +		svc_i3c_master_ack_ibi(master, false);
> +		queue_work(master->base.wq, &master->hj_work);
> +		break;
> +	default:
> +		return IRQ_NONE;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t svc_i3c_master_threaded_handler(int irq, void *dev_id)
> +{
> +	struct svc_i3c_master *master = (struct svc_i3c_master *)dev_id;
> +	u32 status = readl(master->regs + SVC_I3C_MSTATUS);
> +	unsigned int ibiaddr = SVC_I3C_MSTATUS_IBIADDR(status);
> +	struct i3c_dev_desc *dev;
> +
> +	dev = svc_i3c_master_dev_from_addr(master, ibiaddr);
> +	if (WARN_ON(!dev)) {
> +		svc_i3c_master_emit_stop(master);
> +		svc_i3c_master_flush_fifo(master);
> +		return IRQ_HANDLED;
> +	}
> +
> +	svc_i3c_master_handle_ibi(master, dev);
> +	svc_i3c_master_enable_interrupts(master,
> +					 SVC_I3C_MINT_SLVSTART |
> +					 SVC_I3C_MINT_IBIWON);
> +
> +	return IRQ_HANDLED;
> +}

Thanks,
Miquèl
