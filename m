Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B572C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4F82070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8YmmXZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCWVUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:20:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40184 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgCWVUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:20:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so6465072plk.7;
        Mon, 23 Mar 2020 14:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gwk+oA56w7chZgB5rwcFzqm1eElVocnK0t0AHCBP8yQ=;
        b=A8YmmXZ0cGVBB3dUxG1y25+NUkRk38YFfGLeUWWJ++mJoZ1YBc1+Rk/EhQTctZAKeI
         dLaY219krh3CUOauviJMyB7ko8zTiEsdp7JsjxNonedzp2vpQNqsy0Z0iOOUmVv9Djap
         wzLMDPQeZMuXwUVCWNIngfyA9DEOvDpbfoSk/vAEmL0GlkiWov2zYfOjxxaP7iTG1cNK
         GzpQkSBw4fsb1Yz9EZusHfyAZdrPaJ1GA7MA6rifEZnSmIdCN7vslqhnhXx6A/pwkp/Z
         /1uII2u0+t7Kcdw2R4fXbCNmayagQ2Cs2jIdKt30hMa2qVqgFpRkYsbWroLqNfd9emcd
         tStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gwk+oA56w7chZgB5rwcFzqm1eElVocnK0t0AHCBP8yQ=;
        b=EJe7LNTfz6I1NfEmUFBUQkxTTkTsQ3fhwxpKFwKA3s4mUXCbu5C7eTvU4Q8sxo/qvM
         EMHszMUr9qZ9+GHrHFVcQ+ayGnAWhg7gtrHOtG8qGIZ1hTUcEosGs+cLKIbCkNkv1UR1
         RoJDTTSZyjEQTabsOvbU2wBrkisXG6GoLYbTs9sz6YmykYhazqI9NeMvc/SQ13+nn2yE
         vafGOt3rE/dqaAIhQ/OGzgbHeOmYSFXVPoX8RWjXBE7Y4PIA4JVs5i94C6XSpnPHNlfe
         kBM0fw2/x440cSo8LzHpPQdnsrCqSfszllgxcEP2kEONLS5V3lX/c+CJ12ULUSH96+M5
         vdaw==
X-Gm-Message-State: ANhLgQ0g1qYkv/eh+1vWeV//xF93QPgI1isbcVBX2LDcReQ4srXA+3Ti
        V9/ffQApoDD951GuSiJNYxw=
X-Google-Smtp-Source: ADFU+vv7tlepPAmm35itIz/eXxTaP0rUCj7Y76PBef7aDXcjLbwyTDKZpymRXFDJNAm9wfFzB26DWQ==
X-Received: by 2002:a17:90a:208:: with SMTP id c8mr1410640pjc.153.1584998442547;
        Mon, 23 Mar 2020 14:20:42 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id s19sm14469184pfh.218.2020.03.23.14.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 14:20:42 -0700 (PDT)
Date:   Mon, 23 Mar 2020 14:20:39 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/7] ASoC: dt-bindings: fsl_asrc: Add new property
 fsl,asrc-format
Message-ID: <20200323212038.GA7527@Asurada-Nvidia.nvidia.com>
References: <cover.1583725533.git.shengjiu.wang@nxp.com>
 <24f69c50925b93afd7a706bd888ee25d27247c78.1583725533.git.shengjiu.wang@nxp.com>
 <20200309211943.GB11333@Asurada-Nvidia.nvidia.com>
 <20200320173213.GA9093@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320173213.GA9093@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 11:32:13AM -0600, Rob Herring wrote:
> On Mon, Mar 09, 2020 at 02:19:44PM -0700, Nicolin Chen wrote:
> > On Mon, Mar 09, 2020 at 11:58:28AM +0800, Shengjiu Wang wrote:
> > > In order to support new EASRC and simplify the code structure,
> > > We decide to share the common structure between them. This bring
> > > a problem that EASRC accept format directly from devicetree, but
> > > ASRC accept width from devicetree.
> > > 
> > > In order to align with new ESARC, we add new property fsl,asrc-format.
> > > The fsl,asrc-format can replace the fsl,asrc-width, then driver
> > > can accept format from devicetree, don't need to convert it to
> > > format through width.
> > > 
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > index cb9a25165503..780455cf7f71 100644
> > > --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > @@ -51,6 +51,11 @@ Optional properties:
> > >  			  will be in use as default. Otherwise, the big endian
> > >  			  mode will be in use for all the device registers.
> > >  
> > > +   - fsl,asrc-format	: Defines a mutual sample format used by DPCM Back
> > > +			  Ends, which can replace the fsl,asrc-width.
> > > +			  The value is SNDRV_PCM_FORMAT_S16_LE, or
> > > +			  SNDRV_PCM_FORMAT_S24_LE
> > 
> > I am still holding the concern at the DT binding of this format,
> > as it uses values from ASoC header file instead of a dt-binding
> > header file -- not sure if we can do this. Let's wait for Rob's
> > comments.
> 
> I assume those are an ABI as well, so it's okay to copy them unless we 

They are defined under include/uapi. So I think we can use them?

> already have some format definitions for DT. But it does need to be copy 
> in a header under include/dt-bindings/.

Shengjiu is actually quoting those integral values, rather than
those macros, so actually no need copy to include/dt-bindings,
yet whoever adds this format property to a new DT would need to
look up the value in a header file under include/uapi. I's just
wondering if that's okay.

Thanks
