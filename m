Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F7BC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF8362098B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgICQpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:45:19 -0400
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:47136 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728145AbgICQpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:45:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 76A551802926E;
        Thu,  3 Sep 2020 16:45:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tree80_350539c270ab
X-Filterd-Recvd-Size: 3682
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu,  3 Sep 2020 16:45:13 +0000 (UTC)
Message-ID: <6b225c10b6c71ffbc79c236b64dcc83fc33cc21b.camel@perches.com>
Subject: Re: [PATCH 2/3] media: Add support for the AM/FM radio chip KT0913
 from KT Micro.
From:   Joe Perches <joe@perches.com>
To:     Santiago Hormazabal <santiagohssl@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 03 Sep 2020 09:45:12 -0700
In-Reply-To: <20200831220601.20794-3-santiagohssl@gmail.com>
References: <20200831220601.20794-1-santiagohssl@gmail.com>
         <20200831220601.20794-3-santiagohssl@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-31 at 19:06 -0300, Santiago Hormazabal wrote:
> This chip requires almost no support components and can used over I2C.
> The driver uses the I2C bus and exposes the controls as a V4L2 radio.
> Tested with a module that contains this chip (from SZZSJDZ.com,
> part number ZJ-801B, even tho the company seems defunct now), and an H2+
> AllWinner SoC running a kernel built off 07d999f of the media_tree.

Thanks.

style trivia:

[]
> diff --git a/drivers/media/radio/radio-kt0913.c b/drivers/media/radio/radio-kt0913.c
[]
> +static const struct reg_sequence kt0913_init_regs_to_defaults[] = {
> +	/* Standby disabled, volume 0dB */
> +	{ KT0913_REG_RXCFG, 0x881f },

These might be more legible on single lines,
ignoring the 80 column limits.

> +	/* FM Channel spacing = 50kHz, Right & Left unmuted */
> +	{ KT0913_REG_SEEK, 0x000b },

etc...

[]

> +static int __kt0913_set_fm_frequency(struct kt0913_device *radio,
> +				     unsigned int frequency)
> +{
> +	return regmap_write(radio->regmap, KT0913_REG_TUNE,
> +		KT0913_TUNE_FMTUNE_ON | (frequency / KT0913_FMCHAN_MUL));

It might be nicer to align multi-line statements to the
open parenthesis.

[]

> +static int __kt0913_set_au_gain(struct kt0913_device *radio, s32 gain)
> +{
> +	switch (gain) {
> +	case 6:
> +		return regmap_update_bits(radio->regmap,
> +			KT0913_REG_AMSYSCFG, KT0913_AMSYSCFG_AU_GAIN_MASK,
> +			KT0913_AMSYSCFG_AU_GAIN_6DB);
> +	case 3:
> +		return regmap_update_bits(radio->regmap,
> +			KT0913_REG_AMSYSCFG, KT0913_AMSYSCFG_AU_GAIN_MASK,
> +			KT0913_AMSYSCFG_AU_GAIN_3DB);
> +	case 0:
> +		return regmap_update_bits(radio->regmap,
> +			KT0913_REG_AMSYSCFG, KT0913_AMSYSCFG_AU_GAIN_MASK,
> +			KT0913_AMSYSCFG_AU_GAIN_0DB);
> +	case -3:
> +		return regmap_update_bits(radio->regmap,
> +			KT0913_REG_AMSYSCFG, KT0913_AMSYSCFG_AU_GAIN_MASK,
> +			KT0913_AMSYSCFG_AU_GAIN_MIN_3DB);
> +	default:
> +		return -EINVAL;
> +	}
> +}

It's generally more legible to write this with an intermediate
variable holding the changed value.  It's also most commonly
smaller object code.

static int __kt0913_set_au_gain(struct kt0913_device *radio, s32 gain)
{
	int val;

	switch (gain) {
	case 6:
		val = KT0913_AMSYSCFG_AU_GAIN_6DB;
		break;
	case 3:
		val = KT0913_AMSYSCFG_AU_GAIN_3DB;
		break;
	case 0:
		val = KT0913_AMSYSCFG_AU_GAIN_0DB;
		break;
	case -3:
		val = KT0913_AMSYSCFG_AU_GAIN_MIN_3DB;
		break;
	default:
		return -EINVAL;
	}

	return regmap_update_bits(radio->regmap, KT0913_REG_AMSYSCFG,
				  KT0913_AMSYSCFG_AU_GAIN_MASK, val);
}


