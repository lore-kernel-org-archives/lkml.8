Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C194C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4163220721
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590516207;
	bh=Strl1cxJAhSLc51NP6x/GYHOF1epC7a+J4OX9YeKEtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ebn1+gqYV+DewkVm5f6qu3WmM5RcOtLx/m0Q+CWWvFRmy8hHa+VQGfFdQZH4AA9b0
	 gd6qZ2esxMqoXombyyIWPPQ359hWU8kZTYMP5veDFEQBNpkvCm0KUL6XE8kNPEoud4
	 4dFuln9z+dUAhqk3u9K2fzB0MRLb1FqEz/f/OXNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgEZSD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:03:26 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36841 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgEZSDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:03:25 -0400
Received: by mail-il1-f194.google.com with SMTP id 17so21437360ilj.3;
        Tue, 26 May 2020 11:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=udyKIAgzUuMLjrt7p/tKMSuE96YEp3YyGPeKVs0pC30=;
        b=G4fh4tjyEkg90wkTxzfetT4niAZIojQPhqLJNN2r5FzshHQYPV4SH0hmS0xLFqVwPb
         hC8jOISXDFVmYv9ciIOwQ3N5lL8m1NcerTV2BptO9MPtOwPAbUXWb+e7ALnSzlSw6qaf
         MBmMSaV/PRWrU3ZIyUL7okvXsxKTPqSfTYclsDj5uI1033OZuhE1hUZFjAyg1Kgv2HZ7
         LsZooRx3Fg4b0xOoJkWhHBMRa4H/VzdZMt62kbsRw/HzLBIkjG8ubtgUwALAJdl/Abjt
         sw2BFdcaF/0sggBzCp2nAqk4ouLVaj4Oz+UiJcBiXtX+jIJF4FSGNZTv22BruN6JaXNM
         yH8g==
X-Gm-Message-State: AOAM532g01XFOXoUDpuQ4nxopHlzGsvMpX+19jY9mpakyLM0b4rYARbb
        jK39+jGIOVCl1ro/zgdjrw==
X-Google-Smtp-Source: ABdhPJz49fxHgfKUlXk9bT+7PEkcHyxo07cWGJ72t5O8q64FjmH/+SLrhIzcouiT9jARc7MEOifDQA==
X-Received: by 2002:a92:3d8b:: with SMTP id k11mr785485ilf.122.1590516203049;
        Tue, 26 May 2020 11:03:23 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id 4sm337307ilc.34.2020.05.26.11.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 11:03:22 -0700 (PDT)
Received: (nullmailer pid 77730 invoked by uid 1000);
        Tue, 26 May 2020 18:03:21 -0000
Date:   Tue, 26 May 2020 12:03:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        srv_heupstream@mediatek.com, Fan Chen <fan.chen@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <kernel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, James Liao <jamesjj.liao@mediatek.com>
Subject: Re: [PATCH v15 02/11] dt-bindings: soc: Add MT8183 power dt-bindings
Message-ID: <20200526180321.GA77691@bogus>
References: <1590051985-29149-1-git-send-email-weiyi.lu@mediatek.com>
 <1590051985-29149-3-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590051985-29149-3-git-send-email-weiyi.lu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 17:06:15 +0800, Weiyi Lu wrote:
> Add power dt-bindings of MT8183 and introduces "BASIC" and
> "SUBSYS" clock types in binding document.
> The "BASIC" type is compatible to the original power control with
> clock name [a-z]+[0-9]*, e.g. mm, vpu1.
> The "SUBSYS" type is used for bus protection control with clock
> name [a-z]+-[0-9]+, e.g. isp-0, cam-1.
> And add an optional "mediatek,smi" property for phandle to smi-common
> node.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/scpsys.txt    | 21 ++++++++++++++---
>  include/dt-bindings/power/mt8183-power.h           | 26 ++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/power/mt8183-power.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
