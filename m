Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DD2C47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C20D20708
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SMxlHq5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgEAOj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbgEAOj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:39:26 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E38EC061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 07:39:25 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id b6so3783869uak.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=URjoa0IPAuVJrJzf1GzsjjCJgtImSI4fVU++g+IJyuo=;
        b=SMxlHq5r/xlgb1aFLRF6VaIP1+SWFfbYQhAXjYZD4COiPW8KJ+YqJlOeUxHxCY5DlG
         Idx1WYR1HxdMRSDeEA2FIMDrtrlxs+zIzz57nuJsVPdb23kkRR6vDORPdekV6cr8T2ey
         XFPCDrZn+jfp9p8SrvmZa/jauPbMy65QXIIZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=URjoa0IPAuVJrJzf1GzsjjCJgtImSI4fVU++g+IJyuo=;
        b=DGYexVEod1VTNv72mqVlRHYKi8y7Tiu3q/inJyMKCvmlv0TmIkwcXyJj1C+d4LYPIr
         0sKNenz4TkXXNARjHM+dQW8QoKS4yFHDm0mSQEfoo7xxdxGLEGDZ/sN4u78mZna/oPfI
         zWehYeGb0J2M9H2UxR/QkVPxV7fsffC0Mqa4Hm/QrLJAOmJebmyWuIFQ/GVX8jdMZEd8
         /BZHLVeF/hbh8rlh0+Ka1SIAy+FuPqsg3nbOn4tKMT2Ef1MnPq5wz9wRSMuuHsO1UvsF
         DWu5fCii7j8UyjLL3pgg2dhRyiGsibgmiJfVkvJqXOv11mamKQpmw1uXhVQBUE8xtJju
         ceZg==
X-Gm-Message-State: AGi0Pub0DqxbcfnBx8AvvQHIlOHSGeadnUN/P8bxp4zMPnGOEsd/AE3S
        kZKjyvuqVf8pIDPDhUcGgHJURlOeHtg=
X-Google-Smtp-Source: APiQypIm0+UoKR8vddQO0kfES5sqXt4yXi+ruIbRTeazNuttRvvQxILDoKp28MrvrxIT9Bfd8RnBnA==
X-Received: by 2002:ab0:544a:: with SMTP id o10mr3138701uaa.15.1588343964484;
        Fri, 01 May 2020 07:39:24 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id u25sm854243vkn.22.2020.05.01.07.39.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 07:39:23 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id y185so6392492vsy.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 07:39:23 -0700 (PDT)
X-Received: by 2002:a67:bd07:: with SMTP id y7mr3484487vsq.109.1588343962687;
 Fri, 01 May 2020 07:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <1588329036-18732-1-git-send-email-smasetty@codeaurora.org>
In-Reply-To: <1588329036-18732-1-git-send-email-smasetty@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 May 2020 07:39:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W+uaPTZHKXq6WYgx-ZDL1QTedEpNw9T747UBD_g1O8CQ@mail.gmail.com>
Message-ID: <CAD=FV=W+uaPTZHKXq6WYgx-ZDL1QTedEpNw9T747UBD_g1O8CQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7180: Add A618 gpu dt blob
To:     Sharat Masetty <smasetty@codeaurora.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 1, 2020 at 3:30 AM Sharat Masetty <smasetty@codeaurora.org> wrote:
>
> This patch adds the required dt nodes and properties
> to enabled A618 GPU.
>
> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
> ---
> * Remove GCC_DDRSS_GPU_AXI_CLK clock reference from gpu smmu node.
>
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 102 +++++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)

This is the newer version of the patch:

https://lore.kernel.org/r/1581320465-15854-2-git-send-email-smasetty@codeaurora.org

The change to remove the extra IOMMU clock matches our discussions and
there's no longer anything blocking this from landing.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
