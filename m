Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D43C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 05:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58113207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 05:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595311177;
	bh=MIJOMLgYWmL4iYFNkn09Czpo8FFKvRuXARB/inYWKag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YqlPH67qWwrXqDwXL+ZwEj4j2oxsuSuNGCG6MdbCz+M4iIKHI7u62/QMD33iy0SQZ
	 2Dj7kO87G6+G5OvvNl7q3LAwtVtAXvpUPlwpe1iqvJReJ0gEiJ1paZWhm13FYzXp9/
	 gULHbdsFDvpYu/H6R7rRmRU3sk6t5++7JaP6fy+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgGUF7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 01:59:24 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:35165 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgGUF7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 01:59:24 -0400
Received: by mail-wr1-f52.google.com with SMTP id z2so19953368wrp.2;
        Mon, 20 Jul 2020 22:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yn+IvGYcGADoyV/li1kx8w6qqUr66L1fqMcGdqGychA=;
        b=PjCbu2c5/HBDNxl2KyyhzDOM1FEPy+J+dPhQORs1T3mcHpsBcfq0LPOW2psZTS1vFS
         4YzURtLV66x9Sbh0dot1vRZM5NvKRZ5rw9DDRMJLbbNWGDRCzHqzU/rnh1XCQNBMfPFb
         ltoOU3js1kpKQAQUXweIRmVnYpLCbME7+uo5NlzU7CkrP/Sg3H2CjT0CrxCvgfB2/x+j
         b4mqhbXAHuhGvepoT3UJ4jRq2nL93uAk59W/7dUrSpvNtiTaYrRIHDMl6Tt5AuKYr9px
         /BRdA2kqA/2yjxrqHQlH9R0eKlxxfVwbrgBNWbgYEdekfCVsFEytFEacOJeRBDbucxiW
         KitQ==
X-Gm-Message-State: AOAM531qrRMZ6WaoANk2Ctfsb+1U/6RM/hHZIMJFSow1wZ1S9jBRS+iL
        ZEJw7szzpfa0OjSa8SVwTRY=
X-Google-Smtp-Source: ABdhPJx6zkIXCLbTYl5gajQE79/CHChTPjwr7RpAdw7wESfAwSSTXItZTs4hkyyuaOA61wm8qT+dGg==
X-Received: by 2002:adf:c185:: with SMTP id x5mr27196525wre.403.1595311161402;
        Mon, 20 Jul 2020 22:59:21 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id d132sm1964546wmd.35.2020.07.20.22.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 22:59:20 -0700 (PDT)
Date:   Tue, 21 Jul 2020 07:59:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: kworker/0:3+pm hogging CPU
Message-ID: <20200721055917.GD4061@dhcp22.suse.cz>
References: <20200720083956.GA4074@dhcp22.suse.cz>
 <20200720135857.GB1228057@rowland.harvard.edu>
 <20200720143213.GJ4074@dhcp22.suse.cz>
 <20200720151255.GE1228057@rowland.harvard.edu>
 <20200720163355.GA4061@dhcp22.suse.cz>
 <20200720173807.GJ1228057@rowland.harvard.edu>
 <20200720174530.GB4061@dhcp22.suse.cz>
 <20200720174812.GK1228057@rowland.harvard.edu>
 <20200720181605.GC4061@dhcp22.suse.cz>
 <20200720200243.GA1244989@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720200243.GA1244989@rowland.harvard.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-07-20 16:02:43, Alan Stern wrote:
