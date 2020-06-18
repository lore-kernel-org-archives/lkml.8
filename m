Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1098C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCAD520B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Isl79jUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbgFRQvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbgFRQvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 12:51:54 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A38C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 09:51:54 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d66so3039696pfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 09:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ysQewDSw9pjMrTYmtr4DIZRhQJEHELerRdzz4gWr0zI=;
        b=Isl79jUuGROnOJxWpzGM1yzagFHHGRUUAOks6EttsjO63UiTCwl1X+56UA8ZYoWyy5
         5UgmnnO23gbW/Z/39XIaXrdFzWifiW6dMdwwTlzrYEM5DSXiQzLfx6AoM4oCwb2p6a17
         rlyGtTTzPmr4wAwf3s/p2fkaKVmMC9vKpvVig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ysQewDSw9pjMrTYmtr4DIZRhQJEHELerRdzz4gWr0zI=;
        b=VI0X+jMkqOw2hJQio5JoNtkiLysuJ4qcE8xTzieoiusrzU3f2ukE80RGRDE+qMe+Gm
         LzCjvukifqCiPP0GMkI2A/Scp1poXOGCxWpnLyYg9czNI7snEPFotZUnxwojezGx6SXr
         U+50Yghkdqf/ZTmf5SHexTICUXtnq9Q119oj0A8wA+G/qjGl4iJJJ05cgBb890KiNGA8
         M0YUcAUoHyB/gOLSQc3vaOSkZ8BAXA/YL0eOvlT9crKP40PwL7I4UzuC7V5Es8y3llXR
         rJmuczIybB5aKfUfWs4YtKah4Y/6z7T6lmuCT3jV0XDEkbDmyPmt7aHC5nylYxCFf5bb
         JfPw==
X-Gm-Message-State: AOAM533HTGJI8uhcExOBYmIVXvUhPAwFcOazTrayghslE5jxOzkDfdeN
        s3+HrmTVXXgecIgF98CC7zgm3VyusIA=
X-Google-Smtp-Source: ABdhPJzL9RB7aKjHDGDCcpAUdTwKeWdNUobj7fic0ZPFWMk6a2ICKZMgXeYMIfXfiYPbzW3PfMxaAA==
X-Received: by 2002:a63:7453:: with SMTP id e19mr4059548pgn.450.1592499113560;
        Thu, 18 Jun 2020 09:51:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id y7sm3090742pjm.54.2020.06.18.09.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 09:51:52 -0700 (PDT)
Date:   Thu, 18 Jun 2020 09:51:51 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sandeep Maheswaram <sanm@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH] driver core:Export the symbol device_is_bound
Message-ID: <20200618165151.GE4525@google.com>
References: <1591123192-565-1-git-send-email-sanm@codeaurora.org>
 <20200618081443.GA1043700@kroah.com>
 <20200618154555.GD4525@google.com>
 <20200618155820.GA3076467@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200618155820.GA3076467@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 05:58:20PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 18, 2020 at 08:45:55AM -0700, Matthias Kaehlcke wrote:
> > Hi Greg,
> > 
> > On Thu, Jun 18, 2020 at 10:14:43AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Jun 03, 2020 at 12:09:52AM +0530, Sandeep Maheswaram wrote:
> > > > Export the symbol device_is_bound so that it can be used by the modules.
> > > 
> > > What modules need this?
> > 
> > drivers/usb/dwc3/dwc3-qcom.c (and probably other dwc3 'wrappers').
> 
> Why wasn't that said here?  No context is not good :(

Agreed, this patch should probably have been part of a series to establish
the context.

> > Short summary: QCOM dwc3 support is split in two drivers, the core dwc3
> > driver and the QCOM specific parts. dwc3-qcom is probed first (through
> > a DT entry or ACPI), dwc3_qcom_probe() then calls of_platform_populate()
> > to probe the core part. After a successful return from _populate() the
> > driver assumes that the core device is fully initialized. However the
> > latter is not correct, the driver core doesn't propagate errors from
> > probe() to platform_populate(). The dwc3-qcom driver would use
> > device_is_bound() to make sure the core device was probed successfully.
> 
> why does the dwc3-qcom driver care?

Currently the dwc3-qcom driver uses the core device to determine if the
controller is used in peripheral mode and it runtime resumes the XHCI
device when it sees a wakeup interrupt.

The WIP patch to add interconnect support relies on the core driver
to determine the max speed of the controller.

> And why is the driver split in a way that requires such "broken"
> structures?  Why can't that be fixed instead?

It seems determining the mode could be easily changed by getting it through
the pdev, as in st_dwc3_probe(). Not sure about the other two parts,
determining the maximum speed can involve evaluating hardware registers,
which currently are 'owned' by the core driver.

Manu or Sandeep who know the hardware and the driver better than me might
have ideas on how to improve things.
