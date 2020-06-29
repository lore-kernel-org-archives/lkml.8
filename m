Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB25C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B8B2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466825;
	bh=00blYSw4H3we8f6YNcADktzYDOCPmayZbfhVhGUiz6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2DCkeGNRHqCC1BAh87kg8SZbPUGmcQmrY/awtedbNERmdz/u07WugnCqsertEEKV5
	 zNbUDZw/O8uV6qsdjpz8csnodRd2wijTcyFIa6dDLnkoVUE2KjXk/UnNg0PWGjCgxt
	 84E+4kG9rOB/IWGa3Qp/4Heii1sanYuztCfP2lYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389967AbgF2VkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbgF2Sk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:28 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF13820857;
        Mon, 29 Jun 2020 09:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593423274;
        bh=00blYSw4H3we8f6YNcADktzYDOCPmayZbfhVhGUiz6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=profOf+OjR7WE03HKWGRwyP+LXIRgPlX8syXRo/3NQJ8Cr9hQPWee9UDxZACi3WCF
         ONI2Zny5nkvY3b1m12zOrx6cBSzw69Dv+tVQDZ/PKSubTsWPxVS6ATnMHH7swTNwlL
         vSa10APt2UUDEq5Qh4vgF2mM7T2ZQMh2/ocuIec4=
Date:   Mon, 29 Jun 2020 15:04:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 1/3] ALSA: compress: document the compress audio state
 machine
Message-ID: <20200629093429.GA2599@vkoul-mobl>
References: <20200629075002.11436-1-vkoul@kernel.org>
 <20200629075002.11436-2-vkoul@kernel.org>
 <c29b3199-cebd-2153-5530-e75f76aa8b4b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c29b3199-cebd-2153-5530-e75f76aa8b4b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amadeusz,

On 29-06-20, 11:05, Amadeusz Sławiński wrote:
> 
> 
> On 6/29/2020 9:50 AM, Vinod Koul wrote:
> > So we had some discussions of the stream states, so I thought it is a
> > good idea to document the state transitions, so add it documentation
> > 
> > Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >   .../sound/designs/compress-offload.rst        | 51 +++++++++++++++++++
> >   1 file changed, 51 insertions(+)
> > 
> > diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
> > index ad4bfbdacc83..b6e9025ae105 100644
> > --- a/Documentation/sound/designs/compress-offload.rst
> > +++ b/Documentation/sound/designs/compress-offload.rst
> > @@ -151,6 +151,57 @@ Modifications include:
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
> > +  +------------------------------------|          |
> > +  |                                    |   SETUP  |
> > +  |          +------------------------>|          |<-------------------------+
> > +  |          | compr_drain_notify()    +----------+                          |
> > +  |          |         or                   ^                                |
> > +  |          |      compr_stop()            |                                |
> > +  |          |                              | compr_write()                  |
> > +  |          |                              |                                |
> > +  |          |                              |                                |

Not sure, this is not in the version I posted, arrow is from setup ->
prepare. See https://lore.kernel.org/alsa-devel/20200629075002.11436-2-vkoul@kernel.org/

I don't know how it got reversed in your version, maybe the MUA messed
up??

> > +  |          |                         +----------+                          |
> > +  |          |                         |          |   compr_free()           |
> > +  |          |                         |  PREPARE |---------------> A        |
> > +  |          |                         |          |                          |
> > +  |          |                         +----------+                          |
> > +  |          |                              |                                |
> > +  |          |                              |                                |
> > +  |          |                              | compr_start()                  |
> > +  |          |                              |                                |
> > +  |          |                              v                                |
> > +  |    +----------+                    +----------+                          |
> > +  |    |          |    compr_drain()   |          |        compr_stop()      |
> > +  |    |  DRAIN   |<-------------------|  RUNNING |--------------------------+
> > +  |    |          |                    |          |                          |
> > +  |    +----------+                    +----------+                          |
> > +  |                                       |    ^                             |
> > +  |          A                            |    |                             |
> > +  |          |              compr_pause() |    | compr_resume()              |
> > +  |          |                            |    |                             |
> > +  |          v                            v    |                             |
> > +  |    +----------+                   +----------+                           |
> > +  |    |          |                   |          |         compr_stop()      |
> > +  +--->|   FREE   |                   |  PAUSE   |---------------------------+
> > +       |          |                   |          |
> > +       +----------+                   +----------+
> > +
> >   Gapless Playback
> >   ================
> > 
> 
> Line containing compr_free (between SETUP and FREE) seems to be misaligned?

not in the version I posted and see on lore

> If you move prepare to the left and drain in place of drain, it feels like
> you won't need this weird indirection with A

yeah that was a compromise to make it bit neater to me than adding
overlapping arrows...

> Something like:
> 
> >> +                                             v
> > > +         compr_free()                   +----------+
> > > +  +------------------------------------|          |
> > > +  |                                    |   SETUP  |
> > > +  |          +------------------------>|          |<-------------------------+
> > > +  |          | compr_write()           +----------+                          |
> > > +  |          |                              ^                                |
> > > +  |          |                              | compr_drain_notify() or        |
> > > +  |          |                              | compr_stop()                   |
> > > +  |          |                              |                                |
> > > +  |          |                              |                                |
> > > +  |          |                         +----------+                          |
> > > +  |          |                         |          |                          |
> > > +  |          |                         |  DRAIN   |                          |
> > > +  |          |                         |          |                          |
> > > +  |          |                         +----------+                          |
> > > +  |          |                              ^                                |
> > > +  |          |                              |                                |
> > > +  |          |                              | compr_drain()                  |
> > > +  |          |                              |                                |
> > > +  |          |                              |                                |
> > > +  |    +----------+                    +----------+                          |
> > > +  |    |          |    compr_start()   |          |        compr_stop()      |
> > > +  |    |  PREPARE |------------------->|  RUNNING |--------------------------+
> > > +  |    |          |                    |          |                          |
> > > +  |    +----------+                    +----------+                          |
> > > +  |          |                            |    ^                             |
> > > +  |          | compr_free()               |    |                             |
> > > +  |          |              compr_pause() |    | compr_resume()              |
> > > +  |          |                            |    |                             |
> > > +  |          v                            v    |                             |
> > > +  |    +----------+                   +----------+                           |
> > > +  |    |          |                   |          |         compr_stop()      |
> > > +  +--->|   FREE   |                   |  PAUSE   |---------------------------+
> > > +       |          |                   |          |
> > > +       +----------+                   +----------+
> > > +
> 

> but this makes me question PREPARE state, how do you enter it?

a compr_write() moves from SETUP -> PREPARE. Fixing that above looks
better version of mine..

-- 
~Vinod
