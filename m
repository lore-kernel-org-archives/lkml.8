Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C84C433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 13:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22FFC206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 13:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PZoxQWaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgGYNaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 09:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgGYNaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 09:30:21 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7473AC0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 06:30:21 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id e17so429800oie.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 06:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLWl61iUFiVNKzf6C4Wv/3AzPUpXVP85XKnNXPWBYrU=;
        b=PZoxQWaEEFH33OFQHOpMXRU0MIpBu4YViuOHULt18d9xuIhu3tT6809qi9XNf8JTZc
         RjUUeNarCKKAqKNK+KkHyyAA5S8UmDSMWYZ1VWLUb5d4XoJGpm7okf0sokyZHkybqEvI
         rrP6D2a8Rh08n6mwgNSbcmXu/eX2SDbSFpVMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLWl61iUFiVNKzf6C4Wv/3AzPUpXVP85XKnNXPWBYrU=;
        b=l4Ebm3yeYqleEurjq21bR+B2rsfIBeNghATiBfju8j0gLWY/n82drlThqxcmCkEXqQ
         XmdOkrESYKmAjYvy3zxsSdXa/vZhkYWM9ND4TQPasZauB2SumitjHeVqJfm3aZazrpT0
         FxWctKpRmO+3QL7KD/7oQd0ztB1adMkJ/SBrTOQLCybdT+FVeocRxH3hBazKudw+5MP6
         vPXqIHgPAANqrQbA4BNmSaTTnySiVpkLRgNa3X6zFfSLJcUtMAQGRcAs1ScoeA8YY55a
         RjvoDFAr1zKTjW4cumXwyjbrKZ0zvshiwIk0bhYMk9yXnbIJnPrwc8SPxbUJDbQmgoEg
         WN2g==
X-Gm-Message-State: AOAM530OUwya9Gk7LYPZwWesonKoji+AiPh1BEfQf1MjW7VqzsSJEJ72
        GiFfRHHz4573EZm4dMpneUA0OddybhA=
X-Google-Smtp-Source: ABdhPJx7pHucZ95f1KT1oAWpx1ktmCZ+DiLQyf/ZKnTKGuI/WG5+jcgkNARG27kCvkfPYakBbjluZQ==
X-Received: by 2002:aca:c391:: with SMTP id t139mr12270733oif.57.1595683819640;
        Sat, 25 Jul 2020 06:30:19 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id n7sm1963549ooo.38.2020.07.25.06.30.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2020 06:30:17 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id e17so429695oie.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 06:30:16 -0700 (PDT)
X-Received: by 2002:aca:b6c3:: with SMTP id g186mr11132450oif.55.1595683816161;
 Sat, 25 Jul 2020 06:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200715202233.185680-1-ezequiel@collabora.com> <20200715202233.185680-4-ezequiel@collabora.com>
In-Reply-To: <20200715202233.185680-4-ezequiel@collabora.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Sat, 25 Jul 2020 22:30:02 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVJ+baQshWRJJrwKJ6bKss_KqHoC1xP9kvGtDqC0iFZWw@mail.gmail.com>
Message-ID: <CAPBb6MVJ+baQshWRJJrwKJ6bKss_KqHoC1xP9kvGtDqC0iFZWw@mail.gmail.com>
Subject: Re: [PATCH 03/10] media: uapi: h264: Split prediction weight parameters
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, kernel@collabora.com,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 5:23 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> The prediction weight parameters are only required under
> certain conditions, which depend on slice header parameters.
>
> The slice header syntax specifies that the prediction
> weight table is present if:
>
> ((weighted_pred_flag && (slice_type == P || slice_type == SP)) || \
> (weighted_bipred_idc == 1 && slice_type == B))

This is a pretty important bit - how about mentioning in the documentation when
this new control is expected to be present, so both drivers and
userspace submit it
or omit it in a consistent manner?
