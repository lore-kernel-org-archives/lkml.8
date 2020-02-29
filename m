Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2482C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 00:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C605E246A8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 00:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BA1m1yb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgB2ALC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 19:11:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35548 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgB2ALB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 19:11:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id a12so4189262ljj.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 16:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBJm70vbCm0LCgNvDsCCsjTJ9PBmdad0nZhpwK5OW30=;
        b=BA1m1yb8EjVa87IwqexlqG9YD5+1FxdNi0fybLqKTY1lr+JdaGhoGz1NnCbYNIuD70
         C97Mla/aSciSFJD84HLwuF8SH2rrgCGGGpmX7Sr76vnrhQw91k88N2suNg/2Qy6dsSBH
         wanttyosuVCvZi1KMU6VIIXDAxBgXsyUJKUQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBJm70vbCm0LCgNvDsCCsjTJ9PBmdad0nZhpwK5OW30=;
        b=VmMriRDRH8h+XEuqZiCWQGbg8h+jOX1aQTGUJ/mr4r9EwBamG7nCjKZ8CMVMfIJdXR
         jyMynlEbxbYMLJcD+PSZ8Mwf0q7vBNs4/JPtNZQvc8zvHKDVX0y+p380JsvEvlYwaf4a
         pEL/C5AUL2GVQffIkrHH7Uj3JakmY34UfuotSt9ebBWFhqTDwciXn0eG3gtWR0fd1BIt
         fpbJnAI6Bb3+yd4K6P9cXNqPb6yWci5DAZV3rK2Mu8CjtiBY/DCJ8qRfqsvhpwigipPM
         FtE92iknXrA2FbLN7vd7eJ7RrLPT3l5Ux8kO3GTsyzTOVQkygJ20cVlUETot0XYu8agB
         FnhA==
X-Gm-Message-State: ANhLgQ1lSDo0ol65YPQ/uyy/6eT2o/yWOgVo1qsyk1szey6sWME/x54j
        lnfMHCE5+M5fkPmDyuQj4yHoWX/kv5c=
X-Google-Smtp-Source: ADFU+vvJvKS4VKkKQQ4VoM1fB42JnD0j6YE2N0HAb7+87EeBy17l+Yg32Fu6CUtfbSdXHbgOqtAhtg==
X-Received: by 2002:a05:651c:555:: with SMTP id q21mr4291018ljp.241.1582935057974;
        Fri, 28 Feb 2020 16:10:57 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id o26sm2356667ljg.33.2020.02.28.16.10.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 16:10:57 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id c23so3381086lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 16:10:56 -0800 (PST)
X-Received: by 2002:a19:691e:: with SMTP id e30mr3855069lfc.104.1582935056422;
 Fri, 28 Feb 2020 16:10:56 -0800 (PST)
MIME-Version: 1.0
References: <20200227105632.15041-1-sibis@codeaurora.org> <20200227105632.15041-6-sibis@codeaurora.org>
In-Reply-To: <20200227105632.15041-6-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 28 Feb 2020 16:10:20 -0800
X-Gmail-Original-Message-ID: <CAE=gft6bFOMaX_iCVogWjD2+8Hs3prBJi4GYA=KUPRK1M-ABgw@mail.gmail.com>
Message-ID: <CAE=gft6bFOMaX_iCVogWjD2+8Hs3prBJi4GYA=KUPRK1M-ABgw@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] interconnect: qcom: Add OSM L3 support on SC7180
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Odelu Kukatla <okukatla@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 2:57 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Add Operating State Manager (OSM) L3 interconnect provider support on
> SC7180 SoCs.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
