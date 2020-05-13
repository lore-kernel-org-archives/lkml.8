Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12DDC2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9BC205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vnk99OyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733279AbgEMKUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732917AbgEMKT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:19:58 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074BCC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 03:19:57 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 145so7789162pfw.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 03:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VfKfV79D0eRX6SR2B/6OP0RS7P7iJP0BWvtrNbo0Eqk=;
        b=Vnk99OyRW5JipQ5yHpqo/7r9UoI/5cGYHhFChk/a2bKlm8lQJ6hhlEaAeyOb5mzNqo
         vSXFFoCUCLlKqfltd65Bbe6XD3dKcyGdYBDWgvPvk/8hZDmD6bHo+SF56wR5jkUpDn50
         AYv0Sr0oJafCU+3i3HZl7eHOCj1eeKXLnmH8ZKaFlW3/XJZDtgnmEgRijKPz4OTiQ9/m
         1x72rjD9+gg+v59BVTuXKUpI66la8bLcQM197Kg1KnrQuMI9LAJ2/WItQLk5H0vK1H/Z
         TbyPOhpD4OZT7tdcwXpVFBxCx1kAidmcFl8tawAlMYEaYkuex8Hi4xPqiJtHqKj5gfM1
         x4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VfKfV79D0eRX6SR2B/6OP0RS7P7iJP0BWvtrNbo0Eqk=;
        b=YtQ0mVW7Q2kOmqzjefcJGiGDK4ehBMk6M80PTJf1pw5Q4CJkSZf90zfybnCpYLBiFs
         J+W9KInMK5zFf9l6My8oiKWr4/0XvvRA/1XDJBTTFI5EsO1M7aPed3wLioh784QUhPdy
         a+FOxUCD2bDpTnC0sUbiGG1jI8H9Dw7ZE6rvAudmXZFlI+hYKwuHLChOQ9dFOV4hBPuX
         Jb2mcofg+znS8eyNre8bqN3cybn27Go77QLmMBcW6ej9sV5qcdKkO/fVe4ZqxnVxFSi+
         er5fgbw/f3wKX1qX2uJv+HZKXfUVGa+dCnfidmh6uoiDhvwVvdy0Siap0/0tmeQ+9iFs
         KqJQ==
X-Gm-Message-State: AGi0PubbLegJWRSuDGm6OaXvOhnH0lJ+jKE+ZtSkC5/U+wS0xppMBVja
        f1gi9WbCxAva/A37k+8oYgPiDw==
X-Google-Smtp-Source: APiQypLZtSZsVqakT/gaCx7UCx8AEIOT7uiie03Jhbfw/jMfsRFy9Upob5VoFHsbOud5kvZBZEbBWA==
X-Received: by 2002:a63:4665:: with SMTP id v37mr22486920pgk.297.1589365196575;
        Wed, 13 May 2020 03:19:56 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id k1sm8911542pgh.78.2020.05.13.03.19.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 03:19:55 -0700 (PDT)
Date:   Wed, 13 May 2020 15:49:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org,
        robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/10] dt-bindings: interconnect: Add
 interconnect-tags bindings
Message-ID: <20200513101953.zuxtjnwj2axedtch@vireshk-i7>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
 <20200512125327.1868-10-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512125327.1868-10-georgi.djakov@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-05-20, 15:53, Georgi Djakov wrote:
> From: Sibi Sankar <sibis@codeaurora.org>
> 
> Add interconnect-tags bindings to enable passing of optional
> tag information to the interconnect framework.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v8:
> * New patch, picked from here:
>   https://lore.kernel.org/r/20200504202243.5476-10-sibis@codeaurora.org
> 
>  .../devicetree/bindings/interconnect/interconnect.txt        | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> index 6f5d23a605b7..c1a226a934e5 100644
> --- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> @@ -55,6 +55,11 @@ interconnect-names : List of interconnect path name strings sorted in the same
>  			 * dma-mem: Path from the device to the main memory of
>  			            the system
>  
> +interconnect-tags : List of interconnect path tags sorted in the same order as the
> +		    interconnects property. Consumers can append a specific tag to
> +		    the path and pass this information to the interconnect framework
> +		    to do aggregation based on the attached tag.
> +
>  Example:
>  
>  	sdhci@7864000 {

@Rob: Though I have applied the patch to my branch for now, I can
revert it just fine if you aren't okay with the bindings. Please lemme
know about your feedback on this (sorry for missing that earlier).

-- 
viresh
