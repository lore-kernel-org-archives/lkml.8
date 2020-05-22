Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6952DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4908520757
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s2XwS2bD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgEVHh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 03:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgEVHh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:37:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4F6C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 00:37:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u188so8881819wmu.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 00:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FxhyYotOdsb3Prsxlw/PCmLh9cDfCT3MjS19m7K8Q5o=;
        b=s2XwS2bDg3iy2QFTSYYUp2zSt1XfNkCltyHI70cuooryTjTrmQxbyoYtC7EKyK4J/A
         CMELJ8ZUfGTSxOg6AYlN57glArOF+Ly3LjBs501uqsGcZR+l5Ibxqj5DBoVL8XlApo+b
         atG2eMn0WIvN4x1PzdTxcIHXw7mmI8zyZgEqdH4lRMCpbTWYzhSglv9A05yWl0+Rvm4o
         a1TeQChSuAktfp1bMBydXDruT0T7jEQlllRF0IEpKC1x+j4OCj2MCcDtMbvOQOrfVMww
         V3l5bx0/GQmy7oWXfKlljrEXIicKaJzqGjj0q/1VOv2DQAj2EGtyTx5RDElE8IrTsPbQ
         hSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FxhyYotOdsb3Prsxlw/PCmLh9cDfCT3MjS19m7K8Q5o=;
        b=YSl9yMPo6I8SSlfsF8D9xGjId4lk46YzwlSVu8ePfNhMm7u1O/YmN88krY8MdnZtmu
         eovmTQ5KHs7rd69BrC5CtV12WldE/mENJ6U5hp1E2IPDdk+qLLti995tIk9bcwYGzwdz
         zmaMiIbFbjaVsceIsIDkfhvL1ls5pUTuMV/xDD33+Hfcq4IFr2923g+Tf4IyRy5/gdGm
         EbcJwY6OErnRLLOvqiNw28xH5WJp9zpquDOhegy+pXLms6Z3X0Y2ODJqWAOEiZ/AuGls
         InrOaRk9BJg3H1U9pp82RwEv2hfJ2VwpwriAdSA7ghzorjjFIYI8H1efISlmSQ1aBZUE
         jzrg==
X-Gm-Message-State: AOAM532NGqW8SO4oC1xe8lw/lVL6bBT4d4P0DOvFZ17PDCbh7TMTqZuE
        /ws/fmmeMEkrV4tU0EG4RxtXQg==
X-Google-Smtp-Source: ABdhPJxs2hJYnfDm6N4+o9/p+SF/UJ8IDcPxC+ZnYoNz7e9Bj+uhDyIZoQpHZd769I0Jckb0UavO0Q==
X-Received: by 2002:a1c:6042:: with SMTP id u63mr12028802wmb.65.1590133045474;
        Fri, 22 May 2020 00:37:25 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id l19sm9221775wmj.14.2020.05.22.00.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 00:37:24 -0700 (PDT)
Date:   Fri, 22 May 2020 08:37:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     matthias.bgg@kernel.org, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: mfd: mediatek: Add MT6397 Pin Controller
Message-ID: <20200522073722.GP271301@dell>
References: <20200110145952.9720-1-matthias.bgg@kernel.org>
 <20200115151938.GA8182@bogus>
 <ce3747e5-41db-a168-0602-37337d8530f2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce3747e5-41db-a168-0602-37337d8530f2@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020, Matthias Brugger wrote:

> Hi Lee,
> 
> On 15/01/2020 16:19, Rob Herring wrote:
> > On Fri, 10 Jan 2020 15:59:51 +0100, matthias.bgg@kernel.org wrote:
> >> From: Matthias Brugger <matthias.bgg@gmail.com>
> >>
> >> The MT6397 mfd includes a pin controller. Add binding
> >> a description for it.
> >>
> >> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> >>
> >> ---
> >>
> >>  Documentation/devicetree/bindings/mfd/mt6397.txt | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > 
> 
> It looks like this fall through the cracks.
> Would you consider to queue it or do you have further comments?

There is a current issue where Rob and I are both taking patches.
Sometimes we both assume the other will take the patch.

Apologies.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
