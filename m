Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF565C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F6620706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NedFESVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgHXWrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHXWrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:47:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4E5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 15:47:31 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 17so5751334pfw.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 15:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tgCgrj/7RNoEUABuzTp3guQYTwt5yuubONILEbtUHdE=;
        b=NedFESVhjB8Y65MLB01kXcJ3NxiJVrtyBCzQ3AaSaYU7HFRe324lwhjy/rtXDqndkM
         9y6sSETHpexp/EbMGctE8dWHcJQillYrNgIBjst8MZkgUfi9ufBAVybTg4IrFfcj5s4Q
         1tWBslrl4dVhVP6XfxB3Yo6LrMTPWU6tcSH1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tgCgrj/7RNoEUABuzTp3guQYTwt5yuubONILEbtUHdE=;
        b=bD+jTcv4xEbpgSsnbX9Y78R2NVyB/mhnUsr6EFlflbqGaiYtv7cbd/Lm94afJqHFXh
         MacnzINvkrWFQRj6QJ1CRmqK10nuoQoFxVZ5hS7YnLv41tA86CCau8OeclVkoCcIGz5e
         Q24JxSC89ncdYdbZQcNhpsqC7Zbl9DPf5tRadPK6P5JNh9DI6nF4BYq+a+kfannGdZRR
         jCSW8AjhAp/MMbr9r6JWhcmDDzNMx56ryCbxq8EpQ8mdB4H4OiObA2YEpUclSgiiA2ct
         ybXnDixfzH+/9hkXPrcGCM2k6P934HD2jQpf5l5qLx1okWeCFb16btaeCECx/IV+Z8ED
         wNYQ==
X-Gm-Message-State: AOAM533CVZaZFzyUsrmiqHANq5O4UeoiLYIrgVb2zeAkH3Ld+xemd6ls
        rdkNf+WJNXqdJ+Op3amV5SVVaQ==
X-Google-Smtp-Source: ABdhPJzstXCt11oOnd0nn5W2icKYNmJ722Uy6n9Pw7DOVdijRVCMEkUwq7XkTS5YqaQ8CRlGx+aAEw==
X-Received: by 2002:a17:902:b082:: with SMTP id p2mr5320220plr.266.1598309248702;
        Mon, 24 Aug 2020 15:47:28 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id np4sm538459pjb.4.2020.08.24.15.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 15:47:28 -0700 (PDT)
Date:   Mon, 24 Aug 2020 15:47:26 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     "Mani, Rajmohan" <rajmohan.mani@intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: Re: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager
 (IOM) driver
Message-ID: <20200824224726.GA48297@google.com>
References: <20200822040508.23510-1-rajmohan.mani@intel.com>
 <20200822040508.23510-2-rajmohan.mani@intel.com>
 <20200822095631.GB2553024@google.com>
 <DM6PR11MB3963121C820F570F845BBAEEF6560@DM6PR11MB3963.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3963121C820F570F845BBAEEF6560@DM6PR11MB3963.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajmohan,

On Mon, Aug 24, 2020 at 10:19:27PM +0000, Mani, Rajmohan wrote:
> Hi Prashant,
> 
> Thanks for the quick review.
> 
> > > +
> > > +	if (!iom || !iom->dev || !iom->regbar)
> > 
> > Do we need to check for !iom->dev and !iom->regbar?
> 
> It's a good practice to have sanity checks on pointer members dereferenced.
> 
> So I can lose the check on iom->dev, but prefer to keep the check on regbar.
> Let me know if you feel strongly about losing the check for regbar as well.

Sounds good.
> 
> > Is there a valid situation
> > where iom != NULL but iom->dev and/or iom->regbar == NULL?
> > Sounds like it shouldn't, but I may be missing something.
> > 
> 
> I think I am being conservative here.
> 
> > > +		return -ENODEV;
> > > +
> > > +	if (!status || (port > IOM_MAX_PORTS - 1))
> > 
> > I think parentheses around "port > IOM_MAX_PORT - 1" aren't required.
> 
> Ack
> 
> > > +		return -EINVAL;
> > > +
> > > +	reg = iom->regbar + IOM_PORT_STATUS_OFFSET + IOM_REG_LEN *
> > port;
> > > +
> > > +	*status = ioread32(reg);
> > 
> > Perhaps just inline reg within the parentheses?
> 
> Kept this way to increase readability. Let me know if you feel strongly towards
> inline reg.

I'd rather this be inlined, you save a couple lines from the variable
declaration, and IMO we're not gaining much in terms of readability by
declaring this separately.

> 
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(intel_iom_port_status);
> > > +
> > > +static int intel_iom_probe(struct platform_device *pdev) {
> > > +	void __iomem *addr;
> > > +
> > > +	/* only one IOM device is supported */
> > 
> > Minor nit: s/only/Only
> 
> And then I may need to end the comment with a period.
> Let me know if you feel strongly.
Yes, let's capitalize and add the period. Let's try to use the right
punctuation where possible.

Best regards,

-Prashant
