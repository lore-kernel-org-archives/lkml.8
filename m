Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE5AC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3D322B40
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnuX222v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgH0Khz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgH0Khv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 06:37:51 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D7AC061264;
        Thu, 27 Aug 2020 03:37:51 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id j25so6964613ejk.9;
        Thu, 27 Aug 2020 03:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oov+Nn+aeg81kJdRD8uxfGPuMtBeunrsKmXrOnKKVt4=;
        b=fnuX222v41225ZihRKboc7mu9kLWuUXpKnt+oNQvERQKYKis3gguj2lEcP7RuKPTFR
         VbFug0ORTh/WrwTSyo1C5bTtBE8G3ySWsFYEHWTGFMw4jPGbmXO/XTKL3WGnqr0DIWe6
         coZAe5UULVKvsdobEg1NH1F8q45eWZJq6/HSefD8kDM70DTyEoEKg8OGQjjOh5e2O9x1
         xI4o3F4rSTJW2fuBGWZO2EfVuIlJ/Zuq+lgn+MG+WnQKw/lFSOOs3AtJ6sdmGZydNXhD
         H2drHVznJ1k3nzcAqOFrIcjEfFZ5RlNtwPRFODhs1PyNtZdbENPEykCRgzJGbCJtVFrh
         88gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oov+Nn+aeg81kJdRD8uxfGPuMtBeunrsKmXrOnKKVt4=;
        b=H71putZhyydsERkIgeoqsfHedY757Vn5ynNZG869FLBWD/odHv+mdFLst+j5WOVTUy
         juMPulHP3ycw8reJngGWVb+iFuVe7WTxrMRu5gH81d9ST36bFuy1kbdu8AaoFSQrIXfO
         jAyjIEXTcivlXgQqd9MG+w1z+ojFBFI/vftQou8ad+k6n+RlXI8qEJYABs635iTdhLnu
         Y7WrCIkSwla0EkpIG+vxjHAHpgozw6AdfInTjOiqfiG5lb3sumjhJM3/hPbdXYMiREhn
         KQdzU/P6BiXezHEqS35EY5xmZ17hd0X3Fhl4a6IUlAq56A39mtURllrwasBErL7vJ5at
         f+/g==
X-Gm-Message-State: AOAM533yI3S3Q3f1nCk6rmDtSX3g35K7tpi1nIf54wZCSye2jbfdFids
        ruBfD4ja1njlIXZ3b1uGxLc=
X-Google-Smtp-Source: ABdhPJzJK+tsNhJQVuyfYxeHZVkleaUrbAgAt754rudfVraaxEkpsdB5u/cL7lVHV0ifsmqBcL+VvA==
X-Received: by 2002:a17:906:554:: with SMTP id k20mr20075425eja.334.1598524670159;
        Thu, 27 Aug 2020 03:37:50 -0700 (PDT)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id di5sm1212059edb.16.2020.08.27.03.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 03:37:49 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:37:47 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Peter Korsgaard <peter@korsgaard.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] arm: dts: owl-s500: Fix incorrect PPI interrupt
 specifiers
Message-ID: <20200827103747.GC2451538@BV030612LT>
References: <cover.1592123160.git.cristian.ciocaltea@gmail.com>
 <41463413d6b756e9d24f8807cf95ddd98591b990.1592123160.git.cristian.ciocaltea@gmail.com>
 <87zh6gy53h.fsf@dell.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh6gy53h.fsf@dell.be.48ers.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 08:29:06AM +0200, Peter Korsgaard wrote:
> >>>>> "Cristian" == Cristian Ciocaltea <cristian.ciocaltea@gmail.com> writes:
> 
>  > The PPI interrupts for cortex-a9 were incorrectly specified, fix them.
>  > Fixes: fdfe7f4f9d85 ("ARM: dts: Add Actions Semi S500 and LeMaker Guitar")
>  > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> 
> Reviewed-by: Peter Korsgaard <peter@korsgaard.com>
> 
> -- 
> Bye, Peter Korsgaard

Thanks,
Cristi
