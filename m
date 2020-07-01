Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22245C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23C320747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vWbfzuqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgGAJy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbgGAJyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:54:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B528DC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 02:54:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h5so23127011wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GCRZB6BO+WyqQHb12yXCGEbLuElRDfMYs0DsVwcbgz8=;
        b=vWbfzuqPVrNX7v6iAfV0+OOZPHV9P2biz7CACnxJnk7O4VIzZaoZlTc9RABqNwAPjw
         EZCgRLvRv5730sYlDzrffkU85iFRundzLySypQ6JMw1ayp4sJZTO4oka3cGHS1B4I4Gg
         Ma3yGver6/dfDPKaPzKc2N4XDxpFnA3ktfIUBk7hixZqVBL5XJKDj1PsYPNiYb4GZOaR
         KKalsHMvIgfis19wOCyAdTJBafUn+UqURSITCZSoRlzHZoCPNcFLl+p7XuzUKb9Ko7pZ
         ehsUzUV4p06e5ZVOEmP2BiwZwWvKFVfH9E1TP4JkapM7Xk5xiqrIHQDy/PBQO4r/WYPq
         gIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GCRZB6BO+WyqQHb12yXCGEbLuElRDfMYs0DsVwcbgz8=;
        b=eD8HMw21Ss3Ztvg4ylLoCNgB7kPFkQdlCumClM5cLj+/CZRDzHfNJjLspVvW0FeShV
         lqh1cgVYtPFUZqNWYwYsX7lZkyCKNdywLwLbDQDruclurHulmJPrO5Sc+ioz2DrPzBQ4
         vZtzJcNheezucpNwVB7qq9wtEia+2AFsoRLAaeqAQ9Pcv66sCN5fuIcA02c8Wdy+9BRm
         acJhemoSw05RE59cgqiJYGGj3tStOic/YhD5W24J4M7ka44m0ZwHeh43jQTmFO+WM1sy
         VaFURrmBcogG3A4tYYPw6JTRxd4TL/Y8cpMQNYlqqr3PfM49ZlUkeQ0Xyn26znGRJ25C
         HMOQ==
X-Gm-Message-State: AOAM530nwa+Lr3wsscje5y+4EQT/yHp2FjyBzaLXqmQ2h5qRHn1qco96
        7nLM8UroQ/C/vcoIMc9fHDL1PForaaE=
X-Google-Smtp-Source: ABdhPJzaYGU1BSMnZvI9LWba79wJ0Itb9J0+P+qZu2C5QjA7/TzGTrUri62+jPSBEKYEIg1k/24+gA==
X-Received: by 2002:a5d:60c7:: with SMTP id x7mr24190269wrt.138.1593597264203;
        Wed, 01 Jul 2020 02:54:24 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07? ([2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07])
        by smtp.googlemail.com with ESMTPSA id n16sm6168328wmc.40.2020.07.01.02.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 02:54:23 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] thermal: core: Add helpers to browse the cdev, tz
 and governor list
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
 <CAP245DVy+Z9D+6=-cX4TaGFoK-e2N+mWwOvNYOe_E9Fh=7vnaA@mail.gmail.com>
 <bed1d41f81f369e7123a2eab7fde3e81a3b063aa.camel@intel.com>
 <143d954f-2ecf-c4d3-cb7d-f2ea75da8276@linaro.org>
 <766cbdeb2a0f9d9df4f68a71b4b0defd1e95e0be.camel@intel.com>
 <CAP245DUFg6UmzyZqHdpJZUzkPn-G9iQbGAPcpdjVcs75rYNNfg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6396d31a-ee4b-5af4-926e-e019e7b6fc84@linaro.org>
Date:   Wed, 1 Jul 2020 11:54:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAP245DUFg6UmzyZqHdpJZUzkPn-G9iQbGAPcpdjVcs75rYNNfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2020 11:26, Amit Kucheria wrote:
> On Wed, Jul 1, 2020 at 1:27 PM Zhang Rui <rui.zhang@intel.com> wrote:

[ ... ]

>> Then no. I don't have any objection of removing thermal_helper.c, so
>> you can just leave these functions in thermal_core.c
> 
> In that case, Daniel, please find attached a patch to move the
> contents of thermal_helpers into thermal_core.c
> 
> Feel free to include it at the top of this series and modify as you see fit.

I will keep it separate for the moment until this series is accepted and
then send a respin of this patch on top of the merged series.

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
