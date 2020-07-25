Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A69EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 14:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8476206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 14:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m/mqefN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgGYOeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 10:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgGYOeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 10:34:18 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC44C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 07:34:18 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id r13so853144ool.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wrDqlxNNVLuF8POl1GDyeWkvGNEXgQCKCSRteLM6tS4=;
        b=m/mqefN5jqg+eR2S3kGzASpiUbbyyR6SFj9m2pkRIXzdxs9BCmUDKOeq0H2RmV9p+y
         g2sB24A7EDA5B66T9zEQOagrTmm8RbfOZDLfQACKwZ9YInx2Fzxp7CWGbLkVMjB/uf+n
         1HYeToPIeOghavqiZEX1Aecbx/mqCSuMVu35A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrDqlxNNVLuF8POl1GDyeWkvGNEXgQCKCSRteLM6tS4=;
        b=sFAF/NSiByFb+bhMyIVp21y0/tPdUrDd7XiSHcJeS6hL1s/XPMgleGFeyJW10SArL9
         VYjrPTcvGUFAqvXApvahqW2EZ5fVwz9CGWhajEG5//5xfQSKvedicvCAoDYT3uOEeSSC
         R/IBsPzAvcl65CEziayLPcunkS6GO6s8/7VYp+JHOswqUe5GStnaQoXZlE3bpEmD1ktP
         CU9MI7Ed2OCjgAHRJpHgFvcdtfK9D/AsGmsjL9e8jD+29pI6Qxe0O++1o46d1Kt1JGbf
         p9iM8IlraE/fNZniuR1dOjXwvgBPneYA661KSCJFKgLCbhN1uQP9V9aZR4KIfO9rlaR+
         mQVw==
X-Gm-Message-State: AOAM530cAZ84WBBZ6R4uLrvPM6dNRO2o6W1HYmQFTJRotcllu9ZAqGYH
        LsysgPmLXZO7GSmrGVHrQOi9CSSUwEM=
X-Google-Smtp-Source: ABdhPJwd33B3054e7zMWOxQwF/CcxnvMjeZjeaFbOE1m7l7tAdGeq7AyMBqY+TgDNhVOQVWZarmFhg==
X-Received: by 2002:a4a:9e05:: with SMTP id t5mr11322583ook.76.1595687656325;
        Sat, 25 Jul 2020 07:34:16 -0700 (PDT)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id j16sm868990oib.35.2020.07.25.07.34.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2020 07:34:15 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id n24so9128383otr.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 07:34:14 -0700 (PDT)
X-Received: by 2002:a9d:5609:: with SMTP id e9mr12808433oti.141.1595687653817;
 Sat, 25 Jul 2020 07:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200715202233.185680-1-ezequiel@collabora.com> <20200715202233.185680-9-ezequiel@collabora.com>
In-Reply-To: <20200715202233.185680-9-ezequiel@collabora.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Sat, 25 Jul 2020 23:34:00 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVMXeTcUfb-98McYCKjh=eM=BTo2dSY=L1c6dv2jHqXcg@mail.gmail.com>
Message-ID: <CAPBb6MVMXeTcUfb-98McYCKjh=eM=BTo2dSY=L1c6dv2jHqXcg@mail.gmail.com>
Subject: Re: [PATCH 08/10] media: uapi: h264: Clean slice invariants syntax elements
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
> The H.264 specification requires in its "Slice header semantics"
> section that the following values shall be the same in all slice headers:
>
>   pic_parameter_set_id
>   frame_num
>   field_pic_flag
>   bottom_field_flag
>   idr_pic_id
>   pic_order_cnt_lsb
>   delta_pic_order_cnt_bottom
>   delta_pic_order_cnt[ 0 ]
>   delta_pic_order_cnt[ 1 ]
>   sp_for_switch_flag
>   slice_group_change_cycle
>
> and can therefore be moved to the per-frame decode parameters control.

I am really not a H.264 expert, so this question may not be relevant,
but are these values specified for every slice header in the
bitstream, or are they specified only once per frame?

I am asking this because it would certainly make user-space code
simpler if we could remain as close to the bitstream as possible. If
these values are specified once per slice, then factorizing them would
leave user-space with the burden of deciding what to do if they change
across slices.

Note that this is a double-edged sword, because it is not necessarily
better to leave the firmware in charge of deciding what to do in such
a case. :) So hopefully these are only specified once per frame in the
bitstream, in which case your proposal makes complete sense.
