Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C39C11D24
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD9724653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hz3Wvel0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgBUAUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:20:00 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36763 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbgBUAT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:19:59 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so300489oic.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 16:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IHr5qo3B7v5uxs0wZA0fZW6J9zqGy3IdsKd+NBLqxdQ=;
        b=Hz3Wvel0TrnLWu2KOGBLM37xIzOel8u9Z3LL3LKWhQ5uDvm2hmCI+8lAaq9dDcnzK0
         mmF29yC6bk6kCEp7Rp8Xphv7SaNuWSCpytm5t0gbTsUTgWYqT1kGf0Uk4snguMx7ktEB
         CUaU4UXvlG8DiQPZ0fLoxZ7q8pzZGa6twCkjkNgfUTBep5MTIzKNPNNZmjXvVmIuajDT
         x1oGn/KBMPVd010kg/4IBE9Z7pYnop4ImXcsjGIsjF1rqOEZh0XzY3XCKZGRIyEUPwgM
         dnOCLimGwLQYnIXwqYXRG3zAdpZoXpkT5LDSWOlqz/mbvst5M1heaxiNSpmi3QJ6N3pL
         qeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHr5qo3B7v5uxs0wZA0fZW6J9zqGy3IdsKd+NBLqxdQ=;
        b=G/In1azAjMWjhIwdlGY8tPjo0bx7Y58kViTyB+guJ/4hS8KMbXMqNKTuQkIriG/9UB
         p/PLJrSHpxglDkdXwey31t90bsJT2JZ8LKjZod+6/XoEPHV7V6PPDnKkmayZmk22n60q
         GIcpsqhLVQeruy/ohVhnI9TGI0F3SRGAglcDGXTi8nfLv8Z/U6/HAhVxqv1UVTuvAtY9
         xcihEtbUMGm/OAL/fiDrkhdXMY3nL+cHVfv6N3ccLQ26yq14CWbLjhJkP0AJ3YDlXa/l
         M5RWEUiN5qhnrjL4JtatfgLOXqMleE3Zi/b4n1BfWnh4NSiFyAQ//P8VKoRlUZFF4Th3
         jCKA==
X-Gm-Message-State: APjAAAWjcpnq1RZmroPXKTWucHED2Pvmyznam97GCnEGiOanBuBB2GVF
        lDtbZUO9N1mZIHqI1ymhkBxR7a0d5IZKiYv1xH7/vw==
X-Google-Smtp-Source: APXvYqxyLS/9yBWFyxJu7nngbozjCnxStnGWdAIgQ8O7CZoqSKHHSFq255QaoTFU0a3hJMPv5SrYAZQF8EZ/aFXEwgA=
X-Received: by 2002:aca:c0c5:: with SMTP id q188mr3935454oif.169.1582244398771;
 Thu, 20 Feb 2020 16:19:58 -0800 (PST)
MIME-Version: 1.0
References: <1582223216-23459-1-git-send-email-jcrouse@codeaurora.org>
In-Reply-To: <1582223216-23459-1-git-send-email-jcrouse@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 20 Feb 2020 16:19:46 -0800
Message-ID: <CALAqxLW3PHtdFY20AStETme7sp-YLMLXBhqRyjOeLkQDSFOeVQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] msm/gpu/a6xx: use the DMA-API for GMU memory allocations
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:27 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> When CONFIG_INIT_ON_ALLOC_DEFAULT_ON the GMU memory allocator runs afoul of
> cache coherency issues because it is mapped as write-combine without clearing
> the cache after it was zeroed.
>
> Rather than duplicate the hacky workaround we use in the GEM allocator for the
> same reason it turns out that we don't need to have a bespoke memory allocator
> for the GMU anyway. It uses a flat, global address space and there are only
> two relatively minor allocations anyway. In short, this is essentially what the
> DMA API was created for so replace a bunch of memory management code with two
> calls to allocate and free DMA memory and we're fine.
>
> The only wrinkle is that the memory allocations need to be in a very specific
> location in the GMU virtual address space so in order to get the iova allocator
> to do the right thing we need to specify the dma-ranges property in the device
> tree for the GMU node. Since we've not yet converted the GMU bindings over to
> YAML two patches quickly turn into four but at the end of it we have at least
> one bindings file converted to YAML and 99 less lines of code to worry about.
>
> v2: Fix the example bindings for dma-ranges - the third item is the size
> Pass false to of_dma_configure so that it fails probe if the DMA region is not
> set up.

This set still works for me as well. Thanks so much!
Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
