Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EFCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3516B206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrUsbEZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgHCX55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgHCX54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:57:56 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E22AC06174A;
        Mon,  3 Aug 2020 16:57:56 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a26so14658780ejc.2;
        Mon, 03 Aug 2020 16:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VMA09kDi+I3IIST6piBhLUjJZLHB1GtkxXf1OiQUwTs=;
        b=WrUsbEZbGOZEljnf7MPZ0+EI0k6MtomEbVYGqwLSE3s6AnUcQRbI8LTZ92C6KnxNYW
         /X7cMPSkna7QFLrOkx6aO1Fu2IOmS3Va3mgvnfhnPlAm9CShkEhaZxSxgikCsmlv6L8F
         PdVnMksaW3eafBMeWAZc17ZBNPtM6fAzrVyvl4UKwh2/5a61uzEXTpyK85N8a2BKaRnT
         GWXMbjQI1IPHAxvhax113tYcwQzK7VnVY2o4RQKnt76Cafy2fa3OmSqjyXnhAaZK3w9u
         byfXw628My0LWJIv8Oc8rMPddZyZvAF3uCpj3DGD2yPt4eRZhv6jlZoe7AJ0wwaxmcZ6
         5zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VMA09kDi+I3IIST6piBhLUjJZLHB1GtkxXf1OiQUwTs=;
        b=KbFpFj+mVGhhqjn7G8s4DVem3BXIMQ7YCEJdsZWjVpE4FFbJpdqyYlzvsCO8B8avim
         gX5rdGswHfqfKMOqo4Gzjniir5vkt0NQQuh2k7mfPUE5GFn+MJJ88NFFT+3+mVelQI9U
         4i5hFyvhMwOudXDRV33tMWFNgt97AkjuZdJk1q+zoHJhFJxE17o6wFLzfabWNkljgyES
         WhyRHR/dm9ei1Yp+ee4/DVHUBE00PK0kxX5OrcnUWaJgIQH2xfzcMPHKBn9tBRa+6mbP
         lK9VCzNATjLRWdwvSZCJINz7g7eSdzzJ4bQSGdIpJtRwcaYjrCEdhJt7mHcFF/WpbyOq
         FtVg==
X-Gm-Message-State: AOAM533fDhUMar109kJb0njSOHROdxeoXrMiF1DJtCVhZJvmQm9sNIf8
        +uYSC+Bz1m9RpQB/0yJM19OuBbadROQFWtkKsvg=
X-Google-Smtp-Source: ABdhPJyQ9PQkQYqnDZgpkDFgKb26BXg8I7qq9H3w6LUADliDEzsyoI0sHJIf2u6KBx6hIP6L1K0UdUVJizMmgnZP7OM=
X-Received: by 2002:a17:906:3e4f:: with SMTP id t15mr20173574eji.368.1596499074909;
 Mon, 03 Aug 2020 16:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200704122809.73794-1-konradybcio@gmail.com> <20200704130922.GB21333@willie-the-truck>
 <20200705033511.GR388985@builder.lan> <CAMS8qEWO-1mNd12Zs-2WogCrgNF5=6RkF=Z1pTeOZxSuKjx+qg@mail.gmail.com>
 <20200721154415.GA5758@jcrouse1-lnx.qualcomm.com> <CAMS8qEXNh6n9SpMkPAr8cPneasPvJPELD2TZ4gxUf0byxNePbg@mail.gmail.com>
 <20200721235650.GN388985@builder.lan> <CAMS8qEVXGddTdbrPwK3NJMx71HH0hoVyqiJG6-g9tiBRMRYZ8w@mail.gmail.com>
 <20200731054850.GA20825@builder.lan>
In-Reply-To: <20200731054850.GA20825@builder.lan>
From:   Konrad Dybcio <konradybcio@gmail.com>
Date:   Tue, 4 Aug 2020 01:57:19 +0200
Message-ID: <CAMS8qEVmSK=FQyTVCOkF6HX_2PAfr5oJ+Fo=QkRV1Cd15bo3Xw@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Implement qcom,skip-init
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Will Deacon <will@kernel.org>, skrzynka@konradybcio.pl,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sounds like things are progressing nicely for a while there, presumably
> until the next time the display is being refreshed.
>
> Would you be willing to try out the following work in progress:
> https://lore.kernel.org/linux-arm-msm/20200717001619.325317-1-bjorn.andersson@linaro.org/

I sure would like to if you could be kind enough to tell me which tree
I should apply it against. Latest -next brought some changes to
drivers/iommu/ structure which makes this not apply at all :/

Konrad
