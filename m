Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D10C2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8006B206F8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehRBq562"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDDRj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 13:39:29 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53266 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgDDRj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 13:39:29 -0400
Received: by mail-pj1-f66.google.com with SMTP id l36so4580870pjb.3;
        Sat, 04 Apr 2020 10:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rf3Vq8/IRCAw+STZ9AZuxHBMPJ565JHv5wHKM/w6aSo=;
        b=ehRBq562FPQrUJIbElTPYPx+q5KfznlIHZ8EH27UafRR+Lrtpgcz/j80larxavVq+x
         qPBOtLebWxmyU5/ilyzeQawxJkXoWABwQtz/Xt9fyvASkS2wq0ClYk3JuwDFCXdBQEM0
         j0TJO9WgJ60TO5Hv98e4iLOxz4szb1jB/FFNRRGEkIhVcBsGbON3Ili0jAjpL8AHRT5g
         LKHA1Tyj6X5v7HDraGPPxvYQI4fEPlqwx3265M3UgEyQp21rhwpwBFymaZ11jLa06lSU
         WVCWS5WApuqJUOzeGRrKXrRiicjWcAwnVtXAz76oHB612Q+yPaba50p3RoZJ4CiPmed3
         dehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rf3Vq8/IRCAw+STZ9AZuxHBMPJ565JHv5wHKM/w6aSo=;
        b=PTHkp9i+cfIGB9Gmg4MJ3kdM6MJOmg0H57s58d3Ejq2ab4t3Nh/qmVkNIkcEM1eGtW
         unrER907q+MkhX7bYZq4BtdPhTA7wrwVoM3MSzRPVvgJ3aGxx5AdgNQ6uqrmeHaeeQkt
         X+WNrX4+EjibewAg6B0bkG7nWdmVNdHPqnna9SB/TXu3whOoCAnF36sFDCu3SEpF4Gux
         nkniVqGWUO4CbY1o4hYybaNwUPREDrJQU+AsibUGdfKmQI05j+NhieWFsZM5vB4xHvbp
         11WBXKDIf30ej5YhmvQ0Tjo754ql3AzNkZRd4HcSzs3lMTbTlQpRqekwSK1l4lFHB3fr
         /Uag==
X-Gm-Message-State: AGi0PuYpU44DFVPU4fYipUDq8XvJ4Qs8q5MiKDanHoW4nnFufKnIc5Yn
        reWs3iLmX96SsyWQDPmA1g==
X-Google-Smtp-Source: APiQypIkqhCIesa36KRc3Ycny4VLIp6X6B0R6zkeWVfbRUStUOKP3RTg9kUW6HNSHLIdpUMj1+ysjA==
X-Received: by 2002:a17:90a:5a42:: with SMTP id m2mr16400067pji.165.1586021967954;
        Sat, 04 Apr 2020 10:39:27 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2402:3a80:d33:cff:f832:439c:9244:ba33])
        by smtp.gmail.com with ESMTPSA id y131sm8055532pfb.78.2020.04.04.10.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Apr 2020 10:39:27 -0700 (PDT)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Sat, 4 Apr 2020 23:09:21 +0530
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     madhuparnabhowmik10@gmail.com, hariprasad.kelam@gmail.com,
        colin.king@canonical.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        andrianov@ispras.ru, stern@rowland.harvard.edu
Subject: Re: [PATCH] usb: host: u132-hcd: Remove u132_static_list and list
 head u132_list
Message-ID: <20200404173921.GB19729@madhuparna-HP-Notebook>
References: <20200403181816.8115-1-madhuparnabhowmik10@gmail.com>
 <20200404092308.GB1110038@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404092308.GB1110038@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 04, 2020 at 11:23:08AM +0200, Greg KH wrote:
> On Fri, Apr 03, 2020 at 11:48:16PM +0530, madhuparnabhowmik10@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > 
> > u132_static_list is a global list protected by u132_module_lock.
> > It is read in the u132_hcd_exit() function without holding the lock
> > thus may lead to data race.
> > However, it turns out that this list isn't used for anything useful
> > and thus it is okay to get rid of it.
> > Thus, remove the u132_static_list from u132-hcd module.
> > Also remove struct list_head u132_list from struct u132.
> > 
> > Found by Linux Driver Verification project (linuxtesting.org).
> > 
> > Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > ---
> >  drivers/usb/host/u132-hcd.c | 10 ----------
> >  1 file changed, 10 deletions(-)
> 
> Please properly version your patches, otherwise I have no idea what
> changed from the previous one, nor do I know which patch to take over
> which.
> 
> The instructions for how to do this is in the documentation.  Please fix
> up and resend so I have a chance to know what to do...
>
Sure, I will do it.

Thank you,
Madhuparna
> thanks,
> 
> greg k-h
