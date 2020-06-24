Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81094C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC132078A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ccU9fEXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405588AbgFXRjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405427AbgFXRju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:39:50 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9B2C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:39:50 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x11so1320232plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=icPG8hObHg8yafPJKwf2o4eaI571GeN/laooKjhqnGA=;
        b=ccU9fEXoNSEIM7OOQ/yadogIOyX0u9hfrmr0o3aOPCOthUpjuoBld3sSt+PdY3i0Qr
         XrYjEd28vcqX+7L5zyThYAz5CZMd1Rx4YAfvSNHxP8Vf+rBZyFqtdiKeuZ67i/ak9icd
         O3ksW4NGLZpdaE9RP9XJC3jE75u/oa2nEAAJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=icPG8hObHg8yafPJKwf2o4eaI571GeN/laooKjhqnGA=;
        b=pbTF5UjQ0PV0UZ+7ej3JZcpYtkuWVf3zp7YyYJYYV7slCphzjghjSCyYhU9LHBWyJ3
         DywMIgz+v7vqJNpgc8/e/ZMFfyvPBSMY2sLGc2pgk8LLHkG7x5AAriw3aqldL3Cepu7a
         w7hFgmvBvHJuyTvt5i3s45dzu/JfOzEaRZQfQKsnxkpPeF3cRAas5Yi6jMTkdfyBK/S4
         qW7xxqTXwWum7U3So4mrb4vwlqEkR7A087RxeJS//JDWVlX0i3cYBvz9G20d76kC0eao
         J4M3ChieTGQkVPoy6lrwvRix9waz8egRpngHrnBvMt5m76/EyKXX/L7ShTrzDf/8XVcs
         Wq/A==
X-Gm-Message-State: AOAM532SXH1lJfn3nHcV4fD9kNuGvAXmZN63Kbtcn3UBbeU2fg/IbcfF
        3oQb5qyVdQaIKlIhfNE1RiWq5w==
X-Google-Smtp-Source: ABdhPJxEB785qbfd6S3Vxd6Ma7a0jVEjXIBDvEs8LRmaTNVuKN6yFPJfwMEa04arCunvtaU7Med6og==
X-Received: by 2002:a17:902:b60f:: with SMTP id b15mr29521587pls.248.1593020389993;
        Wed, 24 Jun 2020 10:39:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id z5sm501869pfb.1.2020.06.24.10.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 10:39:49 -0700 (PDT)
Date:   Wed, 24 Jun 2020 10:39:48 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, bjorn.andersson@linaro.org,
        agross@kernel.org, robdclark@gmail.com, robdclark@chromium.org,
        stanimir.varbanov@linaro.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v6 6/6] spi: spi-qcom-qspi: Use OPP API to set clk/perf
 state
Message-ID: <20200624173948.GC39073@google.com>
References: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org>
 <1592222564-13556-7-git-send-email-rnayak@codeaurora.org>
 <20200624170933.GB39073@google.com>
 <20200624171537.GL5472@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200624171537.GL5472@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 06:15:37PM +0100, Mark Brown wrote:
> On Wed, Jun 24, 2020 at 10:09:33AM -0700, Matthias Kaehlcke wrote:
> > Hi Mark,
> > 
> > do you plan to land this in your tree?
> > 
> > I know you hate contentless pings, but since you acked this patch and
> > usually don't seem to do that when patches go through your tree I want
> > to make sure we aren't in a situation where everybody thinks that the
> > patch will go through someone else's tree.
> 
> Aren't there dependencies on earlier patches in the series?

Not to my knowledge. Patch "[2/6] spi: spi-geni-qcom: Use OPP API to set
clk/perf state" depends on a change in 'include/linux/qcom-geni-se.h' made
by "1/6] tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state",
however that's not true for this patch.

I wonder if it would have been better to split this series into individual
patches/mini-series, to avoid this kind of confusion.

> In general if someone acks something for their tree that means they don't
> expect to apply it themselves.

Yes, that was my understanding and prompted me to clarify this with you.

The patch could go through the QCOM tree, but to my knowledge there is no
reason for it.

Btw, the patch "[V8,7/8] spi: spi-qcom-qspi: Add interconnect support"
(https://patchwork.kernel.org/patch/11620285/) is in a similar situation.
Another patch of the series for the 'spi-geni-qcom' driver has to go
through the QCOM change due to changes in geni, but the QSPI driver
doesn't use geni and could therefore go through your tree.

Ultimately I don't really care too much through which tree the patches
land as long as you and Bjorn agree on it :)
