Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA72C3F2D3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 00:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B856246A8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 00:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LkkYFkw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgB2AK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 19:10:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32941 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB2AK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 19:10:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so5300488lji.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 16:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtiiDQqIKSwOiG748ha0RsiYW64G2u9tJs1YfUEZ07M=;
        b=LkkYFkw5qXgxsxLKLRdhuf8VX9Bm0uJFBVYjbOycmkZ2HF5N7EPXaXp5qIFbwJMFFF
         bM92NEf1nz9sxFZEyqdT+8QdTXebCc1ff7rExRiLkcCgeGCasdpJNEtXqrdlGddyDURt
         r3D0Q3/kz0FrTEkQJfssCDRmWawC7m+DPFZws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtiiDQqIKSwOiG748ha0RsiYW64G2u9tJs1YfUEZ07M=;
        b=D9Gkmaa2eq3pfAFHJ9+WnQ4VzFo2cs6O2kCH/dIDrDReiQnQWStM4CzNXWca9o0tW0
         XzplmEeGhGsFty4cy/hQBrlev+w8Zw+ndgEu5DjDR5BV6UD3HQvnv+X372KA2vaqxSFh
         9/RPaYnCobr8ZO0dAq/r9pvG8OYFbZnv8y5VUT60KA9kSEtYCMor3Uwop8oao0mW8h1U
         1WxfU7PQY1nSVe93zUmw8cqseIfowMS2wocU6+VYQhnd+IJl5OMDeGZRzA31JA24bOI8
         j05rUA2cuimButAPt5tAVqoNDjQ8RBhrHzo8tmNc+yuJhFITO5xjTGwcd+CcFaBWHj+T
         0Reg==
X-Gm-Message-State: ANhLgQ34EktTzAdAatkNIiEeI6EmxNCGxDEn2BY/1lOClO8vg6tUkP3F
        ecog+tJ7r4/FW+KBuGz9OpjJorCoX9Y=
X-Google-Smtp-Source: ADFU+vsIDjKPt3rM/kqzVxMKduATZsdcZEoIvu9BxOFZWPoGDGirXjd+fLdlqTnCdlDwtPNeHlzIkA==
X-Received: by 2002:a2e:b4f6:: with SMTP id s22mr4235747ljm.218.1582935054363;
        Fri, 28 Feb 2020 16:10:54 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id r12sm6718403ljh.105.2020.02.28.16.10.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 16:10:53 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id c23so3380970lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 16:10:53 -0800 (PST)
X-Received: by 2002:a19:8585:: with SMTP id h127mr3874662lfd.196.1582935052501;
 Fri, 28 Feb 2020 16:10:52 -0800 (PST)
MIME-Version: 1.0
References: <20200227105632.15041-1-sibis@codeaurora.org> <20200227105632.15041-4-sibis@codeaurora.org>
In-Reply-To: <20200227105632.15041-4-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 28 Feb 2020 16:10:15 -0800
X-Gmail-Original-Message-ID: <CAE=gft50mTp6-u-Dw5wzL=1GGTsZB+HoM=5NDSNxnVVwVfA51Q@mail.gmail.com>
Message-ID: <CAE=gft50mTp6-u-Dw5wzL=1GGTsZB+HoM=5NDSNxnVVwVfA51Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] interconnect: qcom: Add OSM L3 interconnect
 provider support
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
> On some Qualcomm SoCs, Operating State Manager (OSM) controls the
> resources of scaling L3 caches. Add a driver to handle bandwidth
> requests to OSM L3 from CPU on SDM845 SoCs.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
