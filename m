Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81EBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D64206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHZIYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:24:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39654 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgHZIYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:24:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 27A3F292BD5
Subject: Re: [PATCH v4 0/7] Convert mtk-dsi to drm_bridge API and get EDID for
 ps8640 bridge
To:     Bilal Wasim <bilalwasim676@gmail.com>, chunkuang.hu@kernel.org
Cc:     sam@ravnborg.org, linux-kernel@vger.kernel.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, Laurent.pinchart@ideasonboard.com
References: <20200501152335.1805790-1-enric.balletbo@collabora.com>
 <20200824190102.44454-1-bilalwasim676@gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <83930a49-8b1b-d5d2-7610-3dac3b316737@collabora.com>
Date:   Wed, 26 Aug 2020 10:24:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824190102.44454-1-bilalwasim676@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bilal,

On 24/8/20 21:01, Bilal Wasim wrote:
> Hi Chun-Kuan, Enric,
> 
> Is there any plan to merge the following commits in this series to the mainline?
> 
>   drm/bridge: ps8640: Get the EDID from eDP control
>   drm/bridge_connector: Set default status connected for eDP connectors
> 

Just sent a new series including this patches:
https://lore.kernel.org/patchwork/project/lkml/list/?series=459760

Thanks,
 Enric

> I see that rest of the patchset is already merged and available in 5.9-RC2. 
> 
> Thanks,
> Bilal
> 
