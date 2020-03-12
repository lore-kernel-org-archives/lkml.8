Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114BAC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA7C20674
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="INV4LL9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgCLKPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:15:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43423 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLKPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:15:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id u12so2837784pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 03:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NrWeVKFKm3KJNrhGkRSBOYO/xSPIyOJst+AQW6M9RlY=;
        b=INV4LL9JXfbpzVD8X22Gzz4sGDVyD0phYXZQyeiJmO9hr7b6vrOq4zFT5582gefjGs
         b5tydoyHozZ0f3bpca+Kd/p2S9/V6Y6aiTWPnr0ZDOPGH6Ezrlph57M+fAJXh3XLihFN
         CGwlKXzSHIlrwTz/0VZPEMV9a1IX4SOV+4fnViqwf9TDKAai7+ANbFEv1kDJZ4OzC/B7
         3D7JvUo009N7SdgRmuTRgvewAOOllNZ/H7xymAeE9sbdzcUs+IW8JLmvr5H/Sof7zHgy
         c37veR7aR/9LU0Mksf/C564ikV2HJlrWyJZa5YeeY12sAamI3BoW3s4XnPsxEK6MvN2B
         uFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NrWeVKFKm3KJNrhGkRSBOYO/xSPIyOJst+AQW6M9RlY=;
        b=WKLtvlrMNjT5xIVzgRv8pRlDvH9kjf8pnk+MJ01+ZFP3uiJrQOOI4x7shWlld7vKYw
         D1HjYsf7IvEgZ9eihq19TCGirrs819pMMzb2N0eMOQxvCdLUtomL5M3CA957gqnxU0As
         4Fuks6BH1w0cOxbwIma1NEWtJ7RJ4yYGWed9l8djBZ9SUW9Ju86tiKmmoO1M6v68RXJW
         IIfChqiXwxP4sOcQRh+XfSt7N2ICEuaHTQ4l0gACODGuXioUZ9mTy3JQ0/6pAaDe6BJR
         QdBACrqu+Mh0fcBPmJTH0aS7XYIMP+bkzeLAQpJJdvabzfZlImNBBL87PM5m//WW0ziC
         4DHQ==
X-Gm-Message-State: ANhLgQ0bBGGKkqsLx1CyMVPMLg6k6vp+JCJex/iyzBQbMfE33x0ZhcDu
        wQH1QBcrGM8IPX2DsjzA/zzftQ==
X-Google-Smtp-Source: ADFU+vuI3QrWm3vKU3oXZdjQWeApNK1gMeLeM9Hp1wmXvFbbfWlWeXr+uPrSgioZqMfq5JoeGYvaNA==
X-Received: by 2002:a63:da45:: with SMTP id l5mr6719291pgj.273.1584008145505;
        Thu, 12 Mar 2020 03:15:45 -0700 (PDT)
Received: from localhost ([122.171.122.128])
        by smtp.gmail.com with ESMTPSA id p21sm53946207pfn.103.2020.03.12.03.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 03:15:44 -0700 (PDT)
Date:   Thu, 12 Mar 2020 15:45:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     peng.fan@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        abel.vesa@nxp.com
Subject: Re: [PATCH v2 10/14] cpufreq: dt: Allow platform specific
 intermediate callbacks
Message-ID: <20200312101543.ktvmfedt2o4ovsms@vireshk-i7>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
 <1582099197-20327-11-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582099197-20327-11-git-send-email-peng.fan@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-20, 15:59, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Platforms may need to implement platform specific get_intermediate and
> target_intermediate hooks.
> 
> Update cpufreq-dt driver's platform data to contain those for such
> platforms.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 4 ++++
>  drivers/cpufreq/cpufreq-dt.h | 4 ++++
>  2 files changed, 8 insertions(+)

Applied. Thanks.

-- 
viresh
