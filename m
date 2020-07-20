Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6A5C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B932065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595286987;
	bh=UBL56L6DvPiSUqINrljfh24/NIVhD1aet891CEeilBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jWCBq0SbK+pfrh6bobLbgS0sXfTl+bVmk32+cxh/Us4+x0bVG6bx1jW6t4eDp36iI
	 SOxgGwqrWVhaIooPq344xarvyexjjOAgUBHo+opgmAwAz6kB0Jm4rgy4OGLOIbPdF7
	 i4/s/UEbiHu8vmKQKO+PKjuSavFnrS4n5LvA9kAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGTXQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:16:24 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35236 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgGTXQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:16:24 -0400
Received: by mail-il1-f193.google.com with SMTP id t18so14802832ilh.2;
        Mon, 20 Jul 2020 16:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rvvIyeI/O+OX0a15wh7KP70spFPqxmPPVr5citgRAhs=;
        b=UGRCgJKNn13PfCTux4RmUX76QQ2o+k/hYpeKsNN4ElZD1tFH4ZIdgdk3cc2d+dVOo0
         EtNQk4tJRjFUJgan/MLfysa2fDdBO78xvSn+LBZbkc0a2/QTO+G3VP0ngHkmwnc/UXlB
         PLGAOaOPDREGvljzxBNHoTikcbjZkkTOVuK+PYBhfqvCAq0Q1pVLljgZrxmWe/kbajie
         QWTyBUFefStViyF0V89DgHY8SZjm2sx+EnlEmlLH4LxzVe8wkieflQxXhFy9syucvAXU
         eI6jo1ggu4f3kWIywuhiENLIgpUuDeYRlNV/7/FFcxUhduAof85Fe4ZqoepTULtH3OqD
         z/Bg==
X-Gm-Message-State: AOAM5334kGTIHEixfxqawB0/Kv/xOyiwo+zK22i2OJO94JRgZJnNY+HO
        4yA/xikqaG8JPqAR/3CvgA==
X-Google-Smtp-Source: ABdhPJyshFo0omA3xHohlTk0hyWSZGLg6Id03dPze2mNf5c56JFT/g2414OvfN4EWj1udjb5SIybmw==
X-Received: by 2002:a92:3407:: with SMTP id b7mr17598958ila.66.1595286983360;
        Mon, 20 Jul 2020 16:16:23 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id h11sm9515742ilh.69.2020.07.20.16.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 16:16:22 -0700 (PDT)
Received: (nullmailer pid 3136375 invoked by uid 1000);
        Mon, 20 Jul 2020 23:16:21 -0000
Date:   Mon, 20 Jul 2020 17:16:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        cui.zhang@mediatek.com, chao.hao@mediatek.com,
        ming-fan.chen@mediatek.com
Subject: Re: [PATCH 04/21] dt-binding: mediatek: Add binding for mt8192 IOMMU
 and SMI
Message-ID: <20200720231621.GA3106350@bogus>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-5-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200711064846.16007-5-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 02:48:29PM +0800, Yong Wu wrote:
> This patch adds decriptions for mt8192 IOMMU and SMI.
> 
> mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> table format. The M4U-SMI HW diagram is as below:
> 
>                           EMI
>                            |
>                           M4U
>                            |
>                       ------------
>                        SMI Common
>                       ------------
>                            |
>   +-------+------+------+----------------------+-------+
>   |       |      |      |       ......         |       |
>   |       |      |      |                      |       |
> larb0   larb1  larb2  larb4     ......      larb19   larb20
> disp0   disp1   mdp    vdec                   IPE      IPE
> 
> All the connections are HW fixed, SW can NOT adjust it.
> 
> mt8192 M4U support 0~16GB iova range. we preassign different engines
> into different iova ranges:
> 
> domain-id  module     iova-range                  larbs
>    0       disp        0 ~ 4G                      larb0/1
>    1       vcodec      4G ~ 8G                     larb4/5/7
>    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
>    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
>    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5

You probably want to use dma-ranges for defining these 
address restrictions. 

How is the domain-id used or needed?

Rob 
