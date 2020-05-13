Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5062C2D0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A572A2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gc7Z967+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgEMHBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgEMHBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:01:07 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEF1C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:01:07 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l73so1391548pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xht2lyYjw3RWBPZeMoeAYqlmyNVt9OCwJ+waHrDKeEg=;
        b=gc7Z967+/+x+Rsbye80nih3OeRQBVS5NToLQHZqZX+ApJYFJOElSd40Ra1HZnEg0Ph
         Rx2a25ItsdZYotcejlAzUajOLBv0Vnw5ZBenOEJq38l9jyTu8H/YRIH6kNiTvovcXWi+
         ozcgLpWi6yUqbLk8B4b0HtezRWolYau49baOajAyrR11aE5vDgJAEV4M5R2XXlFHGrE+
         zXaBEMliC1qhG+8pH8YW8gH4LhQW+5/gUBaFAIDJQHDyQB0YxQMBzfkSXtKHxlIR2hFU
         L/oJ4yD0kfAZ4LdFXX7JxBEcAeCXRMAksgQ6Svtqo6gbrQF5F/89tu1uxZ7CMWW7+Hz3
         Yh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xht2lyYjw3RWBPZeMoeAYqlmyNVt9OCwJ+waHrDKeEg=;
        b=Vptg3T9NMS8gAB9JKYAe6OayTwcKzPmUR9HUApz57WgYbmigxcMkp9acpvpRiCgHCo
         /Z8/d35+M+8hjHi3Mpg6UqR/uNT4cYL27v/FhKQJclTDy/9c45pRQ1FvEQ4CxpDK9d2F
         NddumOklOuWSC25KavIzkfIb9FXO+PkO5IkwuYtr+7tba7NUT48mP63P3u8AsnrwBCLm
         vZOzuH1gCMbJ/TaIobXQXufd/EpnBJFcJ3npvfJSZptW+MckD5MZLxcS8mxuxjC0RtBa
         F0qKmFd8fP/oORAy8+0fWhzh0Jl8S354a4KCEPftLcnwQR815gZxlqbzxQywki3DK+GQ
         SiVw==
X-Gm-Message-State: AOAM533itcbaqymdgys3lm+7j+Z/QafB0ZsrkD1M+LAPV2E8Z7Dgpx7j
        XFclb6fy8lTKHhkETdMV6Oe+7w==
X-Google-Smtp-Source: ABdhPJyaJmFj2yG8v3BmrLqGILiIpuTEKtwTuXWHIP84gKlaqkfpLJBdd+LiwbV9iYkBev0bjFD1og==
X-Received: by 2002:a17:90a:bb81:: with SMTP id v1mr1808779pjr.168.1589353266968;
        Wed, 13 May 2020 00:01:06 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id p190sm14234819pfp.207.2020.05.13.00.01.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 00:01:06 -0700 (PDT)
Date:   Wed, 13 May 2020 12:31:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org,
        robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 04/10] OPP: Add support for parsing interconnect
 bandwidth
Message-ID: <20200513070104.yr4jtfu3pyib2qts@vireshk-i7>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
 <20200512125327.1868-5-georgi.djakov@linaro.org>
 <20200513064139.5kxjjddcooqcvny3@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513064139.5kxjjddcooqcvny3@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-05-20, 12:11, Viresh Kumar wrote:
> On 12-05-20, 15:53, Georgi Djakov wrote:
> > The OPP bindings now support bandwidth values, so add support to parse it
> > from device tree and store it into the new dev_pm_opp_icc_bw struct, which
> > is part of the dev_pm_opp.
> > 
> > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> > ---
> > v8:
> > * Drop bandwidth requests and free memory in _opp_table_kref_release.
> > * Take into account the supply_count in struct size calculations.
> > * Free the temporary arrays for peak and average bandwidth.
> > * Fix the check for opp-level.
> > * Use dev_warn insted of dev_dbg.
> > * Rename _of_find_icc_paths to _of_find_icc_paths.
> > * Rename the variable count to supply_count.
> 
> Added this delta to this patch:

+this :)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 15f30ed70bbc..06e38f95116c 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -336,7 +336,7 @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
                                 struct opp_table *opp_table)
 {
        struct device_node *np;
-       int ret, i, count, num_paths;
+       int ret = 0, i, count, num_paths;
        struct icc_path **paths;
 
        np = of_node_get(dev->of_node);
@@ -375,10 +375,9 @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
        if (opp_table) {
                opp_table->paths = paths;
                opp_table->path_count = num_paths;
+               return 0;
        }
 
-       return 0;
-
 err:
        while (i--)
                icc_put(paths[i]);

-- 
viresh
