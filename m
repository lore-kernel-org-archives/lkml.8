Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061B5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 10:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C967F2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 10:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP3joG2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbgGaKjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 06:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732397AbgGaKjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 06:39:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E48C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 03:39:00 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w14so2100614ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 03:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z79UlB74SFDGkVx/wf5z/xmQkiHttzepy/SROQkunds=;
        b=NP3joG2eyPBwdPuBC5qMi8kkL6strW9nGbsOxkdGKVfI7BxLID1cEUkgnP+mlCWBxt
         Oi+nhKOnN8wnmJSr3M2SroeZ9Qt4xUC+AT9vZKu6L6+68tugEIhkSESjZv69Xj1qQN8a
         9auoue2YYBt5pDKoWjt7M0NeMZV7aSW696PIHQr9CV4Hc1DxV6ZYT+xu+nc71zXevASU
         KVYQObh7ib1jYD4VBS/DMEGRCtRJ+v86MVx8LN2D2U8gsp6Sv3pAR4dktVdayVwiZu8s
         QefOUUQIIjdbW9tb5HPWFerVWpd0bpdfcg1GsRWhLBRExqnXgLZkRubdIOEvxay8il3Q
         Rc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z79UlB74SFDGkVx/wf5z/xmQkiHttzepy/SROQkunds=;
        b=t/yJRznQPsz13vLUtQFUTJsrLmAusn4BYSIaV2TdfpKvExXf0yY5D6VZ4H5f0QDNQd
         MkJI4g7ZJRCdV5A7lpUD6unwB4/FCZSyftbI2HTCPPnMC8lfGQXy28zqKsP/zlGLWo0u
         gJTq4gAOT/kceyCpRS+Wkn0mA5cGE8f9VmnmeiUtoISy7pocPt78nY6LEhhUFxzbIPs3
         AQRceUVeFYpMfJo3+4hxGwYx+cejnAQnV5TOvnzbezOkROR85m0ePWsUkGMmAifokeZ4
         5BrhfC8Det+KyXMcIBG4s3CtNgBniEjU1QyrG+4LpDE77acfzECNudxP29QRBVP6ZtG5
         o1ww==
X-Gm-Message-State: AOAM530Ixxwkrqhb4wGOzZ44eQnccK2m4gX2+Prb28q2D/h4e8oOrCGu
        8y0kOLbnTAM9MhBgfDwsjVByEgMBIVpRRQVx/5s=
X-Google-Smtp-Source: ABdhPJyTao9Lg7MGHS3w6J9lpe8D0qlnuOVVRbxEmgjJQIelAXZ79/aJ1SXFA2+uNtLKj3VoeR2KEKtfcSTSVW8aM3o=
X-Received: by 2002:a2e:5cc9:: with SMTP id q192mr1646387ljb.452.1596191937433;
 Fri, 31 Jul 2020 03:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <1596176895-28724-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1596176895-28724-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 31 Jul 2020 07:38:46 -0300
Message-ID: <CAOMZO5C89emJ91wZsWe-APJ3OpzX=3+jHx6DAEU5kQjNLLSc4Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix value of FSL_SAI_CR1_RFW_MASK
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Fri, Jul 31, 2020 at 3:32 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> The fifo_depth is 64 on i.MX8QM/i.MX8QXP, 128 on i.MX8MQ, 16 on
> i.MX7ULP.
>
> Original FSL_SAI_CR1_RFW_MASK value 0x1F is not suitable for
> these platform, the FIFO watermark mask should be updated
> according to the fifo_depth.
>
> Fixes: a860fac42097 ("ASoC: fsl_sai: Add support for imx7ulp/imx8mq")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
