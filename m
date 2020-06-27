Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE9DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 20:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E94ED20707
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 20:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgF0UTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 16:19:42 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:40990 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0UTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 16:19:42 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 5B062807FA;
        Sat, 27 Jun 2020 22:19:39 +0200 (CEST)
Date:   Sat, 27 Jun 2020 22:19:38 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Improve descriptions of a few simple-panels
Message-ID: <20200627201938.GA80066@ravnborg.org>
References: <20200621222742.25695-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621222742.25695-1-digetx@gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=voM4FWlXAAAA:8 a=pGLkceISAAAA:8
        a=Qkpp-YoNu5Q0VIUAnfEA:9 a=CjuIK1q_8ugA:10 a=IC2XNlieTeVoXbcui8wp:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 01:27:40AM +0300, Dmitry Osipenko wrote:
> Hello,
> 
> This is a follow up to [1], which was already applied to drm-misc and then
> Laurent Pinchart spotted some problems. This series addresses those problems.
> 
> [1] https://patchwork.ozlabs.org/project/linux-tegra/patch/20200617222703.17080-8-digetx@gmail.com/
> 
> Dmitry Osipenko (2):
>   drm/panel-simple: Correct EDT ET057090DHU connector type
>   drm/panel-simple: Add missing BUS descriptions for some panels

Thanks for the quick fixes, both are now applied to drm-misc-next.

	Sam
