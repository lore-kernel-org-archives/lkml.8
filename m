Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D448C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2912B20738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VB63gS3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHXSNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgHXSNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:13:14 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006B7C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:13:13 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b2so8941194edw.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZlICzUjeuNmdErsgzSdsI/rW1E+kwDrSdNfwEc0nZM=;
        b=VB63gS3cz6Fuhygh2GVlV8tghqNi/OkNvv1GRnWqIMD9vnFT08NV0Zsgo0RhAp0nUK
         wBd77s+yUJKswPDSFuA43iaIeR/N0IG1/hx6mczEiGJD1xtPlKcQOQN2hfWQxVFmBR6E
         KE1ZzHhjTk1mahIA0gU+Y0byYsrpN9FZzKQ0BaUyK6WEgdr1BHUIgOMyFHP8YCrt3Ibr
         Fi/VS3RlBnhSCxq+di1mHRTKI/lL4rfoM+YYUvVhEhC4NzMS9Lq79I2oPLsRMC8dUga1
         7GhQaRw5Kt+cF7JeRq/hRcbriodmYBOayGd4ou+f1cHH82YQQfLcqJkIaZI0sDRatUF3
         Q56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZlICzUjeuNmdErsgzSdsI/rW1E+kwDrSdNfwEc0nZM=;
        b=VXncw6cOwpvUNiNfIwtqJKvMW7ev3HF2YS6cno9gfzLSQvfUH10vZFPoZ9Y83JkBhn
         1NqNMxcmznKfvfNCqw3bYCZ4OZqA2atkTR4ufJNB/oW/vNOfGKDUNJyOjzKbsgfhbEuM
         hObxdH4qZvKLlXR1nAeVihcd9JveMoEdRQ4lqRk/2OeAIcomcnMb40Qvqf6EuVnQjKSr
         YnTc6Qt9lonkRqnp4MPkVh1YDxgDt6kUuZffZchVxS2kAHZ4UF9HmXTaZBDcRAqAPXlp
         jrfC+MEx67irnNjqa+LYHert/2X7lAOjmKq2ZJgnRlbNPtP6OZWbnNwmTtImIBNVPCMn
         5EOA==
X-Gm-Message-State: AOAM530V20NHv6EAF52LJpA2xnppQGFfdOOo9H8AGJ86+urUeIR+Ou2N
        caN7lMJHSWJop7XNP9/oZFG/IBqRyR0JmyNAyvc=
X-Google-Smtp-Source: ABdhPJx2V9T9ur0WYEbaBaNb/cak3uRsykTDs5rXB5hMx1xj5beZLk5zzkzC+QII4JD2CkozFdYidvYoKh7+rIuR8Qc=
X-Received: by 2002:aa7:d410:: with SMTP id z16mr6472364edq.287.1598292792665;
 Mon, 24 Aug 2020 11:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200823220025.17588-1-rikard.falkeborn@gmail.com> <20200823220025.17588-6-rikard.falkeborn@gmail.com>
In-Reply-To: <20200823220025.17588-6-rikard.falkeborn@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 24 Aug 2020 20:13:01 +0200
Message-ID: <CAFBinCB4NWbzse6FBRBcLf+djj-i3r+GHschtC9mb7eDsE9MuA@mail.gmail.com>
Subject: Re: [PATCH 5/8] phy: lantiq: vrx200-pcie: Constify ltq_vrx200_pcie_phy_ops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 12:00 AM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> The only usage is to pass its address to devm_phy_create() which takes a
> const pointer. Make it const to allow the compiler to put it in
> read-only memory.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
thank you for this patch! please add my:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
