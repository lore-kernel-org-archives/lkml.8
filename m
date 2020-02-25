Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4649FC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F342176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5gkxScV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgBYN3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 08:29:16 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38127 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBYN3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:29:16 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so9754895lfm.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 05:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5YGUk8kDLWUcN6FO7jMtSAEeHUxuzzxjpTLzQYYweo=;
        b=p5gkxScVwAoyrKk4a4rxpdI8CwjXi3s/gwjb96f6Wq8DMh7+ckHj9cHqtX2Xmvz4PC
         zFcgBUKSY4FDQwgiUQ1XvB35OKkR6W+nk+ZtQFq+vso7pZIo6d8loNtErwQb9q7kG8Kq
         t5+fPBMlWvWaDtcGkjDyWNc5r+VPSLrGb3Y/PgD7A+08ySrZv+T/s3Jpy8HTfsIXKRT3
         9ulKYZZOdKaOtTytuTsDglE2qRWURjKzH8/TJGNqNerCXFTfAaczzTneYndUttFmAj6r
         n0eCaa+1Lcyvkm5CoaTn1hZaw0uCMlq+ojmfQ03coOvxRxDckBLwgAAnOb/Sp9x0MF0l
         zS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5YGUk8kDLWUcN6FO7jMtSAEeHUxuzzxjpTLzQYYweo=;
        b=ptA/RN8QWr5z9BDgryINaD8tvo2Y0AMuljspUkKtfMbgcSmPlvVDvT3bb5JPHDPop8
         x0nR24yDI7PzJFfnAM1H46SQ92to8WvObNn7Cr4dk/FOdMOnW7gEpDWKXzY+eWc93lT2
         HnSWfI7mYI61tUILZrVbacaPzwXoiOtkGMAtzgMeb+gpIJTs46Po6NOPLJlYLqtDPk6h
         NvRg5SCcwIkGwX6aaymxG84TxnkCzN+kwra/Gg2qIbjANMuk4qtTcJ7GhSs1Hy77OEQ/
         lub/IUpp6lRrMGTasUp1/XsgqSrbd8qU5+pd1kF7bfm7+jJHaNR2XX+HIqy6wAi7zTHv
         sE0w==
X-Gm-Message-State: APjAAAXD+FE7NhbjIwKSA/adBQx16cWDjTK/Uy3PHKzk+mea52dudJ48
        Kd703r+X45z2yS3PTtyiuKqn+YmhYXBweKyaoEU=
X-Google-Smtp-Source: APXvYqw3oHtn5KjqRvE1g+6UE2ciKFKZF1TT8oRFN2lxJXdMFSeR/r0UOh+jyirs0SD3FwQmtigjkFxNiZtJu4xI81k=
X-Received: by 2002:a05:6512:10d4:: with SMTP id k20mr14161107lfg.70.1582637353133;
 Tue, 25 Feb 2020 05:29:13 -0800 (PST)
MIME-Version: 1.0
References: <20200128144707.21833-1-daniel.baluta@oss.nxp.com>
In-Reply-To: <20200128144707.21833-1-daniel.baluta@oss.nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 25 Feb 2020 10:29:03 -0300
Message-ID: <CAOMZO5CKda0TEai5CDdkmADNSMnn3WvY_xD42a=PMpzUFO4Z-w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl: Add generic CPU DAI driver
To:     "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 11:47 AM Daniel Baluta (OSS)
<daniel.baluta@oss.nxp.com> wrote:

> +static struct snd_soc_dai_driver fsl_esai_dai = {
> +       .name = "esai0",
> +};
> +
> +static struct snd_soc_dai_driver fsl_sai_dai = {
> +       .name = "sai1",

So the name will be hardcoded to sai1 even if SAI2, SAI3, etc is used?
