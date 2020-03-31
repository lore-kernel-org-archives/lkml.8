Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B147C2D0F2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD0A2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDQqfzOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgCaMmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:42:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52899 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730671AbgCaMmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 08:42:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id 11so1162369wmi.2;
        Tue, 31 Mar 2020 05:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vcz0g72rifXSLeWaNnOdJDDcN3baXq4Yt3Uy827zZ2Y=;
        b=pDQqfzOTiRQ7tL7td5hE81Qm/6VdRKt++vY5nVx42+C+gwdAxA8zZhbXiVzDg1B19m
         dLAGEfr8aD2VgGiiu4LQLTz7dxR533Oy/5VawYbQIEEe7Ln9dxSfycYxUoFl+HsnFzeN
         YfxXV6LN3qO0EEAKboOZ577a0Pnb9lepWu3XZeCe5RVq6i8+cqw76YPfOqYPC3Bb+N8N
         ug9J4xmDmfX0BEwhK0Eh9/c9/ZQGM9U9J/3FRHNF7zdMm9qpfLR79fcCsH5VGCvByR/0
         WRwSNf5s4EZqq4EcMWo/Qyhp3SHJg6G15DCxJvS8ft8WPAp9z8HLH6FI86zy+kaMVJYg
         cf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcz0g72rifXSLeWaNnOdJDDcN3baXq4Yt3Uy827zZ2Y=;
        b=A2bgOgthZOgN8Rr4wJCFlynk/5z4LfICtL7hlYVJlCl4e77zfu9sImhTTdz4iCVIQ6
         Pay/kLjYr/gfoEdMZuNFN8U5/TRCRDBeKUEbFvqdsFdHOJS1u48OsOUI+6KRSv6s6q+A
         5i7LcFi5zaSIoyidsmveb0SZiWdta7Sfedy2i+BEr03kohYhU9AFEp9Dqiye/vpTaU8Y
         VzXjVE+VC3xSXRZNMTKsXa0VqT1vRDzw9Vn+RYElI9yGPBI/08O6/epqG3ruSalc2xoP
         tqUgyo4YFPsg9bhjxH7USVmdV+1R4idVo6iNyuLD+mKGsNcQN9rNH7wH+3ZwbZPaU89S
         TfkA==
X-Gm-Message-State: ANhLgQ32W8zcslja3t0zZnezWmOh9UbH1n4MDGVtUU8iUpETI+beNtXX
        c8lZqqmk9bDFMScUhyq4Ofum7Hiy95xIh4Ze5GM=
X-Google-Smtp-Source: ADFU+vv3upvTMzc++M5CXYzCHX8rdxvQ44BYLbC/mPwEbu0+mM3gc1laM5QzlJ1lMnw37DBAu77fn+1n/4pcdPgbFbI=
X-Received: by 2002:a1c:c3c3:: with SMTP id t186mr3447283wmf.118.1585658529082;
 Tue, 31 Mar 2020 05:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200319194957.9569-1-daniel.baluta@oss.nxp.com>
 <20200319194957.9569-3-daniel.baluta@oss.nxp.com> <20200331122540.GD4802@sirena.org.uk>
In-Reply-To: <20200331122540.GD4802@sirena.org.uk>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 31 Mar 2020 15:41:57 +0300
Message-ID: <CAEnQRZD_Hjp2vsouUURuZ_zgAnnUXynq_L5YgCZAN4pFkcmGWQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] ASoC: SOF: imx: fix undefined reference issue
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        kai.vehmanen@linux.intel.com, dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Yue Haibing <yuehaibing@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sound-open-firmware@alsa-project.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 3:25 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Mar 19, 2020 at 09:49:54PM +0200, Daniel Baluta wrote:
> > From: Daniel Baluta <daniel.baluta@nxp.com>
>
> > Fixes: f9ad75468453 ("ASoC: SOF: imx: fix reverse CONFIG_SND_SOC_SOF_OF
> > dependency")
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>
> This has you as the author but you list a signoff by Pierre before you?

Patch was initially designed by Pierre [1] when in the internal SOF
tree we already had the I.MX8M patches.
Whereas, in the current patch series I firstly fix the i.MX8 then I
add support for i.MX8M.

Should I go back and put Pierre as original author?

[1] https://github.com/thesofproject/linux/commit/0c7dcfee80d96a8e75684178ab738c1e6175c386
