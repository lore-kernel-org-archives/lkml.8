Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4DCC3404C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC72207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoN26OTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgBRWyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 17:54:46 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37735 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgBRWyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:54:45 -0500
Received: by mail-pj1-f68.google.com with SMTP id m13so1652604pjb.2;
        Tue, 18 Feb 2020 14:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DLcO2DKWECMZLG1IHbpSAq+iosbKYeAAnLf8zJftE2I=;
        b=RoN26OTSoD8xQPX8Ejb8azpPGaUfxPDvq/VvNyKPUXC02u6KESX4+KewWJ0C3B6BvY
         Qe1m2IweSiLDlgWK90aBCD09mUr1arr5/A8ACf2W+VfYSIlOLRZM9GnqkYCH1Hk9Agoj
         +PNGQbijasxynJv26p7N5IwUoW2ory/yMjEaGzcnvWGXZ9Ty/Y4qskG2oDvwhP9uGs4U
         7/Vzvi4mr8AnPcRhPfuz+jTCNtKEXjzqK2+uZ5DD5xXRui0DuhY8RuP2kRy9664Z9xkn
         Ajfm5wDf5zrloWSVfa/c1AYPhfG8K/6YjkD/0dfA1novKrcoPB8Ky47OKjgh6sc2gsXF
         GXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DLcO2DKWECMZLG1IHbpSAq+iosbKYeAAnLf8zJftE2I=;
        b=MbT2RWCqmBBkJ42x+7Teut1a4S/gQhjz4Yunw2/mtV1WOdKpekVBIX8KbXwzy2D5fW
         HAl6bDtDRet/MKxIn+VvPDw9oeb0pVVS9+EJKN4eTWX5ih5DS4PdJllXmzf9T5lRJxXb
         inge/9zLoa5Obezo9N0H88dtZ9uCt12vMaZ+Lrm8Y6+5mWOKNurd1qSV5SaZJ9XkP8EQ
         f2o1bwT3fdMA9y+bUKx0TiG/NBmZ6lsbRPS5UXsyfi8JbP4Y6UDtKciZm5LhIE7FJfKS
         Nztr9uHgEgvqfn+aSp/g1N8rATrYWm3eP5ghbnnjGIlLD9BPuoEiTuec7YJts67XBPOy
         BGLw==
X-Gm-Message-State: APjAAAWjEZ7efmpTPbZQaagIqS5Ib4x1dEotrUcI3cFMKdA3Rzbx8Opn
        uqrJTH+zmDzkqMnGTzYFe0w=
X-Google-Smtp-Source: APXvYqxKyKfvB6gUIxasXk+3gpb22DtW5pbbJzCinqep7l23wSdhHK6tbwkFTvHB8sVofima6J/cHw==
X-Received: by 2002:a17:90a:cc16:: with SMTP id b22mr5326984pju.65.1582066485149;
        Tue, 18 Feb 2020 14:54:45 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id i2sm4403pjs.21.2020.02.18.14.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 14:54:45 -0800 (PST)
Date:   Tue, 18 Feb 2020 14:54:54 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ASoC: dt-bindings: fsl_easrc: Add document for
 EASRC
Message-ID: <20200218225454.GA32720@Asurada-Nvidia.nvidia.com>
References: <cover.1582007379.git.shengjiu.wang@nxp.com>
 <a02af544c73914fe3a5ab2f35eb237ef68ee29e7.1582007379.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a02af544c73914fe3a5ab2f35eb237ef68ee29e7.1582007379.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 02:39:36PM +0800, Shengjiu Wang wrote:
> EASRC (Enhanced Asynchronous Sample Rate Converter) is a new
> IP module found on i.MX8MN.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,easrc.txt   | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.txt b/Documentation/devicetree/bindings/sound/fsl,easrc.txt
> new file mode 100644
> index 000000000000..0e8153165e3b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,easrc.txt
> @@ -0,0 +1,57 @@
> +NXP Asynchronous Sample Rate Converter (ASRC) Controller

Missing "Enhanced", I guess.

And "ASRC" => "EASRC"

> +The Asynchronous Sample Rate Converter (ASRC) converts the sampling rate of a

Ditto

> +signal associated with an input clock into a signal associated with a different
> +output clock. The driver currently works as a Front End of DPCM with other Back
> +Ends Audio controller such as ESAI, SSI and SAI. It has four context to support

"context" => "contexts"

Btw, what's the definition of this "context"?

And, is SSI still available on imx8mn?
