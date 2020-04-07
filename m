Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1568C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E2D20692
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtZs2j/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgDGA3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:29:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37599 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgDGA3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:29:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id r4so875782pgg.4;
        Mon, 06 Apr 2020 17:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hqwa+hUekQq3MYYw51APHLwXOUrFBa1sM5+b28OQ11o=;
        b=BtZs2j/dnw2PngLknCmZUjx56rNiQyDoDmVAOgZQjjRFRVxLZmw40H/jFGMoJZu00W
         LLkqlHs1rwByTmWTrV9dylFtIoPG+wYrFTNW58bNW7CX3M4zii4/8arExgdhP2ic/PTf
         WlMBZCjZHDb/BccMKoa4uwTN/Apkz9UcGUQFfRGmkWHUDDSkqkC2cEUyLY1KFcdwEZ94
         aoNc4cygUuxfFDA1FlbDFkkIC4yCB4kJuh2R4uoxmaVAYdTyERGIL9vfLA3tFkUHINdA
         y0q7KIHg48OMMq82+/ct57yUkpHZ+qahZDz6d7pgpWUvQ03wpYntCF+gpzk4jkfeoHU3
         wBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hqwa+hUekQq3MYYw51APHLwXOUrFBa1sM5+b28OQ11o=;
        b=JvnNe+WNSlpivPBroaGVkBfPXgMmWZFih3lL9beZZykCGe1+/mzFEt5wXP+CLWuK9J
         3/5iIUBJEa6OsfJ3OtnsNgwd2JK2Cd44YZ+uZev5SBxuFiFnY2d9F2hzb+Z4p5u3Qvoa
         BJHRFWc6zMZGZz418fcKSvPLiOYKK/opknCmDSbs6++HDnQU2dWTsXjyOsWMmspg0ba0
         hqDWxr7vUS8Xkl5FnGzw0iiMv/64zb452wtLyo6N7lo4dsyobYRVVmz17ubpXRE4sLrU
         3Dzk0TBBRuWLz2Cp5uOJzOzKOS1mI9hC+2ZLBBZox4U9Wl60HMXuYeI6xOTIEHBgrFbQ
         3buw==
X-Gm-Message-State: AGi0PuZ1Iwr5aD2V8imbG93P7xXUcs0PXKN+51Yd+iqPSLMFS8w7pzoe
        ZkgF3vTYe6OmvhZutztZRT4=
X-Google-Smtp-Source: APiQypL4QBLHOntUiX150El6Uq7vgM86HJSiaP4ts+25+U4uWp6LAmAo44aRKGMV6U/ne7TLrZMjQw==
X-Received: by 2002:aa7:97a7:: with SMTP id d7mr13246pfq.194.1586219354103;
        Mon, 06 Apr 2020 17:29:14 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id s76sm11686055pgc.64.2020.04.06.17.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 17:29:13 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:29:18 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 7/7] ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers
Message-ID: <20200407002918.GC20945@Asurada-Nvidia.nvidia.com>
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
 <3b5abe538eb293be9e82c077379d63487f71b7c6.1585726761.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b5abe538eb293be9e82c077379d63487f71b7c6.1585726761.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 04:45:40PM +0800, Shengjiu Wang wrote:
> EASRC (Enhanced Asynchronous Sample Rate Converter) is a new IP module
> found on i.MX8MN. It is different with old ASRC module.
> 
> The primary features for the EASRC are as follows:
> - 4 Contexts - groups of channels with an independent time base
> - Fully independent and concurrent context control
> - Simultaneous processing of up to 32 audio channels
> - Programmable filter charachteristics for each context
> - 32, 24, 20, and 16-bit fixed point audio sample support
> - 32-bit floating point audio sample support
> - 8kHz to 384kHz sample rate
> - 1/16 to 8x sample rate conversion ratio
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>

Overall, looks good to me.

Please add:
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
> +static int fsl_easrc_normalize_filter(struct fsl_asrc *easrc,

> +	 * If exponent is zero (value == 0), or 7ff (value == NaNs)
[...]
> +	if (exp == 0 || exp == 0x7ff) {
[...]
> +	if ((shift > 0 && exp >= 2047) ||
> +	    (shift < 0 && exp <= 0)) {

Could fit into one line, and would be probably nicer to re-use
"0x7ff" matching previous places, instead of "2047".
