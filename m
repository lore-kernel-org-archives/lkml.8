Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0374FC3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AD42469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qW06oxb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgB1Ac1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:32:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36719 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgB1Ac1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:32:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id i13so746753pfe.3;
        Thu, 27 Feb 2020 16:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s30J624/VP3HrEoGo1r3bYubq6LVO8D9HM/6PcACQO0=;
        b=qW06oxb1fzVXep6BwwNAyOwG70mCiGpQS6B6veLIokygiuOnqSU1PudiZIsyJpuDx2
         Al7uKGJQUorkbQ1IGXFelHFXnR0NglIvfd2Lq/EiNe87HNeRuAgm5FeuRv/GssADtqzS
         tPnRqVZHQnEIK7DGqx7PWnEBCmtfPSElyVDFrTLGyLF0NhgxEItQ9kHYuoQWreLQZdyk
         l7WdZZ5VhrfNjRKEIRBtoelpxmuc4pgibYQ4PJK2iTrnCTuKVzZ4ytwBvEOK5Zpzy7oc
         eThbhOkSJ7pukiWAfWGhr+T/sLtsSdIFkXPifmZ5tQRfIcQSOMVAUQsIhuZCUVVB1d+r
         pURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=s30J624/VP3HrEoGo1r3bYubq6LVO8D9HM/6PcACQO0=;
        b=qLR+98llWly/V6pEoVQoAy6iGXNLXQj9qprzalHAYofvp0sBSdL2QdMNsV8w7WAc+B
         ilI0quHj6IPLSgCanjQ0UvWY3tc08X/P/tfvzmH9/e52A0DCI+s5GVTB5wCsraBupV+q
         JMcd+x6XS09jjKgOp3eVgAFpeBbasmo2VsMiSw/fsIwl+xsfgxl+rkWzjYx8SlGFuLz6
         xsT2ddvdJVglTTgptfMhVujfZHVLg6TE874Xe160oEwEr6LCB0k86hMfAMIb8MyX9d5u
         8Dwq6HGQCecbBs2CBSw6Nr9embWtawPG9sAA3a7DXZsh7nPQk+J1iARBYyuRKLQxsHxa
         8gxQ==
X-Gm-Message-State: APjAAAWg3urrk24IFtoO/iGVai0u33LQHw7Kuu1XdG5VBXkRnElBdSgj
        ow0qyb+rjod0zuYjpBQHrX1+am0s
X-Google-Smtp-Source: APXvYqzm2cVg7M5gfQ2fdWy+5ejprQEPAiNepZFokpFo9yk5YoIstG6fh1BrQPNVAEmApm+3Vm5q/g==
X-Received: by 2002:a63:c550:: with SMTP id g16mr1961644pgd.9.1582849946286;
        Thu, 27 Feb 2020 16:32:26 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u12sm7936215pgr.3.2020.02.27.16.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 16:32:25 -0800 (PST)
Date:   Thu, 27 Feb 2020 16:32:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Antti =?iso-8859-1?Q?Sepp=E4l=E4?= <a.seppala@gmail.com>,
        Boris ARZUR <boris@konbu.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Schiller <ms@dev.tdt.de>
Subject: Re: [RFT PATCH 2/4] usb: dwc2: Do not update data length if it is 0
 on inbound transfers
Message-ID: <20200228003224.GA11811@roeck-us.net>
References: <20200226210414.28133-1-linux@roeck-us.net>
 <20200226210414.28133-3-linux@roeck-us.net>
 <CAD=FV=UutvJE+k4W0sQDs6q+oOfbz5Tz670+L-8fFHfdB=KytQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UutvJE+k4W0sQDs6q+oOfbz5Tz670+L-8fFHfdB=KytQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 02:06:44PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Wed, Feb 26, 2020 at 1:04 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > The DWC2 documentation states that transfers with zero data length should
> > set the number of packets to 1 and the transfer length to 0. This is not
> > currently the case for inbound transfers: the transfer length is set to
> > the maximum packet length. This can have adverse effects if the chip
> > actually does transfer data as it is programmed to do. Follow chip
> > documentation and keep the transfer length set to 0 in that situation.
> >
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/usb/dwc2/hcd.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> I don't have any other test setup that you don't have, so just giving
> my review tag and not tested tag.
> 
> I will note that it feels like this should have a "Fixes" tag or a
> direct Cc to stable to make it obvious that it should make its way
> back to stable trees.
> 

I added

Fixes: 56f5b1cff22a1 ("staging: Core files for the DWC2 driver")

> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks!

Guenter