> On Mon, Jul 20, 2020 at 08:16:05PM +0200, Michal Hocko wrote:
> > On Mon 20-07-20 13:48:12, Alan Stern wrote:
> > > On Mon, Jul 20, 2020 at 07:45:30PM +0200, Michal Hocko wrote:
> > > > On Mon 20-07-20 13:38:07, Alan Stern wrote:
> > > > > On Mon, Jul 20, 2020 at 06:33:55PM +0200, Michal Hocko wrote:
> > > > > > On Mon 20-07-20 11:12:55, Alan Stern wrote:
> > > > > > [...]
> > > > > > > 	sudo echo 'module usbcore =p' >/debug/dynamic_debug/control
> > > > > > > 
> > > > > > > Then wait long enough for some interesting messages to appear in the 
> > > > > > > kernel log (it should only take a few seconds if the worker thread is as 
> > > > > > > busy as you say) and collect the output from the dmesg command.
> > > > > > > 
> > > > > > > To turn dynamic debugging back off when you're finished, use the same 
> > > > > > > command with "=p" changed to "-p".
> > > > > > 
> > > > > > [   95.395815] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
> > > > > > [   95.395824] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
> > > > > > [   95.395838] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
> > > > > > [   95.396016] hub 2-0:1.0: hub_suspend
> > > > > > [   95.396023] usb usb2: bus auto-suspend, wakeup 1
> > > > > > [   95.396029] usb usb2: bus suspend fail, err -16
> > > > > 
> > > > > Okay, that's the problem.  You may get more specific information about 
> > > > > the suspend failure if you turn on dynamic debugging for the xhci-hcd 
> > > > > module (same command as above but with xhci-hcd instead of usbcore).
> > > > 
> > > > Would that help to pinpoint the problem down?
> > > 
> > > It might.  I can't say for sure without seeing the output.
> > 
> > echo 'module xhci-hcd =p' >/sys/kernel/debug/dynamic_debug/control
> > 
> > doesn't yield to any output. I have tried both with and without usbcore
> > debug output enabled. In the former there is no new output and for the
> > later I get the same I have posted earlier.
> 
> Sorry, my mistake.  The module name needs to be "xhci_hcd" with an '_' 
> character, not a '-' character -- the same as what shows up in the lsmod 
> output.


[14766.973734] xhci_hcd 0000:00:14.0: Get port status 2-1 read: 0xe000088, return 0x88
[14766.973738] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0xe000088, return 0x88
[14766.973742] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0xe0002a0, return 0x2a0
[14766.973746] xhci_hcd 0000:00:14.0: Get port status 2-4 read: 0xe0002a0, return 0x2a0
[14766.973750] xhci_hcd 0000:00:14.0: Get port status 2-5 read: 0xe0002a0, return 0x2a0
[14766.973754] xhci_hcd 0000:00:14.0: Get port status 2-6 read: 0xe0002a0, return 0x2a0
[14766.973759] xhci_hcd 0000:00:14.0: Get port status 2-1 read: 0xe000088, return 0x88
[14766.973763] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0xe000088, return 0x88
[14766.973771] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 0 status  = 0xe000088
[14766.973780] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 1 status  = 0xe000088
[14766.973789] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 2 status  = 0xe0002a0
[14766.973798] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 3 status  = 0xe0002a0
[14766.973807] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 4 status  = 0xe0002a0
[14766.973816] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 5 status  = 0xe0002a0
[14766.973830] xhci_hcd 0000:00:14.0: Bus suspend bailout, port over-current detected

Repeating again and again. The last message suggests a HW problem? But
why does the kernel try the same thing over and over?

> You could also try collect a usbmon trace from the .../2u file.  It does 
> seem that bus 2 is where the problem occurs.

a random sample

