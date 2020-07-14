Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA526C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8677A204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="neWIcuYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgGNHb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgGNHbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:31:55 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B204CC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 00:31:55 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x9so6678334plr.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 00:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J3KZkLfKSbC5BZHL1d7yO/DwRivb2bB63Afyu0rAU7c=;
        b=neWIcuYRVYuNZuF10/O3q7zrFJP1sqCxlXB97WQT2VbL3vvBdpupQ/95yQPa2zdUQu
         wWarWnCZZcwf31IYFbOm+0q9QrPLM7Y8VaO6OcTrVRqtC3+QFlWdTwLVX7e0vRZwY6C6
         8gRJ4wKSV1CbCtbXTPTT7XBQRZItRciZ0RyMPlDxmi3EctrZQQPeIYMH7XpPKnCw7z+U
         uEQI4ZGtjktdxDrhh5dbQEkESc+LhHRT/iFVbo8EXDxc8fzcEQD0tleyYa+uyntfo+Rj
         0SRP+ixxeCsrRkMY0LSTqJrx/KJemBooUE5Xz5iB+BuNSrY8NVsn1xi7mDHZ/WeLHUAM
         6J0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J3KZkLfKSbC5BZHL1d7yO/DwRivb2bB63Afyu0rAU7c=;
        b=IgUmPD/BuFL1zRq1BGkXD0UkeV7WM4SEm84KbwgxK6uZsLKrEWkl0qpG9St6+DX+Vg
         w9fiNRhn3fcOXmlJ2RZUbJ8+9XZ3C/WKYNFWHXrx1WiE3XOTZQFpV/cK3sXHr55eCaHs
         hjwkoy3/LxkVHTbFGhQLNA+W3Y01VxsGZyCelDIiEX2WBKL7U867It2dIfIWvpivjS+Y
         qB8eOAm+bf7wQaEg/qsaxVD8mPBHp4W6xSD9LjE+3xEJWIJE5bTd1a+aleVhk9gy1q0M
         YDoL+0odRsyRLokXZgQXJchKJDFOLRgqYLIPxKutEfv/aKsQNClBJ6IfsXrzdQR2HLgx
         1H7g==
X-Gm-Message-State: AOAM533lAD/aEkhUWtcr4Ri+2Vqe4MYmno8WxGjXah8129HY5xGR9g5B
        +GfXNGSn4P2xOOA3JKxjZlIyrw==
X-Google-Smtp-Source: ABdhPJz4Gu9yn7RPaM4tJg1tqh+c8051L0lJfupoplxt4ZQbS1Uj9OmeRr99/0ypRIpDK6J+yF33xw==
X-Received: by 2002:a17:90b:300d:: with SMTP id hg13mr3447366pjb.212.1594711914895;
        Tue, 14 Jul 2020 00:31:54 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id g6sm16518336pfr.129.2020.07.14.00.31.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 00:31:53 -0700 (PDT)
Date:   Tue, 14 Jul 2020 13:01:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: tegra186: Fix initial frequency
Message-ID: <20200714073152.cof7pdgevcaettm2@vireshk-i7>
References: <20200712100645.13927-1-jonathanh@nvidia.com>
 <20200713032554.cykywnygxln6ukrl@vireshk-i7>
 <3d6091f2-6b04-185f-6c23-e39a34b87877@nvidia.com>
 <20200714034635.2zdv3wzmftjg2t4a@vireshk-i7>
 <aa941c67-1dec-5363-7bd7-5e9d8d324110@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa941c67-1dec-5363-7bd7-5e9d8d324110@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-20, 08:26, Jon Hunter wrote:
> OK, I can add a get callback. However, there are a few other drivers
> that set the current frequency in the init() and don't implement a get()
> callback ...
> 
> drivers/cpufreq/pasemi-cpufreq.c
> drivers/cpufreq/ppc_cbe_cpufreq.c

These are quite old and I am not sure why they didn't do it.

> drivers/cpufreq/intel_pstate.c

With intel-pstate driver, the firmware sets the frequency of the CPUs
and it can be different from what cpufreq core has asked it to. And so
the kernel normally has no idea of what the frequency a CPU is running
at.

-- 
viresh
