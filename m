Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5057FC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117332078A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="v57MwSSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgCYNQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:16:23 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13356 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726998AbgCYNQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:16:23 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02PD8I8Y005912;
        Wed, 25 Mar 2020 14:16:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=9BseJf9skXpYKfLaOw9WSTpsDzs4N4zuRxaLSqQrK8E=;
 b=v57MwSSWlrRVLMiwHqeTMLSWoUNxW3OAj0Z0FNPkFMYBy7oSiGXAII6T/ADRtvhL/7xx
 KHcTjXAIC/nvKGoZnIWGwOT0vmCy0or1lRqfZ3+psMd9iN1Dbtj18NzWjHATW2P6oaSo
 D+BL9yVd/FFwXmHD07Z5cN7iFtafnTWblv85bYycvv623kMw44EVwUEiIF0GL30lMti3
 /17UjpaJzVeXiEYUXUuEP1jevD/wu44if2vexz1+zhcxhvp2xuguUlXRDQq140BoJ8rZ
 ywPCy28p4y/+0flHGD2FYG+L1qOCvqPgOfEO54M8awaBRz/CIyyKMYUYCLGMPNj2xJKj CA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yw8xe61m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 14:16:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5CBE710002A;
        Wed, 25 Mar 2020 14:16:01 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 472AB2A8514;
        Wed, 25 Mar 2020 14:16:01 +0100 (CET)
Received: from lmecxl0889.tpe.st.com (10.75.127.48) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Mar
 2020 14:15:49 +0100
Subject: Re: [PATCH v7 2/2] tty: add rpmsg driver
To:     Jiri Slaby <jslaby@suse.cz>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        xiang xiao <xiaoxiang781216@gmail.com>
References: <20200324170407.16470-1-arnaud.pouliquen@st.com>
 <20200324170407.16470-3-arnaud.pouliquen@st.com>
 <e458f805-c746-c88e-98f4-d874a7552933@suse.cz>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <1e4ce821-dd9b-bb04-774b-58a255834cf5@st.com>
