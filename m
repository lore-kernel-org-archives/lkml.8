Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE67DC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B587F207C4
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kHRhckqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgFFOmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 10:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgFFOmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:42:49 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16609C08C5C2
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 07:42:48 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x11so4867371plv.9
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 07:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uRszDx+SWbrUSA1S9dvL1khB1G3QVBSQcKh5Peg+R5c=;
        b=kHRhckqzf6lsVhYRZE5hxpsmQRw3lkGndVmIteEJTmWrJsvPThCy+KhTwgBNtITuJf
         TjOJtWMig5GLG3otDAPq/wRJHWobLieiuSKjpp8m4lhOnnDA52i/6+ARiHyE8zTpcc1a
         AbM/KA6MUJKRhHqYyPI0OcMBcSVTs+93kK3LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uRszDx+SWbrUSA1S9dvL1khB1G3QVBSQcKh5Peg+R5c=;
        b=hAXYWhp4KiNo/kGJWOI+OW/s2cQF0t0CCi5dkAzZBOdoo3dpzhy0mX0xwV3qCVGcMg
         5CYtFWZYrqSyxsaLrr+13+9wsUQ0P689dUm1wxLKhRswoPHgNzmwSjyjxrW7CfnQzQme
         QWjov5nvldfZUcnq4WuGP0ghw6/oWlszEzJYysfDv2dc/GAGhKknhv8/gqtBLcqnBVjs
         KAaroqXDOfSDnt2cOkIS1B7EyCR/GFWdFjOPR4f7VwCVjJOjVuOGRY28Sp7Ik15P0OaB
         18/wT3wUDmTtVP+xuYSX7+jj9ixyHV8i9RfvKqfaqvzMa0QDsf09rUN/cmjieQgHgq8R
         KpTA==
X-Gm-Message-State: AOAM5324Kj5vU6iBTdKtAljo9xWoIVz+WNjWIDR3R5ZSpV5o/iYE9XKo
        Z7w1VEHElWtHYxYptR3uFAln2h+MGsg=
X-Google-Smtp-Source: ABdhPJzJPm9LWmRykZ+Wwq7yuiFVr8kdt+iI1STB0GexFIGxsUc2AZ1pIQoukw5vm0+Aqnx9QD3lJQ==
X-Received: by 2002:a17:902:a412:: with SMTP id p18mr14119856plq.111.1591454567480;
        Sat, 06 Jun 2020 07:42:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id n24sm10638960pjt.47.2020.06.06.07.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2020 07:42:46 -0700 (PDT)
Date:   Sat, 6 Jun 2020 07:42:45 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     bgodavar@codeaurora.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>,
        Zijun Hu <zijuhu@codeaurora.org>, linux-kernel@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Claire Chang <tientzu@chromium.org>, hemantg@codeaurora.org
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: Skip serdev wait when no
 transfer is pending
Message-ID: <20200606144245.GQ4525@google.com>
References: <20200605184611.252218-1-mka@chromium.org>
 <20200605114552.2.I2a095adb2a9a98b15c11d7310db142b27f8cab28@changeid>
 <ca3bb368e9959770720c8a3fbe149652@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca3bb368e9959770720c8a3fbe149652@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bala,

On Sat, Jun 06, 2020 at 06:27:59PM +0530, bgodavar@codeaurora.org wrote:
> Hi matthias,
> 
> On 2020-06-06 00:16, Matthias Kaehlcke wrote:
> > qca_suspend() calls serdev_device_wait_until_sent() regardless of
> > whether a transfer is pending. While it does no active harm since
> > the function should return immediately it makes the code more
> > confusing. Add a flag to track whether a transfer is pending and
> > only call serdev_device_wait_until_sent() is needed.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > 
> >  drivers/bluetooth/hci_qca.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index b1d82d32892e9..90ffd8ca1fb0d 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -2050,6 +2050,7 @@ static int __maybe_unused qca_suspend(struct
> > device *dev)
> >  	struct hci_uart *hu = &qcadev->serdev_hu;
> >  	struct qca_data *qca = hu->priv;
> >  	unsigned long flags;
> > +	bool tx_pending = false;
> >  	int ret = 0;
> >  	u8 cmd;
> > 
> > @@ -2083,6 +2084,7 @@ static int __maybe_unused qca_suspend(struct
> > device *dev)
> > 
> >  		qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
> >  		qca->ibs_sent_slps++;
> > +		tx_pending = true;
> >  		break;
> > 
> >  	case HCI_IBS_TX_ASLEEP:
> > @@ -2099,8 +2101,10 @@ static int __maybe_unused qca_suspend(struct
> > device *dev)
> >  	if (ret < 0)
> >  		goto error;
> > 
> > -	serdev_device_wait_until_sent(hu->serdev,
> > -				      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
> > +	if (tx_pending) {
> [Bala]: Good idea why don't we move this call to switch case under
> HCI_IBS_TX_AWAKE
> https://elixir.bootlin.com/linux/latest/source/drivers/bluetooth/hci_qca.c#L1994

I agree that this would make the code easier to follow, however the
reason this wasn't done in the first place is (probably) that the
IBS spinlock is held during the switch/case block.

In principle the unlock could be done before calling _wait_until_sent(),
but then the unlock also needs to happen in the other 'case' branches.
It's not ideal, but also not necessarily worse than introducing
'tx_pending', the repeated unlocks might be preferable in terms of
readability.

> i.e. i would recommend below sequence
> 
> 1. Send SLEEP BYTE
> 2. wait for some time to write SLEEP Byte on Tx line
> 3. call for Tx clock off qca_wq_serial_tx_clock_vote_off
> 
> > +		serdev_device_wait_until_sent(hu->serdev,
> > +					      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
> > +	}
> > 
> >  	/* Wait for HCI_IBS_SLEEP_IND sent by device to indicate its Tx is
> > going
> >  	 * to sleep, so that the packet does not wake the system later.
