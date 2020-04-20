Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95518C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E88208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgDTR7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:59:18 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:34664 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgDTR7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:59:17 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 7C4A98040D;
        Mon, 20 Apr 2020 19:59:11 +0200 (CEST)
Date:   Mon, 20 Apr 2020 19:59:09 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com
Subject: Re: Rule for bridge yaml dt binding maintainers?
Message-ID: <20200420175909.GA5810@ravnborg.org>
References: <87d082jtfn.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d082jtfn.fsf@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=kKKJSc-euidS1K_z5cIA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian

On Mon, Apr 20, 2020 at 02:19:24PM +0300, Adrian Ratiu wrote:
> Hello,
> 
> I got confused while doing the txt -> yaml conversion at [1] and it's still
> not clear to me who should be added in the "maintainers" field.  Clearly not
> the maintainers as returned by get_maintainer.pl. :)
> 
> Rob mentioned that "owners" should be manintainers but I also have trouble
> picking the persons who should be owners / yaml maintainers.
> 
> Looking at the completed bridge conversions in the latest linux-next, I
> couldn't find a rule and the majority of bindings are still txt:
> 
> $ find ./devicetree/bindings/display/bridge/ -name *txt | wc -l
> 23
> $ find ./devicetree/bindings/display/bridge/ -name *yaml | wc -l
> 5
> 
> So my questions are:
> 1. Is there a general rule for assigning yaml file owners/maintainers?
> 
> 2. Is this vagueness specific to the bridge dt bindings only?
> 
> 3. Who should step up and maintain these bindings? Original/new authors,
> SoC, bridge, DRM maintainers etc.?
> 
> It would be useful to have a rule to make it easier to do these conversions.
> We (Collabora) are considering doing the conversion work.

For the panel conversion I did recently it was simple:
1) If listed in MAINTAINERS - use this info
2) Otherwise use the person(s) that authored the original .txt file.
   Using git log --follow foo.txt
3) In a few cases I may have decided otherwise, but the above covers the
   majority.

I would also be great if you or someone else could:
- teach get_maintainers about .yaml file listed maintainers
- teach checkpatch that it is OK to convert .txt to .yaml
- teach checkpatch about some simple yaml validation (maybe)

I am looking forward to the day we have more .yaml files
than .txt files in Documentation/devicetree/binding/*

	Sam
