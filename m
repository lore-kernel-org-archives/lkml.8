Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0BFC54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A9B2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0st62iO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgCXUj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:39:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38783 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgCXUj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:39:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id w3so7907344plz.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AchiROZ1qH+L08TJpKjISOOVOXOStkcgxe1wjoszpbs=;
        b=r0st62iOSmGxMm+qfpPheG4IYx104WRDgw9y2c+eWJqpw6zgXcx+uz7sOLKRal+sHR
         DjMPaphDa3OOsCRiHzXaGoYkeU3AhSIupETKaX12UblI+q4lZBge1V8WtFGQiLbJBloY
         EmvEIIcCRYaOE8HEJAI1lmaznGABdzKmi9P7OSghRERyclG+dmD2BCMkaixelD2eo6ed
         qKEXgH5Tg+JDgDQ7FFFQ9SI4yY6ugcwNaspieqyc13aVAkzmtzZ2ABn/I+LJ8evEG+bZ
         Pq3kKpAqQCbES2SLLst3NSQ5oBGAmLaV9GD0SF07tm5wdNAPcnuoqTRMOlYOb2+dZvzc
         3m5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AchiROZ1qH+L08TJpKjISOOVOXOStkcgxe1wjoszpbs=;
        b=jxD+BFCggoiI+2Af6l0g1wCer1chKSRII12gyDNNwJ61NefAO14P42sopueI8jgJ97
         spqHAOTDzEz8MZlK/os6vdpSyVf4BztRqlRNrAHhO9IO8MmtWy2AY0DdtzA4zNwMu+x6
         K8SUhu37YfshIM56XMMKKrnbD+v9YG0HmyrGQKebPDPyBukFYEn2p/ZjBTXslr7DlNiN
         nQ6NNecjObznrKOpcf60m2UgAjaqXdYnDjuJYhTBgrKeK2wjcz+UNCdwDxsiBdXN3LA4
         ZfZPihFVuvnzHYfD/p5wybZ4espQvp3sY+gEklw+jW3wfsxEXh0tg3hUfLd8m8wJc1rU
         /ukQ==
X-Gm-Message-State: ANhLgQ1VYK7XGf1QXT1oy7V1pQUiDVKCCquD2EHd9qCU/+LaS7x37iM0
        gV7xBludDQUJHaVM4YJaxPBT2LwmXNs=
X-Google-Smtp-Source: ADFU+vud8Vsb+h0uacUnY/KjbuZs8bsWOz7x3iMR2p/ALNP8vbDuaIpkn8U1D4K3WkF+W/lMUKK4QA==
X-Received: by 2002:a17:902:b948:: with SMTP id h8mr19870530pls.155.1585082395952;
        Tue, 24 Mar 2020 13:39:55 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q61sm3039205pja.2.2020.03.24.13.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 13:39:55 -0700 (PDT)
Date:   Tue, 24 Mar 2020 13:39:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     gregkh@linuxfoundation.org, davem@davemloft.net,
        smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, hemantk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v3 6/7] net: qrtr: Add MHI transport layer
Message-ID: <20200324203952.GC119913@minitux>
References: <20200324061050.14845-1-manivannan.sadhasivam@linaro.org>
 <20200324061050.14845-7-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324061050.14845-7-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23 Mar 23:10 PDT 2020, Manivannan Sadhasivam wrote:

