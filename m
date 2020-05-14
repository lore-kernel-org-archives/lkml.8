Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDA7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB2B20671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W89jninm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgENN4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726117AbgENN4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:56:23 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB41C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:56:23 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id p127so5097269oia.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QaeCjNYyNaLWwCKtPQuE5dOCmpyD933kyEEJ8XGmdc=;
        b=W89jninmD4jOMGWH9hNe8p2EZhmo5dVOszViIBZWspw84gJP1EyDd+q+vUO5zEoICL
         byga9phhsYgE8NWn2fi86exAJ4VhIXMM+72mYsp2tuVToKiKmhunIM2sUhoGk/F+x+77
         DYN/ujPfV6em1l32FGCMfOKp44sYzrI6HIwLJJh5Q7G19RwiWFcWgzMN51ooCqPNz0+J
         iexVE1WnyER0TrCIFyYScYUPUWsXbN78TTQiidPPbjneD7wJfL2rnRXHzgvRwe7nCvas
         7/q250rThqM8ZM0o/P6pFxVXvl3GGfdosyuRlHGUkLkOqdroZIvBKjC0UzURDUdsRcAq
         srbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QaeCjNYyNaLWwCKtPQuE5dOCmpyD933kyEEJ8XGmdc=;
        b=XqaxrG8dSAXgA82TTWDDytxBJWrC3LYgayg+imL8yU7XW8o4wWbj0AInj2pxRJ8r1w
         8xDaQZzB+uE/Mxu4O7NFG3AWjINhu93MFvVrywOsxaQy6+UBDUxw0uyiU64aGctpmrHi
         Od6CpAg9IzsbQ74MYmffrH3/M4A5jgfrKET+QvXAylfOgDtgAb1zQb7oPf5IUa+hjvEe
         hJx/9g/zRxsuwIEZPZ/gV2fqhCtRP5gsmZfmbLLaEtLPmuUjfiuVI6QtUTRfBr1Bu69l
         G+kjOLcUcnmc30M4UuY/WURHZyFqxyh9s1HEmrwooposMRFiXkSMI6El7MU3R/Xy/fvh
         rUcg==
X-Gm-Message-State: AGi0PuaZ0i94yC2xTSLTWIng851irvDlJeG8kROHqRvDbFPlVqbFP6z1
        OecPrmiPWqTyS++UMWiydcJVROoigXEOE3/FZkEw4w==
X-Google-Smtp-Source: APiQypLwISt71xgIY2WR9s+KHLTS/yR4PmkFamPn/Ls5oRdriazJm8RLebvh62tDs2EjkF/bm5ERMgFesmc1OkzyN2E=
X-Received: by 2002:aca:f146:: with SMTP id p67mr32413451oih.56.1589464582979;
 Thu, 14 May 2020 06:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200406060049.227029-1-bjorn.andersson@linaro.org>
In-Reply-To: <20200406060049.227029-1-bjorn.andersson@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 14 May 2020 15:56:11 +0200
Message-ID: <CAG3jFythh_34wujTUKpuS1DbEsihNS0C5oPYXKgBgaSVhiakyg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: c630: Specify UFS device reset
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020 at 08:03, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> On some device the reset line for the UFS memory needs to be tickled in
> order for UFS to initialize properly, add this to the ufs_mem_hc node.
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
