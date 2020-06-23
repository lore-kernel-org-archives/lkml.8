Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360C6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 04:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5BA20780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 04:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592885126;
	bh=UVz4+oAosUXKAyVWZlcgGKdvRIQ5BClYVUWNS+XZFDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MyqoSFLQWyrdttgqd94tixy3OoH90Eba/vpnC5I4JHOV5nHn6Cl/lCrUqf2kJ/Sx4
	 lU2MoRyiBGANT401GDdIPS2EcBZaB4g6eaMPrAkjDjjmDEWmIUugJRYZsg7HP8d9GY
	 5HQEun2qaDvS/psDiuN9UQaFUjo77CXd5JKyrQnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbgFWEFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 00:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgFWEFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 00:05:24 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 887A92076A;
        Tue, 23 Jun 2020 04:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592885123;
        bh=UVz4+oAosUXKAyVWZlcgGKdvRIQ5BClYVUWNS+XZFDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hXzxBbbbYe1Wcpmfu1Vz6vMkRUo6uf50URq/g8XmTvPPrXQwP+nwvV1CoiBtf1ybY
         h8kdo+GlNGbyxaKIyEfiImk1mXOJtq2zfXFAKPfcVsP2hGArGjcvzaXEohAPCuNiTk
         UtGmZ1sMlto+F+fvvAleTPgWTnblr8bIr/XgR0u0=
Date:   Tue, 23 Jun 2020 09:35:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ALSA: compress: document the compress audio state
 machine
Message-ID: <20200623040517.GO2324254@vkoul-mobl>
References: <20200622065811.221485-1-vkoul@kernel.org>
 <20200622065811.221485-2-vkoul@kernel.org>
 <800a2632-b263-500f-707e-c1ce94ce92d4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <800a2632-b263-500f-707e-c1ce94ce92d4@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-20, 08:28, Pierre-Louis Bossart wrote:
> 
> 
> On 6/22/20 1:58 AM, Vinod Koul wrote:
> > So we had some discussions of the stream states, so I thought it is a
> > good idea to document the state transitions, so add it documentation
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >   .../sound/designs/compress-offload.rst        | 52 +++++++++++++++++++
> >   1 file changed, 52 insertions(+)
> > 
> > diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
> > index ad4bfbdacc83..6f86db82298b 100644
> > --- a/Documentation/sound/designs/compress-offload.rst
> > +++ b/Documentation/sound/designs/compress-offload.rst
> > @@ -151,6 +151,58 @@ Modifications include:
> >   - Addition of encoding options when required (derived from OpenMAX IL)
> >   - Addition of rateControlSupported (missing in OpenMAX AL)
> > +State Machine
> > +=============
> > +
> > +The compressed audio stream state machine is described below ::
> > +
> > +                                        +----------+
> > +                                        |          |
> > +                                        |   OPEN   |
> > +                                        |          |
> > +                                        +----------+
> > +                                             |
> > +                                             |
> > +                                             | compr_set_params()
> > +                                             |
> > +                                             v
> > +         compr_free()                   +----------+
> > +  +-------------------------------------|          |
> > +  |                                     |   SETUP  |
> > +  |           +------------------------>|          |<---------------------------------+
> > +  |           | compr_drain_notify()    +----------+                                  |
> > +  |           |                              |                                        |
> > +  |           |                              |                                        |
> > +  |           |                              | compr_write()                          |
> > +  |           |                              |                                        |
> > +  |           |                              v                                        |
> > +  |           |                         +----------+                                  |
> > +  |           |                         |          |                                  |
> > +  |           |                         |  PREPARE |                                  |
> > +  |           |                         |          |                                  |
> > +  |           |                         +----------+                                  |
> > +  |           |                              |                                        |
> > +  |           |                              |                                        |
> > +  |           |                              | compr_start()                          |
> > +  |           |                              |                                        |
> > +  |           |                              v                                        |
> > +  |     +----------+                    +----------+  compr_pause()  +----------+     |
> > +  |     |          |    compr_drain()   |          |---------------->|          |     |
> > +  |     |  DRAIN   |<-------------------|  RUNNING |                 |  PAUSE   |     |
> > +  |     |          |                    |          |<----------------|          |     |
> > +  |     +----------+                    +----------+  compr_resume() +----------+     |
> > +  |           |                           |      |                                    |
> > +  |           |                           |      |                                    |
> > +  |           |                           |      |                                    |
> > +  |           |                           |      |          compr_stop()              |
> > +  |           |                           |      +------------------------------------+
> > +  |           |       +----------+        |
> > +  |           |       |          |        |
> > +  +-----------+------>|          |<-------+
> > +     compr_free()     |   FREE   |  compr_free()
> > +                      |          |
> > +                      +----------+
> > +
> 
> Sorry, this confuses me even more...

Oops

> a) can you clarify if we can go from running to free directly? is this
> really a legit transition? There's already the option of doing a stop and a
> a drain.

As Charles pointed it is legit one, but then from SM we should remove
running->free arrow to clarify. Internally, free in running, draining
and paused triggers a stop and then free.

> b) no way to go back to SETUP from PREPARE? What happens if the app never
> starts but want to tear down the resources?

See above, free would trigger an internal step to stop (setup) and then
freed.

Btw I am not adding changes to code but documenting the 'existing'
behaviour, so a code lookup will help

> c) no way to stop a paused stream?

Yes missed that, will add.

-- 
~Vinod
