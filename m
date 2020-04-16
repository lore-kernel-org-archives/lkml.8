Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782FEC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52322206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJXSpv4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439097AbgDPHRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438104AbgDPHRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:17:38 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B0DC061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:17:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f13so3484679wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wxbpA+gkMQzP49NMDgYKzmcFDKrFFfhXbq9DHHrnuNU=;
        b=LJXSpv4KpEVnkUH8WFCBWBaib2J9uL1w43yQ2BA7ThHLLvSV9NKeh+SoX9WTHLiwa5
         1sM9bpENrVAgMyEhNzNSWe7bv2T6VIXjXtdYhTWj+pnD2UauH6Sb9D8y3bGXpUGP6Adr
         611auVtBf5IclwqCjtLvu+19UUYwIl25KMATsGFHrae8OzX7tsUtofGOt6Mxa2Y8QGSb
         jXPsXYtGRIpObdQMxjwBmi/XSQWjfsBiOnRJbDxONdfeEnSoEEIYCIiXObkBNtrZ+80D
         ddVaftTGpbpJpfqCEq8P5gjYLFFSUW6PkWzaeyBKQFplWqRAzX45rXPwTv4Be3UNu4Bc
         Whag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wxbpA+gkMQzP49NMDgYKzmcFDKrFFfhXbq9DHHrnuNU=;
        b=un6lb6jzkjcBz00/EjRaGzwilqCXPxhI24xx94k2CtmDSXwDKdWTjvSFrFzfluRfb0
         ZMDPbVU2RInQDIcVsqx/3RF3PtbX2xm9RTud6eor/pXQifKBEvzZUi1Gdkn71b2gUEqG
         yvicPvpcwTyY2hnWDn62/yLIl4dGsl2Svrt6Vv5CHMvp6cp9yFmaHK2cE6sq8u7eixdn
         4xpYwysu3skzQDu1qlbH2VmY+XjYmpbv89jNP7LpTHAX8Nj5KUfGDys8etw/ROLvMUp7
         a3vB1pvozEP59dVLyAogrD88B/fsGX5qHrN52CdN29Uk/dDmepAd9NUSpqMqElRCyk57
         wh7A==
X-Gm-Message-State: AGi0PuZvL05Xm5YJJIRJc1gjBQNAhN1nSxLZHwuAbA+FNlf2Jdm6EHZ8
        8Sfr391WKdOtINDIH5As63o9hQ==
X-Google-Smtp-Source: APiQypJZ6oLLqIKvsbJo/X2R5PGU1Kjo53h8hr94MPus2CWNL1NzO6VzQpwajJvKPdifJbTZsraJOg==
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr34168071wrx.398.1587021455171;
        Thu, 16 Apr 2020 00:17:35 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id h1sm2565341wme.42.2020.04.16.00.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 00:17:34 -0700 (PDT)
Date:   Thu, 16 Apr 2020 08:18:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
Subject: Re: [PATCH v5 1/4] mfd: syscon: Add fwnode_to_regmap
Message-ID: <20200416071835.GR2167633@dell>
References: <cover.1585103753.git.eswara.kota@linux.intel.com>
 <9953bb25281397553cb87b09d641c968d8432dd9.1585103753.git.eswara.kota@linux.intel.com>
 <20200415093116.GH2167633@dell>
 <0adafade-7228-58d3-3db0-b06325712468@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0adafade-7228-58d3-3db0-b06325712468@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020, Dilip Kota wrote:

> 
> On 4/15/2020 5:31 PM, Lee Jones wrote:
> > On Wed, 25 Mar 2020, Dilip Kota wrote:
> > 
> > > Traverse regmap handle entry from firmware node handle.
> > > 
> > > Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> > > ---
> > > Changes on v5:
> > >    No changes
> > > 
> > > Changes on v4:
> > >    No changes
> > > 
> > >   drivers/mfd/syscon.c       | 8 ++++++++
> > >   include/linux/mfd/syscon.h | 6 ++++++
> > >   2 files changed, 14 insertions(+)
> > I think you'll find it very difficult to have a patch merged if you do
> > not send it to any Maintainers of the associated subsystem(s).
> Sorry, i completely missed adding the system configuration Maintainers. I
> was completely thinking about the PHY driver( in doing changes and upgrades)
> while sending the patches.
> I have noticed it, and already sent v6 patch series by adding you and
> arnd@arndb.de
> 
> "[RESEND PATCH v6 0/4] Add Intel ComboPhy driver"
> Snippet from the mail.
> 
> "Re-sending the patches v6 by adding the system configuration Maintainers,
> which i missed to add them."

I have it now.  Thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
