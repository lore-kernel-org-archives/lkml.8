Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638A9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4236D2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ope4PDxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389867AbgFXHcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388375AbgFXHcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:32:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50873C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 00:32:11 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh7so701387plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 00:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XiffTKYWfkRx2OuMiP/252mjsVT01Skep/qWi8vbGWk=;
        b=Ope4PDxZMKqo33DrekdQIdllBSDMkIlNiHCxw3yYG5stm7pwHar0QsGYxUv1ivqW1Z
         SRN16VM0aa5Mc9iKJyZnIz0LvX4yjs+p4eJ3aQeOtnZOvdchEvfZpHiutoDpAlcQwMug
         OSmVWqM98/0yw7XUkxvFRykp2Q2gCAgkNvEe7k+WplncMKqzuaatAWOXW+/8cGV1DBRP
         LjeBl/8cO8V89B5ICJpFG3VSGMgKkIIAuiJ3yfS5KGpv9inZK1+xFpgLIUzbieNES2lS
         NXgVHWc7cn5EjOaUNf3CDQumo78W0+VhABf/oM3A5Fb7M4cME54HpW8KUiEGo4oeauq3
         jMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XiffTKYWfkRx2OuMiP/252mjsVT01Skep/qWi8vbGWk=;
        b=EtTR/ZoB7eKN+5NsmJmD2ldA/mnlM6iDaKB4s4vLlLMNCILaiS5tZ8hgawA2LXJvu+
         XIQK5n+mShe1OqgT7FUzsn4Vjy1g2safz7xyrGCeU5r35ouf+9fshuviLInQBwqGsrWb
         N5sZ+eLs6bvCWr1SDPwy5gb5irLrY2tsOlmifZZny50+tKtyo7e51X15h02goOtBY0N0
         EpbwFL6ykCeYpSXy9M5BuvZOI0uuG3C0CnDNlAJ27MRP/eURBs9EImq7rJkCsCVqQLQr
         uLOx83haUgWrj4QFRfkj/6oVau0tBCkJMiyxbg1nDl3qxAwXR0joWnt6I/RthYlQmlKM
         G62A==
X-Gm-Message-State: AOAM533XKYz3jy8snVyR/AJFEl35HgT5C3b2+IVD3nzkdxSnqX5WXSXy
        g4VAECkQM+cZI1ouBB4ycpW1WQ==
X-Google-Smtp-Source: ABdhPJzmmQR87baMbd/6VHklCBu0rFXvmKlmotKOEGTSQbtK8VLZjuez9jqsDKFhQIepFUxhRZLPwQ==
X-Received: by 2002:a17:90a:5c82:: with SMTP id r2mr16853142pji.161.1592983930591;
        Wed, 24 Jun 2020 00:32:10 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g21sm18765157pfh.134.2020.06.24.00.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 00:32:09 -0700 (PDT)
Date:   Wed, 24 Jun 2020 00:29:27 -0700
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
Subject: Re: [PATCH v2 06/12] arm64: dts: qcom: msm8994: Add SCM node
Message-ID: <20200624072927.GT128451@builder.lan>
References: <20200623224813.297077-1-konradybcio@gmail.com>
 <20200623224813.297077-7-konradybcio@gmail.com>
 <20200623231919.GL128451@builder.lan>
 <CAMS8qEXeFO0vNKHoJeDKKprdECFLVtXOWnphc6iRjOBigeFe1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMS8qEXeFO0vNKHoJeDKKprdECFLVtXOWnphc6iRjOBigeFe1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23 Jun 16:30 PDT 2020, Konrad Dybcio wrote:

> >Shouldn't this be "qcom,scm-msm8992", "qcom,scm" ?
> >
> >(Or rather "qcom,scm-msm8994", "qcom,scm")
> 
> Some DTs only have the SoC-specific one, and some also
> have the generic one. But I can add the generic one if
> you wish.
> 
> I went with 8992, as I added it in the 8992 series
> (gonna update that one soon, too, so we can get it merged)
> and I didn't want to needlessly duplicate it. Ideally maybe we
> could switch to just qcom,scm for clockless SCM compats?
> 

It's fairly common practice to specify both a specific and a generic
compatible, this would allow us to in the driver do special handling of
the specific in the future if we need to - without having to update the
devicetree.

Regards,
Bjorn
