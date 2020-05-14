Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C59BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DEB2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WtAGzzHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgENRN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726327AbgENRN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:13:56 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3F1C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 10:13:55 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 9so1510916pgr.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 10:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pZwvriwNnPDIuQg/s1zEJFRH9W1eSn/xiKB4r1yycD0=;
        b=WtAGzzHAreY2FrOXWW81pGGNF8HYMNjnooPNQE2dhQs3NK1FCVnDPgJe+saCaPzFKX
         SavVgbyp0I0InXX+OlmkaiZnVe6jBMqgdgHZEHpmZM8N0aHZJGU8YhC2CVWQWgolb+NK
         pktI49+6koBCl8id1hnYb4zFNuvCxVV08+oGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pZwvriwNnPDIuQg/s1zEJFRH9W1eSn/xiKB4r1yycD0=;
        b=UeeexuxKaVCcnZIqUyOqS5iSNeCJezN+PeWZCdOlkUAtktNFPpmri7H2zqqh4+HBMg
         k9e9O+b4shZQjfltRsVhOo+qC0O/v8lCQ3BEtevdhRC4n1ZOyKZx2l1C10ggNauXy/Mr
         6BlrYZf6R60fyVvszHmCNnNw83ztOTfm3bcHwuEEz6fLO3DftX8LkZ0/N7fzg5ofk4hU
         qTrTebEK9VJIUG7DyJEhHLPbaxBuIoCtWHVvL6xWZdcBPfdzNuwvRrNSXrT+LMDBLpof
         hvsmgA5i1FnOIBJVNcLwIAu2b3k1SbugGvK4+T4CzQUSES0xpQl8Zbat5H74SXbJpEOj
         3HKA==
X-Gm-Message-State: AOAM5331e5sGp7yCzKkkWEGpQk0neFHp93ibwsDbwMvdnz9TNNi06g2y
        okYevaqQZwhs5BDEcnYOIzHl/g==
X-Google-Smtp-Source: ABdhPJzTMtX/fiIO+nYHtwgKMOYFe2MCvlHAa/e+2326oOvxEe7BgZ+kbG/xU4lSSPCdMgkw+B89sA==
X-Received: by 2002:a62:4e88:: with SMTP id c130mr5482778pfb.122.1589476434887;
        Thu, 14 May 2020 10:13:54 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id q134sm2798078pfc.143.2020.05.14.10.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 10:13:53 -0700 (PDT)
Date:   Thu, 14 May 2020 10:13:52 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Sandeep Maheswaram <sanm@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Chandana Kishori Chiluveru <cchiluve@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v7 2/4] usb: dwc3: qcom: Add interconnect support in dwc3
 driver
Message-ID: <20200514171352.GP4525@google.com>
References: <1585718145-29537-1-git-send-email-sanm@codeaurora.org>
 <1585718145-29537-3-git-send-email-sanm@codeaurora.org>
 <878shu4uwk.fsf@kernel.org>
 <875zcy4uuj.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875zcy4uuj.fsf@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 02:30:28PM +0300, Felipe Balbi wrote:
> Felipe Balbi <balbi@kernel.org> writes:
> 
> > Hi,
> >
> > Sandeep Maheswaram <sanm@codeaurora.org> writes:
> >> +static int dwc3_qcom_interconnect_init(struct dwc3_qcom *qcom)
> >> +{
> >> +	struct device *dev = qcom->dev;
> >> +	int ret;
> >> +
> >> +	if (!device_is_bound(&qcom->dwc3->dev))
> >> +		return -EPROBE_DEFER;
> >
> > this breaks allmodconfig. I'm dropping this series from my queue for
> > this merge window.
> 
> Sorry, I meant this patch ;-)

I guess that's due to INTERCONNECT being a module. There is currently a
discussion about this  with Viresh and Georgi in response to another
automated build failure. Viresh suggests changing CONFIG_INTERCONNECT
from tristate to bool, which seems sensible to me given that interconnect
is a core subsystem.

Let's hold back with this patch/series then until that is sorted out.
