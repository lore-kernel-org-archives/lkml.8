Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914C7C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F90620702
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595267136;
	bh=cGefnHWtfmetooCXTtBdDCt125ezpB6aqojzB+rSj7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x6tjsg0cwIlm4be8q7tloLn8eY207hPGksSUyLgDtPLQArwUYC2x4G6fbAirrLKfO
	 MrFU2TA4/xT+VQncaxcMz8rZBAX8FLWzkCdICM3xI5Uow2/oOJbpvFnJCk3dyMTIdp
	 t3Wm7ESiBuO5M4qpEbz+VLF4I71SUmiBHBFKuefU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389213AbgGTRpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:45:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36066 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbgGTRpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 13:45:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id 88so8423818wrh.3;
        Mon, 20 Jul 2020 10:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vCW6rhw++ctPrWxqsobIhIm2YGDrSLQICyPcOqGzVic=;
        b=siDpoCAdCvWJoextvjPas8GjBg9zEnfmkwZKiBFSvbnQw3vY0XNPBWi5E0K4Av7DBQ
         kRTsrl90IZq4vXL7Y5Deb9rA2c7doYFBqRPcGW/Q6u+xlScHArYfq0maeVPiH/mbrxhI
         HdfaH/us07Dio5FaTkDCg57dsUjWz+5kZBJQjDUOj1VRmtqJdoX8jYW9LYt/bc3jXE9E
         DQ73gAhjihEpUpYR/pKCmTcBENNs1jBG8bgdZOfMo82gdZBCf3RFCc7+8Gl2aLn9S/Zn
         AAiepYeDBQavAs3AG2k8n/52y6gEPCcnEQMgwF4/HsDn+616P6B+jlYHccxTzxuAwQz4
         ev+w==
X-Gm-Message-State: AOAM530GDNed28YxmmygG/TTyOVR8a5XvemyUnZ7niMNkkFmNHh2pCVG
        cwjJsB/k6MARY3EOchIDsyM=
X-Google-Smtp-Source: ABdhPJxAmtT2PiCX1cPO/6tiM/WmB4eTtiXp39Jhq6o8XKE02D6H09Ij3QF5Vfe85E2QFp2R2eOgBw==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr23142800wrp.100.1595267132638;
        Mon, 20 Jul 2020 10:45:32 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id r8sm34178512wrp.40.2020.07.20.10.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 10:45:31 -0700 (PDT)
Date:   Mon, 20 Jul 2020 19:45:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: kworker/0:3+pm hogging CPU
Message-ID: <20200720174530.GB4061@dhcp22.suse.cz>
References: <20200720083956.GA4074@dhcp22.suse.cz>
 <20200720135857.GB1228057@rowland.harvard.edu>
 <20200720143213.GJ4074@dhcp22.suse.cz>
 <20200720151255.GE1228057@rowland.harvard.edu>
 <20200720163355.GA4061@dhcp22.suse.cz>
 <20200720173807.GJ1228057@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720173807.GJ1228057@rowland.harvard.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-07-20 13:38:07, Alan Stern wrote:
> On Mon, Jul 20, 2020 at 06:33:55PM +0200, Michal Hocko wrote:
> > On Mon 20-07-20 11:12:55, Alan Stern wrote:
> > [...]
> > > 	sudo echo 'module usbcore =p' >/debug/dynamic_debug/control
> > > 
> > > Then wait long enough for some interesting messages to appear in the 
> > > kernel log (it should only take a few seconds if the worker thread is as 
> > > busy as you say) and collect the output from the dmesg command.
> > > 
> > > To turn dynamic debugging back off when you're finished, use the same 
> > > command with "=p" changed to "-p".
> > 
> > [   95.395815] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
> > [   95.395824] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
> > [   95.395838] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
> > [   95.396016] hub 2-0:1.0: hub_suspend
> > [   95.396023] usb usb2: bus auto-suspend, wakeup 1
> > [   95.396029] usb usb2: bus suspend fail, err -16
> 
> Okay, that's the problem.  You may get more specific information about 
> the suspend failure if you turn on dynamic debugging for the xhci-hcd 
> module (same command as above but with xhci-hcd instead of usbcore).

Would that help to pinpoint the problem down?

> If you want a quick way to prevent this from happening, you can do:
> 
> 	sudo echo on >/sys/bus/usb/devices/usb2/power/control
> 
> That won't actually fix anything, but it will stop the system from 
> automatically trying to suspend usb2 root hub.

Yes, that helped to put some relief to the machine. 

-- 
Michal Hocko
SUSE Labs
