Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77960C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 08:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5822083B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 08:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgBIIUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 03:20:25 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:40204 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgBIIUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 03:20:25 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id D29B22001E;
        Sun,  9 Feb 2020 09:20:20 +0100 (CET)
Date:   Sun, 9 Feb 2020 09:20:19 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, philippe.cornu@st.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] dt-bindings: add simple DSI panels
Message-ID: <20200209082019.GB5321@ravnborg.org>
References: <20200206133344.724-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206133344.724-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=LtanmIvG8o0tSDT4I0gA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin.

On Thu, Feb 06, 2020 at 02:33:41PM +0100, Benjamin Gaignard wrote:
> To complement panel-simple.yaml, create panel-simple-dsi.yaml.
> panel-simple-dsi-yaml are for all simple DSP panels with a single
> power-supply and optional backlight / enable GPIO / reset GPIO.
> 
> Some DSI panels like orisetech,otm8009a or raydium,rm68200 are quite
> similar to simple dsi panel but with small variations. Create dedicated
> yaml files for them.
> 
> Benjamin Gaignard (2):
>   dt-bindings: panel: Convert raydium,rm68200 to json-schema
>   dt-bindings: panel: Convert orisetech,otm8009a to json-schema
> 
> Sam Ravnborg (1):
>   dt-bindings: one file of all simple DSI panels

Thanks for picking this up.
Applied and pushed to drm-misc-next.

	Sam
