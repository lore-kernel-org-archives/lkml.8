Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AEEC433F2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3661520663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DflabSqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgGOGhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbgGOGhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:37:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA22C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:37:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j4so1125267wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=u2kB3u3B7AZFrOCGW7RIbsXke2HgLh3kljbiXXyptSU=;
        b=DflabSqtgomXfgwzbBO59rDFG7DmZF0QwxlvgHDY6SG4gFvuxxTOEsqI3Qkbm9/cNL
         Vyz37o9ET2TVqtRXZUanFcuC//q/iMBNCpFoSN7v7zFgDgw4mVFx6iScqPSvJDhNc+95
         z1Oilh02U3ccJ9Zqz8QS8e5CeXiKjFK2bmpShMHe2yqZi2UjcU5Kdfd1m91OAzSPrslo
         aGz9pMcQIhY9wBm+6DDe3X82YQ4wulFwdWuz0XeifgiAGqZBT+e009TzxntlQIwYp9LP
         GuVahIDsrQQSA7LXKheMxUoVZNhPQgJaIuzrgMUN2JUWHRPfzvRqdQvsq+LUil4AY8+V
         H2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=u2kB3u3B7AZFrOCGW7RIbsXke2HgLh3kljbiXXyptSU=;
        b=uoWxnSM+SXPHd+Ge9gOYqd0kqd+5efosTYGsUWcPAhdouIn/wuxgcByIzvbuIwvLcF
         YXko47+sVLxZVouqgy7a6qUlT0VK7121Dgv2HfmnIshXCjqToW7RQewAvI2oGhMFo0VN
         cXTFr3t6td1DjmbzLQ8DwftrPAF+s0Z4mVsbCkFMRFMT29n/u/+jRafMoUrLYjxokwCo
         VtdkWtQpNDS++Em6IYj9sXKU4Ly5vWi+ZqYS3WA9Xz9VizV+fbqefTZMkU1BzGsTf2Xs
         fTKC3l7Arcvm8+Gbf3p2USvh1ZRPJ7gHpVGpiVX8GnJtcTUNSOa6YT1cjDoVzQRoTIzZ
         Wo9A==
X-Gm-Message-State: AOAM531GAu+x+yctI5XuRKH2bQ1U0TuN6FavfOW2n1+gkasPZqd3lBsx
        Nf4vDybc5x8yzqGWfN4GmEvmdQ==
X-Google-Smtp-Source: ABdhPJyQKOyuNDVm5aBX/CZ5eLSSM6VnDrMQdMe2T5HTFw69fLdvnITpMrkrEn88NJswxqQv5MWxXg==
X-Received: by 2002:adf:eec8:: with SMTP id a8mr9640759wrp.421.1594795027904;
        Tue, 14 Jul 2020 23:37:07 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id 51sm1946742wrc.44.2020.07.14.23.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 23:37:07 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:37:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
Message-ID: <20200715063705.GR1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-10-lee.jones@linaro.org>
 <CAJZ5v0iB0K6H28DSDQj9T7k_kV10THxV6-HwN9qfmkLsYNHfiA@mail.gmail.com>
 <20200714210340.GJ1398296@dell>
 <20200715032442.gh2cliiddhv35fdj@vireshk-i7>
 <20200715032718.2zlo2eurhkpoayya@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715032718.2zlo2eurhkpoayya@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020, Viresh Kumar wrote:

> On 15-07-20, 08:54, Viresh Kumar wrote:
> > On 14-07-20, 22:03, Lee Jones wrote:
> > > On Tue, 14 Jul 2020, Rafael J. Wysocki wrote:
> > > 
> > > > On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > >
> > > > > Can't see them being used anywhere and the compiler doesn't complain
> > > > > that they're missing, so ...
> > > > 
> > > > Aren't they needed for automatic module loading in certain configurations?
> > > 
> > > Any idea how that works, or where the code is for that?
> > 
> > The MODULE_DEVICE_TABLE() thingy creates a map of vendor-id,
> > product-id that the kernel keeps after boot (and so there is no static
> > reference of it for the compiler), later when a device is hotplugged
> > into the kernel it refers to the map to find the related driver for it
> > and loads it if it isn't already loaded.
> > 
> > This has some of it, search for MODULE_DEVICE_TABLE() in it.
> > Documentation/driver-api/usb/hotplug.rst
> 
> And you just need to add __maybe_unused to them to suppress the
> warning.

Right.  That's Plan B.

Will fix.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
