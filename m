Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551F0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315D72080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qSnnev9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgH0FOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 01:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgH0FOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 01:14:04 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FE9C061242
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 22:14:04 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 17so2567631pfw.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 22:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cBHoE76BRmIWjK8GBasxXIFwFSuyPmo/sqEtV0bmcP4=;
        b=qSnnev9F/aZWHDr5/8MADrCSBktScfoAZvPVSqSgnZdkziAqjFfTRRcxe4Ewqh0sYs
         XeEhcux2DoeJwCgpnte2jo+Tb5IgC/gyag4xlBz0QWgANA/PNEiiEeicsD/PC3fozLm7
         3vrVjrTtNAonXrOcT4sWCsQmSY/UAjtjypb2+6BDa7Cif8XCMh6A3uRK8FW7LMmYYjeO
         ytQZ1CvUKwcq9zNIXW6giAXvavTGYs0FOqyMdSWkwUR1uJ04iVGndaI37i03jdrzP8mG
         14xh5z8mNaR0wCuWBJdX0gLiyj6k5mDswyq8av8csip/G83PUPyh/BjqzADRBCZdf68l
         8nXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cBHoE76BRmIWjK8GBasxXIFwFSuyPmo/sqEtV0bmcP4=;
        b=HJdp7BYFIoSuBb7J4qusahftpNhjOW60Wv+x1BKuLY5RwSEAqq9n1uNsnOmJX3XaZF
         7r8t6GXp7FQTXiZjKJn+TimbVPFsB5FQOEUIt5wOLOr2atkg2PNMfdTCp/xS+dIMw4j1
         VL8CzdhY2op0lvHVrhH29ae2AU7JdHUVAGlOE7fknd6bLaq2w0whOlLLIbNBHMp2WnDb
         UwnT72XCVPrIGzjt+iq/rkT+8TVZbyL1MY3LaPCc3YShkEgEle7uXs2rCerZl/Chr6LI
         a/EsH0fIuyhyh0sx8BPhcK0ouMkJE0jxshhMDCO+6AO8efKO9bwHVXS7e0ssXKigbVry
         Pprw==
X-Gm-Message-State: AOAM5319yenjHvjwcHYjgDdy0t6Rorq8Dwy1Nc2C6c4z5lKJXMNxeMgf
        O+sVwPNhMnRWyoc5aR2QBIO7ePhM9XYMOQ==
X-Google-Smtp-Source: ABdhPJw2o3vKKmT5+jk9Yh7g4SdntLbf3XgImV3KGAJcmCCFpFNBAB55zgqUX2cTpO2gqRBSlzvkjw==
X-Received: by 2002:a17:902:ee8b:: with SMTP id a11mr15130201pld.30.1598505243978;
        Wed, 26 Aug 2020 22:14:03 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id z15sm856087pjz.12.2020.08.26.22.14.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 22:14:03 -0700 (PDT)
Date:   Thu, 27 Aug 2020 10:44:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>, rafael.j.wysocki@intel.com
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] thermal: sysfs: fall back to vzalloc for cooling
 device's statistics
Message-ID: <20200827051401.yryitpgq2gi3nkbh@vireshk-i7>
References: <20200818063005.13828-1-zbestahu@gmail.com>
 <40b69f97-46e5-d62e-0d2f-604dfd4dafa1@linaro.org>
 <20200826101319.00003048.zbestahu@gmail.com>
 <c3fd7949-b33a-aca3-8dd5-1c2df35fb63d@linaro.org>
 <20200827120327.00003740.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827120327.00003740.zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-08-20, 12:03, Yue Hu wrote:
> Hi Daniel,
> 
> Now, i'm just focus on removing the kernel warning based on current code logic.
> Commit 8ea229511e06 (thermal: Add cooling device's statistics in sysfs) added
> the thermal statistics by viresh and viresh gived the patch an acknowledgement
> in anther mail thread. 
> 
> Hi viresh,
> 
> Could you review the patch again about the question above?

Yeah, I Acked it but the questions raised by Daniel are very valid and must be
answered.

I understand that you only cared about fixing the warning, but maybe we need to
fix the driver and the warning will go away by itself. If you don't want to do
it, then someone who is responsible for the driver should do it.

Was it the acpi_video.c driver that you got the warning from ? I have added
Rafael to the email in case that driver needs getting fixed.

-- 
viresh
