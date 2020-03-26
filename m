Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED33C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 08:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83382070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 08:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585210896;
	bh=I/HXWFRBajYMYlrJ1h/82iUEqdu35M990EWm2pbNP2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ed1Kf5l4Z8Tk4TrJw1ECSXLGyShhyrONIv4pWeM+ye6bFvc9QXQv3kXxh0GBvD/N6
	 0OLCXReSAwABSEwciwMsG6BWgViX04AeJmSgliHZKb+o7rZk7K79S0e5H5Lti5hEY3
	 wmcO2AIITEL+S+h84EsvBuMqH2Qr2+C7h0hDlyjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgCZIVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:21:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42221 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgCZIVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 04:21:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id q19so5397501ljp.9;
        Thu, 26 Mar 2020 01:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sVJJ788lIqUmQp6fGdmkgrlONPOf+ggU84FOgzg9/88=;
        b=JLyiIyboVwYWfFbcZZ7l/1pG5RtnQl55SL3K3wqGYoVhqQUGyfFPp4Dzwx6l3ve1zc
         JwQWriiW3DyxXRClKsBPIBvg2fKfV9Z4kFG32n4jVQNSneqSBjHiB0QcuDqdGPD/7fFk
         +xMz9mJcCMwShCPOc/7wcf6GgM1bRGGItxDs9FcVe5Qxl/azGm4K9Mc5oaoqYsMFDEnG
         ee/uPhzb3oXIFNm2X2jiK2IxBVarRBc93rcYuNzwnNWM5x2xsKnbiGPE9FEXl1MJSoix
         npEEu0XESu8Nnzegf8wgwtDA/uo+/6BP9XJrnWu6/1V9RSTzYi/fCXqkCSs0z6V76N4u
         wtLw==
X-Gm-Message-State: ANhLgQ35mX3i8T3qcipFn3SDoPxkFqVGAYH4vMgmd7S9hGFHB4202UL6
        n2QVhch8GlrZQFOR9xsylcw=
X-Google-Smtp-Source: APiQypLBnbJYCvGqm5enSf75eI08oi9ZIns0qhRhRYtBj5kbfS2AMBxutadqhiln0ePQP2Vfz6Qa7g==
X-Received: by 2002:a2e:9e8d:: with SMTP id f13mr4381812ljk.171.1585210891760;
        Thu, 26 Mar 2020 01:21:31 -0700 (PDT)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id j6sm966296lfb.13.2020.03.26.01.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 01:21:30 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jHNlN-0002pX-UA; Thu, 26 Mar 2020 09:21:17 +0100
Date:   Thu, 26 Mar 2020 09:21:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Qiujun Huang <hqjagain@gmail.com>, johan@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        anenbupt@gmail.com
Subject: Re: [PATCH] USB: io_edgeport: fix  slab-out-of-bounds Read in
 edge_interrupt_callback
Message-ID: <20200326082117.GC4899@localhost>
References: <1585122757-4528-1-git-send-email-hqjagain@gmail.com>
 <20200326081433.GA979574@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326081433.GA979574@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 09:14:33AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 25, 2020 at 03:52:37PM +0800, Qiujun Huang wrote:
> > The boundary condition should be (length - 1) as we access data[position+1].
> > 
> > Reported-and-tested-by: syzbot+37ba33391ad5f3935bbd@syzkaller.appspotmail.com
> > Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> > ---
> >  drivers/usb/serial/io_edgeport.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> > index 5737add..4cca0b8 100644
> > --- a/drivers/usb/serial/io_edgeport.c
> > +++ b/drivers/usb/serial/io_edgeport.c
> > @@ -710,7 +710,7 @@ static void edge_interrupt_callback(struct urb *urb)
> >  		/* grab the txcredits for the ports if available */
> >  		position = 2;
> >  		portNumber = 0;
> > -		while ((position < length) &&
> > +		while ((position < length - 1) &&
> >  				(portNumber < edge_serial->serial->num_ports)) {
> >  			txCredits = data[position] | (data[position+1] << 8);
> >  			if (txCredits) {
> > -- 
> > 1.8.3.1
> > 
> 
> Johan, any objection from me taking this in my tree now?

Just let me take a look at it first.

Are sending another PR to Linus for 5.6? Otherwise I can include this
in my 5.7 PR to you. Will try to get it to you today.

Johan
