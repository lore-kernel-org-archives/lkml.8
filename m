Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8928C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA7E2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584967603;
	bh=7C/45yxMVezqPY/AYGZVlsZQoI91jW9qnhU3Os7B61w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WZFcBNB5rbK1L+TaqUa50JDiDIGF+tqPlE7R+ZxhVSzBERrh9RAaO/h6CJirrVByE
	 2TsA/9sU4z2cMASZPAAahrG2RrsnsgCrcmWkFDJjOKaqtM/TQGGVHrxX3ZCzP7wOCW
	 +P0G6hRzFmWZ6wcy3Yv8QTfWSwNGGj5yCu4KR8i4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgCWMqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbgCWMqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:46:42 -0400
Received: from localhost (unknown [122.178.205.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACA7C2072E;
        Mon, 23 Mar 2020 12:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584967601;
        bh=7C/45yxMVezqPY/AYGZVlsZQoI91jW9qnhU3Os7B61w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NXIMczFaCjgjWefIoljSdvKnyxoa/R+pZ0836WIdz3F7JJTFUPn43gKihTEtub0EV
         S9f0XkaoQGnBo362s/XqyLWh4Tz4MUi3qiekMOxc/gfvjFd1fJ5+zIU2NLJnvZnD17
         m7iRdJ9HdqB4e2YPr2gI4zMSpKN01TILfaUD2gdI=
Date:   Mon, 23 Mar 2020 18:16:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH] soundwire: stream: only change state if needed
Message-ID: <20200323124636.GN72691@vkoul-mobl>
References: <20200317105142.4998-1-pierre-louis.bossart@linux.intel.com>
 <20200320141528.GI4885@vkoul-mobl>
 <f212f561-27aa-265c-3f4c-45b2336ac145@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f212f561-27aa-265c-3f4c-45b2336ac145@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-20, 09:33, Pierre-Louis Bossart wrote:
> On 3/20/20 9:15 AM, Vinod Koul wrote:
> > On 17-03-20, 05:51, Pierre-Louis Bossart wrote:
> > > In a multi-cpu DAI context, the stream routines may be called from
> > > multiple DAI callbacks. Make sure the stream state only changes for
> > > the first call, and don't return error messages if the target state is
> > > already reached.

Again I ask you to read emails carefully and not jump the gun.

> > For stream-apis we have documented explicitly in Documentation/driver-api/soundwire/stream.rst
> > 

< begins with quote from the file stream.rst>

> > "Bus implements below API for allocate a stream which needs to be called once
> > per stream. From ASoC DPCM framework, this stream state maybe linked to
> > .startup() operation.
> > 
> > .. code-block:: c
> > 
> >    int sdw_alloc_stream(char * stream_name); "

<end quote>

> > This is documented for all stream-apis.

This line is very important. But seems to have skipped

> > This can be resolved by moving the calling of these APIs from
> > master-dais/slave-dais to machine-dais. They are unique in the card.

This is suggestion, feel free to do anything as long as that conforms to
documentation laid out, which incidentally was written by Sanyog and
signed off by you. See 89634f99a83e ("Documentation: soundwire: Add more documentation")

> this change is about prepare/enable/disable/deprepare, not allocation or
> startup.

Sad to see this. Now am going to quote for all these, since you skipped
the line in above email.

For prepare:
"Bus implements below API for PREPARE state which needs to be called
once per stream. From ASoC DPCM framework, this stream state is linked
to .prepare() operation. Since the .trigger() operations may not
follow the .prepare(), a direct transition from
``SDW_STREAM_PREPARED`` to ``SDW_STREAM_DEPREPARED`` is allowed."

See the point about "once per stream".

On Enable:
"Bus implements below API for ENABLE state which needs to be called once per
stream. From ASoC DPCM framework, this stream state is linked to
.trigger() start operation."

See the point about "once per stream".

For Disable:
"Bus implements below API for DISABLED state which needs to be called once
per stream. From ASoC DPCM framework, this stream state is linked to
.trigger() stop operation."

See the point about "once per stream".

For deprepare:
"Bus implements below API for DEPREPARED state which needs to be called
once per stream. ALSA/ASoC do not have a concept of 'deprepare', and
the mapping from this stream state to ALSA/ASoC operation may be
implementation specific."

See the point about "once per stream".

> I see no reason to burden the machine driver with all these steps. It's not
> because QCOM needs this transition that everyone does.
> 
> As discussed earlier, QCOM cannot use this functionality because the
> prepare/enable and disable/deprepare are done in the hw_params and hw_free
> respectively. This was never the intended use, but Intel let it happen so
> I'd like you to return the favor. This change has no impact for QCOM and
> simplifies the Intel solution, so why would you object?
> 
> Seriously, your replies on all Intel contributions make me wonder if this is
> the QCOM/Linaro SoundWire subsystem, or if we are going to find common
> ground to deal with vastly different underlying architectures?

It is extremely sad that you chose to say this and didn't even try to
read the email and recheck the documentation you have signed off.

This has nothing to do with Qcom/Linaro. If you look at git tree in
Intel you will find that the original implementation was to use these from
machine driver. I am sure of this fact as I had written that code.

I am really getting extremely annoyed at your attitude in your
conversations and accusing me. This is not nice.
My replies are based on documentation and questioning the
implementation, which is my job here. I dont care if you feel bad about
me questions. I guess you dont like that someone is questioning, but I
dont care.

-- 
~Vinod
