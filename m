Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5B3C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE27221707
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VxcMqauS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408025AbgDPGcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:32:51 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35700 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407709AbgDPGcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:32:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03G6WSNl091235;
        Thu, 16 Apr 2020 01:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587018748;
        bh=Rb8TXWTmwQcjPvJd3E+h6uzfxHfRJWCoNumVEM5OcBE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VxcMqauSvSkeMWgQZ96WlmQKP7xDtXR9gTemFrgiHZGchILth/PH2eIgvnZ6vSIyN
         duAgQ04xBDc0michmtgvgpby/jE9vXZ+KeM8ySYDQYN8PZ56bb+Wbi7Gr2F8Bv9Y1S
         vlN+qO/9AW3welU9Mu/1Q890ytQBOxnUPO5Gp4k0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03G6WRfg083663
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Apr 2020 01:32:27 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 16
 Apr 2020 01:32:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 16 Apr 2020 01:32:26 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03G6WOfQ025822;
        Thu, 16 Apr 2020 01:32:25 -0500
Subject: Re: [PATCH -next] drm/omap: venc: remove unused variable
 'venc_config_pal_bdghi'
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        YueHaibing <yuehaibing@huawei.com>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <sebastian.reichel@collabora.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20200415132105.43636-1-yuehaibing@huawei.com>
 <20200415153959.GI4758@pendragon.ideasonboard.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <1c9e1e60-5ff6-3ee7-e31e-e7cfb0cd279e@ti.com>
Date:   Thu, 16 Apr 2020 09:32:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415153959.GI4758@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2020 18:39, Laurent Pinchart wrote:
> Hi Yue,
> 
> Thank you for the patch.
> 
> On Wed, Apr 15, 2020 at 09:21:05PM +0800, YueHaibing wrote:
>> drivers/gpu/drm/omapdrm/dss/venc.c:211:33:
>>   warning: 'venc_config_pal_bdghi' defined but not used [-Wunused-const-variable=]
>>   static const struct venc_config venc_config_pal_bdghi = {
>>                                   ^~~~~~~~~~~~~~~~~~~~~
>>
>> It is never used, remove it.
> 
> Tomi, is this the right fix, or should we work on making use of this
> structure ?

I think we can remove it. I'll pick you this patch.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
