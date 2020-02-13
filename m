Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FEFC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020252465D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBecrczY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgBMPeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:34:09 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37787 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729664AbgBMPaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:30:15 -0500
Received: by mail-pj1-f68.google.com with SMTP id m13so2573489pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 07:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h4tXxCDqUAeynBn8YfdI4d7ZTww8jr1pxW2BfTAecOw=;
        b=JBecrczYg/FyZDYE2AD6DZpQw8AIB6CSVaDIj1K/dFnFrEr2zRO+zLKtyzp0Z39Xnq
         IuzUCdw9nwffWRWpajJpZT4OwMlCOpi+ovKz39fufc6rkztLeurDSzyNe3kRmokyBG5a
         +gmLrP5OOJcRjRxe3NO22f1QhCsls+vFKA2xeDyT0LwwB82JrEWA0p0tk+R0gX0c2r7S
         JAlpTr7pQJSmAat59NdTtv1EOte41xirVsrnmS7VmioGXwX+f6Xb7ZDenCH+XGQZrBMm
         8W02xkMZue137NK7rZCbMlPlIIdZLugk5OSsohCHVUeZa3qxGN2q42ZhcsH2tzSRajoX
         wjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h4tXxCDqUAeynBn8YfdI4d7ZTww8jr1pxW2BfTAecOw=;
        b=mpsnLCv6ELctWO+pvXnlIKnSjo8QQd0uvfCKAe1BVlQ7lxGa+K6f0Vcj6OjK0QwDcr
         JGuhobf8mefnRy7dpEue4g2YClpjJ9NA4vttjjP5/aoDiRfT2YRtbgaCaZS23VXimcYW
         3fR5QbjeSlzXUF5RX3CB9rasmdpgebihb1cW0MsZHDO6GIjHAEB0hW94017i2I7s3GuD
         +rYPFv+7N8Bp9VKTXhYphkbNEmi/sH2c9u/5k1BeK8oc0Q1ey6s7MMFG9AMDTxUzbOiv
         sD9IKKlLgquD25PmqXf7yeC/p04EEOFZRA+pyEXetsPLczeTNaI6IudMuUNwYYKgeO1n
         dijA==
X-Gm-Message-State: APjAAAWxAfAZ8/rSNrFaipxKyJ8QY1Iunw1ffE4hLvlPPOeS3DmikejT
        wCk+N+RvnNGg0jyIv3bGvqb9
X-Google-Smtp-Source: APXvYqz4gm0XDqU07OdTiTdJXfSfampqcbHQpGnuG26etIIxJDg/VSwU6SBMHKkVPXZ7r6GHgiSJqg==
X-Received: by 2002:a17:90b:97:: with SMTP id bb23mr5485019pjb.53.1581607815090;
        Thu, 13 Feb 2020 07:30:15 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id x6sm3506464pfi.83.2020.02.13.07.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 07:30:14 -0800 (PST)
Date:   Thu, 13 Feb 2020 21:00:08 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dan Williams <dcbw@redhat.com>
Cc:     davem@davemloft.net, kuba@kernel.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Migrate QRTR Nameservice to Kernel
Message-ID: <20200213153007.GA26254@mani>
References: <20200213091427.13435-1-manivannan.sadhasivam@linaro.org>
 <34daecbeb05d31e30ef11574f873553290c29d16.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34daecbeb05d31e30ef11574f873553290c29d16.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Thu, Feb 13, 2020 at 09:22:39AM -0600, Dan Williams wrote:
> On Thu, 2020-02-13 at 14:44 +0530, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This patchset migrates the Qualcomm IPC Router (QRTR) Nameservice
> > from userspace
> > to kernel under net/qrtr.
> > 
> > The userspace implementation of it can be found here:
> > https://github.com/andersson/qrtr/blob/master/src/ns.c
> > 
> > This change is required for enabling the WiFi functionality of some
> > Qualcomm
> > WLAN devices using ATH11K without any dependency on a userspace
> > daemon.
> 
> Just out of curiousity, what's the motivation for not requiring a
> userspace daemon? What are the downsides of the current userspace
> daemon implementation?
>

The primary motivation is to eliminate the need for installing and starting
a userspace tool for the basic WiFi usage. This will be critical for the
Qualcomm WLAN devices deployed in x86 laptops.

Also, there are some plans to implement QRTR link negotiation based on this
in future.

Thanks,
Mani
 
> Dan
> 
> > The original userspace code is published under BSD3 license. For
> > migrating it
> > to Linux kernel, I have adapted Dual BSD/GPL license.
> > 
> > This patchset has been verified on Dragonboard410c and Intel NUC with
> > QCA6390
> > WLAN device.
> > 
> > Thanks,
> > Mani
> > 
> > Manivannan Sadhasivam (2):
> >   net: qrtr: Migrate nameservice to kernel from userspace
> >   net: qrtr: Fix the local node ID as 1
> > 
> >  net/qrtr/Makefile |   2 +-
> >  net/qrtr/ns.c     | 730
> > ++++++++++++++++++++++++++++++++++++++++++++++
> >  net/qrtr/qrtr.c   |  51 +---
> >  net/qrtr/qrtr.h   |   4 +
> >  4 files changed, 746 insertions(+), 41 deletions(-)
> >  create mode 100644 net/qrtr/ns.c
> > 
> 
