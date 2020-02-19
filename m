Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335CDC34054
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF38224656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582127893;
	bh=gSP4kGRHp1dqPghTphH6FKOty1LF5Vjv0h0b7MZKnls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mOGfAsEkRlJvEZFqp4XkjLf4Et9Za/ITS2hZDt8I7+DcBFbOFUuDgP4VFRL6F7noY
	 wVkwssuuJcyCdHmHJqwVRLk2w7DkG+93mQOsb0AbJOSmvLcoDI3esHQ1jGcf1+gnxu
	 QVlKH8Xaoc9Y9Ob3LSZhsy9zPwQRTffS43G3hl4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgBSP6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:58:12 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36757 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSP6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:58:11 -0500
Received: by mail-ot1-f65.google.com with SMTP id j20so611008otq.3;
        Wed, 19 Feb 2020 07:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4O9CnOr8+zUib3MxUktx8tocBFHd3My1FuGlD5p8EN4=;
        b=Sg/hvop9G7/GYdPHXo7YzioR+atuvs/DBCyQJhQtA3uiHSICXohhyqHFeBqFFnskIV
         gY/2RnyC5MxVqRTFo7ZKl//K/u/4XfwS5B57jndLPSBw7tuLXDIxH4JgZ43Q5b8Bm6py
         iZmmdNf0gt/tnRAHy6XucE5d1RaHpfX6eMmcUvJa8Qqma54N2BZnjoTnTI/RTJe8Rfps
         wy/3y1GU6oQNOhnIo6i13hsJcQpdN52gUyrdU94i1Y39YQmWe47WWZs0Rq3PU2lS63Sl
         pOSbusJxVn5M18QG4JPkYS41q4Rc9IbeBHNxCCzc1nGJVyLmdmWc2DTyilmxpu9du5lT
         fHUA==
X-Gm-Message-State: APjAAAXqXGaaTxSlOsdRmWvq+vggbGH/Iqo25XrOYNtfYesCXNv/Jsg1
        Pa17RaboJAgdBuUsNVDGkw==
X-Google-Smtp-Source: APXvYqy52y8smJwyT9Is0xjNr20hyf/ScQra7/VzFFvdo3mdTJjnN8sfVb/YuAwgUyT81Y71mrMBFQ==
X-Received: by 2002:a9d:664a:: with SMTP id q10mr19081630otm.298.1582127890051;
        Wed, 19 Feb 2020 07:58:10 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w20sm45232otj.21.2020.02.19.07.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 07:58:08 -0800 (PST)
Received: (nullmailer pid 30717 invoked by uid 1000);
        Wed, 19 Feb 2020 15:58:08 -0000
Date:   Wed, 19 Feb 2020 09:58:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: simple-card: switch to yaml base
 Documentation
