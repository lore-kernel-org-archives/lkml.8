Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B511C2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 02:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E3B24655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 02:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsZXbwYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgAVCbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 21:31:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34905 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgAVCbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 21:31:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id i23so2547003pfo.2;
        Tue, 21 Jan 2020 18:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=7aOoEW/v4ZBMRBcWQsOtFSrMdeixlozJh486/30lCpI=;
        b=UsZXbwYv6ZPR85IYYFx6cqsS88eCBPdn2suqm1SAcOc4k6M/j0Ef6wsF9JpKi42CJm
         f/+/3ZXJNLNqOl05qIJcJQv65XodmdZagSLhLBttR5OKdWdcD8m4VkOsiSowhCeFJMSO
         jp6BcPOlAKICFeM+ugu4wWnnsFgWIFYB0lPIeoPcJhN1gASSlATGTfJOnnDlHSicjz2Z
         1TxY1buC/UXzrHcEND4KdRiZMGpIPOBDIzI1ooXSIpRZopvqlROX3GMcUepjiW7mdZOA
         vVPEqlU/EbCJ/4oa2epCd618Yo9Dsvze9IzY0qycqpFkPqDhGXIVTxsZaQ6X675Bw+dO
         EK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=7aOoEW/v4ZBMRBcWQsOtFSrMdeixlozJh486/30lCpI=;
        b=UYD6KAlrHV8FBmqmEgdtprG6WzoZKdwoca8VTZQ2k5LjNLwAidsM6Qk/rSeSnMuGON
         QyA4ZPX6/u2MMDCSXzv7cZwciGmC9yxVhB1QZvTc7SPuLqHsTerRLkAhKbQmHHwGIXGJ
         gPNbEsBYaCjMCI2+IZM5lHmVM2TER/yGp+Dshk5YpqhCcbUoGwd1AxhOFxT0WblKvPNN
         vjKiinK++p1wO0u3rgM7JKb6JRZw9E74xMYZS0o4ySAIqQG7iiqD5fyQQVmSvRdYoaCk
         aPVQcwtzyoQmB9/CzzZrtgQswpkw7SQuJu01fszOS8hNVXlbRcHTEZbKHQrd80mcg93K
         NIAw==
X-Gm-Message-State: APjAAAVA+Vka8pehft0rT5LqsdjbzzmSTrRyKLYxHBqWZBaVQUIRfniK
        8VKFhIa/+0GOEoNhwrf2fuI=
X-Google-Smtp-Source: APXvYqzzykB4VB6XmCbFShAZ7DHf/87RgXhEgonHv5Eezjy7eiPDckPWa7PJMHXnCFN0xgBC272P5A==
X-Received: by 2002:a63:780d:: with SMTP id t13mr8373607pgc.82.1579660293931;
        Tue, 21 Jan 2020 18:31:33 -0800 (PST)
Received: from EliteBook (174-17-125-110.phnx.qwest.net. [174.17.125.110])
        by smtp.gmail.com with ESMTPSA id 11sm46222260pfz.25.2020.01.21.18.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jan 2020 18:31:33 -0800 (PST)
