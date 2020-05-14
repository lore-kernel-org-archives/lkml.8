Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E05C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB074205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZLliR++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgENGiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 02:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725818AbgENGiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 02:38:54 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE65C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 23:38:54 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j21so851524pgb.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 23:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=trpCHC2rLO1MlJDoRWUVG8LcEP1hcZOfyLGO5G0f2rQ=;
        b=zZLliR++wDgRRitEX5/Q9ylF5d6B3oUNfdX3DFBcMpOGNH9uem9dfdhEl6CsbQIcl1
         RKxBNQ31tZfpVBcaQetcEmtZNGkBFyeNIQcwh+MdhtT5Pq/FnoyT+RiuQzXk4IHcEqSa
         uCvO0ewqL9e7wS1no4p8LF4r4y9m4UZV9Qnb73BodRNqEEuxTbU4sdxj0I2Zi4oRXd52
         ojFZoC/xcKc1ge95zTh+LRFW+AKazDEsx155A/4vxRHnQv4E+RwUAsiKT94hkIGwk3Wu
         zeEZXNZ8Hefywm3T16bvIwr3ouD3CqnoRCyBTLajdNVcO07siTiWXYRNNC+H+i8TD7MZ
         aGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=trpCHC2rLO1MlJDoRWUVG8LcEP1hcZOfyLGO5G0f2rQ=;
        b=MbqnFclDnfgNXW4pLnDiGLezS2bgknjWDxaP5ipCmmhKKtw8L5vnEi0BOM2zBQyr2E
         JWaikIebfodCsDJG1BYYCoCs7MHMAnWyUAqIzG1Q2/ShsRoosj0BMzSm+sQG8yFdBCDS
         BQj6IEULxwNvSgbrmcqxOnoBBYfmfczrSws0OjR1Gk1bQgUrl7l8Yy4vaACoExIxwc7S
         nEKZVmfR8TOgBO0redMvzTb4jG/SkAlWByPrFV9NszkzPN7UK/UhdSSMzCfWFRT/oVej
         gcDT9WSEYrum/qOXKNsuRIlq+xAGj3/aV/kHs9sbnBC1IJo/WVEptRsSDtpp3eod0P7h
         JVcQ==
X-Gm-Message-State: AOAM532uQ2nzAik0jfWgF5zjJT8oKiRwdl0SNe2HaOj/Z/t0rDlkcu9r
        mR822wvMh8BGNVyuvCBIKs1GUQ==
X-Google-Smtp-Source: ABdhPJznm23JfEqj5UmVgS4Swq3v1SnUWfjL55likkes1GYDPsbFDk1FcQ1ZXkwDTG5Sj5Lzzxi6lw==
X-Received: by 2002:a62:f24e:: with SMTP id y14mr2913204pfl.116.1589438334034;
        Wed, 13 May 2020 23:38:54 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id j26sm1351855pfr.215.2020.05.13.23.38.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 23:38:53 -0700 (PDT)
Date:   Thu, 14 May 2020 12:08:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: linux-next: build failure after merge of the opp tree
Message-ID: <20200514063851.4yrixgabncsgtqii@vireshk-i7>
References: <20200514115811.1c6192b5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514115811.1c6192b5@canb.auug.org.au>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-05-20, 11:58, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the opp tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> x86_64-linux-gnu-ld: drivers/opp/core.o: in function `dev_pm_opp_put_opp_table':
> (.text+0x76e): undefined reference to `icc_put'
> x86_64-linux-gnu-ld: drivers/opp/core.o: in function `dev_pm_opp_set_rate':
> (.text+0x2c59): undefined reference to `icc_set_bw'
> x86_64-linux-gnu-ld: drivers/opp/of.o: in function `dev_pm_opp_of_find_icc_paths':
> (.text+0x3ca): undefined reference to `of_icc_get_by_index'
> x86_64-linux-gnu-ld: (.text+0x441): undefined reference to `icc_set_tag'
> x86_64-linux-gnu-ld: (.text+0x542): undefined reference to `icc_put'
> 
> Caused by commit
> 
>   12fa389dcf86 ("OPP: Add support for parsing interconnect bandwidth")
> 
> I have used the opp tree from next-20200512 for today.

There is some issue with Kconfig dependencies, we are working on it
and until then I have removed the patches from linux-next branch.

-- 
viresh
