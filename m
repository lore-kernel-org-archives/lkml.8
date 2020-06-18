Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19667C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5BA208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eGgDOyjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgFRRwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgFRRwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:52:21 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20398C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:52:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r9so6013312wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lb6ruUo4th4gczpSuevPe5msRghKn9eEg7we4tRduH4=;
        b=eGgDOyjrGAgWo8+oJBjv2YRlI0KPsVR0vk3sX9sj5UkJB3QMBW4oB/V3LHRO5p+jkR
         AzFtvoivhxfC58Yswr8wRmbhgXOtENtAyrJUVC1EV5C0H+PasAaahOh0c7MU6DXy4eBw
         fuWwyC4exoBoszRiG/M/X4Hssfd9RctogKm2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lb6ruUo4th4gczpSuevPe5msRghKn9eEg7we4tRduH4=;
        b=NwicRfX9guNCYEdwly+PbjTgRck7oFviCUZrVCxKBmnPzdlmsOU7HmOhV3SiW5943+
         HDFx2+JzYZJ3qFwOuJb4LCGsj0bUaLDzDdJy/BPh0gbB26j6LLfPrMSBZxklotEKW9Ck
         4Q6qgmr/LUlUTHlfa6ZpFNfroxOnKypqtn4v52HHsIPt+d/+PQPhve5sb8LmaiqiOrM5
         IIA6TUP9IDzdMnbJC3W52l0AbeSd8PUFU6Y3EExDmns8XydQc/j/zN/QzIRMJ3fhQ6cC
         YTI2A4Vf/BzU4WtpnDSaj0c0Tk2ekWJeqLH1iN4de7DITozxvwtmAtvb45eXClXUvvLY
         TsZw==
X-Gm-Message-State: AOAM531dejPGbFMVnw3ia4gX1eBWZQ0cdDVNBVySXRW8XWBQxiAseReS
        FuVPwX+2SLofBKECTFIqPfhjZ1VA18l+2w==
X-Google-Smtp-Source: ABdhPJyN6ugEFVxfi2oUTpklkACeaBduQoso3/vz2+EfcawKtoU105dOecEZxHdsjW8oylGRMPEBSA==
X-Received: by 2002:a7b:c2a9:: with SMTP id c9mr5352893wmk.11.1592502739874;
        Thu, 18 Jun 2020 10:52:19 -0700 (PDT)
Received: from chromium.org (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id o1sm4589796wrw.20.2020.06.18.10.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 10:52:19 -0700 (PDT)
Date:   Thu, 18 Jun 2020 17:52:18 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] media: v4l UAPI: add
 V4L2_BUF_CAP_SUPPORTS_RO_REQUESTS
Message-ID: <20200618175218.GB10831@chromium.org>
References: <20200617014928.4374-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617014928.4374-1-yunfei.dong@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunfei,

On Wed, Jun 17, 2020 at 09:49:27AM +0800, Yunfei Dong wrote:
> This patch adds support for the V4L2_BUF_CAP_SUPPORTS_RO_REQUESTS
> flag. This flag is used for RO Request.

I think this patch series lacks two major things:
 - a cover letter explaining the feature and what it is needed/useful
   for,
 - a user - is there an upstream driver which would implement this
   feature and benefit from it?

Best regards,
Tomasz