Date:   Wed, 25 Mar 2020 14:15:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e458f805-c746-c88e-98f4-d874a7552933@suse.cz>
Content-Type: text/plain; charset="iso-8859-2"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_05:2020-03-24,2020-03-25 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/20 9:45 AM, Jiri Slaby wrote:
> On 24. 03. 20, 18:04, Arnaud Pouliquen wrote:
>> --- /dev/null
>> +++ b/drivers/tty/rpmsg_tty.c
>> @@ -0,0 +1,417 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) STMicroelectronics 2020 - All Rights Reserved
>> + * Authors: Arnaud Pouliquen <arnaud.pouliquen@st.com> for STMicroelectronics.
>> + */
> ...
>> +typedef void (*rpmsg_tty_rx_cb_t)(struct rpmsg_device *, void *, int, void *,
>> +				  u32);
> 
> Unused, it seems?
> 
>> +static int rpmsg_tty_cb(struct rpmsg_device *rpdev, void *data, int len,
>> +			void *priv, u32 src)
>> +{
>> +	struct rpmsg_tty_port *cport = dev_get_drvdata(&rpdev->dev);
>> +	int copied;
>> +
>> +	if (src == cport->data_dst) {
>> +		/* data message */
>> +		if (!len)
>> +			return -EINVAL;
>> +		copied = tty_insert_flip_string_fixed_flag(&cport->port, data,
>> +							   TTY_NORMAL, len);
> 
> Provided you always pass TTY_NORMAL, why not simply call
> tty_insert_flip_string instead?
> 
>> +		if (copied != len)
>> +			dev_dbg(&rpdev->dev, "trunc buffer: available space is %d\n",
>> +				copied);
>> +		tty_flip_buffer_push(&cport->port);
>> +	} else {
>> +		/* control message */
>> +		struct rpmsg_tty_ctrl *msg = data;
>> +
>> +		if (len != sizeof(*msg))
>> +			return -EINVAL;
>> +
>> +		cport->data_dst = msg->d_ept_addr;
>> +
>> +		/* Update remote cts state */
>> +		cport->cts = msg->cts ? 1 : 0;
> 
> Number to bool implicit conversion needs no magic, just do:
> cport->cts = msg->cts;

In this case i would prefer  cport->cts = (msg->cts != 1);
for the conversion

> 
>> +		if (cport->cts)
>> +			tty_port_tty_wakeup(&cport->port);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void rpmsg_tty_send_term_ready(struct tty_struct *tty, u8 state)
> 
> Should the state be bool? Should it be named "ready" instead?
> 
>> +{
>> +	struct rpmsg_tty_port *cport = tty->driver_data;
>> +	struct rpmsg_tty_ctrl m_ctrl;
>> +	int ret;
>> +
>> +	m_ctrl.cts = state;
>> +	m_ctrl.d_ept_addr = cport->d_ept->addr;
>> +
>> +	ret = rpmsg_trysend(cport->cs_ept, &m_ctrl, sizeof(m_ctrl));
>> +	if (ret < 0)
>> +		dev_dbg(tty->dev, "cannot send control (%d)\n", ret);
>> +};
>> +
>> +static void rpmsg_tty_throttle(struct tty_struct *tty)
>> +{
>> +	struct rpmsg_tty_port *cport = tty->driver_data;
>> +
>> +	/* Disable remote transmission */
>> +	if (cport->cs_ept)
>> +		rpmsg_tty_send_term_ready(tty, 0);
> 
> then s/0/false/;
> 
>> +};
>> +
>> +static void rpmsg_tty_unthrottle(struct tty_struct *tty)
>> +{
>> +	struct rpmsg_tty_port *cport = tty->driver_data;
>> +
>> +	/* Enable remote transmission */
>> +	if (cport->cs_ept)
>> +		rpmsg_tty_send_term_ready(tty, 1);
> 
> and s/1/true/> 
>> +};
> ...
>> +static int rpmsg_tty_write(struct tty_struct *tty, const u8 *buf, int len)
>> +{
>> +	struct rpmsg_tty_port *cport = tty->driver_data;
>> +	struct rpmsg_device *rpdev;
>> +	int msg_max_size, msg_size;
>> +	int ret;
>> +	u8 *tmpbuf;
>> +
>> +	/* If cts not set, the message is not sent*/
>> +	if (!cport->cts)
>> +		return 0;
>> +
>> +	rpdev = cport->rpdev;
>> +
>> +	dev_dbg(&rpdev->dev, "%s: send msg from tty->index = %d, len = %d\n",
>> +		__func__, tty->index, len);
>> +
>> +	msg_max_size = rpmsg_get_mtu(rpdev->ept);
>> +
>> +	msg_size = min(len, msg_max_size);
>> +	tmpbuf = kzalloc(msg_size, GFP_KERNEL);
>> +	if (!tmpbuf)
>> +		return -ENOMEM;
>> +
>> +	memcpy(tmpbuf, buf, msg_size);
> 
> This is kmemdup, but why do you do that in the first place?
> 
>> +	/*
>> +	 * Try to send the message to remote processor, if failed return 0 as
>> +	 * no data sent
>> +	 */
>> +	ret = rpmsg_trysendto(cport->d_ept, tmpbuf, msg_size, cport->data_dst);
> 
> data of rpmsg_trysendto is not const. OK, you seem you need to change
> that first, I see no blocker for that.

I created a temporary buffer to ensure that buffer to sent does not exceed the 
MTU size.
But perhaps this is an useless protection as the rpmsg_tty_write_room already
return the MTU value, and so the 'len' variable can not be higher that value
returned by the write_room?

> 
>> +	kfree(tmpbuf);
>> +	if (ret) {
>> +		dev_dbg(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
>> +		return 0;
>> +	}
>> +
>> +	return msg_size;
>> +}
>> +
>> +static int rpmsg_tty_write_room(struct tty_struct *tty)
>> +{
>> +	struct rpmsg_tty_port *cport = tty->driver_data;
>> +
>> +	return cport->cts ? rpmsg_get_mtu(cport->rpdev->ept) : 0;
> 
> With if, this would be more readable, IMO.
> 
>> +}
> ...> +static struct rpmsg_tty_port *rpmsg_tty_alloc_cport(void)
>> +{
>> +	struct rpmsg_tty_port *cport;
>> +
>> +	cport = kzalloc(sizeof(*cport), GFP_KERNEL);
>> +	if (!cport)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	mutex_lock(&idr_lock);
>> +	cport->id = idr_alloc(&tty_idr, cport, 0, MAX_TTY_RPMSG, GFP_KERNEL);
>> +	mutex_unlock(&idr_lock);
>> +
>> +	if (cport->id < 0) {
>> +		kfree(cport);
>> +		return ERR_PTR(-ENOSPC);
> 
> You should return ERR_PTR(cport->id) instead. It might be ENOMEM too.
> 
>> +	}
>> +
>> +	return cport;
>> +}
> ...
>> +static int rpmsg_tty_port_activate(struct tty_port *p, struct tty_struct *tty)
>> +{
>> +	p->low_latency = (p->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
>> +
>> +	/* Allocate the buffer we use for writing data */
> 
> Where exactly -- am I missing something?

in tty_port_alloc_xmit_buf. it's a copy past from mips_ejtag_fdc.c,
I will clean this line if it's confusing.
 
> 
>> +	return tty_port_alloc_xmit_buf(p);
>> +}
>> +
>> +static void rpmsg_tty_port_shutdown(struct tty_port *p)
>> +{
>> +	/* Free the write buffer */
>> +	tty_port_free_xmit_buf(p);
>> +}
> ...
>> +static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
>> +{
>> +	struct rpmsg_tty_port *cport;
>> +	struct device *dev = &rpdev->dev;
>> +	struct rpmsg_channel_info chinfo;
>> +	struct device *tty_dev;
>> +	int ret;
>> +
>> +	cport = rpmsg_tty_alloc_cport();
>> +	if (IS_ERR(cport)) {
>> +		dev_err(dev, "failed to alloc tty port\n");
>> +		return PTR_ERR(cport);
>> +	}
>> +
>> +	if (!strncmp(rpdev->id.name, TTY_CH_NAME_WITH_CTS,
>> +		     sizeof(TTY_CH_NAME_WITH_CTS))) {
> 
> sizeof of a string feels unnatural, but will work in this case. Can a
> compiler optimize strlen of a static string?

I don't know if a compiler can do this...
what about replacing sizeof by strlen function? 
i saw some code example that use strlen with static string...
(e.g  https://elixir.bootlin.com/linux/latest/source/drivers/edac/edac_mc.c#L1193)


I will take into account all your other comments in may next version.

Thanks for the review,
Arnaud

> 
>> +		/*
>> +		 * the default endpoint is used for control. Create a second
>> +		 * endpoint for the data that would be exchanges trough control
>> +		 * endpoint. address of the data endpoint will be provided with
>> +		 * the cts state
>> +		 */
>> +		cport->cs_ept = rpdev->ept;
>> +		cport->data_dst = RPMSG_ADDR_ANY;
>> +
>> +		strscpy(chinfo.name, TTY_CH_NAME_WITH_CTS, sizeof(chinfo.name));
>> +		chinfo.src = RPMSG_ADDR_ANY;
>> +		chinfo.dst = RPMSG_ADDR_ANY;
>> +
>> +		cport->d_ept = rpmsg_create_ept(rpdev, rpmsg_tty_cb, cport,
>> +						chinfo);
>> +		if (!cport->d_ept) {
>> +			dev_err(dev, "failed to create tty control channel\n");
>> +			ret = -ENOMEM;
>> +			goto err_r_cport;
>> +		}
>> +		dev_dbg(dev, "%s: creating data endpoint with address %#x\n",
>> +			__func__, cport->d_ept->addr);
>> +	} else {
>> +		/*
>> +		 * TTY over rpmsg without CTS management the default endpoint
>> +		 * is use for raw data transmission.
>> +		 */
>> +		cport->cs_ept = NULL;
>> +		cport->cts = 1;
>> +		cport->d_ept = rpdev->ept;
>> +		cport->data_dst = rpdev->dst;
>> +	}
>> +
>> +	tty_port_init(&cport->port);
>> +	cport->port.ops = &rpmsg_tty_port_ops;
> 
> I expected these two in rpmsg_tty_alloc_cport
> 
>> +
>> +	tty_dev = tty_port_register_device(&cport->port, rpmsg_tty_driver,
>> +					   cport->id, dev);
>> +	if (IS_ERR(tty_dev)) {
>> +		dev_err(dev, "failed to register tty port\n");
>> +		ret = PTR_ERR(tty_dev);
>> +		goto  err_destroy;
>> +	}
>> +
>> +	cport->rpdev = rpdev;
>> +
>> +	dev_set_drvdata(dev, cport);
>> +
>> +	dev_dbg(dev, "new channel: 0x%x -> 0x%x : ttyRPMSG%d\n",
>> +		rpdev->src, rpdev->dst, cport->id);
>> +
>> +	return 0;
>> +
>> +err_destroy:
>> +	tty_port_destroy(&cport->port);
>> +	if (cport->cs_ept)
>> +		rpmsg_destroy_ept(cport->d_ept);
>> +err_r_cport:
>> +	rpmsg_tty_release_cport(cport);
>> +
>> +	return ret;
>> +}
> 
> thanks,
> 
