Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6342AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F73F20776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgH1R61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:58:27 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:47008 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1R61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 13:58:27 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 10DFE201BD;
        Fri, 28 Aug 2020 19:58:00 +0200 (CEST)
Date:   Fri, 28 Aug 2020 19:57:59 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH RFC v6 1/6] dt-bindings: display: add Unisoc's drm master
 bindings
Message-ID: <20200828175759.GB660103@ravnborg.org>
References: <1595930879-2478-1-git-send-email-kevin3.tang@gmail.com>
 <1595930879-2478-2-git-send-email-kevin3.tang@gmail.com>
 <20200728202732.GB1277651@ravnborg.org>
 <CAFPSGXahb7KzsM3iZFjW=JjZAYr0h1vwMx2ROrwR=x8MCchn1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFPSGXahb7KzsM3iZFjW=JjZAYr0h1vwMx2ROrwR=x8MCchn1Q@mail.gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=CaYmGojl c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=eyGgB6SCGB90EZ01wQQA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin.

> >
> > Any specific reason why this is not a ports node like used by many other
> > display bindings?
> > In other words - I think this is too simple.
> We only support one display pipeline now, other interface, like
> DP(DisplayPort), HDMI...will be add later...
> 
>   ports:
>     $ref: /schemas/types.yaml#/definitions/phandle-array
>     description: |
>       Should contain a list of phandles pointing to display interface port
>       of dpu devices.. dpu definitions as defined in
>       Documentation/devicetree/bindings/display/sprd/sprd,dpu.yaml

There is nothing wrong having a ports node that is limited to a single
port node. But please remember the binding describes the HW - so if the
HW supports more than one port the binding should describe this.
What the driver supports is not relevant for the binding.

	Sam