Date:   Tue, 21 Jan 2020 19:31:31 -0700
From:   Paul Zimmerman <pauldzim@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Heinzelmann <heinzelmann.david@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [REGRESSION][BISECTED] 5.5-rc suspend/resume failure caused by
 patch a4f55d8b8c14 ("usb: hub: Check device descriptor before
 resusciation")
Message-ID: <20200121193131.070a28bf@EliteBook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020 13:52:15 -0700 Paul Zimmerman <pauldzim@gmail.com> wrote:

> On Mon, 20 Jan 2020 10:23:11 -0500 (EST) Alan Stern <stern@rowland.harvard.edu> wrote:
>   
> > On Sun, 19 Jan 2020, Paul Zimmerman wrote:
> >     
> > > I reported this regression last week (see
> > > https://lore.kernel.org/linux-usb/20200115153714.03d5b3aa@EliteBook/T/#u)
> > > but I got no response to my email. Today I have retested with
> > > 5.5-rc7 and verified that the problem still exists. So I am
> > > resending with a different subject line to see if anyone responds.
> > > 
> > > The $subject patch causes a regression on my HP EliteBook laptop
> > > with a built-in USB bluetooth adapter. About 50% of the time, a
> > > suspend/resume cycle will cause the bluetooth adapter to stop
> > > working.
> > > 
> > > The dmesg log below shows two suspend/resume cycles. At time
> > > 63.928 you can see the bluetooth adapter being successfully
> > > resumed, and at time 140.969 you can see it fail. After reverting
> > > the patch, the bluetooth adapter resumes 100% of the time.
> > > 
> > > I also included below a lsusb -v of the bluetooth adapter. Is
> > > there any other debugging info you'd like me to send?      
> > 
> > It looks like your dmesg log was made without enabling debugging 
> > messages in usbcore.  Can you collect another log with debugging 
> > messages turned on?
> > 
> > 	echo 'module usbcore =p'    
> > >/sys/kernel/debug/dynamic_debug/control    
> > 
> > Also, it might not hurt to collect and post a usbmon trace for a bad
> > suspend-resume cycle.    
> 
> Hi Alan,
> 
> Thanks for responding. The new dmesg log and the usbmon trace are
> below. The dmesg shows a good suspend/resume followed by a bad one.
> The bluetooth device is usb 2-3.2 I believe. The usbmon trace is only
> for the failed suspend/resume case.  

I did some more debugging on this using ftrace, here is an annotated
log that shows what I think is happening on a failed resume. Note that
hub_port_connect_change() is the function that the patch modified to
call usb_get_device_descriptor() in some circumstances.

This first call to hub_port_connect_change() is for a different device,
not the failing one. There are multiple other calls to that function in
the trace, but they are not for the device in question:
     kworker/1:6-19987 [001]  7803.175058: funcgraph_entry:                      |  hub_port_connect_change() {
     kworker/1:6-19987 [001]  7803.175069: funcgraph_entry:      ! 11911.151 us  |    usb_get_device_descriptor();
     kworker/2:5-20675 [002]  7803.179333: funcgraph_entry:                      |  usb_probe_interface() {

Starting here is a worker thread that is trying to setup the bluetooth
adapter after the resume:
   kworker/u17:1-3175  [002]  7803.179457: funcgraph_entry:                      |  hci_power_on() {
   kworker/u17:1-3175  [002]  7803.179458: funcgraph_entry:                      |    hci_dev_do_open() {
   kworker/u17:1-3175  [002]  7803.179468: funcgraph_entry:                      |      btusb_setup_intel() {
     kworker/2:5-20675 [002]  7803.179480: funcgraph_exit:       ! 147.596 us    |  }

And here is a worker thread that is handling the connect change on the USB
port with the bluetooth device. This happens while the btusb_setup_intel()
function called by the other thread above is still running:
     kworker/3:1-16790 [003]  7803.181323: funcgraph_entry:                      |  hub_port_connect_change() {
     kworker/3:1-16790 [003]  7803.181330: funcgraph_entry:                      |    usb_get_device_descriptor() {
     kworker/0:2-19962 [000]  7803.184885: funcgraph_entry:        6.016 us      |  hub_port_connect_change();
     kworker/0:2-19962 [000]  7803.187208: funcgraph_entry:        5.462 us      |  hub_port_connect_change();
     kworker/1:6-19987 [001]  7803.187835: funcgraph_exit:       ! 12776.810 us  |  }
     kworker/1:6-19987 [001]  7803.187846: funcgraph_entry:      ! 767445.344 us |  hub_port_connect_change();

By this point the failure has happened ("Bluetooth: hci0: Reading Intel
version information failed (-110)") , and it looks like somebody
queues another work to try setting up the bluetooth adapter again:
       hciconfig-21074 [000]  7803.193549: funcgraph_entry:                      |  hci_dev_open() {
     kworker/1:6-19987 [001]  7803.955315: funcgraph_entry:      ! 144039.307 us |  hub_port_connect_change();
   kworker/u17:1-3175  [003]  7805.203325: funcgraph_exit:       ! 2023855 us    |      }
   kworker/u17:1-3175  [003]  7805.211728: funcgraph_exit:       ! 2032269 us    |    }
   kworker/u17:1-3175  [003]  7805.211731: funcgraph_exit:       ! 2032273 us    |  }
       hciconfig-21074 [000]  7805.211760: funcgraph_entry:                      |    hci_dev_do_open() {
       hciconfig-21074 [000]  7805.211777: funcgraph_entry:      ! 3069605 us    |      btusb_setup_intel();

And here the usb_get_device_descriptor() call made by the USB worker thread
finally completes. It also fails ("kworker/3:1 timed out on ep0in len=0/18"):
     kworker/3:1-16790 [003]  7808.277224: funcgraph_exit:       ! 5095893 us    |    }
       hciconfig-21074 [001]  7808.283313: funcgraph_exit:       ! 3071554 us    |    }
       hciconfig-21074 [001]  7808.283315: funcgraph_exit:       ! 5089767 us    |  }

So if I'm understanding this correctly, there are two threads that are
trying to access the USB bluetooth device at the same time. I have no
idea if that is how it's supposed to work.

Thanks,
Paul
