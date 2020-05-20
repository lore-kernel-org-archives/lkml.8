Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F06BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD072072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xuJe0Zw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgETOzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:55:19 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47744 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETOzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:55:18 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04KEt56t020122;
        Wed, 20 May 2020 09:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589986505;
        bh=uJ0Vb5JIqEbT+TGiMoMQolR3yOEu9tZTebuogh5jPAo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xuJe0Zw/zFQOXCbcSMXGjCSeSmOUmVLI/NbPQ87oDS3XnASIpv/BgAL4sMY+84Axm
         tRVqM98LZce2N81zbzOjsdBoXlhC3fQPgm8hy//EimncRw3EOJqT4a4OO9pkuQAMcx
         ZC0IRN5z2x+vFaI4+UYPgBkEVWP6RDS67VPvvafU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04KEt5nq037164
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 09:55:05 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 20
 May 2020 09:55:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 20 May 2020 09:55:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04KEt5Jw096887;
        Wed, 20 May 2020 09:55:05 -0500
Date:   Wed, 20 May 2020 09:55:05 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     Michael Grzeschik <m.grzeschik@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <russell@personaltelco.net>,
        <fercerpav@gmail.com>
Subject: Re: [PATCH v1] usb: musb: dsps: set MUSB_DA8XX quirk for AM335x
Message-ID: <20200520145505.GC15845@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, russell@personaltelco.net,
        fercerpav@gmail.com
References: <20200327053849.5348-1-o.rempel@pengutronix.de>
 <20200519221851.GA15845@iaqt7>
 <20200520044934.hyngdg774ibqai46@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200520044934.hyngdg774ibqai46@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 06:49:34AM +0200, Oleksij Rempel wrote:
> On Tue, May 19, 2020 at 05:18:51PM -0500, Bin Liu wrote:
> > Hi,
> > 
> > On Fri, Mar 27, 2020 at 06:38:49AM +0100, Oleksij Rempel wrote:
> > > Beagle Bone Black has different memory corruptions if kernel is
> > > configured with USB_TI_CPPI41_DMA=y. This issue is reproducible with
> > > ath9k-htc driver (ar9271 based wifi usb controller):
> > > 
> > > root@AccessBox:~ iw dev wlan0 set monitor  fcsfail otherbss
> > > root@AccessBox:~ ip l s dev wlan0 up
> > > kmemleak: Cannot insert 0xda577e40 into the object search tree (overlaps existing)
> > > CPU: 0 PID: 176 Comm: ip Not tainted 5.5.0 #7
> > > Hardware name: Generic AM33XX (Flattened Device Tree)
> > > [<c0112c14>] (unwind_backtrace) from [<c010dc98>] (show_stack+0x18/0x1c)
> > > [<c010dc98>] (show_stack) from [<c08c7c2c>] (dump_stack+0x84/0x98)
> > > [<c08c7c2c>] (dump_stack) from [<c02c75a8>] (create_object+0x2f8/0x324)
> > > [<c02c75a8>] (create_object) from [<c02b8928>] (kmem_cache_alloc+0x1a8/0x39c)
> > > [<c02b8928>] (kmem_cache_alloc) from [<c072fb68>] (__alloc_skb+0x60/0x174)
> > > [<c072fb68>] (__alloc_skb) from [<bf0c5c58>] (ath9k_wmi_cmd+0x50/0x184 [ath9k_htc])
> > > [<bf0c5c58>] (ath9k_wmi_cmd [ath9k_htc]) from [<bf0cb410>] (ath9k_regwrite_multi+0x54/0x84 [ath9k_htc])
> > > [<bf0cb410>] (ath9k_regwrite_multi [ath9k_htc]) from [<bf0cb7fc>] (ath9k_regwrite+0xf0/0xfc [ath9k_htc])
> > > [<bf0cb7fc>] (ath9k_regwrite [ath9k_htc]) from [<bf1aca78>] (ar5008_hw_process_ini+0x280/0x6c0 [ath9k_hw])
> > > [<bf1aca78>] (ar5008_hw_process_ini [ath9k_hw]) from [<bf1a66ac>] (ath9k_hw_reset+0x270/0x1458 [ath9k_hw])
> > > [<bf1a66ac>] (ath9k_hw_reset [ath9k_hw]) from [<bf0c9588>] (ath9k_htc_start+0xb0/0x22c [ath9k_htc])
> > > [<bf0c9588>] (ath9k_htc_start [ath9k_htc]) from [<bf0eb3c0>] (drv_start+0x4c/0x1e8 [mac80211])
> > > [<bf0eb3c0>] (drv_start [mac80211]) from [<bf104a84>] (ieee80211_do_open+0x480/0x954 [mac80211])
> > > [<bf104a84>] (ieee80211_do_open [mac80211]) from [<c075127c>] (__dev_open+0xdc/0x160)
> > > [<c075127c>] (__dev_open) from [<c07516a8>] (__dev_change_flags+0x1a4/0x204)
> > > [<c07516a8>] (__dev_change_flags) from [<c0751728>] (dev_change_flags+0x20/0x50)
> > > [<c0751728>] (dev_change_flags) from [<c076971c>] (do_setlink+0x2ac/0x978)
> > > 
> > > After applying this patch, the system is running in monitor mode without
> > > noticeable issues.
> > > 
> > > Suggested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
> > >  drivers/usb/musb/musb_dsps.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> > > index 88923175f71e..c01f9e9e69f5 100644
> > > --- a/drivers/usb/musb/musb_dsps.c
> > > +++ b/drivers/usb/musb/musb_dsps.c
> > > @@ -690,7 +690,7 @@ static void dsps_dma_controller_resume(struct dsps_glue *glue) {}
> > >  #endif /* CONFIG_USB_TI_CPPI41_DMA */
> > >  
> > >  static struct musb_platform_ops dsps_ops = {
> > > -	.quirks		= MUSB_DMA_CPPI41 | MUSB_INDEXED_EP,
> > > +	.quirks		= MUSB_DMA_CPPI41 | MUSB_INDEXED_EP | MUSB_DA8XX,
> > 
> > The MUSB_DA8XX flag cannot be simply applied to MUSB_DSPS, at least the
> > teardown and autoreq register offsets are different as show in
> > cppi41_dma_controller_create().
> 
> ok
> 
> > Do you understand what exactly caused the issue?
> 
> No.
> 
> Disabling DMA support "solve" this issue as well.
> 
> Beside, with DMA support, there remains one more crash with different symptoms.
> I can workaround it by disabling CPU Freq governor, or setting it to performance.
> 
> > The kernel trace above doesn't provide enuough information.
> 
> Do you have any suggestions how to instrument the kernel to get needed
> information? Or, should I try to capture USB traffic before the crash? 

First can you please try the following patch instead?

diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index 7fbb8a307145..26c996f8b2bd 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -614,7 +614,6 @@ static int cppi41_dma_channel_abort(struct dma_channel *channel)
        }

        /* DA8xx Advisory 2.3.27: wait 250 ms before to start the teardown */
-       if (musb->ops->quirks & MUSB_DA8XX)
                mdelay(250);

        tdbit = 1 << cppi41_channel->port_num;

> 
> If it helps, ath9k_htc is a usb wifi adapter. It generates a lot of
> USB traffic on multiple endpoints. Bulk with data packets and Interrupt
> with register accesses, LED blinking... etc.

Do you have a link to the picture or description of the adapter? I'd like
to see if I can buy the same to take a look.

-Bin.
