Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B734C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AEC72078A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LSBTXbot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgHXCSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 22:18:52 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49156 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgHXCSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 22:18:51 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 26B72279;
        Mon, 24 Aug 2020 04:18:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1598235529;
        bh=RoKm8ixOBiN9I2lstV2sr8M8mjB5HkR5dbHfe1S+R6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LSBTXbotaqk4zEATQtqy3tif3cy2aX0VWWOHz4zL6NpNtJd98yHd5wvzGsfROtNcO
         xWUb9l40Cx422WfaSjzi75UhfCiwWklums84WckO3yPJz34oyF9GqcBv7+7WHU8mXw
         VAhu3HBjGc3mgv2PFNofwHKtX10v8KdKByjginOg=
Date:   Mon, 24 Aug 2020 05:18:30 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Swapnil Jakhade <sjakhade@cadence.com>, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, jonas@kwiboo.se, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        yamonkar@cadence.com, jsarha@ti.com, nsekhar@ti.com,
        praneeth@ti.com
Subject: Re: [PATCH v8 2/3] drm: bridge: Add support for Cadence MHDP DPI/DP
 bridge
Message-ID: <20200824021830.GZ6002@pendragon.ideasonboard.com>
References: <1596713672-8146-1-git-send-email-sjakhade@cadence.com>
 <1596713672-8146-3-git-send-email-sjakhade@cadence.com>
 <20200811023622.GC13513@pendragon.ideasonboard.com>
 <49c2a4c8-6d84-6164-d350-6a985fc9a3e9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49c2a4c8-6d84-6164-d350-6a985fc9a3e9@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On Fri, Aug 14, 2020 at 12:29:35PM +0300, Tomi Valkeinen wrote:
> On 11/08/2020 05:36, Laurent Pinchart wrote:
> 
> >> +static int cdns_mhdp_mailbox_write(struct cdns_mhdp_device *mhdp, u8 val)
> >> +{
> >> +	int ret, full;
> >> +
> >> +	WARN_ON(!mutex_is_locked(&mhdp->mbox_mutex));
> >> +
> >> +	ret = readx_poll_timeout(readl, mhdp->regs + CDNS_MAILBOX_FULL,
> >> +				 full, !full, MAILBOX_RETRY_US,
> >> +				 MAILBOX_TIMEOUT_US);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	writel(val, mhdp->regs + CDNS_MAILBOX_TX_DATA);
> >> +
> >> +	return 0;
> >> +}
> > 
> > As commented previously, I think there's room for optimization here. Two
> > options that I think should be investigated are using the mailbox
> > interrupts, and only polling for the first byte of the message
> > (depending on whether the firmware implementation can guarantee that
> > when the first byte is available, the rest of the message will be
> > immediately available too). This can be done on top of this patch
> > though.
> 
> I made some tests on this.
> 
> I cannot see mailbox_write ever looping, mailbox is never full. So in this case the
> readx_poll_timeout() call is there just for safety to catch the cases where something has gone
> totally wrong or perhaps once in a while the mbox can be full for a tiny moment. But we always do
> need to check CDNS_MAILBOX_FULL before each write to CDNS_MAILBOX_TX_DATA, so we can as well use
> readx_poll_timeout for that to catch the odd cases (afaics, there's no real overhead if the exit
> condition is true immediately).
> 
> mailbox_read polls sometimes. Most often it does not poll, as the data is ready in the mbox, and in
> these cases the situation is the same as for mailbox_write.
> 
> The cases where it does poll are related to things where the fw has to wait for something. The
> longest poll waits seemed to be EDID read (16 ms wait) and adjusting LT (1.7 ms wait). And afaics,
> when the first byte of the received message is there, the rest of the bytes will be available
> without wait.
> 
> For mailbox_write and for most mailbox_reads I think using interrupts makes no sense, as the
> overhead would be big.
> 
> For those few long read operations, interrupts would make sense. I guess a simple way to handle this
> would be to add a new function, wait_for_mbox_data() or such, which would use the interrupts to wait
> for mbox not empty. This function could be used in selected functions (edid, LT) after
> cdns_mhdp_mailbox_send().
> 
> Although I think it's not that bad currently, MAILBOX_RETRY_US is 1ms, so it's quite lazy polling,
> so perhaps this can be considered TODO optimization.

I'm fine with TODO optimization.

-- 
Regards,

Laurent Pinchart
