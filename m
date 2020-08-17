Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010D0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51062072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QBOEjwUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgHQVMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgHQVMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:12:19 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EF6C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 14:12:18 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id s29so5175091uae.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 14:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ekTSKo1pbYsTe6haa619uXui/FKJjHYGUOaSFf17VjQ=;
        b=QBOEjwUjtryHxtBvVTbC4f0ZBDkwpm75MZYBWIfR90Ktq2NgHymjo76sA9zuX1ejqT
         gJN4UY+ePTJVNDgOSy/5RQkn7isZOpL1QmvO2HnjiETWqlotGNMX/0YDkv3IA/v66B0c
         OLPA4KN7c42fNV2cJ/nsN1yHEiVJcWvTJlJvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ekTSKo1pbYsTe6haa619uXui/FKJjHYGUOaSFf17VjQ=;
        b=EsFCmQubPWiKcgyxD13ERb0XgLNVTdKwXX6nvXoYYeUM6SZU169ptTRDpbVjwDZU5r
         D/DVcNipU8V2ORYQYYhuyHeKY++GncwuzS6cI9r5HG59RsZw62ruqZUU6XQJU36Jwpoy
         UCUYmf9ArBzFoOBycE2d127/vWEVOcDDKh+KemO4RVb+KeD4EMIahKJfb3hPKG3qWfMb
         sgmFOSW/Wnl7ISXBPGj5Rj6Ud79HWiovnZAgY6GRem+pnH5o1bzHmWx0DS0cZvSnKrK/
         ymoOeBZ9an09QWMQh4AAWYrir4xQ4/k1va6fmdnbQVd6q2XGt0Ooj0w3UJKzz7Y8Xs20
         4a5w==
X-Gm-Message-State: AOAM532Y/zFM0/jFfYqp2qtj+dvhRTCA+YFnGQxdUiFZtkzj5uUf1CQL
        jzztUGgfd0AnVtJGnXgWqzKHgrkZ2/WHeg==
X-Google-Smtp-Source: ABdhPJxFStuhUXRj0xjjefqurfdw0pPRuCq62IPQbsc4EQlKAIrhfZH3wVhfRPP9nUZl6eifG8V4TQ==
X-Received: by 2002:ab0:6253:: with SMTP id p19mr8940408uao.48.1597698737966;
        Mon, 17 Aug 2020 14:12:17 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id x187sm1220839vkg.1.2020.08.17.14.12.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 14:12:17 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id v20so5174467ual.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 14:12:17 -0700 (PDT)
X-Received: by 2002:a9f:2b89:: with SMTP id y9mr9076116uai.0.1597698736857;
 Mon, 17 Aug 2020 14:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200817040417.11111-1-saiprakash.ranjan@codeaurora.org>
In-Reply-To: <20200817040417.11111-1-saiprakash.ranjan@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 Aug 2020 14:12:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VVeoqOsVzJiCxjYTpJc8JX4Qx3vB+0evzp8oMdYsRZvQ@mail.gmail.com>
Message-ID: <CAD=FV=VVeoqOsVzJiCxjYTpJc8JX4Qx3vB+0evzp8oMdYsRZvQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Fix the LLCC base register size
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Aug 16, 2020 at 9:04 PM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> There is only one LLCC logical bank on SC7180 SoC of size
> 0x50000(320KB) not 2MB, so correct the size and fix copy
> paste mistake from SDM845 which had 4 logical banks.

I guess SDM845 not only has 4 banks but each bank is bigger?  At first
I thought "yeah, 4 banks and 4 * 0x5 = 0x20" except that's not true in
hex.  ;-)


> Fixes: 7cee5c742899 ("arm64: dts: qcom: sc7180: Fix node order")
> Fixes: c831fa299996 ("arm64: dts: qcom: sc7180: Add Last level cache controller node")
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Without having any documentation ,this seems sane to me.  I guess it
doesn't do a whole lot because the driver just reads one register from
this whole space (at 0x0003000c bytes off).  So it's just a cleanup,
or is it needed to actually fix something?

...the fact that there's a status register in the middle of this seems
strange, though.  Your commit message makes it sound as if this range
is describing the size of the cache itself and then I would think that
this was the address range where you could read from the cache memory
directly, but that doesn't seem to mesh in my mind with there being a
status register.  Hrm.  Am I just confused as usual?


-Doug
