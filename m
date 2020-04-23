Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24B8C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73AB62084D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsyXxkNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgDWJzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726474AbgDWJzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 05:55:21 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7893DC08E859
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 02:55:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so5859519wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 02:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CNZHIzr/sBiOQMg4o7SLifEDxLKhTFFCAk3xHKq/Wkk=;
        b=DsyXxkNH0btzVamhIFYzv5e350yw7X/w1LKFwogh0iIwGOZ96kVPXuXkDX32LZlwAC
         94fwg0MWeHie4nOwR95Jrn7cRtHYa60rXz9VOiMSFM/iKMyymQip57NZrPEQTg9A9yrb
         sU1IjCQpH+9HLWLKs738y4q6R63guG/pQy4hAMFfXU/FaxMDYHU6DOWGVn+x2CbWEpkx
         Vo5zrIPAcwf72RxKvq889DHMx7Sv/eAARH47GGoJKHa8+8uB7M208Vnt1tgwYaqBlp/v
         5UkeF6iEQSn2bZD9AtRien1PivU6B7DVufUotKDoDbqTxnfNsCAXWKrMdChEeIIErbT7
         0RBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CNZHIzr/sBiOQMg4o7SLifEDxLKhTFFCAk3xHKq/Wkk=;
        b=oCDcH8cVogvG05fOi9+OfezVJSvfqXlnANHGIb995hwsSKBeUSR0odjGXkgURDM1Wq
         o5nWBS0KqA+0AQ8cdtpQaI7I471vRM2xdKWLp80Hckjf0lnjQ0EHWQpd59rt8CmmBA09
         ooZtXDEIKR+mj9z33p73X7HZoZ3Xf7ydSfVN6xA6jlp9y2CSVpNjOysdsUCpGw84MffI
         jWlPGpFFEN/u0H7OC0+a6zRHW3Rak2EILN5PllIwcgYc0yIpyJeJlW+8U+IpJsa0in6T
         08w7NyXDdDhBDXW5m1vJcMYEP9LenhZw1YGa2ZArxzRF4V5zSny8bkcicgs11x9h/QXL
         nzdg==
X-Gm-Message-State: AGi0PuarW5LRsiW5XSqOSSlVTXEq8S44rH3KqTiQ4xgMc4WdUaiWGPRg
        G+ZywdI6iIzThLWUQ3ZgJvqAfQ==
X-Google-Smtp-Source: APiQypL6ZyvDfFcOWCfVXnw6SXTOR2+Oss71maaUGGL6LrnXJ7de4PKprtb6zu5/4UALDKzAFGgGXw==
X-Received: by 2002:a05:600c:2112:: with SMTP id u18mr3386058wml.112.1587635717910;
        Thu, 23 Apr 2020 02:55:17 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:75d8:694c:3b71:4e43? ([2a01:e34:ed2f:f020:75d8:694c:3b71:4e43])
        by smtp.googlemail.com with ESMTPSA id i17sm2997016wml.23.2020.04.23.02.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 02:55:17 -0700 (PDT)
Subject: Re: [PATCH v6 01/10] PM / EM: change naming convention from
 'capacity' to 'performance'
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        qperret@google.com, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
References: <20200410084210.24932-1-lukasz.luba@arm.com>
 <20200410084210.24932-2-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3f764593-99fa-bce3-3630-ce16101df536@linaro.org>
Date:   Thu, 23 Apr 2020 11:55:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200410084210.24932-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2020 10:42, Lukasz Luba wrote:
> The Energy Model uses concept of performance domain and capacity states in
> order to calculate power used by CPUs. Change naming convention from
> capacity to performance state would enable wider usage in future, e.g.
> upcoming support for other devices other than CPUs.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
