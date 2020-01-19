Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44614C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 06:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21772206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 06:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgASG45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 01:56:57 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:40582 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgASG45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 01:56:57 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id B9F0A20023;
        Sun, 19 Jan 2020 07:56:50 +0100 (CET)
Date:   Sun, 19 Jan 2020 07:56:49 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com
Subject: Re: [PATCH v10 0/5] add driver for "boe, tv101wum-nl6", "boe,
 tv101wum-n53", "auo, kd101n80-45na" and "auo, b101uan08.3" panels
Message-ID: <20200119065649.GA1391@ravnborg.org>
References: <20200119014541.64273-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119014541.64273-1-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=oHMhZ3l30UxMmAFbuhYA:9 a=CjuIK1q_8ugA:10 a=pHzHmUro8NiASowvMSCR:22
        a=xoEH_sTeL_Rfw54TyV31:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jitao.

On Sun, Jan 19, 2020 at 09:45:36AM +0800, Jitao Shi wrote:
> Changes since v9:
>  - remove Rob from maintainers in boe,tv101wum-nl6.yaml

This series is already applied to drm-misc-next.
I removed Rob from Maintainers while applying.

	Sam
