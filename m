Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0C3C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 04:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4791020768
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 04:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MejU3VUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgHME3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 00:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgHME3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 00:29:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C4FC061757
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 21:29:43 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f193so2153410pfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 21:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xIdIpbnx60CzDLvbTVQD5OyHFhB3i0JZtsYS6xXe3jc=;
        b=MejU3VUHQfeX/8vP4xljEDExyeMgyTbHPaDCkHdMQ3sPCnWKfITG1MPAnqQR12gc+r
         VPzYyjc24N79BG8NU2kpGB7/BBYiTcvI+ZmxfkIUC7I9iZW2g1Jsjeraj83mbk7P8LFu
         Tz3n9Z5OSUaheVep1IHXkIGK0KxGMwo0XThXEjv2jMJ/RUS6pZ999qKL7XswloRgrhAB
         9Nb5ZBJHT2wfgzR/ayhogd3alNISpLYKx2a8dYsxQM8uqOgHauYx3z+uA13O05Mj7U2m
         GkjAWeHjcX+VE6QK+T/23OFOzL4mXHU/zzEnKcBjTpoEZEALz0dcf7hco+DrRMnw1WyB
         Papg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xIdIpbnx60CzDLvbTVQD5OyHFhB3i0JZtsYS6xXe3jc=;
        b=gPBUlY4m/re8ntVZOQD8wm8/f3Tl7/RJuxShkT9UPyMsfQ5f6nf5ZOHpj6fHYvWYQZ
         O54ub4iAPkXotKM8TX5a5v7smHme+PGWsK0g3zckXqlIA0kStCrNQ+ByN2jMhgYkLDoP
         p6Qwoq2Wmbme905KazJGuV9bKcyG1n2otFMDOA+iENUx8uMBFWiMSeGNwlGSUZhGgnHm
         p7Vu9bODoAbqxJEc0b/aHo55y2TAV2CHSYB3zn0zpJyodzHxVVaDh7oNA5QmXPbpB1ys
         3P5iRGFEYCnPKD133iDTHRHQECKQ9rqU4PfC91VLKyov3NW0Ckp80qwUbNVusy83Zb/O
         spWw==
X-Gm-Message-State: AOAM533lqjdikN1xauT7OeIuxYtdszagJurVBbC2TtZ8kLoHZlswJXg6
        Xrgyq/f9tvXHJp+qm1B9pjPx8g==
X-Google-Smtp-Source: ABdhPJx6frQktQqrAUHEZ1iFW6nmiLYBgM7XrzuzOuqkpNDkGl/pJc+JVQoakHmORATi5XJ8nxy2AA==
X-Received: by 2002:a05:6a00:1509:: with SMTP id q9mr2625321pfu.24.1597292983508;
        Wed, 12 Aug 2020 21:29:43 -0700 (PDT)
Received: from localhost ([171.79.32.211])
        by smtp.gmail.com with ESMTPSA id u14sm4080239pfm.103.2020.08.12.21.29.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Aug 2020 21:29:42 -0700 (PDT)
Date:   Thu, 13 Aug 2020 09:59:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, nm@ti.com,
        vireshk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] opp: Fix dev_pm_opp_set_rate() to not return early
Message-ID: <20200813042940.dg75g7oj3iiyuu4k@vireshk-mac-ubuntu>
References: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org>
 <159718019170.1360974.4800051292737590657@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159718019170.1360974.4800051292737590657@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-08-20, 14:09, Stephen Boyd wrote:
> This is a goto maze! Any chance we can clean this up?

I have sent a short series in reply to this series, please have a
look. It should look better now.

-- 
viresh
