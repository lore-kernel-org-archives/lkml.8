Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D240EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE952078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a/H1lS9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgFOXML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOXMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:12:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAEBC08C5C4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 16:12:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h22so613385pjf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=brcjvLKF1tqBCWFby3z+8MOldV/7mW3P5ikqS7XALSA=;
        b=a/H1lS9d3FYn9UhSPXJsrr9Ixza6PpJjH8tSHUvh/CVDtcrK+HwLEfl5AcfQGKk7Yt
         DgkSjxwNcl1kly5pAN0wEFgD8B08fUExsWnorPyLFmvpIBj+R/zkm9nzMFoDzMIv7hC6
         We3UEU2NIbpxqEVOI2R78klemetd7V15D0qk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=brcjvLKF1tqBCWFby3z+8MOldV/7mW3P5ikqS7XALSA=;
        b=WbhWna5AXL5zCXVzgntZ5pqxfD0S2Ka88QXW7D+Mo4EJFKGJA2H8FHYlHldB/tsP8G
         aRGJY0XlNgdov1pOms1EZ5OFsgBfUp5FlcWv/Hcq9pwA+6KOohyqIHNEAZG1cn4yKOWS
         fDKKCs+LkVpQVQWjPV3TUCHdOGBgXxsLfYE7Iydlh8an2ff8vNg+Zo0cCVYqufjuKieX
         CYr/BCcwqrybccnAakxgE/wv74Rk2/f2beT/eXhohdd1mplfIx0RJm1bi60T7PPwpMAK
         eZ8t3gwiQFnNDQsV2JT/sDBH9O7PF0Sz04NCaWWDTWNQqNdlbRozjSqJyShEAzWoddbV
         5Hlw==
X-Gm-Message-State: AOAM5303+44DKqoTHsy8CxLNb13AQK3IIEHsHnM3pUUAcSkyyCeW3PKl
        KG5pKf1mDYMIWyB2cJNcYmXfIQ==
X-Google-Smtp-Source: ABdhPJyyci+2oQlVyjby51mYZoyBYZiTzI2eRXhAYx5ofJPrOzIloyTJpVXRIiOsGGjwxvfH9O22kg==
X-Received: by 2002:a17:90b:3004:: with SMTP id hg4mr266813pjb.208.1592262729649;
        Mon, 15 Jun 2020 16:12:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id h3sm513401pje.28.2020.06.15.16.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 16:12:08 -0700 (PDT)
Date:   Mon, 15 Jun 2020 16:12:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, adrian.hunter@intel.com,
        robh+dt@kernel.org, ulf.hansson@linaro.org,
        vbadigan@codeaurora.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc-owner@vger.kernel.org,
        rnayak@codeaurora.org, sibis@codeaurora.org, matthias@chromium.org
Subject: Re: [PATCH V4 1/2] mmc: sdhci-msm: Add interconnect bandwidth
 scaling support
Message-ID: <20200615231207.GX4525@google.com>
References: <1591691846-7578-1-git-send-email-ppvk@codeaurora.org>
 <1591691846-7578-2-git-send-email-ppvk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1591691846-7578-2-git-send-email-ppvk@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 02:07:25PM +0530, Pradeep P V K wrote:
> Interconnect bandwidth scaling support is now added as a
> part of OPP. So, make sure interconnect driver is ready
> before handling interconnect scaling.
> 
> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
> Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Do you plan to send also patches that add the necessary DT entries?
I'm particularly interested in SC7180.
