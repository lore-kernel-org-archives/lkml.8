Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6430C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3488215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aLHlS6xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgEEE4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 00:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726065AbgEEE4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 00:56:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAE0C0610D5
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 21:56:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so334001plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 21:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0bcNjjam7owzFyIwJPvOejbVBTQ69maDzUfbwggZ2dA=;
        b=aLHlS6xiNMHuJwgtS5c5FBNg7bB7qF2DSLw7iTqBVNXqJfmgox5k3SxD7cxrmKdk6v
         l+kjTGGSZZKpT+CpQLlZN1qjlVBOya7XkibQvKsue/5dKzBH9vCbAJT8qr9Ma53x/3yI
         QXIwV7ZAU1/UFqF4a6EW2NLopHZvqG1Rpm8orjkIk7tClG4Q8UbHmh8MOlLqqN0yzsYZ
         Au7XZXV+dC9LVCS2NqNAnPzZ6jxJ22bARxfuvAPIT+7hPeuPDiMyHHV8G3Vs+JhdS+DR
         cufyrx/Hws7YY7h93HkE1ORrPU2aw1a3ulvVLWrVW3NIhMU4oQfjzxIrNxURG6M226Uu
         ucbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0bcNjjam7owzFyIwJPvOejbVBTQ69maDzUfbwggZ2dA=;
        b=p+1fEFDFdgrl4FhhUdK9BpX4UFd+hM5d+119mW6catM+JYWyWmXVYTGzN+mCBqM0A9
         bbE96mD6pntN3bmDE/R1u4aYIV9aH7TtN5XvPbYtJp8vPk62au0dA48q7sFeJh0nfyRj
         bQBsnggJGDc58E7jV7wDN1fV0D8rkH5zLvVVkY1g/3vWdfrGN53xXqHj8L7cV9YvqgXY
         uxY/CJ5JhAHN/GUyZLt1yCfueKW84zxeZzhjjOCQM9k2VP90xZshkcjy6TwZrORlOSwY
         cGuIaPqTOr2pO+UmCYLupxlO7jAl9Li8kMcxRTfBCtZfdssuv4JmC0nhf3HpIXFdjETB
         4XMw==
X-Gm-Message-State: AGi0PuZzk3IOIZsbFLlqGRXHwdaRXjmjfdza76ATpv9HLTk6c24L5M1X
        wqxf0G4Rs+zWTCi1ksdsyWISMg==
X-Google-Smtp-Source: APiQypKz5PGkrZWTJbP3+f/TlvnG7+he8Ca87yIh/qmdt7h/HMYRPft82Ev9HjoCwI1XU0L+nqL4ug==
X-Received: by 2002:a17:90a:f197:: with SMTP id bv23mr677669pjb.3.1588654601713;
        Mon, 04 May 2020 21:56:41 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id h14sm721964pfq.46.2020.05.04.21.56.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 21:56:41 -0700 (PDT)
Date:   Tue, 5 May 2020 10:26:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, saravanak@google.com, mka@chromium.org,
        nm@ti.com, agross@kernel.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, ulf.hansson@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com
Subject: Re: [PATCH v4 10/12] OPP: Add support for setting interconnect-tags
Message-ID: <20200505045639.i4nnplwaxlkful4o@vireshk-i7>
References: <20200504202243.5476-1-sibis@codeaurora.org>
 <20200504202243.5476-11-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504202243.5476-11-sibis@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-05-20, 01:52, Sibi Sankar wrote:
> Add support for setting tags on icc paths associated with
> the opp_table.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/opp/of.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)

Maybe this should be part of Georgi's series ?

-- 
viresh
