Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5D6C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0976208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="XCmye49i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgDQLZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 07:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730176AbgDQLZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 07:25:12 -0400
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5300::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BCDC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1587122706;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=PL8NP1zjYSBNJ+7M2gB6mpIwxdDNW486VMAFOgdOofM=;
        b=XCmye49ia90RQ2AhWuN2E6R2OuT5xYw5bDqQG3FH6IUhly9O8WBBEIKjlZYYjDWH+j
        m/uHCBUZ/C46zoTYfYGmUCVRyEk8IruJCr7XAXX+LmiY/WsP762Ik46xDr/of3dXIfWK
        IZmhyyAoY/g86SYNBrN2edp7sU1OMHl1U8LRtQ10eA5Frzx/QP09wFpnxIpKT77Qdk5t
        kAfcV1HoKjD2a57foYBlV7XoC2cfke8cDpSCy9H25sE3432RSI6VtzGePKbPcPs/IO1v
        izR49/fC76S3eC70GDh3TxYutEoexzg79xIV4mWNsgQgDIafofIcQWjbSJblLz7e2B4U
        76jg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j8Ic/Fboo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.5.0 DYNA|AUTH)
        with ESMTPSA id I0a766w3HBP11Vr
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 17 Apr 2020 13:25:01 +0200 (CEST)
Date:   Fri, 17 Apr 2020 13:24:55 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com
Subject: Re: [PATCH 0/2] ASoC: qdsp6: fix default FE dais and routings.
Message-ID: <20200417112455.GA7558@gerhold.net>
References: <20200311180422.28363-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311180422.28363-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srini,

On Wed, Mar 11, 2020 at 06:04:20PM +0000, Srinivas Kandagatla wrote:
> QDSP6 Frontend dais can be configured to work in rx or tx or both rx/tx mode,
> however the default routing do not honour this DT configuration making sound
> card fail to probe. FE dais are also not fully honouring device tree configuration.
> Fix both of them.
> 

I discovered this patch set when QDSP6 audio stopped working after
upgrading to Linux 5.7-rc1. As far as I understand, device tree bindings
should attempt to be backwards compatible wherever possible.
This isn't the case here, although this is not the reason for my mail.
(I don't mind updating my device tree, especially since it is not
upstream yet...)

I have a general question about the design here.

I understand the original motivation for this patch set: Attempting to
configure a TX/RX-only DAI was not possible due to the default routing.
In my opinion this is only relevant for the compressed DAI case.

If we ignore the compressed DAIs for a moment (which can be
unidirectional only), I think we shouldn't care how userspace uses the
available FE/MultiMedia DAIs. We have this huge routing matrix in q6routing,
with 800+ mixers that can be configured in any way possible from userspace.

In "ASoC: qdsp6: q6asm-dai: only enable dais from device tree" you mention:

> This can lead to un-necessary dais in the system which will never be
> used. So honour whats specfied in device tree.

but IMO the FE DAIs are a negligible overhead compared to the routing 
matrix and the many BE DAIs that are really never going to be used
(because nothing is physically connected to the ports).

Even if you restrict FE DAIs to RX/TX only, or disable them entirely,
all the routing mixers still exist for them. They will just result in
configurations that are not usable in any way. IMO the only thing we
gain by restricting the FE DAIs is that the available mixers no longer
match possible configurations.

Before this patch set I used a slightly different approach in my device
tree for MSM8916: I kept all FE DAIs bi-directional, and added DAI links
for all of them. This means that I actually had 8 bi-directional PCM
devices in userspace.

I didn't use all of them - my ALSA UCM configuration only uses
MultiMedia1 for playback and MultiMedia2 for capture.
However, some other userspace (let's say Android) could have chosen
different FE DAIs for whatever reason. We have the overhead for the
routing matrix anyway, so we might as well expose it in my opinion.

My question is: In what way are the FE DAIs really board-specific?

If we expose only some FE DAIs with intended usage per board,
e.g. MultiMedia1 for HDMI, MultiMedia2 for slimbus playback,
     MultiMedia3 for slimbus capture,
I could almost argue that we don't need DPCM at all.
The FE DAIs are always going to be used for the same backend anyway.

This is a bit exaggerated - for example if you have a single compress
DAI per board you probably intend to use it for both HDMI/slimbus.
But this is the feeling I get if we configure the FE DAIs separately
for each board.

I wonder if we should leave configuration of the FE DAIs up to userspace
(e.g. ALSA UCM), and expose the same full set of FE DAIs for each board.

I think this is mostly a matter of convention for configuring FE DAIs
in the device tree - I have some ideas how to make that work
with the existing device tree bindings and for compressed DAIs.
But this mail is already long enough as-is. ;)

I also don't mind if we keep everything as-is
- I just wanted to share what I have been thinking about.

What do you think?

Thanks for reading! ;)
Stephan

> Originally  issue was reported by Vinod Koul
> 
> Srinivas Kandagatla (2):
>   ASoC: qdsp6: q6asm-dai: only enable dais from device tree
>   ASoC: qdsp6: q6routing: remove default routing
> 
>  sound/soc/qcom/qdsp6/q6asm-dai.c | 30 +++++++++++++++++++++++-------
>  sound/soc/qcom/qdsp6/q6routing.c | 19 -------------------
>  2 files changed, 23 insertions(+), 26 deletions(-)
> 
> -- 
> 2.21.0
> 
