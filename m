Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679FDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D28322B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595268972;
	bh=lNUGkZCZq4qHIBPrk46OLjVJIXtrZKM6xr/LgNzrfDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lypK38J0K8IKaX3bSBvDzeMKvPQFR5oSSQlqunB0u2a/j8oU8fjYnQuygymjKn69l
	 aulkxvd2Hnj4TkDV1TBKnazv0K2c89uJLsMl93tRSAam1+0y2R9wyqcAsZCqCLX4XX
	 2eHLEfbFYBa5Vn3JDwdbi6ZJeob6MNFgSCeAsaps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgGTSQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:16:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42791 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbgGTSQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:16:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id o11so18777378wrv.9;
        Mon, 20 Jul 2020 11:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HXSsIJUOCvmbyYAUWXz+DeBNCaIkG6xpbOIrdCqj1uo=;
        b=Df7SlEU7nWUi162tgHFplfVFK3z5gkKptqoI0uwFddUv1Co2iSkaP2q7iv66FKnu7p
         hnaXyhjDpa6j4uxg/pY88VTti5ZuMXP1d9XsdcMRMZFwWIkfFnhS3zGC43IkXZted6hG
         /CTaOCA4yLVgsAzVKPdyE1BMXDrWwbziJXwVNvzfnIVi7+LuD7x9K0OdtjsyX2IxdbTB
         dmSP2hPDqoD1mlunRsc69VQIMwZXrZlIEHjUxgMZ05GINGmjol9ZqmxSkH/k5nwmVP25
         EV0bN2RAnJZJTfIkIix8I4/x9SgdYUeMm9frjIZptWtlZD274n3/vo5H/8Ic9uKnmAgH
         WBTg==
X-Gm-Message-State: AOAM5333vAJVHQYSY21JMkCm2LrVKWL0//tmZiKKbV1uuypcHJkRpc+I
        nTDu3byI5NzBCqH/kZFv0VI=
X-Google-Smtp-Source: ABdhPJxtopxet5EFXRABidBi8j39aXqy+hWmkMAJBvpKRfR5By3gTl0qggq/Sw77B7di5086mN7Wsw==
X-Received: by 2002:adf:a15c:: with SMTP id r28mr3902225wrr.151.1595268968556;
        Mon, 20 Jul 2020 11:16:08 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id 69sm462466wma.16.2020.07.20.11.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 11:16:07 -0700 (PDT)
Date:   Mon, 20 Jul 2020 20:16:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: kworker/0:3+pm hogging CPU
Message-ID: <20200720181605.GC4061@dhcp22.suse.cz>
References: <20200720083956.GA4074@dhcp22.suse.cz>
 <20200720135857.GB1228057@rowland.harvard.edu>
 <20200720143213.GJ4074@dhcp22.suse.cz>
 <20200720151255.GE1228057@rowland.harvard.edu>
 <20200720163355.GA4061@dhcp22.suse.cz>
 <20200720173807.GJ1228057@rowland.harvard.edu>
 <20200720174530.GB4061@dhcp22.suse.cz>
 <20200720174812.GK1228057@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720174812.GK1228057@rowland.harvard.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-07-20 13:48:12, Alan Stern wrote:
> On Mon, Jul 20, 2020 at 07:45:30PM +0200, Michal Hocko wrote:
> > On Mon 20-07-20 13:38:07, Alan Stern wrote:
> > > On Mon, Jul 20, 2020 at 06:33:55PM +0200, Michal Hocko wrote:
> > > > On Mon 20-07-20 11:12:55, Alan Stern wrote:
> > > > [...]
> > > > > 	sudo echo 'module usbcore =p' >/debug/dynamic_debug/control
> > > > > 
> > > > > Then wait long enough for some interesting messages to appear in the 
> > > > > kernel log (it should only take a few seconds if the worker thread is as 
> > > > > busy as you say) and collect the output from the dmesg command.
> > > > > 
> > > > > To turn dynamic debugging back off when you're finished, use the same 
> > > > > command with "=p" changed to "-p".
> > > > 
> > > > [   95.395815] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
> > > > [   95.395824] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
> > > > [   95.395838] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
> > > > [   95.396016] hub 2-0:1.0: hub_suspend
> > > > [   95.396023] usb usb2: bus auto-suspend, wakeup 1
> > > > [   95.396029] usb usb2: bus suspend fail, err -16
> > > 
> > > Okay, that's the problem.  You may get more specific information about 
> > > the suspend failure if you turn on dynamic debugging for the xhci-hcd 
> > > module (same command as above but with xhci-hcd instead of usbcore).
> > 
> > Would that help to pinpoint the problem down?
> 
> It might.  I can't say for sure without seeing the output.

echo 'module xhci-hcd =p' >/sys/kernel/debug/dynamic_debug/control

doesn't yield to any output. I have tried both with and without usbcore
debug output enabled. In the former there is no new output and for the
later I get the same I have posted earlier.
-- 
Michal Hocko
SUSE Labs
