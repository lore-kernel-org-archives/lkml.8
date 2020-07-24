Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A432FC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 793712070B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J1sP4XCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGXUjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgGXUji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:39:38 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3D6C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:39:38 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id k7so5593176vso.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ugfc4z1Sse9ZbIN/IxhzK+fXKHAP5kdvENEw9KlUA4k=;
        b=J1sP4XCuyJ7w/J6wNht2mFKaTFqYcEq9mdPZvQB7bFqZB/nkzSCgqNvi4+rhcwghzD
         KxrDKPm7diaDemEPG4Aid4QYfnHaAo4oulmyUgrjY9WJECEvdwHlYK4a+bHX3Qs90ERj
         Ko87bt6yXlGZi76FHOTuiI1fNxLmJeBLJ6KAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugfc4z1Sse9ZbIN/IxhzK+fXKHAP5kdvENEw9KlUA4k=;
        b=s4H+qpx5i5zvzQp0WBFh/FpCmbk0iw36+Kc91pTFoO2/5OyokO5bemaPLp5mDA72B6
         TCN2z3chJC2G+OoCtMuyOQWjGyvCDz3T0jRaKQ7RIRslR0ik1YW28l8HPby8OPFN0tsL
         8CK1I0/ifent0Q/p8THeX+5WsTYGd8ku+eiHDa5ydFcwZEQXrazf9udYypEu5FN1t968
         IuSII0idgK5z3DvsZkvouQJvete83+CaqLwoeqh669cC6csu4NNCx/USYaWaKWDBjN6B
         yIP0KIhiGBnk0pnmqofxSyIbu+AVFRnKHMjxPjrMabRclCxofX3rU5HbMfxBk5mtQ/E5
         2WUw==
X-Gm-Message-State: AOAM5336TEa59tCxJLqEO0gVBA9rTLO/bQ9QIKTVsv25643cbAdNjrLv
        v5UhYlP3fJqbdmn35WWJdSlFq2lEaZQ=
X-Google-Smtp-Source: ABdhPJzxjr2a/U8kasQ1BHRj5D6g8wNZuYfom5k8a5owTkIpptiTYBXsI7jxOEkpP8vX3G89+Qg6YA==
X-Received: by 2002:a67:e81:: with SMTP id 123mr9133520vso.75.1595623177418;
        Fri, 24 Jul 2020 13:39:37 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id c70sm243448vkc.31.2020.07.24.13.39.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 13:39:36 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id h1so2502007vkn.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:39:36 -0700 (PDT)
X-Received: by 2002:a1f:b68b:: with SMTP id g133mr2763682vkf.59.1595623176252;
 Fri, 24 Jul 2020 13:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200723230344.1422750-1-swboyd@chromium.org> <20200723230344.1422750-2-swboyd@chromium.org>
In-Reply-To: <20200723230344.1422750-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 13:39:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VRDWH8wgX5EC3S_dw_riDoY=X4EVY8BbD3ctmA6Wi+GA@mail.gmail.com>
Message-ID: <CAD=FV=VRDWH8wgX5EC3S_dw_riDoY=X4EVY8BbD3ctmA6Wi+GA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: Add bindings for sx9310 sensor
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 23, 2020 at 4:03 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> From: Daniel Campello <campello@chromium.org>
>
> Adds device tree bandings for sx9310 sensor.
>
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> [swboyd@chromium.org: Add both regulators and make them optional]
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../iio/proximity/semtech,sx9310.yaml         | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
