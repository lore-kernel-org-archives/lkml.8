Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5F5C433F1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90CA20658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bAXyF5mn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgGOPIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgGOPIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:08:09 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003D6C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:08:08 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id k6so2256869ili.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N2Tc17Rr4p8/CnE9/Q69Mw8vNfjf1wSeomUtzrfVVt4=;
        b=bAXyF5mnFFNR50WGQCzoR4y0e+YNErNmhCFIzAXmeEtskZ7YDy+JJQIW87Ox8yK/vB
         rwIwwOP6uTHi8U6q0Pad9dFtVOntIC5IJtLE5CKpTeiotgrWDY50fKatgrtcfdYUUnhN
         Zi8Ip7+cnsbF+I9HXiuhpj9cCmF0fxr90MjB7LXT0hgfOK/6RScSZbxcSMoo9ANXRXlP
         lGHrWhatHeSzlG2kFnOurhmusDInccD2yNh+pvPnM9UqTA8v7TuOO2bU4hogfiDWQgv5
         SXPUq3OtKkytIWOpLAos/2TRw5XbiaJZej4OIefJXGRnTRHXfDjDi1tHtInU33l5qCtB
         AV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N2Tc17Rr4p8/CnE9/Q69Mw8vNfjf1wSeomUtzrfVVt4=;
        b=mpIV6ZKGjFnxPwvcNySDRDw6CSYBjKy0A9LdqK4HsWxJqdv+hosJJDljpIUeVKGfY+
         9W8xbhGtpwslciHWxMaIZ25J9wa4FbzcZB/rHo+K0P0LQp5dVEamAdsQyTSstEDBndf1
         illwmRkY0rg+sP/JxYKxetF26yuOxQDTBbsZudVLhWyM2C3wz0NLdDcRs0fAFFcskp9m
         XL20F0jll1oq+gZDlWdjancyJRQCCYb1f7yYJAjvizfQbDxi7fq2lvHqAOWCrz2RdziJ
         pa7nooj/FVj/ydUqiGF6cI58yizCxemYoIBwKqNfu6tp1JHGl6cZtIqsVWPZ6pKQIviV
         GYXw==
X-Gm-Message-State: AOAM530CfkABcDCEedZ+WK1IXc7dWLJe7MGOyslf/1/DE20I+iT964AI
        G3jAaRocGsO7A4UM1vKBgTd8d3zSVYSLSQ==
X-Google-Smtp-Source: ABdhPJwFgGIm9OBMGPtFlk9DjAAg1pLSFUTqlyBWPGuVv1d4Ker51JWjIoh/EMy1vWoA1unf4T5oow==
X-Received: by 2002:a92:48da:: with SMTP id j87mr10913166ilg.197.1594825687973;
        Wed, 15 Jul 2020 08:08:07 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r2sm1271254iop.34.2020.07.15.08.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 08:08:07 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200715121423.6c20731b@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <22e580c4-be3d-5917-b8dd-4a212f5160f3@kernel.dk>
Date:   Wed, 15 Jul 2020 09:08:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715121423.6c20731b@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/20 8:14 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> block/blk-timeout.c: In function 'blk_round_jiffies':
> block/blk-timeout.c:96:14: error: 'CONFIG_HZ_ROUGH_MASK' undeclared (first use in this function)
>    96 |  return (j + CONFIG_HZ_ROUGH_MASK) + 1;
>       |              ^~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   91ba0f529364 ("block: relax jiffies rounding for timeouts")
> 
> CONFIG_HZ_ROUGH_MASK is not defined for this build even though
> CONFIG_HZ_100 is set. The arm arch does not include kernel/Kconfig.hz.
> 
> I have reverted that commit for today.

Thanks, I'll take a look.

-- 
Jens Axboe

