Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCB6C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA4620672
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rqDUfhu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgGOD1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 23:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgGOD1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:27:21 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAABC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:27:21 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n5so1757575pgf.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xfe44VUg6t3uEKEZr5KZlokmJcH7EcHODPZ1Ek7+ev0=;
        b=rqDUfhu/YFg8AfXgIqvzj4jUJm55xGZGfZTn0nJ/RhPxv87G+CfMpoXZtlSiPIxZiO
         7cOCDnt6ewvLo+BACOIbspH5nBMsv76s2FbCrGB6hwOYO3GReB84ZsqW0xFDRkpsXo3T
         93CmWiGNZRYwmlAAj3JyxA8y15aWS/k1nzmkMhk3PJ1cajgQ/xCaODvAnXkeR/IDIU7M
         MiU0BYLPd7sHVZUSeQ6Q6Tt6e7tWYTJmypD9HLQTGwp+L4qyc0c25BhPJjnbC9ychl8s
         47a82C0Lor/R7eqYHGIXFUDtfC73dthfGXAVmD/GLNssgfp/UY342VD+Ck4FIpfdeD96
         scRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xfe44VUg6t3uEKEZr5KZlokmJcH7EcHODPZ1Ek7+ev0=;
        b=N50r0kEPcOGJDYkQIHotBWTaGSkj77RhH9w7Vps31hlWRGWDugGL8ReduCtnCzSI4W
         0kxAA9kAMHPAsjSlA9gvTpm4SGvL+E3M7smaBru9fXWH0X11H924N6d8e6FI2ROyLEg5
         YzqphUHLGU80ICQFt8iVypRVQS+WEJ66yJDFU+zIkx+yzJkH9bAH+qAt5Cy22A52wpNN
         tpcEqM0vZ59IHIn/9ZPe+KS7ZZYshIW0kiTxIKH/0eoqNNIBs4E7UZtm3CgMvV6Pt8qE
         sLeo63lXaHvobMHUZPA4jxMHQtuSUyBKS28F4PflWtHrb1U625dzNxxrknnvMpph6uKQ
         Up6A==
X-Gm-Message-State: AOAM532rOc4I14I/FTiGC6tuprJq+VR42yC+OY0pio1CnzsGS0KXhrbf
        /H5AOaQb0pO5Er/zW9YgA/5EKkI0PBw=
X-Google-Smtp-Source: ABdhPJxvLtPG6/Yk6jZYYT6/cu/KekSQOrjbd/Em8rcltuDksibR5oAhSOVlLJAds+5Rs63iGLD3vw==
X-Received: by 2002:a65:6883:: with SMTP id e3mr6203354pgt.5.1594783640870;
        Tue, 14 Jul 2020 20:27:20 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id z2sm503142pff.36.2020.07.14.20.27.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 20:27:20 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:57:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Grover <andrew.grover@intel.com>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Dominik Brodowski <linux@brodo.de>,
        Denis Sadykov <denis.m.sadykov@intel.com>
Subject: Re: [PATCH 09/13] cpufreq: acpi-cpufreq: Remove unused ID structs
Message-ID: <20200715032718.2zlo2eurhkpoayya@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-10-lee.jones@linaro.org>
 <CAJZ5v0iB0K6H28DSDQj9T7k_kV10THxV6-HwN9qfmkLsYNHfiA@mail.gmail.com>
 <20200714210340.GJ1398296@dell>
 <20200715032442.gh2cliiddhv35fdj@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715032442.gh2cliiddhv35fdj@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-07-20, 08:54, Viresh Kumar wrote:
> On 14-07-20, 22:03, Lee Jones wrote:
> > On Tue, 14 Jul 2020, Rafael J. Wysocki wrote:
> > 
> > > On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > Can't see them being used anywhere and the compiler doesn't complain
> > > > that they're missing, so ...
> > > 
> > > Aren't they needed for automatic module loading in certain configurations?
> > 
> > Any idea how that works, or where the code is for that?
> 
> The MODULE_DEVICE_TABLE() thingy creates a map of vendor-id,
> product-id that the kernel keeps after boot (and so there is no static
> reference of it for the compiler), later when a device is hotplugged
> into the kernel it refers to the map to find the related driver for it
> and loads it if it isn't already loaded.
> 
> This has some of it, search for MODULE_DEVICE_TABLE() in it.
> Documentation/driver-api/usb/hotplug.rst

And you just need to add __maybe_unused to them to suppress the
warning.

-- 
viresh
