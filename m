Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C136C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 361442064A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ad+roKvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgD1ITH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726377AbgD1ITG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:19:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DC9C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 01:19:06 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so23570123wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 01:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OURtSv+36+oE/sqTvfCFcfDI8FbFV0v5BfUs3TstP2w=;
        b=ad+roKvC5V8gYPY6wjww2oXYWV0rJ1z7ziGfl3GObc7dSPCs6URF5nw+O8lGQ/q7V0
         lhoRdB+RkFf4o0ELPOxVDrWDIqY3siAbUtnsluyjycLeZXxQo+RM7BrzsmPg7l2tG6Xd
         iprqLr1acQkJVXohTBskh+XV0ma9j659hsKnnl0stRnvKXKKa0T4UEN8T9NfZURKNc8E
         gC8Ixeuj2Qc8OBsvOJ56dl8+rNfFaTtqcWvhd5EDR2C1kmD3sV3J3IMw7NpA+9R7NW4P
         A7od6NYP1u04jqdcVjv+z+F3kZLQN8fSHncovPF7Kr/JwEnK/jo0hW3ikYjuMkwD97Yg
         klLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OURtSv+36+oE/sqTvfCFcfDI8FbFV0v5BfUs3TstP2w=;
        b=OMUHXpCHRRecaHAydymU3uuBI6qEaAzYx0shD79rInkTUvl5uOCKaCMDj2o4WPjnxp
         egRTuX5M4yuMJF39AWb6tpEQztjyUt4TckmGcUg29qd9/SJy1Ldy4VXJTa/HoTW1J1iI
         wQMwX09u6VkhpZgw36iP3SCKCACHZrA1KezNgmwmyzQm01DMkILZV7CkOUZ6oc5/yz/2
         RbbD4K4iRgdygV12q9eOdRKPIA4CSGPZ0unbqaVymhqXBz09O0jJZrh7U0qcFDYKCq8Q
         XAZNtuuhkLtOQYkRr0DdrTaHoOS+F0aOuksRoAoj2j/bklmZdsktUaEgKMIBVDquzarH
         qtyw==
X-Gm-Message-State: AGi0PubReeIipv2gLiQhg6H4oL6iQ5ZD7GtIdHZoj5LePzkNuPwCrkGA
        eLN0p3py9oIlEghk/BVpa4B2MA==
X-Google-Smtp-Source: APiQypKEUqpNYvBnm61LnREyxoamcIU8wI6uv6kB7Yp6INzadBBTJTnquTQsSSUExv8vUasj0u6YzQ==
X-Received: by 2002:adf:e986:: with SMTP id h6mr31497011wrm.256.1588061945215;
        Tue, 28 Apr 2020 01:19:05 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id c20sm2395678wmd.36.2020.04.28.01.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 01:19:04 -0700 (PDT)
Date:   Tue, 28 Apr 2020 09:19:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mfd: syscon: Add Spreadtrum physical regmap bus
 support
Message-ID: <20200428081902.GK3559@dell>
References: <c2fd765aa388d4510194ba02c017e39bde57c8d4.1587478171.git.baolin.wang7@gmail.com>
 <CADBw62rJ8VYTgnW_3q4=TkCyZx2B1DHsG+oOmiph8FLsukUROQ@mail.gmail.com>
 <20200427090518.GG3559@dell>
 <CADBw62qXtNnoNq0F1iZrvQHryMTy86GEqcD-qXBzsJJL-B8mQg@mail.gmail.com>
 <20200428071447.GJ3559@dell>
 <CADBw62o=D-hmp1yB=oPXPJfBucOEEa87cZado5+1mTKsCWDKfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADBw62o=D-hmp1yB=oPXPJfBucOEEa87cZado5+1mTKsCWDKfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020, Baolin Wang wrote:

> On Tue, Apr 28, 2020 at 3:14 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Tue, 28 Apr 2020, Baolin Wang wrote:
> >
> > > On Mon, Apr 27, 2020 at 5:05 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > On Mon, 27 Apr 2020, Baolin Wang wrote:
> > > >
> > > > > Hi Arnd and Lee,
> > > > >
> > > > > On Tue, Apr 21, 2020 at 10:13 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > > >
> > > > > > Some platforms such as Spreadtrum platform, define a special method to
> > > > > > update bits of the registers instead of read-modify-write, which means
> > > > > > we should use a physical regmap bus to define the reg_update_bits()
> > > > > > operation instead of the MMIO regmap bus. Thus we can register a new
> > > > > > physical regmap bus into syscon core to support this.
> > > > > >
> > > > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > > >
> > > > > Do you have any comments for this patch? Thanks.
> > > >
> > > > Yes.  I'm not accepting it, sorry.
> > > >
> > > > I'd rather you duplicate the things you need from of_syscon_register()
> > > > in your own driver than taint this one.
> > >
> > > Thanks for your comments and I can understand your concern. But we
> > > still want to use the standard syscon APIs in syscon.c, which means we
> > > still need insert an callback or registration or other similar methods
> > > to support vendor specific regmap bus. Otherwise we should invent some
> > > similar syscon APIs in our vendor syscon driver, like
> > > sprd_syscon_regmap_lookup_by_phandle/sprd_syscon_regmap_lookup_by_compatible.
> >
> > So long as the generic driver stays generic.  Providing a registration
> > function sounds cleaner than tainting the code with vendor specifics.
> 
> So seems my V1 patch set [1] was on the direction as you suggested,
> but Arnd did not like that.
> 
> [1]
> https://lore.kernel.org/patchwork/patch/1226161/
> https://lore.kernel.org/patchwork/patch/1226162/

I don't often disagree with Arnd, but in this instance I think a
registration function which allows vendor spin-offs to use the generic
API is better than tainting the generic driver by adding vendor
specific #ifery/code to it.

Your original idea seems more palatable to me.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
