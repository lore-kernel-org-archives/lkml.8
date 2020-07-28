Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCAEC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64D4207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rt+ymG5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgG1GwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgG1GwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:52:04 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55613C0619D4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:52:04 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l12so250088pgt.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/GS/4OHUC58pzoucFVteRuIhHVuqFuzv5eBDbKwTaes=;
        b=rt+ymG5Cbhfum5rPhzbu2bNlLrOp2IYPr1KhUaVGa/JAf4KFUIgZoNlrcr9ss8BvzG
         QwIQxBO7tsuKVEqXL4c3rX0VtADAkGcNlf5nIDGY+cRQkp5Umvsg0jlr+YVA9ucRX6Zl
         9rJOvRnTFaw1+62YFnp0j3qDHqPZPgSoMJ7M4KlvRpvhcyfuvo3Vq92tm5pT/qK1robW
         pD5CudnsUUBNCVG93MqMptvbYcGnCP0okPFROypwhzqtHhn4yfVf9hm5YpELNmTwdeat
         TvTd7hKZrmrB02cq/aCptA4N4sj/mUUFU8wzNpS3783wXNxRwLv80AIS8P4T22iDYZuk
         fAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/GS/4OHUC58pzoucFVteRuIhHVuqFuzv5eBDbKwTaes=;
        b=PkfFxcsj7o1ZKdC9mL1n/NtzZK4l+nit9JT5qXPWQTnOUEEbkuz1j3YF3e92+b2cGE
         iynLFWZv3PF81BGOAIxDrk0RIFHxvoz17p8V8JsdPcssx/4y7xTjb0jWAtFekecZeVbH
         1H7u4QWl7vAV984LynQfg4RIoVVGaaPbH1PRrfKGuSNDdKmkx6O9wPhQM2txL30jQgwN
         ac2geQ3VvleXuP1kjuyz4g8D03CSUkWB/7n6AzXktfELhXhl4SlFHYfpTr1RrVdPDuK/
         Eszib76Wp5NuNBeXJ6V2lLJ5jMbAWaw8SX33ENyFbODEYmAhYuPzsg42yx5jXGhKYlxc
         Iq0g==
X-Gm-Message-State: AOAM533qFMm74yXxxTYcjdUmPv5h6LSlgxVTgCRaZzK5M60aTFvKl7fc
        i00XGdIJxW3gJoquWzcXb97YUw==
X-Google-Smtp-Source: ABdhPJxfbaZBUKL4RCI1GSa5MCOEQqQ61UEUjQME4GaIZXbAZyAHFPAaz4UlbjqcmBNjh+s0Ky1hDQ==
X-Received: by 2002:a63:fd44:: with SMTP id m4mr22809692pgj.160.1595919123788;
        Mon, 27 Jul 2020 23:52:03 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t73sm16963494pfc.78.2020.07.27.23.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 23:52:03 -0700 (PDT)
Date:   Mon, 27 Jul 2020 23:48:31 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/13] msm8992 DTS updates, peripheral enablement
Message-ID: <20200728064831.GD202429@builder.lan>
References: <20200625182118.131476-1-konradybcio@gmail.com>
 <CAMS8qEVKssmOTZTQqgo3y6yUp7KztapQLtek+Q6FewqVaSGYyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMS8qEVKssmOTZTQqgo3y6yUp7KztapQLtek+Q6FewqVaSGYyA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27 Jul 11:20 PDT 2020, Konrad Dybcio wrote:

> Bumping this up, in case it just got overlooked.
> 

It was just overlooked, thanks for the bump!

I think it looks good, will pick up the patches, and the previous series
that it depends on.

Thanks,
Bjorn