> MHI is the transport layer used for communicating to the external modems.
> Hence, this commit adds MHI transport layer support to QRTR for
> transferring the QMI messages over IPC Router.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  net/qrtr/Kconfig  |   7 ++
>  net/qrtr/Makefile |   2 +
>  net/qrtr/mhi.c    | 208 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 217 insertions(+)
>  create mode 100644 net/qrtr/mhi.c
> 
> diff --git a/net/qrtr/Kconfig b/net/qrtr/Kconfig
> index 63f89cc6e82c..8eb876471564 100644
> --- a/net/qrtr/Kconfig
> +++ b/net/qrtr/Kconfig
> @@ -29,4 +29,11 @@ config QRTR_TUN
>  	  implement endpoints of QRTR, for purpose of tunneling data to other
>  	  hosts or testing purposes.
>  
> +config QRTR_MHI
> +	tristate "MHI IPC Router channels"
> +	depends on MHI_BUS
> +	help
> +	  Say Y here to support MHI based ipcrouter channels. MHI is the
> +	  transport used for communicating to external modems.
> +
>  endif # QRTR
> diff --git a/net/qrtr/Makefile b/net/qrtr/Makefile
> index 1c6d6c120fb7..3dc0a7c9d455 100644
> --- a/net/qrtr/Makefile
> +++ b/net/qrtr/Makefile
> @@ -5,3 +5,5 @@ obj-$(CONFIG_QRTR_SMD) += qrtr-smd.o
>  qrtr-smd-y	:= smd.o
>  obj-$(CONFIG_QRTR_TUN) += qrtr-tun.o
>  qrtr-tun-y	:= tun.o
> +obj-$(CONFIG_QRTR_MHI) += qrtr-mhi.o
> +qrtr-mhi-y	:= mhi.o
> diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
> new file mode 100644
> index 000000000000..90af208f34c1
> --- /dev/null
> +++ b/net/qrtr/mhi.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/mhi.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/skbuff.h>
> +#include <net/sock.h>
> +
> +#include "qrtr.h"
> +
> +struct qrtr_mhi_dev {
> +	struct qrtr_endpoint ep;
> +	struct mhi_device *mhi_dev;
> +	struct device *dev;
> +	spinlock_t ul_lock;		/* lock to protect ul_pkts */
> +	struct list_head ul_pkts;
> +	atomic_t in_reset;
> +};
> +
> +struct qrtr_mhi_pkt {
> +	struct list_head node;
> +	struct sk_buff *skb;
> +	struct kref refcount;
> +	struct completion done;
> +};
> +
> +static void qrtr_mhi_pkt_release(struct kref *ref)
> +{
> +	struct qrtr_mhi_pkt *pkt = container_of(ref, struct qrtr_mhi_pkt,
> +						refcount);
> +	struct sock *sk = pkt->skb->sk;
> +
> +	consume_skb(pkt->skb);
> +	if (sk)
> +		sock_put(sk);
> +
> +	kfree(pkt);
> +}
> +
> +/* From MHI to QRTR */
> +static void qcom_mhi_qrtr_dl_callback(struct mhi_device *mhi_dev,
> +				      struct mhi_result *mhi_res)
> +{
> +	struct qrtr_mhi_dev *qdev = dev_get_drvdata(&mhi_dev->dev);
> +	int rc;
> +
> +	if (!qdev || mhi_res->transaction_status)
> +		return;
> +
> +	rc = qrtr_endpoint_post(&qdev->ep, mhi_res->buf_addr,
> +				mhi_res->bytes_xferd);
> +	if (rc == -EINVAL)
> +		dev_err(qdev->dev, "invalid ipcrouter packet\n");

Perhaps this should be a debug print, perhaps rate limited. But either
way it's relevant for any transport, so I think you should skip it here
- and potentially move it into qrtr_endpoint_post() in some form.

> +}
> +
> +/* From QRTR to MHI */
> +static void qcom_mhi_qrtr_ul_callback(struct mhi_device *mhi_dev,
> +				      struct mhi_result *mhi_res)
> +{
> +	struct qrtr_mhi_dev *qdev = dev_get_drvdata(&mhi_dev->dev);
> +	struct qrtr_mhi_pkt *pkt;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&qdev->ul_lock, flags);
> +	pkt = list_first_entry(&qdev->ul_pkts, struct qrtr_mhi_pkt, node);
> +	list_del(&pkt->node);
> +	complete_all(&pkt->done);

You should be able to release the lock after popping the item off the
list, then complete and refcount it.

> +
> +	kref_put(&pkt->refcount, qrtr_mhi_pkt_release);
> +	spin_unlock_irqrestore(&qdev->ul_lock, flags);
> +}
> +
> +static void qcom_mhi_qrtr_status_callback(struct mhi_device *mhi_dev,
> +					  enum mhi_callback mhi_cb)
> +{
> +	struct qrtr_mhi_dev *qdev = dev_get_drvdata(&mhi_dev->dev);
> +	struct qrtr_mhi_pkt *pkt;
> +	unsigned long flags;
> +
> +	if (mhi_cb != MHI_CB_FATAL_ERROR)
> +		return;
> +
> +	atomic_inc(&qdev->in_reset);

You have ul_lock close at hand in both places where you access in_reset,
so I think it would be better to just use that, instead of an atomic.

> +	spin_lock_irqsave(&qdev->ul_lock, flags);
> +	list_for_each_entry(pkt, &qdev->ul_pkts, node)
> +		complete_all(&pkt->done);
> +	spin_unlock_irqrestore(&qdev->ul_lock, flags);
> +}
> +
> +/* Send data over MHI */
> +static int qcom_mhi_qrtr_send(struct qrtr_endpoint *ep, struct sk_buff *skb)
> +{
> +	struct qrtr_mhi_dev *qdev = container_of(ep, struct qrtr_mhi_dev, ep);
> +	struct qrtr_mhi_pkt *pkt;
> +	int rc;
> +
> +	rc = skb_linearize(skb);
> +	if (rc) {
> +		kfree_skb(skb);
> +		return rc;
> +	}
> +
> +	pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
> +	if (!pkt) {
> +		kfree_skb(skb);
> +		return -ENOMEM;
> +	}
> +
> +	init_completion(&pkt->done);
> +	kref_init(&pkt->refcount);
> +	kref_get(&pkt->refcount);
> +	pkt->skb = skb;
> +
> +	spin_lock_bh(&qdev->ul_lock);
> +	list_add_tail(&pkt->node, &qdev->ul_pkts);
> +	rc = mhi_queue_skb(qdev->mhi_dev, DMA_TO_DEVICE, skb, skb->len,
> +			   MHI_EOT);

Do you want to continue doing this when qdev->in_reset? Wouldn't it be
better to bail early if the remote end is dying?

> +	if (rc) {
> +		list_del(&pkt->node);
> +		/* Reference count needs to be dropped 2 times */
> +		kref_put(&pkt->refcount, qrtr_mhi_pkt_release);
> +		kref_put(&pkt->refcount, qrtr_mhi_pkt_release);
> +		kfree_skb(skb);
> +		spin_unlock_bh(&qdev->ul_lock);
> +		return rc;
> +	}
> +
> +	spin_unlock_bh(&qdev->ul_lock);
> +	if (skb->sk)
> +		sock_hold(skb->sk);
> +
> +	rc = wait_for_completion_interruptible_timeout(&pkt->done, HZ * 5);
> +	if (atomic_read(&qdev->in_reset))
> +		rc = -ECONNRESET;
> +	else if (rc == 0)
> +		rc = -ETIMEDOUT;

Is this recoverable? The message will remain on the list and may be
delivered at a later point(?), but qrtr and the app will learn that the
message was lost - which is presumably considered fatal.

Is it guaranteed that qcom_mhi_qrtr_ul_callback() will happen later and
find the head of the list?


The reason for my question is that without this you have one of two
scenarios;
1) the message is put on the list, decremented in
qcom_mhi_qrtr_ul_callback() then we get back here and decrement it
again.
2) the message is put on the list, then qcom_mhi_qrtr_status_callback()
happens and all messages are released - presumably then
qcom_mhi_qrtr_ul_callback() won't happen.


