Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91779C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63020246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BclSCGD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgB1INV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:13:21 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33269 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgB1INU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:13:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id n7so1342839pfn.0;
        Fri, 28 Feb 2020 00:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1XeAZdDEEMWPSRFSSrigFDHZjIaWywrJrDOcCv/SctI=;
        b=BclSCGD/+Gp7pLCK+Yfq+IH0orWklytTcUNiFna90KwERemW3y0lq2SFGwBTScn/ZR
         SOnMFpFra//MK4i1yP2XSWxhSB0AmtyVADIvnaixDjHOEilFGfAtxn96llpXGSu9w6x9
         cnYc7x7sgEcbB4wEdoWPyc1hRhVj/x1T1b7yJp/3L1qebJXpWiZZcerMA4aKUSTSJzOu
         +EJL716Ez9KnsOA3AUIXTOEjEYftKhDFAE4pxRa3OfvNhxlaMqYrOmYwyXYyNJdP0BwU
         JH+Jb4ugNll/M3AjCQdCwSJWKoNoHs8e/biyVduULpYiHq+u7xkE0FG316miHyBgMLPu
         3vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1XeAZdDEEMWPSRFSSrigFDHZjIaWywrJrDOcCv/SctI=;
        b=Rb5MQdLNTJfph2R87UypBvSK54SNAdcquRtbIynWhNFG7+b70BN/9Qwy/7TPZtmjbF
         lOuzLFK4gncNiGZ1gz6/Lc94G6+v9euOYIro0QySymlHx1mpXBeXpHscjQmXm1Qk5uBF
         uQjbR3inHhwVaKLP9fuMvD9XJaIW0imY6hMxJsgaiNWMqJ5nVEIKzQm5temNrqCFdX/P
         sTs62MOpng3NkJSTyTL35xb8JFtUwb25G90uUKERMi+h4OVV9L7W4i+zCY18QL+mJ6o9
         Dt3LO6jXpOdc/WNv7TH/VY8Uu1vVtwS2oURENCYNpBWTnIhIrjsW3Vf467tgbeFDNf5N
         ydjw==
X-Gm-Message-State: APjAAAWTKt/zFrFfhec97eLFPiRJJRNqMeO9Z7X0Q3/DbwI+UtqbA5em
        l8AToCXGSeDq4cVqDHFzEhU=
X-Google-Smtp-Source: APXvYqwaScFWt2pSZw8deGePN2rW5lckHptMxbrEKDdWitX5+l+202jKgzn654xFzxvUIwznQHDJHQ==
X-Received: by 2002:aa7:93a6:: with SMTP id x6mr3341479pff.72.1582877599463;
        Fri, 28 Feb 2020 00:13:19 -0800 (PST)
Received: from taoren-ubuntuvm (c-24-4-25-55.hsd1.ca.comcast.net. [24.4.25.55])
        by smtp.gmail.com with ESMTPSA id c18sm8717917pgw.17.2020.02.28.00.13.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 00:13:19 -0800 (PST)
Date:   Fri, 28 Feb 2020 00:13:11 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>, linux-aspeed@lists.ozlabs.org,
        devicetree@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, taoren@fb.com,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 7/7] dt-bindings: usb: add documentation for aspeed
 usb-vhub
Message-ID: <20200228081309.GA4531@taoren-ubuntuvm>
References: <20200227230507.8682-1-rentao.bupt@gmail.com>
 <20200227230507.8682-8-rentao.bupt@gmail.com>
 <3150424b9e9f5856c747a0fbf44647919f49209d.camel@kernel.crashing.org>
 <20200228010444.GA19910@taoren-ubuntu-R90MNF91>
 <2676013663fc8c53e02a5fdaafb1b27e18249b80.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2676013663fc8c53e02a5fdaafb1b27e18249b80.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 02:02:28PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2020-02-27 at 17:05 -0800, Tao Ren wrote:
> > > Also long run I think best is going to have a child node per downstream
> > > port, so we create a matching linux struct device. This will make it
> > > easier to deal with the other device-controller in the ast2600 which is
> > > basically one of these without a vhub above it.
> > 
> > Maybe a dumb question: what would be the proper place to parse the child
> > node/properties when they are added? For example, in some usb_gadget_ops
> > callback?
> 
> No. What the vhub would do is when it probes, it creates a platform
> device for each "port" child node that's linked to the DT node.
> 
> The driver for the device then attaches to it via standard DT matching
> and checks if it has a vhub parent or not, and based on that, operates
> as a vhub child device or a standalone one.
> 
> (For example, it might have different functions for EP selection since
> standalone devices have private EPs rather than a shared pool)
> 
> They can both be in the same module or they can be separate modules
> with cross dependencies.
> 
> Cheers,
> Ben.

I see. It's to describe these downstream devices (such as configurations
and according functions) in device tree, which is similar to defining a
composite device and linking functions/interfaces via configfs. Thanks for
the clarify.


Cheers,

Tao
