Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6970AC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 23:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBEE2465B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 23:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bY/fyKJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgAVXy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 18:54:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41273 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVXy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 18:54:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id t14so504787plr.8;
        Wed, 22 Jan 2020 15:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xH3k99ZFUTR2CTX6CDQPWZxKFVJIF0Rpq9Ykd9dMlnc=;
        b=bY/fyKJ2GJG6of8/QmD1qZPxkEg1xqMmWqhMxq2unytiurzZeU1WcNs7D2KI9t+GKk
         j7fUqFnukAhMNvnmrCvCf0Sk552UpUJasJeue+zVvmTR6TdpwnsS1p4y7cHJpNOsFFR7
         oWESmeZnK2nVmyAA8e3HZfjqTL2P93ZSPlo/+lX2DGnEiFkbAzXKPmsaDzadYFOZqtkz
         +yaGf2YzIFJOoCzDaNxc/xy8pEZxRJHJl8wCwJGfMZ1SBJQ3SipIsw7TM1GcjgOpi4UZ
         6945R8Vvzz01duF2NEiUGzfc5uGJjsuNnGornNt27XIxVs1JdgSH92OrtGAOL/UfIGkI
         G8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xH3k99ZFUTR2CTX6CDQPWZxKFVJIF0Rpq9Ykd9dMlnc=;
        b=Ax6OU4Pkto/Sztm6uToivL7ZyANipTSrVk/luXzVlBp9NIGDmCQcpYRvWcZsczyxVB
         3Ebw62LY9Z1+SaNUBre569uFOwa0JDLmHBWg1CT9hd10pjVSkidRJUGCVbBZIynDBeti
         f/h0STKANEzYPZvuPYRx31is5QPz5GTveD/Q3roF1KMu3ZCyUsUXernwOlB1KFILUi2q
         l2Ko1CW8tCq6rbiET4PSKLV6HceULobxyiwuNveNdqnbactjwr8qKggO6FCCIp/hN8+E
         MBwGHNDkYzbQPISEp6enskCSJk1cEBmEUE4CN25yFP1AbkFPsxMvMeL5/p0VRAeOGUwb
         smog==
X-Gm-Message-State: APjAAAVDOEqtld6bYzeuXO8sAXuVerc/Vi2QOm3ALUwn8arTDZgoKCAp
        qNiMxLn04zorO0+/xcVYp9ZMcz0COVs=
X-Google-Smtp-Source: APXvYqzPl1vPqbDpHWjbAyGl/KPtd2lqs2YfGKY2C5PIFmDzIuiwbYPPKsm7oCQaImJGFM5Rb0+PMg==
X-Received: by 2002:a17:90a:9b88:: with SMTP id g8mr1210521pjp.72.1579737297713;
        Wed, 22 Jan 2020 15:54:57 -0800 (PST)
Received: from EliteBook (174-17-125-110.phnx.qwest.net. [174.17.125.110])
        by smtp.gmail.com with ESMTPSA id b15sm66479pft.58.2020.01.22.15.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 15:54:57 -0800 (PST)
