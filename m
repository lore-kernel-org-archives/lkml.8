Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E14C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 15:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9B5207BC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 15:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K9ghdPHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgFFP0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 11:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbgFFP0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 11:26:35 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B233BC08C5C2
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 08:26:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y18so4896098plr.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bdDQGQlfMyBLNXHlU2gdYlCWamJEqiCQQxBbDFu1aeM=;
        b=K9ghdPHNAlyzGuATlYcfEHNxLaHm4h9S2LHHY/dMpyLgOo4v3RreEZntj66ZLPdaic
         rAw0SWHdhck6AUnJoLnntMvLA/N76aAcUMS1IstEVw3vQaoyA9npBZvZVLCCtlLe9sAf
         q6cOxcFgOpBHPQ0mZNhcvDODp/CzSFlEyoWEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bdDQGQlfMyBLNXHlU2gdYlCWamJEqiCQQxBbDFu1aeM=;
        b=apZb+oLgY+k/winljkaQmRo83ErSom/WYoY/PX/n5aG7VGhSiPpCnoYQLfnB8Zl/cA
         l9Do5YmUknzb71OqA741x+aAUr+Uc3Ec5Yp9KGES1zkEQU/lPUIsLuzPerz+aCiqlzkF
         WWCUVM8qP6IroBtTCwqX2rnbLyOBC4P5xDWsce0TNZsAOH1y14EW7W7nCMHYYCUNIfyg
         fIinE3idvC1evMySjQ48k2zQoGuNnHIBiH5GpTrIkizUXr9NYyuZSHQoOousqpgt7u/e
         RcQuFQ0d7ZF7f0LKrDnOCv5dbNdxu5apLT+XrSaQdXbjUD+cQDkuii7vUGp7IkcQEGMF
         EIBQ==
X-Gm-Message-State: AOAM532cZ9mmfKEfZT4x8fKbC6owj/NQ544qHxfx8t374/HLNwwidQ9F
        ZKSYszKW2pltg98n9VAerCDpqA==
X-Google-Smtp-Source: ABdhPJwBATYFPJ7Fwfk/1+/kvzEPGCdlVMRuOFUkvWLBdcyrFSrRgLoIy939Wrz41s26vJNamrsEHg==
X-Received: by 2002:a17:90a:65c5:: with SMTP id i5mr8534128pjs.155.1591457194172;
        Sat, 06 Jun 2020 08:26:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id x197sm2697496pfc.13.2020.06.06.08.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2020 08:26:33 -0700 (PDT)
Date:   Sat, 6 Jun 2020 08:26:32 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     bgodavar@codeaurora.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>,
        Zijun Hu <zijuhu@codeaurora.org>, linux-kernel@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Claire Chang <tientzu@chromium.org>
Subject: Re: [PATCH 1/3] Bluetooth: hci_qca: Only remove TX clock vote after
 TX is completed
Message-ID: <20200606152632.GR4525@google.com>
References: <20200605184611.252218-1-mka@chromium.org>
 <20200605114552.1.I7bcad9d672455473177ddbc7db08cc1adcdee1dc@changeid>
 <534a51662c623a512780e20162138469@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <534a51662c623a512780e20162138469@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bala,

On Sat, Jun 06, 2020 at 06:23:13PM +0530, bgodavar@codeaurora.org wrote:
> Hi Matthias,
> 
> On 2020-06-06 00:16, Matthias Kaehlcke wrote:
> > qca_suspend() removes the vote for the UART TX clock after
> > writing an IBS sleep request to the serial buffer. This is
> > not a good idea since there is no guarantee that the request
> > has been sent at this point. Instead remove the vote after
> > successfully entering IBS sleep. This also fixes the issue
> > of the vote being removed in case of an aborted suspend due
> > to a failure of entering IBS sleep.
> > 
> > Fixes: 41d5b25fed0a0 ("Bluetooth: hci_qca: add PM support")
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > 
> >  drivers/bluetooth/hci_qca.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index ece9f91cc3deb..b1d82d32892e9 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -2083,8 +2083,6 @@ static int __maybe_unused qca_suspend(struct
> > device *dev)
> > 
> >  		qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
> >  		qca->ibs_sent_slps++;
> > -
> > -		qca_wq_serial_tx_clock_vote_off(&qca->ws_tx_vote_off);
> >  		break;
> > 
> >  	case HCI_IBS_TX_ASLEEP:
> > @@ -2112,8 +2110,10 @@ static int __maybe_unused qca_suspend(struct
> > device *dev)
> >  			qca->rx_ibs_state == HCI_IBS_RX_ASLEEP,
> >  			msecs_to_jiffies(IBS_BTSOC_TX_IDLE_TIMEOUT_MS));
> > 
> > -	if (ret > 0)
> > +	if (ret > 0) {
> > +		qca_wq_serial_tx_clock_vote_off(&qca->ws_tx_vote_off);
> [Bala]: qca_wq_serial_tx_clock_vote_off votes for Tx clock off, when both Tx
> clock and Rx clock voted to off.
> then only actual call to clock off is called.
> https://elixir.bootlin.com/linux/latest/source/drivers/bluetooth/hci_qca.c#L312
> I would recommend to vote Tx clock off after sending SLEEP BYTE from HOST TO
> BT SOC.

Are you suggesting to move the vote after _wait_until_sent() and before
waiting for RX_SLEEP?

I think if the vote is done before RX_SLEEP and going to RX_SLEEP fails the
variables qca->tx_vote and qca->tx_votes_off would have the wrong state, even
if that doesn't lead to actually switching the clock off. I might be missing
something though, I'm not very familiar with this part.
