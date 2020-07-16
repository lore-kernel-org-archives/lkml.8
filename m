Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E230C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C421205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+oERqSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGPDXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 23:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgGPDXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:23:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7174AC08C5CE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 20:23:03 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b9so3261115plx.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 20:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5vL2rTMSzdb973P0bKvsekMeIZjsfxMApp0DH5ESVjs=;
        b=d+oERqSXZVucE1V+TQGL/D2zNmxgT3cpGX2KTRh4NEs8kTssviY1Ba3cbAxVizMP02
         QyQEU3W53ITr1t+HZHOPPMmsYI7qPCy/7b0Tjr8VeSDsj8mu6WXpeTZDOhxqb/ow7nVK
         NcPgTUhDwHSP0A5OFe+1+s73uw41VYCG1GGgAlPJBOW28GwS4PcFOCfS2DRUdRWbctIc
         YkK4wpm/cJDaE8S57OdeAa2GK2K8BXXIxe88FCTuIGh1kjXu3U3tZpyI+h8OogQlWncV
         PbsuDk692E0wysOoCWptCn9lHgdR06F01+h/us00y/6VrSGsqiYPnSs3fQlxADphJwnI
         hm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5vL2rTMSzdb973P0bKvsekMeIZjsfxMApp0DH5ESVjs=;
        b=CdunMj3z57o7P2J0IFBKTerpTAf2p0G8uEbsK+P+I8znWpylH5AVBG9d07ROSCJsWp
         2ZDeHi1wqWYKc8KqNeaZVLqNzjJohBqwpDa2ZaohTR8VYbMD1d+2y5RANmtTMOdDmyYP
         JSKN6eGfOUfyMuOg7cgssBN6pYKTSE5m/uWfFygAh4zYaMdZd4QcjTHV8udm7dddZie2
         28P19sWNS/wzsTrjLikatMSmYdGB4adZBecIGolBlwHXOcTIWvR/He5fAwhK8RikSNeY
         5PqicmqERuj7GJHgtj+EYDFUJd/RdyBpGDChEVvQ42rpaARwat6aX5Xjo9xS8T+4tyX5
         8s3g==
X-Gm-Message-State: AOAM530xTbyobw6fBkY+CbMuSGXi6ft+9cDG5d2lIYu2EEeJvIuvnQvF
        EtWp/hicV8HXYqUDCHCYlWSGTQ==
X-Google-Smtp-Source: ABdhPJyz6+Yw1GquiPJ80G7wUbREi52JSXyMY3Hl9inYjcIG9pgGPETGIXyrrx0B7gL0Fb8xBKJXVQ==
X-Received: by 2002:a17:90a:f00d:: with SMTP id bt13mr2843254pjb.109.1594869782919;
        Wed, 15 Jul 2020 20:23:02 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id g19sm3069589pfu.183.2020.07.15.20.23.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 20:23:01 -0700 (PDT)
Date:   Thu, 16 Jul 2020 08:52:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Walter Lozano <walter.lozano@collabora.com>
Cc:     linux-pm@vger.kernel.org, kernel@collabora.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Increase parsed_static_opps on _of_add_opp_table_v1
Message-ID: <20200716032259.l5ybqetpg74ybogh@vireshk-i7>
References: <20200716025452.25761-1-walter.lozano@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716025452.25761-1-walter.lozano@collabora.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-07-20, 23:54, Walter Lozano wrote:
> Currently, when using _of_add_opp_table_v2 parsed_static_opps is
> increased and this value is used on _opp_remove_all_static to
> check if there are static opps entries that need to be freed.
> Unfortunately this does not happens when using _of_add_opp_table_v1,
> which leads to warnings.
> 
> This patch increases parsed_static_opps on _of_add_opp_table_v1 in a
> similar way as in _of_add_opp_table_v2.
> 
> Signed-off-by: Walter Lozano <walter.lozano@collabora.com>
> ---
> 
>  drivers/opp/of.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 9a5873591a40..b2bc82bf8b42 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -917,6 +917,8 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
>  		nr -= 2;
>  	}
>  
> +	opp_table->parsed_static_opps++;
> +
>  	return ret;
>  }

Merged with this and added relevant Fixes and stable tags.

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index b2bc82bf8b42..314f306140a1 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -902,6 +902,10 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
                return -EINVAL;
        }
 
+       mutex_lock(&opp_table->lock);
+       opp_table->parsed_static_opps = 1;
+       mutex_unlock(&opp_table->lock);
+
        val = prop->value;
        while (nr) {
                unsigned long freq = be32_to_cpup(val++) * 1000;
@@ -917,8 +921,6 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
                nr -= 2;
        }
 
-       opp_table->parsed_static_opps++;
-
        return ret;
 }
 
-- 
viresh