So if the third case (where we return here and then later
qcom_mhi_qrtr_ul_callback() must find this particular packet at the
front of the queue) can't happen, then you can just skip the entire
refcounting.

Further more, you could carry qrtr_mhi_pkt on the stack.


...or to flip this around, is there a reason to wait here at all? What
would happen if you just return immediately after calling
mhi_queue_skb()? Wouldn't that provide you better throughput?

> +	else if (rc > 0)
> +		rc = 0;
> +
> +	kref_put(&pkt->refcount, qrtr_mhi_pkt_release);
> +
> +	return rc;
> +}
> +
> +static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
> +			       const struct mhi_device_id *id)
> +{
> +	struct qrtr_mhi_dev *qdev;
> +	u32 net_id;
> +	int rc;
> +
> +	qdev = devm_kzalloc(&mhi_dev->dev, sizeof(*qdev), GFP_KERNEL);
> +	if (!qdev)
> +		return -ENOMEM;
> +
> +	qdev->mhi_dev = mhi_dev;
> +	qdev->dev = &mhi_dev->dev;
> +	qdev->ep.xmit = qcom_mhi_qrtr_send;
> +	atomic_set(&qdev->in_reset, 0);
> +
> +	net_id = QRTR_EP_NID_AUTO;

Just pass QRTR_EP_NID_AUTO directly in the function call below.

Regards,
Bjorn

> +
> +	INIT_LIST_HEAD(&qdev->ul_pkts);
> +	spin_lock_init(&qdev->ul_lock);
> +
> +	dev_set_drvdata(&mhi_dev->dev, qdev);
> +	rc = qrtr_endpoint_register(&qdev->ep, net_id);
> +	if (rc)
> +		return rc;
> +
> +	dev_dbg(qdev->dev, "Qualcomm MHI QRTR driver probed\n");
> +
> +	return 0;
> +}
> +
> +static void qcom_mhi_qrtr_remove(struct mhi_device *mhi_dev)
> +{
> +	struct qrtr_mhi_dev *qdev = dev_get_drvdata(&mhi_dev->dev);
> +
> +	qrtr_endpoint_unregister(&qdev->ep);
> +	dev_set_drvdata(&mhi_dev->dev, NULL);
> +}
> +
> +static const struct mhi_device_id qcom_mhi_qrtr_id_table[] = {
> +	{ .chan = "IPCR" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(mhi, qcom_mhi_qrtr_id_table);
> +
> +static struct mhi_driver qcom_mhi_qrtr_driver = {
> +	.probe = qcom_mhi_qrtr_probe,
> +	.remove = qcom_mhi_qrtr_remove,
> +	.dl_xfer_cb = qcom_mhi_qrtr_dl_callback,
> +	.ul_xfer_cb = qcom_mhi_qrtr_ul_callback,
> +	.status_cb = qcom_mhi_qrtr_status_callback,
> +	.id_table = qcom_mhi_qrtr_id_table,
> +	.driver = {
> +		.name = "qcom_mhi_qrtr",
> +	},
> +};
> +
> +module_mhi_driver(qcom_mhi_qrtr_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm IPC-Router MHI interface driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1
> 
