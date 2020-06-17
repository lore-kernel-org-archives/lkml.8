Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA9AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD672207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cDnYNZzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgFQOzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgFQOzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:55:08 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A61EC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:55:08 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id i8so850454uak.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwgqDzLlKBlZHgeSExhyQD7IUX0bBrSxqALSEdkys8o=;
        b=cDnYNZzcuJY2Z8YxBUqI1q7VnRgPH6Ganx1dgOwjPXJnq1jOC75XvUqKB/ppGw0mMm
         2BR9fAx9ZjOId2omlKrwBFn19wnOwN1Kdne0r/o6xnS+s9XHyuiMegWXFfGW95OPNNaJ
         S6EczbN4+D9BhHWJ5roupqIvL90ghK7tP7CJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwgqDzLlKBlZHgeSExhyQD7IUX0bBrSxqALSEdkys8o=;
        b=JofHiWSIRJxAJfnqyCIHjXDU8PreESjrGuMPFlkOL0nfETBp3e+5kH1Gsc1wM4GdqW
         UojZ3eq2hCDKZAOzE1i64M/Erl33ogejxVePcsHAXPWmaNHoEDrObZledxxMr/dfad1s
         7KGBU1jQiyyUVE9Ou8X+xRnoro03ebBbyVNygCc2FCxbgL6gMC9Ofj71B+vvq+GFV+g6
         u1pNciOMh5tarDHTKKEivbJSYXBX6AcHWT5X+oWDJwHszK5hZLVYhQs7psQ7fCcL/92H
         ZGNjSMD4JvG4QwZPsj51jp3H2s24xms3i/J4Ke+Orx83hPKE6YsEqVMg4DR5aNWgViT4
         q4ug==
X-Gm-Message-State: AOAM533jEPuIbNDf2DoZIFh5EhHE04zC06mFSnWYo4sx98CUqd3tCcN4
        /EtUjS1V+3eRSXr4O2kiNzxt5c5kyBY=
X-Google-Smtp-Source: ABdhPJzSq/Q1dCJK+e+UhFoQIcfwxTwDV1iB7eRWfZ5b1GB2BLChUOFuCixuv08FYzAjEVq2RIAaFw==
X-Received: by 2002:ab0:cd:: with SMTP id 71mr6577681uaj.78.1592405707135;
        Wed, 17 Jun 2020 07:55:07 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id u4sm2676437uaq.16.2020.06.17.07.55.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 07:55:05 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id o15so1519096vsp.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:55:05 -0700 (PDT)
X-Received: by 2002:a67:1703:: with SMTP id 3mr6503266vsx.169.1592405704994;
 Wed, 17 Jun 2020 07:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <1591868882-16553-1-git-send-email-rbokka@codeaurora.org>
 <1591868882-16553-3-git-send-email-rbokka@codeaurora.org> <CAD=FV=XSfMPehyCLB25hct+GE8JtU=5J=04KyU4AoHfg9cs50A@mail.gmail.com>
In-Reply-To: <CAD=FV=XSfMPehyCLB25hct+GE8JtU=5J=04KyU4AoHfg9cs50A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Jun 2020 07:54:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VAobLWeJvAn3wseNZ4JUJzta0m3wNUhiWiOoC0VcNisA@mail.gmail.com>
Message-ID: <CAD=FV=VAobLWeJvAn3wseNZ4JUJzta0m3wNUhiWiOoC0VcNisA@mail.gmail.com>
Subject: Re: [RFC v2 2/3] drivers: nvmem: Add QTI qfprom-efuse support
To:     Ravi Kumar Bokka <rbokka@codeaurora.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jun 13, 2020 at 1:33 PM Doug Anderson <dianders@chromium.org> wrote:
>
> In general I'm happy to post my series to the list myself to get
> review feedback.  For now I'm expecting that you can squash my changes
> in and send the next version.

I talked with Ravi offline and he suggested that I send out the v3, so
it's been posted.  For the cover letter, see:

https://lore.kernel.org/r/20200617145116.247432-1-dianders@chromium.org

-Doug