ffff8882447743c0 2551256361 S Ii:2:001:1 -115:2048 4 <
ffff888040808cc0 2551256367 C Ci:2:001:0 0 4 = 88000000
ffff888040808cc0 2551256373 C Ci:2:001:0 0 4 = 88000000
ffff888040808cc0 2551256377 S Co:2:001:0 s 23 03 001b 0701 0000 0
ffff888040808cc0 2551256384 C Co:2:001:0 0 0
ffff888040808cc0 2551256432 C Co:2:001:0 0 0
ffff888040808cc0 2551256482 C Co:2:001:0 0 0
ffff888040808cc0 2551256531 C Co:2:001:0 0 0
ffff888040808cc0 2551256535 S Co:2:001:0 s 23 03 001b 0705 0000 0
ffff888040808cc0 2551256542 C Co:2:001:0 0 0
ffff888040808cc0 2551256551 C Co:2:001:0 0 0
ffff8882447743c0 2551256555 C Ii:2:001:1 -2:2048 0
ffff888040808cc0 2551256562 S Ci:2:001:0 s a3 00 0000 0001 0004 4 <
ffff888040808cc0 2551256566 C Ci:2:001:0 0 4 = 88000000
ffff888040808cc0 2551256568 S Ci:2:001:0 s a3 00 0000 0002 0004 4 <
ffff888040808cc0 2551256573 S Ci:2:001:0 s a3 00 0000 0003 0004 4 <
ffff888040808cc0 2551256579 S Ci:2:001:0 s a3 00 0000 0004 0004 4 <
ffff888040808cc0 2551256584 S Ci:2:001:0 s a3 00 0000 0005 0004 4 <
ffff888040808cc0 2551256625 S Ci:2:001:0 s a3 00 0000 0006 0004 4 <
ffff888040808cc0 2551256686 S Ci:2:001:0 s a3 00 0000 0001 0004 4 <
ffff888040808cc0 2551256689 C Ci:2:001:0 0 4 = 88000000
ffff888040808cc0 2551256735 C Ci:2:001:0 0 4 = 88000000
ffff888040808cc0 2551256745 C Co:2:001:0 0 0
ffff888040808cc0 2551256748 S Co:2:001:0 s 23 03 001b 0702 0000 0
ffff888040808cc0 2551256755 C Co:2:001:0 0 0
ffff888040808cc0 2551256757 S Co:2:001:0 s 23 03 001b 0703 0000 0
ffff888040808cc0 2551256764 C Co:2:001:0 0 0
ffff888040808cc0 2551256802 C Co:2:001:0 0 0
ffff888040808cc0 2551256843 C Co:2:001:0 0 0
ffff888040808cc0 2551256871 C Co:2:001:0 0 0
ffff8882447743c0 2551256914 C Ii:2:001:1 -2:2048 0
ffff888040808cc0 2551256922 S Ci:2:001:0 s a3 00 0000 0001 0004 4 <
ffff888040808cc0 2551256925 C Ci:2:001:0 0 4 = 88000000
ffff888040808cc0 2551256927 S Ci:2:001:0 s a3 00 0000 0002 0004 4 <
ffff888040808cc0 2551256933 S Ci:2:001:0 s a3 00 0000 0003 0004 4 <
ffff888040808cc0 2551256936 C Ci:2:001:0 0 4 = a0020000
ffff888040808cc0 2551256942 C Ci:2:001:0 0 4 = a0020000
ffff8882447743c0 2551257018 S Ii:2:001:1 -115:2048 4 <
ffff888040808cc0 2551257070 S Ci:2:001:0 s a3 00 0000 0002 0004 4 <
ffff888040808cc0 2551257106 C Co:2:001:0 0 0
ffff888040808cc0 2551257115 C Co:2:001:0 0 0
ffff888040808cc0 2551257125 C Co:2:001:0 0 0
ffff888040808cc0 2551257288 C Co:2:001:0 0 0
ffff888040808cc0 2551257290 S Co:2:001:0 s 23 03 001b 0706 0000 0
ffff888040808cc0 2551257297 C Co:2:001:0 0 0
ffff8882447743c0 2551257300 C Ii:2:001:1 -2:2048 0
ffff888040808cc0 2551257329 S Ci:2:001:0 s a3 00 0000 0001 0004 4 <
ffff888040808cc0 2551257367 S Ci:2:001:0 s a3 00 0000 0002 0004 4 <
ffff888040808cc0 2551257408 S Ci:2:001:0 s a3 00 0000 0004 0004 4 <
ffff888040808cc0 2551257461 C Ci:2:001:0 0 4 = a0020000
ffff8882447743c0 2551257762 S Ii:2:001:1 -115:2048 4 <
ffff888040808cc0 2551257815 S Co:2:001:0 s 23 03 001b 0701 0000 0
ffff888040808cc0 2551257823 C Co:2:001:0 0 0
ffff888040808cc0 2551257839 C Co:2:001:0 0 0
ffff888040808cc0 2551257877 C Co:2:001:0 0 0
ffff888040808cc0 2551257947 C Co:2:001:0 0 0
ffff888040808cc0 2551257996 S Ci:2:001:0 s a3 00 0000 0001 0004 4 <
ffff888040808cc0 2551258005 S Ci:2:001:0 s a3 00 0000 0003 0004 4 <
ffff888040808cc0 2551258017 C Ci:2:001:0 0 4 = a0020000
ffff888040808cc0 2551258057 S Ci:2:001:0 s a3 00 0000 0001 0004 4 <
ffff888040808cc0 2551258140 C Co:2:001:0 0 0
ffff888040808cc0 2551258179 C Co:2:001:0 0 0
ffff888040808cc0 2551258257 C Co:2:001:0 0 0
ffff888040808cc0 2551258265 C Co:2:001:0 0 0
ffff888040808cc0 2551258273 C Co:2:001:0 0 0
ffff888040808cc0 2551258286 C Ci:2:001:0 0 4 = 88000000
ffff888040808cc0 2551258294 C Ci:2:001:0 0 4 = a0020000
ffff888040808cc0 2551258391 C Ci:2:001:0 0 4 = a0020000
ffff888040808cc0 2551258448 C Ci:2:001:0 0 4 = 88000000
ffff888040808cc0 2551258462 C Co:2:001:0 0 0
ffff888040808cc0 2551258470 C Co:2:001:0 0 0
ffff888040808cc0 2551258486 C Co:2:001:0 0 0
-- 
Michal Hocko
SUSE Labs