Message-ID: <20200219155808.GA25095@bogus>
References: <87blq1zr8n.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blq1zr8n.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 02:13:05PM +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch switches from .txt base to .yaml base Document.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
> 
> 	- add missing setup
> 
>  .../devicetree/bindings/sound/simple-card.txt | 351 -------------
>  .../bindings/sound/simple-card.yaml           | 484 ++++++++++++++++++
>  2 files changed, 484 insertions(+), 351 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/simple-card.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/simple-card.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
> deleted file mode 100644
> index 79954cd6e37b..000000000000
> --- a/Documentation/devicetree/bindings/sound/simple-card.txt
> +++ /dev/null
> @@ -1,351 +0,0 @@
> -Simple-Card:
> -
> -Simple-Card specifies audio DAI connections of SoC <-> codec.
> -
> -Required properties:
> -
> -- compatible				: "simple-audio-card"
> -
> -Optional properties:
> -
> -- simple-audio-card,name		: User specified audio sound card name, one string
> -					  property.
> -- simple-audio-card,widgets		: Please refer to widgets.txt.
> -- simple-audio-card,routing		: A list of the connections between audio components.
> -					  Each entry is a pair of strings, the first being the
> -					  connection's sink, the second being the connection's
> -					  source.
> -- simple-audio-card,mclk-fs             : Multiplication factor between stream rate and codec
> -					  mclk. When defined, mclk-fs property defined in
> -					  dai-link sub nodes are ignored.
> -- simple-audio-card,hp-det-gpio		: Reference to GPIO that signals when
> -					  headphones are attached.
> -- simple-audio-card,mic-det-gpio	: Reference to GPIO that signals when
> -					  a microphone is attached.
> -- simple-audio-card,aux-devs		: List of phandles pointing to auxiliary devices, such
> -					  as amplifiers, to be added to the sound card.
> -- simple-audio-card,pin-switches	: List of strings containing the widget names for
> -					  which pin switches must be created.
> -
> -Optional subnodes:
> -
> -- simple-audio-card,dai-link		: Container for dai-link level
> -					  properties and the CPU and CODEC
> -					  sub-nodes. This container may be
> -					  omitted when the card has only one
> -					  DAI link. See the examples and the
> -					  section below.
> -
> -Dai-link subnode properties and subnodes:
> -
> -If dai-link subnode is omitted and the subnode properties are directly
> -under "sound"-node the subnode property and subnode names have to be
> -prefixed with "simple-audio-card,"-prefix.
> -
> -Required dai-link subnodes:
> -
> -- cpu					: CPU   sub-node
> -- codec					: CODEC sub-node
> -
> -Optional dai-link subnode properties:
> -
> -- format				: CPU/CODEC common audio format.
> -					  "i2s", "right_j", "left_j" , "dsp_a"
> -					  "dsp_b", "ac97", "pdm", "msb", "lsb"
> -- frame-master				: Indicates dai-link frame master.
> -					  phandle to a cpu or codec subnode.
> -- bitclock-master			: Indicates dai-link bit clock master.
> -					  phandle to a cpu or codec subnode.
> -- bitclock-inversion			: bool property. Add this if the
> -					  dai-link uses bit clock inversion.
> -- frame-inversion			: bool property. Add this if the
> -					  dai-link uses frame clock inversion.
> -- mclk-fs             			: Multiplication factor between stream
> -					  rate and codec mclk, applied only for
> -					  the dai-link.
> -
> -For backward compatibility the frame-master and bitclock-master
> -properties can be used as booleans in codec subnode to indicate if the
> -codec is the dai-link frame or bit clock master. In this case there
> -should be no dai-link node, the same properties should not be present
> -at sound-node level, and the bitclock-inversion and frame-inversion
> -properties should also be placed in the codec node if needed.
> -
> -Required CPU/CODEC subnodes properties:
> -
> -- sound-dai				: phandle and port of CPU/CODEC
> -
> -Optional CPU/CODEC subnodes properties:
> -
> -- dai-tdm-slot-num			: Please refer to tdm-slot.txt.
> -- dai-tdm-slot-width			: Please refer to tdm-slot.txt.
> -- clocks / system-clock-frequency	: specify subnode's clock if needed.
> -					  it can be specified via "clocks" if system has
> -					  clock node (= common clock), or "system-clock-frequency"
> -					  (if system doens't support common clock)
> -					  If a clock is specified, it is
> -					  enabled with clk_prepare_enable()
> -					  in dai startup() and disabled with
> -					  clk_disable_unprepare() in dai
> -					  shutdown().
> -					  If a clock is specified and a
> -					  multiplication factor is given with
> -					  mclk-fs, the clock will be set to the
> -					  calculated mclk frequency when the
> -					  stream starts.
> -- system-clock-direction-out		: specifies clock direction as 'out' on
> -					  initialization. It is useful for some aCPUs with
> -					  fixed clocks.
> -
> --------------------------------------------
> -Example 1 - single DAI link:
> --------------------------------------------
> -
> -sound {
> -	compatible = "simple-audio-card";
> -	simple-audio-card,name = "VF610-Tower-Sound-Card";
> -	simple-audio-card,format = "left_j";
> -	simple-audio-card,bitclock-master = <&dailink0_master>;
> -	simple-audio-card,frame-master = <&dailink0_master>;
> -	simple-audio-card,widgets =
> -		"Microphone", "Microphone Jack",
> -		"Headphone", "Headphone Jack",
> -		"Speaker", "External Speaker";
> -	simple-audio-card,routing =
> -		"MIC_IN", "Microphone Jack",
> -		"Headphone Jack", "HP_OUT",
> -		"External Speaker", "LINE_OUT";
> -
> -	simple-audio-card,cpu {
> -		sound-dai = <&sh_fsi2 0>;
> -	};
> -
> -	dailink0_master: simple-audio-card,codec {
> -		sound-dai = <&ak4648>;
> -		clocks = <&osc>;
> -	};
> -};
> -
> -&i2c0 {
> -	ak4648: ak4648@12 {
> -		#sound-dai-cells = <0>;
> -		compatible = "asahi-kasei,ak4648";
> -		reg = <0x12>;
> -	};
> -};
> -
> -sh_fsi2: sh_fsi2@ec230000 {
> -	#sound-dai-cells = <1>;
> -	compatible = "renesas,sh_fsi2";
> -	reg = <0xec230000 0x400>;
> -	interrupt-parent = <&gic>;
> -	interrupts = <0 146 0x4>;
> -};
> -
> --------------------------------------------
> -Example 2 - many DAI links:
> --------------------------------------------
> -
> -sound {
> -	compatible = "simple-audio-card";
> -	simple-audio-card,name = "Cubox Audio";
> -
> -	simple-audio-card,dai-link@0 {		/* I2S - HDMI */
> -		reg = <0>;
> -		format = "i2s";
> -		cpu {
> -			sound-dai = <&audio1 0>;
> -		};
> -		codec {
> -			sound-dai = <&tda998x 0>;
> -		};
> -	};
> -
> -	simple-audio-card,dai-link@1 {		/* S/PDIF - HDMI */
> -		reg = <1>;
> -		cpu {
> -			sound-dai = <&audio1 1>;
> -		};
> -		codec {
> -			sound-dai = <&tda998x 1>;
> -		};
> -	};
> -
> -	simple-audio-card,dai-link@2 {		/* S/PDIF - S/PDIF */
> -		reg = <2>;
> -		cpu {
> -			sound-dai = <&audio1 1>;
> -		};
> -		codec {
> -			sound-dai = <&spdif_codec>;
> -		};
> -	};
> -};
> -
> --------------------------------------------
> -Example 3 - route audio from IMX6 SSI2 through TLV320DAC3100 codec
> -through TPA6130A2 amplifier to headphones:
> --------------------------------------------
> -
> -&i2c0 {
> -	codec: tlv320dac3100@18 {
> -		compatible = "ti,tlv320dac3100";
> -		...
> -	}
> -
> -	amp: tpa6130a2@60 {
> -		compatible = "ti,tpa6130a2";
> -		...
> -	}
> -}
> -
> -sound {
> -	compatible = "simple-audio-card";
> -	...
> -	simple-audio-card,widgets =
> -		"Headphone", "Headphone Jack";
> -	simple-audio-card,routing =
> -		"Headphone Jack", "HPLEFT",
> -		"Headphone Jack", "HPRIGHT",
> -		"LEFTIN", "HPL",
> -		"RIGHTIN", "HPR";
> -	simple-audio-card,aux-devs = <&amp>;
> -	simple-audio-card,cpu {
> -		sound-dai = <&ssi2>;
> -	};
> -	simple-audio-card,codec {
> -		sound-dai = <&codec>;
> -		clocks = ...
> -	};
> -};
> -
> --------------------------------------------
> -Example 4. Sampling Rate Conversion
> --------------------------------------------
> -
> -sound {
> -	compatible = "simple-audio-card";
> -
> -	simple-audio-card,name = "rsnd-ak4643";
> -	simple-audio-card,format = "left_j";
> -	simple-audio-card,bitclock-master = <&sndcodec>;
> -	simple-audio-card,frame-master = <&sndcodec>;
> -
> -	simple-audio-card,convert-rate = <48000>;
> -
> -	simple-audio-card,prefix = "ak4642";
> -	simple-audio-card,routing = "ak4642 Playback", "DAI0 Playback",
> -			"DAI0 Capture", "ak4642 Capture";
> -
> -	sndcpu: simple-audio-card,cpu {
> -		sound-dai = <&rcar_sound>;
> -	};
> -
> -	sndcodec: simple-audio-card,codec {
> -		sound-dai = <&ak4643>;
> -		system-clock-frequency = <11289600>;
> -	};
> -};
> -
> --------------------------------------------
> -Example 5. 2 CPU 1 Codec (Mixing)
> --------------------------------------------
> -sound {
> -	compatible = "simple-audio-card";
> -
> -	simple-audio-card,name = "rsnd-ak4643";
> -	simple-audio-card,format = "left_j";
> -	simple-audio-card,bitclock-master = <&dpcmcpu>;
> -	simple-audio-card,frame-master = <&dpcmcpu>;
> -
> -	simple-audio-card,routing = "ak4642 Playback", "DAI0 Playback",
> -			"ak4642 Playback", "DAI1 Playback";
> -
> -	dpcmcpu: cpu@0 {
> -		sound-dai = <&rcar_sound 0>;
> -	};
> -
> -	cpu@1 {
> -		sound-dai = <&rcar_sound 1>;
> -	};
> -
> -	codec {
> -		prefix = "ak4642";
> -		sound-dai = <&ak4643>;
> -		clocks = <&audio_clock>;
> -	};
> -};
> -
> --------------------------------------------
> -Example 6 - many DAI links with DPCM:
> --------------------------------------------
> -
> -CPU0 ------ ak4613
> -CPU1 ------ PCM3168A-p  /* DPCM 1ch/2ch */
> -CPU2 --/                /* DPCM 3ch/4ch */
> -CPU3 --/                /* DPCM 5ch/6ch */
> -CPU4 --/                /* DPCM 7ch/8ch */
> -CPU5 ------ PCM3168A-c
> -
> -sound {
> -	compatible = "simple-audio-card";
> -
> -	simple-audio-card,routing =
> -		  "pcm3168a Playback", "DAI1 Playback",
> -		  "pcm3168a Playback", "DAI2 Playback",
> -		  "pcm3168a Playback", "DAI3 Playback",
> -		  "pcm3168a Playback", "DAI4 Playback";
> -
> -	simple-audio-card,dai-link@0 {
> -		format = "left_j";
> -		bitclock-master = <&sndcpu0>;
> -		frame-master = <&sndcpu0>;
> -
> -		sndcpu0: cpu {
> -			sound-dai = <&rcar_sound 0>;
> -		};
> -		codec {
> -			sound-dai = <&ak4613>;
> -		};
> -	};
> -	simple-audio-card,dai-link@1 {
> -		format = "i2s";
> -		bitclock-master = <&sndcpu1>;
> -		frame-master = <&sndcpu1>;
> -
> -		convert-channels = <8>; /* TDM Split */
> -
> -		sndcpu1: cpu@0 {
> -			sound-dai = <&rcar_sound 1>;
> -		};
> -		cpu@1 {
> -			sound-dai = <&rcar_sound 2>;
> -		};
> -		cpu@2 {
> -			sound-dai = <&rcar_sound 3>;
> -		};
> -		cpu@3 {
> -			sound-dai = <&rcar_sound 4>;
> -		};
> -		codec {
> -			mclk-fs = <512>;
> -			prefix = "pcm3168a";
> -			dai-tdm-slot-num = <8>;
> -			sound-dai = <&pcm3168a 0>;
> -		};
> -	};
> -	simple-audio-card,dai-link@2 {
> -		format = "i2s";
> -		bitclock-master = <&sndcpu2>;
> -		frame-master = <&sndcpu2>;
> -
> -		sndcpu2: cpu {
> -			sound-dai = <&rcar_sound 5>;
> -		};
> -		codec {
> -			mclk-fs = <512>;
> -			prefix = "pcm3168a";
> -			sound-dai = <&pcm3168a 1>;
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
> new file mode 100644
> index 000000000000..0a2a2c878c4a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
> @@ -0,0 +1,484 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/simple-card.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple Audio Card Driver Device Tree Bindings
> +
> +maintainers:
> +  - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> +
> +definitions:
> +
> +  frame-master:
> +    description: Indicates dai-link frame master.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

Only 1 phandle (plus args)? If so,

allOf:
  - $ref: /schemas/types.yaml#/definitions/phandle-array
  - maxItems: 1

> +
> +  bitclock-master:
> +    description: Indicates dai-link bit clock master
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  frame-inversion:
> +    description: dai-link uses frame clock inversion
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +  bitclock-inversion:
> +    description: dai-link uses bit clock inversion
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +  dai-tdm-slot-num:
> +    description: see tdm-slot.txt.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Is there a max?

> +
> +  dai-tdm-slot-width:
> +    description: see tdm-slot.txt.
> +    $ref: /schemas/types.yaml#/definitions/uint32

max is 32 or something much less than 2^32?

> +
> +  clocks:
> +    description: |
> +      If a clock is specified and a multiplication factor is given with
> +      mclk-fs, the clock will be set to the calculated mclk frequency
> +      when the stream starts.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

'clocks' already has a type definition. You should only be defining how 
many and what each one is if more than 1.

> +
> +  system-clock-frequency:
> +    description: |
> +      If a clock is specified and a multiplication factor is given with
> +      mclk-fs, the clock will be set to the calculated mclk frequency
> +      when the stream starts.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  system-clock-direction-out:
> +    description: |
> +      specifies clock direction as 'out' on initialization.
> +      It is useful for some aCPUs with fixed clocks.
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +  mclk-fs:
> +    description: |
> +      Multiplication factor between stream rate and codec mclk.
> +      When defined, mclk-fs property defined in dai-link sub nodes are ignored.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  aux-devs:
> +    description: |
> +      List of phandles pointing to auxiliary devices, such
> +      as amplifiers, to be added to the sound card.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  convert-rate:
> +    description: CPU to Codec rate convert.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  convert-channels:
> +    description: CPU to Codec rate channels.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  prefix:
> +    description: "device name prefix"
> +    $ref: /schemas/types.yaml#/definitions/string
> +
> +  label:
> +    description: "device name"
> +    $ref: /schemas/types.yaml#/definitions/string

'label' already has a type definition.

> +
> +  routing:
> +    description: |
> +      A list of the connections between audio components.
> +      Each entry is a pair of strings, the first being the
> +      connection's sink, the second being the connection's source.
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +
> +  widgets:
> +    description: User specified audio sound widgets.
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +
> +  pin-switches:
> +    description: the widget names for which pin switches must be created.
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +
> +  format:
> +    description: audio format.
> +    items:
> +      enum:
> +        - i2s
> +        - right_j
> +        - left_j
> +        - dsp_a
> +        - dsp_b
> +        - ac97
> +        - pdm
> +        - msb
> +        - lsb
> +
> +  dai:
> +    type: object
> +    properties:
> +      sound-dai:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array

This should have a common definition elsewhere which I'd prefer be in 
the dtschema repo. You can just assume there is and do 'maxItems: 1' 
here assuming it's only 1.

> +
> +      # common properties
> +      mclk-fs:
> +        $ref: "#/definitions/mclk-fs"
> +      prefix:
> +        $ref: "#/definitions/prefix"
> +      frame-inversion:
> +        $ref: "#/definitions/frame-inversion"
> +      bitclock-inversion:
> +        $ref: "#/definitions/bitclock-inversion"
> +      frame-master:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +      bitclock-master:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +
> +      dai-tdm-slot-num:
> +        $ref: "#/definitions/dai-tdm-slot-num"
> +      dai-tdm-slot-width:
> +        $ref: "#/definitions/dai-tdm-slot-width"
> +      clocks:
> +        $ref: "#/definitions/clocks"
> +      system-clock-frequency:
> +        $ref: "#/definitions/system-clock-frequency"
> +      system-clock-direction-out:
> +        $ref: "#/definitions/system-clock-direction-out"
> +    required:
> +      - sound-dai
> +
> +properties:
> +  compatible:
> +    contains:
> +      enum:
> +        - simple-audio-card
> +        - simple-scu-audio-card
> +
> +  "#address-cells": true
> +  "#size-cells": true

Aren't these always 1 and 0, respectively?

> +
> +  label:
> +    $ref: "#/definitions/label"
> +
> +  simple-audio-card,name:
> +    description: User specified audio sound card name.
> +    $ref: /schemas/types.yaml#/definitions/string
> +
> +# use patternProperties to use "#definitions/xxx"
> +patternProperties:
> +  "^simple-audio-card,widgets$":
> +    $ref: "#/definitions/widgets"
> +  "^simple-audio-card,routing$":
> +    $ref: "#/definitions/routing"
> +  "^simple-audio-card,cpu(@.*)?":
> +    $ref: "#/definitions/dai"
> +  "^simple-audio-card,codec(@.*)?":
> +    $ref: "#/definitions/dai"
> +
> +  # common properties
> +  "^simple-audio-card,frame-master$":
> +    $ref: "#/definitions/frame-master"
> +  "^simple-audio-card,bitclock-master$":
> +    $ref: "#/definitions/bitclock-master"
> +  "^simple-audio-card,frame-inversion$":
> +    $ref: "#/definitions/frame-inversion"
> +  "^simple-audio-card,bitclock-inversion$":
> +    $ref: "#/definitions/bitclock-inversion"
> +  "^simple-audio-card,format$":
> +    $ref: "#/definitions/format"
> +  "^simple-audio-card,mclk-fs$":
> +    $ref: "#/definitions/mclk-fs"
> +  "^simple-audio-card,aux-devs$":
> +    $ref: "#/definitions/aux-devs"
> +  "^simple-audio-card,convert-rate$":
> +    $ref: "#/definitions/convert-rate"
> +  "^simple-audio-card,convert-channels$":
> +    $ref: "#/definitions/convert-channels"
> +  "^simple-audio-card,prefix$":
> +    $ref: "#/definitions/prefix"
> +  "^simple-audio-card,pin-switches$":
> +    $ref: "#/definitions/pin-switches"
> +# use common *-gpio for
> +#   simple-audio-card,hp-det-gpio:
> +#   simple-audio-card,mic-det-gpio:
> +
> +  "^simple-audio-card,dai-link(@.*)?":

We can do better than '.*' with '[0-9a-f]'. Also, needs a '$' on the 
end.

> +    description: |
> +      Container for dai-link level properties and the CPU and CODEC sub-nodes.
> +      This container may be omitted when the card has only one DAI link.
> +    type: object
> +    properties:
> +      reg:
> +        $ref: /schemas/types.yaml#/definitions/uint32

Just 'maxItems: 1' is enough.

> +
> +      # common properties
> +      frame-master:
> +        $ref: "#/definitions/frame-master"
> +      bitclock-master:
> +        $ref: "#/definitions/bitclock-master"
> +      frame-inversion:
> +        $ref: "#/definitions/frame-inversion"
> +      bitclock-inversion:
> +        $ref: "#/definitions/bitclock-inversion"
> +      format:
> +        $ref: "#/definitions/format"
> +      mclk-fs:
> +        $ref: "#/definitions/mclk-fs"
> +      aux-devs:
> +        $ref: "#/definitions/aux-devs"
> +      convert-rate:
> +        $ref: "#/definitions/convert-rate"
> +      convert-channels:
> +        $ref: "#/definitions/convert-channels"
> +      prefix:
> +        $ref: "#/definitions/prefix"
> +      pin-switches:
> +        $ref: "#/definitions/pin-switches"
> +      # use common *-gpio for
> +      #	hp-det-gpio:
> +      #	mic-det-gpio:
> +
> +    patternProperties:
> +      "^cpu(@.*)?":

Same as previous comment on unit-address. Can do better than '.*'.

> +        $ref: "#/definitions/dai"
> +      "^codec(@.*)?":
> +        $ref: "#/definitions/dai"
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +#--------------------
> +# single DAI link
> +#--------------------
> +  - |
> +    sound {
> +        compatible = "simple-audio-card";
> +        simple-audio-card,name = "VF610-Tower-Sound-Card";
> +        simple-audio-card,format = "left_j";
> +        simple-audio-card,bitclock-master = <&dailink0_master>;
> +        simple-audio-card,frame-master = <&dailink0_master>;
> +        simple-audio-card,widgets =
> +                "Microphone", "Microphone Jack",
> +                "Headphone", "Headphone Jack",
> +                "Speaker", "External Speaker";
> +        simple-audio-card,routing =
> +                "MIC_IN", "Microphone Jack",
> +                "Headphone Jack", "HP_OUT",
> +                "External Speaker", "LINE_OUT";
> +
> +        simple-audio-card,cpu {
> +            sound-dai = <&sh_fsi2 0>;
> +        };
> +
> +        dailink0_master: simple-audio-card,codec {
> +            sound-dai = <&ak4648>;
> +            clocks = <&osc>;
> +        };
> +    };
> +
> +#--------------------
> +# Multi DAI links
> +#--------------------
> +  - |
> +    sound {
> +        compatible = "simple-audio-card";
> +        simple-audio-card,name = "Cubox Audio";
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        simple-audio-card,dai-link@0 {		/* I2S - HDMI */
> +            reg = <0>;
> +            format = "i2s";
> +            cpu {
> +                sound-dai = <&audio0>;
> +            };
> +            codec {
> +                sound-dai = <&tda998x0>;
> +            };
> +        };
> +
> +        simple-audio-card,dai-link@1 {		/* S/PDIF - HDMI */
> +            reg = <1>;
> +            cpu {
> +                sound-dai = <&audio1>;
> +            };
> +            codec {
> +                sound-dai = <&tda998x1>;
> +            };
> +        };
> +
> +        simple-audio-card,dai-link@2 {		/* S/PDIF - S/PDIF */
> +            reg = <2>;
> +            cpu {
> +                sound-dai = <&audio2>;
> +            };
> +            codec {
> +                sound-dai = <&spdif_codec>;
> +            };
> +        };
> +    };
> +
> +#--------------------
> +# route audio from IMX6 SSI2 through TLV320DAC3100 codec
> +# through TPA6130A2 amplifier to headphones:
> +#--------------------
> +  - |
> +    sound {
> +        compatible = "simple-audio-card";
> +
> +        simple-audio-card,widgets =
> +            "Headphone", "Headphone Jack";
> +        simple-audio-card,routing =
> +            "Headphone Jack", "HPLEFT",
> +            "Headphone Jack", "HPRIGHT",
> +            "LEFTIN", "HPL",
> +            "RIGHTIN", "HPR";
> +        simple-audio-card,aux-devs = <&amp>;
> +        simple-audio-card,cpu {
> +            sound-dai = <&ssi2>;
> +        };
> +        simple-audio-card,codec {
> +            sound-dai = <&codec>;
> +            clocks = <&clocks>;
> +        };
> +    };
> +
> +#--------------------
> +# Sampling Rate Conversion
> +#--------------------
> +  - |
> +    sound {
> +        compatible = "simple-audio-card";
> +
> +        simple-audio-card,name = "rsnd-ak4643";
> +        simple-audio-card,format = "left_j";
> +        simple-audio-card,bitclock-master = <&sndcodec>;
> +        simple-audio-card,frame-master = <&sndcodec>;
> +
> +        simple-audio-card,convert-rate = <48000>;
> +
> +        simple-audio-card,prefix = "ak4642";
> +        simple-audio-card,routing = "ak4642 Playback", "DAI0 Playback",
> +                                    "DAI0 Capture", "ak4642 Capture";
> +
> +        sndcpu: simple-audio-card,cpu {
> +            sound-dai = <&rcar_sound>;
> +        };
> +
> +        sndcodec: simple-audio-card,codec {
> +            sound-dai = <&ak4643>;
> +            system-clock-frequency = <11289600>;
> +        };
> +    };
> +
> +#--------------------
> +# 2 CPU 1 Codec (Mixing)
> +#--------------------
> +  - |
> +    sound {
> +        compatible = "simple-audio-card";
> +
> +        simple-audio-card,name = "rsnd-ak4643";
> +        simple-audio-card,format = "left_j";
> +        simple-audio-card,bitclock-master = <&dpcmcpu>;
> +        simple-audio-card,frame-master = <&dpcmcpu>;
> +
> +        simple-audio-card,convert-rate = <48000>;
> +        simple-audio-card,convert-channels = <2>;
> +
> +        simple-audio-card,routing = "ak4642 Playback", "DAI0 Playback",
> +                                    "ak4642 Playback", "DAI1 Playback";
> +
> +        dpcmcpu: simple-audio-card,cpu@0 {
> +            sound-dai = <&rcar_sound 0>;
> +        };
> +
> +        simple-audio-card,cpu@1 {
> +            sound-dai = <&rcar_sound 1>;
> +        };
> +
> +        simple-audio-card,codec {
> +            prefix = "ak4642";
> +            sound-dai = <&ak4643>;
> +            clocks = <&audio_clock>;
> +        };
> +    };
> +
> +#--------------------
> +# Multi DAI links with DPCM:
> +#
> +# CPU0 ------ ak4613
> +# CPU1 ------ PCM3168A-p  /* DPCM 1ch/2ch */
> +# CPU2 --/                /* DPCM 3ch/4ch */
> +# CPU3 --/                /* DPCM 5ch/6ch */
> +# CPU4 --/                /* DPCM 7ch/8ch */
> +# CPU5 ------ PCM3168A-c
> +#--------------------
> +  - |
> +    sound {
> +        compatible = "simple-audio-card";
> +
> +        simple-audio-card,routing =
> +            "pcm3168a Playback", "DAI1 Playback",
> +            "pcm3168a Playback", "DAI2 Playback",
> +            "pcm3168a Playback", "DAI3 Playback",
> +            "pcm3168a Playback", "DAI4 Playback";
> +
> +        simple-audio-card,dai-link@0 {
> +            format = "left_j";
> +            bitclock-master = <&sndcpu0>;
> +            frame-master = <&sndcpu0>;
> +
> +            sndcpu0: cpu {
> +                sound-dai = <&rcar_sound 0>;
> +            };
> +            codec {
> +                sound-dai = <&ak4613>;
> +            };
> +        };
> +
> +        simple-audio-card,dai-link@1 {
> +            format = "i2s";
> +            bitclock-master = <&sndcpu1>;
> +            frame-master = <&sndcpu1>;
> +
> +            convert-channels = <8>; /* TDM Split */
> +
> +            sndcpu1: cpu@0 {
> +                sound-dai = <&rcar_sound 1>;
> +            };
> +            cpu@1 {
> +                sound-dai = <&rcar_sound 2>;
> +            };
> +            cpu@2 {
> +                sound-dai = <&rcar_sound 3>;
> +            };
> +            cpu@3 {
> +                sound-dai = <&rcar_sound 4>;
> +            };
> +            codec {
> +                mclk-fs = <512>;
> +                prefix = "pcm3168a";
> +                dai-tdm-slot-num = <8>;
> +                sound-dai = <&pcm3168a 0>;
> +            };
> +        };
> +
> +        simple-audio-card,dai-link@2 {
> +            format = "i2s";
> +            bitclock-master = <&sndcpu2>;
> +            frame-master = <&sndcpu2>;
> +
> +            sndcpu2: cpu {
> +                sound-dai = <&rcar_sound 5>;
> +            };
> +            codec {
> +                mclk-fs = <512>;
> +                prefix = "pcm3168a";
> +                sound-dai = <&pcm3168a 1>;
> +            };
> +        };
> +    };
> -- 
> 2.17.1
> 
