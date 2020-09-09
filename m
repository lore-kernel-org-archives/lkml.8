Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3783BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA9D621919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kt3Qe+l2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgIIHbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgIIHbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:31:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FD0C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 00:31:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a17so1764068wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/mmZxPftJdKRelQlen4tZiIs8ACZ1tu9mZccolxvPRc=;
        b=kt3Qe+l2vG0tRHkGoxXWGr+5zbEDyB73qrTQ1haHgoHJ84jWMBpM2lOIIsYIONP3r0
         Bx8GvhN+skq/PaHrTC/CqMTHvDYTL6vmC6N15eijQ7cbSiPQRUXKSJCvq3SeDKpGszqX
         IaEt7lkSnUBw1M/w6a1ASjKc8cCSMmslpgzaVVKPS9VWiNX/HJsx8Psli3B36O9D5ZDj
         rh8YOsncPKiTnAZEb1wTQ+EHU1XIplE3lVtoIFpt3qWN0j4YX+JCI0lqEfLmj2ZFjzTy
         6x7LJ4quj+l6BHeqA+S3VwEmVppmCLyvp7U3BAFAm1ceD5qTDnnJSyKYL21fSIjabcjE
         OPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/mmZxPftJdKRelQlen4tZiIs8ACZ1tu9mZccolxvPRc=;
        b=jhBC3uDyqssoYiB1QtXljPOpwbTftOdYqPNgsV6TMqr1CqMT7srut1MTehF2hX5nsG
         5+R08skxKQKhip4h9Qwy6kxX2um4mEYcdtvIznyFifuNbEe/I4Uk7Qv1dJcFxdBlV9G/
         5nF4r90zcnKnH8Y9j/gYDQWYWCXZ0FAFKjExp94co9uwiU+zlqcp5QOidzxIdYTJfYn/
         aKNLdBjLaeveUzqv7hNfvGQqgOV5H2tC1CFivOTA1jxqd8+KKiFi0O7E/QnfNm4rMMyl
         xbd4w4wYn7ry11ePiYcTsLH4FlGEGi+j/GtSwc96E3F2R1aSWvxWBeLBXi7lmdCehBtf
         u1+Q==
X-Gm-Message-State: AOAM531OX03mleLy6yI1DoduwtbuiqnT0NK29/9UOD8hzjbkvUNl47Fg
        KMExW9kH9hu1tQtbt4hagaJcrg==
X-Google-Smtp-Source: ABdhPJyJ1fF54eSj39pXlfAdCyzup7gc86q4mr7E7IMgXAEFVnUfAWWNVxdCFU2zmeOVarr6B7D5nA==
X-Received: by 2002:adf:ec82:: with SMTP id z2mr2498903wrn.214.1599636702307;
        Wed, 09 Sep 2020 00:31:42 -0700 (PDT)
Received: from dell ([91.110.221.179])
        by smtp.gmail.com with ESMTPSA id u126sm2974502wmu.9.2020.09.09.00.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 00:31:41 -0700 (PDT)
Date:   Wed, 9 Sep 2020 08:31:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v4 2/2] mfd: intel-m10-bmc: add Max10 BMC chip support
 for Intel FPGA PAC
Message-ID: <20200909073140.GC4400@dell>
References: <1597822497-25107-1-git-send-email-yilun.xu@intel.com>
 <1597822497-25107-3-git-send-email-yilun.xu@intel.com>
 <20200828100236.GF1826686@dell>
 <20200829182405.GA27132@yilunxu-OptiPlex-7050>
 <20200908120356.GQ4400@dell>
 <20200909060140.GB27300@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200909060140.GB27300@yilunxu-OptiPlex-7050>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Sep 2020, Xu Yilun wrote:

> > > > > + * m10bmc_raw_read - read m10bmc register per addr
> > > > > + * m10bmc_sys_read - read m10bmc system register per offset
> > > > > + */
> > > > > +static inline int
> > > > > +m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
> > > > > +		unsigned int *val)
> > > > > +{
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = regmap_read(m10bmc->regmap, addr, val);
> > > > > +	if (ret)
> > > > > +		dev_err(m10bmc->dev, "fail to read raw reg %x: %d\n",
> > > > > +			addr, ret);
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +#define m10bmc_sys_read(m10bmc, offset, val) \
> > > > > +	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
> > > > 
> > > > No unnecessary abstractions.
> > > > 
> > > > Just use the Regmap API directly please.
> > > 
> > > Could we keep the 2 definition?
> > > 
> > > For m10bmc_raw_read(), we make it to help print some error info if
> > > regmap RW fail. So we don't have to write "if (ret) dev_err" every time
> > > we use regmap.
> > 
> > How many call sites are there?
> 
> There are about 20 calls of the register read in m10bmc base driver and
> sub device drivers. Most of them calls m10bmc_sys_read().
> I prefer to keep the function for unified error log, but I'm also good
> to follow your opinion. How do you think?

Avoidable abstraction is one of my pet hates.  However,
unified/centralised error handling is a valid(ish) reason for
abstraction to exist.  Do you really need to know which read failed?
Is there a case where a read from only a particular register would
fail where others succeed?

> I also realize that it is not necessary that we define so many
> m10bmc_raw_bulk_read/bulk_write/update_bits ... which are not frequently
> used. We could change them.

Yes please.

> > > For m10bmc_sys_read(), the offset of BMC system registers could be
> > > configured by HW developers (The MAX 10 is an CPLD, it could be easily
> > > reprogrammed). And the HW SPEC will not add the offset when describing
> > > the addresses of system registers. So:
> > > 1. It makes the definition of system registers in code align with HW SPEC.
> > > 2. It makes developers easier to make changes when the offset is adjusted
> > >    in HW (I've been told by HW guys, it is sometimes necessary to adjust
> > >    the offset when changing RTL, required by Altera EDA tool - Quartus).
> > 
> > Make sure you justify this for the function(s) you keep.
> 
> Yes, I could add some comments.
> 
> Thanks,
> Yilun

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