Date:   Wed, 22 Jan 2020 16:54:54 -0700
From:   Paul Zimmerman <pauldzim@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Heinzelmann <heinzelmann.david@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [REGRESSION][BISECTED] 5.5-rc suspend/resume failure caused by
 patch a4f55d8b8c14 ("usb: hub: Check device descriptor before
 resusciation")
Message-ID: <20200122165454.757aaa25@EliteBook>
In-Reply-To: <Pine.LNX.4.44L0.2001221249190.1636-100000@iolanthe.rowland.org>
References: <20200121193131.070a28bf@EliteBook>
        <Pine.LNX.4.44L0.2001221249190.1636-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020 14:31:29 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Tue, 21 Jan 2020, Paul Zimmerman wrote:
> 
> > On Mon, 20 Jan 2020 13:52:15 -0700 Paul Zimmerman <pauldzim@gmail.com> wrote:
> >   
> > > On Mon, 20 Jan 2020 10:23:11 -0500 (EST) Alan Stern <stern@rowland.harvard.edu> wrote:
> > >     
> > > > On Sun, 19 Jan 2020, Paul Zimmerman wrote:
> > > >       
> > > > > I reported this regression last week (see
> > > > > https://lore.kernel.org/linux-usb/20200115153714.03d5b3aa@EliteBook/T/#u)
> > > > > but I got no response to my email. Today I have retested with
> > > > > 5.5-rc7 and verified that the problem still exists. So I am
> > > > > resending with a different subject line to see if anyone responds.
> > > > > 
> > > > > The $subject patch causes a regression on my HP EliteBook laptop
> > > > > with a built-in USB bluetooth adapter. About 50% of the time, a
> > > > > suspend/resume cycle will cause the bluetooth adapter to stop
> > > > > working.
> > > > > 
> > > > > The dmesg log below shows two suspend/resume cycles. At time
> > > > > 63.928 you can see the bluetooth adapter being successfully
> > > > > resumed, and at time 140.969 you can see it fail. After reverting
> > > > > the patch, the bluetooth adapter resumes 100% of the time.
> > > > > 
> > > > > I also included below a lsusb -v of the bluetooth adapter. Is
> > > > > there any other debugging info you'd like me to send?        
> > > > 
> > > > It looks like your dmesg log was made without enabling debugging 
> > > > messages in usbcore.  Can you collect another log with debugging 
> > > > messages turned on?
> > > > 
> > > > 	echo 'module usbcore =p'      
> > > > >/sys/kernel/debug/dynamic_debug/control      
> > > > 
> > > > Also, it might not hurt to collect and post a usbmon trace for a bad
> > > > suspend-resume cycle.      
> > > 
> > > Hi Alan,
> > > 
> > > Thanks for responding. The new dmesg log and the usbmon trace are
> > > below. The dmesg shows a good suspend/resume followed by a bad one.
> > > The bluetooth device is usb 2-3.2 I believe. The usbmon trace is only
> > > for the failed suspend/resume case.    
> 
> It might be interesting to have a usbmon trace of a successful resume 
> as well, for comparison.  However I suspect it would just show that 
> the new Get-Device-Descriptor request worked and everything else 
> continued on normally.

< snip >

> > So if I'm understanding this correctly, there are two threads that are
> > trying to access the USB bluetooth device at the same time. I have no
> > idea if that is how it's supposed to work.  
> 
> In fact it isn't, although in principle this shouldn't cause any
> trouble.  It looks like your bluetooth device is deficient: It
> sometimes crashes if it receives a Get-Device-Descriptor request while
> it is busy with something else.
> 
> Still, since there was no real connection change at the port, there's
> no reason to call hub_port_connect_change() here.  Let's see if the
> patch below fixes your problem.
> 
> Alan Stern
> 
> 
> 
> Index: usb-devel/drivers/usb/core/hub.c
> ===================================================================
> --- usb-devel.orig/drivers/usb/core/hub.c
> +++ usb-devel/drivers/usb/core/hub.c
> @@ -1216,11 +1216,6 @@ static void hub_activate(struct usb_hub
>  #ifdef CONFIG_PM
>  			udev->reset_resume = 1;
>  #endif
> -			/* Don't set the change_bits when the device
> -			 * was powered off.
> -			 */
> -			if (test_bit(port1, hub->power_bits))
> -				set_bit(port1, hub->change_bits);
>  
>  		} else {
>  			/* The power session is gone; tell hub_wq */
> 

I can confirm this fixes the issue for me, I did a couple dozen
suspend/resume cycles without seeing a failure.

I see the code you removed was added by Lan Tianyu in commit
ad493e5e5805 ("usb: add usb port auto power off mechanism"). I
wonder if your patch would break that? I don't know what that is
or how to test it.

In any case:
Tested-by: Paul Zimmerman <pauldzim@gmail.com>
