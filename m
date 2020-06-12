Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E769AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 23:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54A520575
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 23:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pyIeBb07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgFLX55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 19:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgFLX54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 19:57:56 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E095C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 16:57:56 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id x17so2274534oog.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 16:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HOWpXRhAQPZLUNyvQpWGm4V2ESJc01BbPvWojl719Lc=;
        b=pyIeBb07D6klnrVJySMCOCDBMj+63aMBxanzNDWnEd3JBhf2w5ZQ7nvBLq4eyQSfaB
         ph2G+6zQGlAqIvUkvLzvnBRHzheVmGPn4G+MmjebcYL1/pMSSD9R5CJCcnUJFU9Miaw8
         7wK0BVQg3cKIdmproJ3X8dETn9W1yMH/zRn+mFPUgVCso3on/JGNKQIDq63Opgb15Hg0
         apFCQBCGNSZHvFyEqKiCDDfcojETw0QiMIBmdG9ruEUR3DgUQAPKfbWOpjVsmvpC7jpa
         TYpbVuIBYZ3cFH06zcwTWptWYg6U3HvHLgkNtLU6KNqNidYwJyosOtKzaEMUVASCDrcO
         uRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HOWpXRhAQPZLUNyvQpWGm4V2ESJc01BbPvWojl719Lc=;
        b=RvIvwFqeYyNWtXoRxmJKrN6fBadccVGt/f+WPl8MOeqS980FfH3Tln7ZWLT3OFt1yW
         V7QXfWlJ3MMTb8XHwMyD03G5Bf+10gzMpRv5/fioPXgUj5bbijmrLjTIpuHzmnwwPUZ7
         L3Q9kRTxSta4urTtiFsibTBq5DMMR+DRxUBCv7Gsy1Q4S0SqNkYrBZnT7/mWS2FuK2rW
         jgGXTFvzQ6xBVO7F+zMm0Qceth6qkU7L4+rhgRoo+JTCy1mXtqfk8noLuL1z89DdGrU6
         dKkaAaIeRHD5VffF37O2idpoP9Rl6OH2y+Wzk7HpHiZq5X4XZiE5ErJ35WFLUkdirrJg
         8wwQ==
X-Gm-Message-State: AOAM531jKmBG0Pmzws9EqaG9kjHk/RP2PUYlglTVqtBvc7cuKW2rkm4s
        cAa/8kSJQ2CAHsoqO7XN8WYENt42r4vqXD9BFJ9/Rg==
X-Google-Smtp-Source: ABdhPJxX1QaScGqT8ta8x6SqAo6M+yAgHqmGZa56fHwOocpCvZA5JKmeRudDWRkQQsDu9uhaEXtmbrhNKZJiEL89R1U=
X-Received: by 2002:a4a:ddd7:: with SMTP id i23mr12822037oov.9.1592006275829;
 Fri, 12 Jun 2020 16:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200612123711.29130-1-srinivas.kandagatla@linaro.org> <20200612123711.29130-2-srinivas.kandagatla@linaro.org>
In-Reply-To: <20200612123711.29130-2-srinivas.kandagatla@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 12 Jun 2020 16:57:43 -0700
Message-ID: <CALAqxLUqPw_h-BQ1NuP3AP5VMseCSyz13dYKkwqHVjk_QqXmdA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: qcom: common: set correct directions for dailinks
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 5:38 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Currently both FE and BE dai-links are configured bi-directional,
> However the DSP BE dais are only single directional,
> so set the directions as supported by the BE dais.
>
> Fixes: c25e295cd77b (ASoC: qcom: Add support to parse common audio device nodes")
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Yep, this resolves the recent issue for me!  Thanks so much for the quick fix!

Tested-by: John Stultz <john.stultz@linaro.org>

thanks again!
-john
