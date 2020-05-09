Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DE2C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 15:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487DC20820
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 15:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgEIPUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 11:20:21 -0400
Received: from foss.arm.com ([217.140.110.172]:59922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgEIPUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 11:20:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7102E30E;
        Sat,  9 May 2020 08:20:20 -0700 (PDT)
Received: from bogus (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C1BC3F305;
        Sat,  9 May 2020 08:20:18 -0700 (PDT)
Date:   Sat, 9 May 2020 16:20:07 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     joe_zhuchg@126.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Joe Zhu <Chunguang.Zhu@verisilicon.com>
Subject: Re: [PATCH 1/1] firmware: arm_scmi/mailbox: ignore notification for
 tx done using irq
Message-ID: <20200509152007.GA18877@bogus>
References: <20200509085457.31920-1-joe_zhuchg@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509085457.31920-1-joe_zhuchg@126.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 04:54:57PM +0800, joe_zhuchg@126.com wrote:
> From: Joe Zhu <Chunguang.Zhu@verisilicon.com>
> 
> If mailbox uses IRQ method, it already notified framework with
> mbox_chan_txdone() in ISR.
> 
> Signed-off-by: Joe Zhu <Chunguang.Zhu@verisilicon.com>
> ---
>  drivers/firmware/arm_scmi/mailbox.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
> index 73077bbc4ad9..303a5dc42429 100644
> --- a/drivers/firmware/arm_scmi/mailbox.c
> +++ b/drivers/firmware/arm_scmi/mailbox.c
> @@ -9,6 +9,7 @@
>  #include <linux/err.h>
>  #include <linux/device.h>
>  #include <linux/mailbox_client.h>
> +#include <linux/mailbox_controller.h>

This is an indication that something is wrong. The mailbox controller
and client interfaces are very clear. You need to use mailbox controller
interface when implementing a mailbox controller and use only client
interface when implementing a mailbox client.

>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/slab.h>
> @@ -147,7 +148,8 @@ static void mailbox_mark_txdone(struct scmi_chan_info *cinfo, int ret)
>  	 * Unfortunately, we have to kick the mailbox framework after we have
>  	 * received our message.
>  	 */
> -	mbox_client_txdone(smbox->chan, ret);
> +	if (!smbox->chan->mbox->txdone_irq)
> +		mbox_client_txdone(smbox->chan, ret);

If this patch is to avoid getting "Client can't run the TX ticker" error
messages, then you make need to fix that with something like below:

Regards,
Sudeep

-->8
diff --git i/drivers/mailbox/mailbox.c w/drivers/mailbox/mailbox.c
index 0b821a5b2db8..5a78a0adcce4 100644
--- i/drivers/mailbox/mailbox.c
+++ w/drivers/mailbox/mailbox.c
@@ -189,7 +189,9 @@ EXPORT_SYMBOL_GPL(mbox_chan_txdone);
 void mbox_client_txdone(struct mbox_chan *chan, int r)
 {
        if (unlikely(!(chan->txdone_method & TXDONE_BY_ACK))) {
-               dev_err(chan->mbox->dev, "Client can't run the TX ticker\n");
+               if (unlikely(!(chan->txdone_method & TXDONE_BY_IRQ)))
+                       dev_err(chan->mbox->dev,
+                               "Client can't run the TX ticker\n");
                return;
        }

