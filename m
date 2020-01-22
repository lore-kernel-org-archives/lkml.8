Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95A4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25A824689
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579689850;
	bh=U7baVMUBD0atkOvxVpY1i6OsBGZBdoYk6vMsLlamq5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jza7Fs4Qk5G98eH5D9XL7k+IdcMJLnDRh0qdLrgJlX4Vj1N1ALHo/BWksePXzbfK8
	 esdbjl4AGYp+P0Jj8c7N4vJvWCEPhLcJ0aeFVbDmo57RNJ7qBCTkJSQuOQUox4+N5y
	 P12Lkc0CIvtvyb9Xv2UU7o174lM0utLbwBKz7LAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgAVKoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:44:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgAVKoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:44:09 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FA0224688;
        Wed, 22 Jan 2020 10:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579689848;
        bh=U7baVMUBD0atkOvxVpY1i6OsBGZBdoYk6vMsLlamq5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZXkWgPRYXC9AKBrp3Hlil++Z4lNFiEZjUjC/mAdr53vbH1Wtz8Z2quRd0RSkznGf0
         x8pQmO3goBhNl8wI7rTYrajTkOSfJXw0i+olU0Wb/ZD+Lm1lphPJtg9gDwREphdoRI
         WtwfN8MwqWIKnFv52fFI/Pcmwl9nOYFGbILW9ojY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1iuDUU-000ipx-AG; Wed, 22 Jan 2020 10:44:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 Jan 2020 10:44:06 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't confuse get_vlpi_map() by
 writing DB config
In-Reply-To: <20200122085609.658-1-yuzenghui@huawei.com>
References: <20200122085609.658-1-yuzenghui@huawei.com>
Message-ID: <4aaaad3ae7367c5c932c430e18550d9e@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

Thanks for this.

On 2020-01-22 08:56, Zenghui Yu wrote:
> When we're writing config for the doorbell interrupt, get_vlpi_map() 
> will
> get confused by doorbell's d->parent_data hack and find the wrong 
> its_dev
> as chip data and the wrong event.
> 
> Fix this issue by making sure no doorbells will be involved before 
> invoking
> get_vlpi_map(), which restore some of the logic in lpi_write_config().
> 
> Fixes: c1d4d5cd203c ("irqchip/gic-v3-its: Add its_vlpi_map helpers")
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
> 
> This is based on mainline and can't be directly applied to the current
> irqchip-next.
> 
>  drivers/irqchip/irq-gic-v3-its.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index e05673bcd52b..cc8a4fcbd6d6 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1181,12 +1181,13 @@ static struct its_vlpi_map
> *get_vlpi_map(struct irq_data *d)
> 
>  static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
>  {
> -	struct its_vlpi_map *map = get_vlpi_map(d);
>  	irq_hw_number_t hwirq;
>  	void *va;
>  	u8 *cfg;
> 
> -	if (map) {
> +	if (irqd_is_forwarded_to_vcpu(d)) {
> +		struct its_vlpi_map *map = get_vlpi_map(d);
> +
>  		va = page_address(map->vm->vprop_page);
>  		hwirq = map->vintid;

Shouldn't we fix get_vlpi_map() instead? Something like (untested):

diff --git a/drivers/irqchip/irq-gic-v3-its.c 
b/drivers/irqchip/irq-gic-v3-its.c
index e05673bcd52b..b704214390c0 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1170,13 +1170,14 @@ static void its_send_vclear(struct its_device 
*dev, u32 event_id)
   */
  static struct its_vlpi_map *get_vlpi_map(struct irq_data *d)
  {
-	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
-	u32 event = its_get_event_id(d);
+	if (irqd_is_forwarded_to_vcpu(d)) {
+		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+		u32 event = its_get_event_id(d);

-	if (!irqd_is_forwarded_to_vcpu(d))
-		return NULL;
+		return dev_event_to_vlpi_map(its_dev, event);
+	}

-	return dev_event_to_vlpi_map(its_dev, event);
+	return NULL;
  }

  static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)


Or am I missing the actual problem?

Overall, I'm starting to hate that ->parent hack as it's been the source
of a number of bugs.

The main issue is that the VPE hierarchy is missing one level (it has
no ITS domain, and goes directly from the VPE domain to the low-level
GIC domain). It means we end-up special-casing things, and that's never
good...

         M.
-- 
Jazz is not dead. It just smells funny...
