Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC2CC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18D720787
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O/hBjmLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgCSR5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:57:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgCSR5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=k8TW3yHFBtrZYI9aCCu/XMSUcC9QXBVgRxHR3Kex5ls=; b=O/hBjmLMxo7r971x2zhGqShXOg
        KMJ2Tkon9mJc/xyfiudjOTcl9X8pV20jGWpF+2zt998TwLoOv0xJlAp8Jct/2WtZwofxxIGAQiFau
        wIUUzgQd3W2URbfFEKKcdxyhWQEwV1cqaibx7kZE+Fctn7bHm4YV9ACuQvWF4cxfD3ltLfegfglUf
        4qLoc9EDG4TOtzvP4Xp4qvJt5UJTDZOMbhHoJboSVC6lOYICKG/PjMSPQ+TgwlSDVfP8cbj2pYUog
        g91DKqWi8emKpPipLcElsRfQvcahlP0+8nTA10jYOnpZyDboiHDNJKVdCB1tg0NegkK0jRKEIMLvr
        TabEKeVg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEzQQ-00068Q-Vk; Thu, 19 Mar 2020 17:57:47 +0000
Subject: Re: [RESEND PATCH] mailbox: Add dummy mailbox API implementation
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>, jassisinghbrar@gmail.com
Cc:     leonard.crestez@nxp.com, aisheng.dong@nxp.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20200319174921.18787-1-daniel.baluta@oss.nxp.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d8ce4b21-e737-27ed-bedd-064bee2c7863@infradead.org>
Date:   Thu, 19 Mar 2020 10:57:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319174921.18787-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/20 10:49 AM, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> There are users of mailbox API that could be enabled
> via COMPILE_TEST without select CONFIG_MAILBOX.
> 
> In such cases we got compilation errors, like these:
> 
> ld: drivers/firmware/imx/imx-scu.o: in function `imx_scu_probe':
> imx-scu.c:(.text+0x25e): undefined reference to
> `mbox_request_channel_byname'
> ld: drivers/firmware/imx/imx-scu.o: in function `imx_scu_call_rpc':
> imx-scu.c:(.text+0x4b8): undefined reference to `mbox_send_message'
> ld: drivers/firmware/imx/imx-scu-irq.o: in function
> `imx_scu_enable_general_irq_channel':
> imx-scu-irq.c:(.text+0x34d): undefined reference to
> `mbox_request_channel_byname'
> 
> Fix this by implementing dummy mailbox API when CONFIG_MAILBOX is not
> set.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> resend adding Jassi's email
> 
>  include/linux/mailbox_client.h | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
> index 65229a45590f..ab5d130f0b5c 100644
> --- a/include/linux/mailbox_client.h
> +++ b/include/linux/mailbox_client.h
> @@ -37,6 +37,7 @@ struct mbox_client {
>  	void (*tx_done)(struct mbox_client *cl, void *mssg, int r);
>  };
>  
> +#ifdef CONFIG_MAILBOX
>  struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
>  					      const char *name);
>  struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index);
> @@ -46,4 +47,37 @@ void mbox_client_txdone(struct mbox_chan *chan, int r); /* atomic */
>  bool mbox_client_peek_data(struct mbox_chan *chan); /* atomic */
>  void mbox_free_channel(struct mbox_chan *chan); /* may sleep */
>  
> +#else
> +static inline
> +struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
> +					      const char *name)
> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
> +
> +static inline
> +struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
> +
> +static inline int mbox_send_message(struct mbox_chan *chan, void *mssg)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline int mbox_flush(struct mbox_chan *chan, unsigned long timeout)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline void mbox_client_txdone(struct mbox_chan *chan, int r) { }
> +
> +static inline bool mbox_client_peek_data(struct mbox_chan *chan)
> +{
> +	return false;
> +}
> +
> +static inline void mbox_free_channel(struct mbox_chan *chan) { }
> +#endif
>  #endif /* __MAILBOX_CLIENT_H */
> 


-- 
~Randy
