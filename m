Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7FEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77D8D206DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxdsHDR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgHCIEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHCIEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:04:34 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F08C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 01:04:34 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l6so34392458qkc.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 01:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbxuUNCCa6ME9VA4qtvs1h8FPSgrKaIDkh4zhn6OcKk=;
        b=SxdsHDR/CMqtwMOGCpm+P3ZmX6jQtEE+sdvUP0ggRkCVAptrad6mAJnDn3R9LTlRLT
         RdkJUW0hPtegQ59VFDJxSiqHIyon86tf1OoH6ZO38apbVYGl7Hzl5WE+87btTZ+OkzIJ
         Dy+DcRBoGFUeKXDLw42f2HuNjfHlTHYRzh0GG/g0wLYMZxcsXf5PSo1KI2Hh0b9Oq4gI
         WfE97iOgJjWT0bQ88xWSWT4K5jztgCrJIdFWbhqb77hdt6/GQzarAaNZCH5XcRrzklYF
         k9Mvpyn740h8Ud+tK1xo/yCUrJCKFSFXnTEqu7CL89APAIcYoLuDSFIda0KmwjYN4sWG
         JMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbxuUNCCa6ME9VA4qtvs1h8FPSgrKaIDkh4zhn6OcKk=;
        b=H+sffIXB6eq9ZhkAi84mVp8NZaBrXdthQ4GMUk4sy6r7Dw534ndrc6HaP/mSnfTnND
         jCmvLjhCb61aOOpTSXj7MN92zMihePZeyzsjYmBWauLE8MP+fsN8IseoGgoakVfH/Jq/
         74CZvLyp0fnUkJapYNiYtfMdwnr4OZedxiZ2Pz1encgYWKttSc27hXD+YgVG/xk43JAI
         1XTFRqRvlR0HapiRFP3f4LA2cpTvBOWJwFNcErwsjBdQgImCYXwZIU1H+yoaBtHwScPx
         zxfAHGBkJbvn31DWJwrC5YBvIHsIxVXobfzc2Y+HncrTuLnucKuOyj9xJSPP4ED89VVg
         Jgmw==
X-Gm-Message-State: AOAM532l02BenNKjarBbuQEj/rMtWuTVG3+JQaxCbMj89kkCuosnWzGl
        /1FRtQuqzhi/aypdvhz2zd+HhpYCvsN/qkLe6/0=
X-Google-Smtp-Source: ABdhPJzByIPDL7NYWq8UK3KcJM4lmBsSInj2L7u+lqt9skSqwBP62kAhaIYGIfs2yPZrY2LMIq7cqfATqyDENfdDx18=
X-Received: by 2002:a05:620a:b8d:: with SMTP id k13mr15300055qkh.450.1596441874047;
 Mon, 03 Aug 2020 01:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <1596424674-32127-1-git-send-email-shengjiu.wang@nxp.com> <20200803054037.GA1056@Asurada-Nvidia>
In-Reply-To: <20200803054037.GA1056@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 3 Aug 2020 16:04:23 +0800
Message-ID: <CAA+D8AOGF44UUq=P1S-M5TUwDUaOnqVmHJKPDBM9DAzt1nVzmQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Clean code for synchronize mode
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 1:42 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Aug 03, 2020 at 11:17:54AM +0800, Shengjiu Wang wrote:
> > TX synchronous with RX: The RMR is no need to be changed when
> > Tx is enabled, the other configuration in hw_params() is enough for
>
> Probably you should explain why RMR can be removed, like what
> it really does so as to make it clear that there's no such a
> relationship between RMR and clock generating.
>
> Anyway, this is against the warning comments in the driver:
>         /*
>          * For SAI master mode, when Tx(Rx) sync with Rx(Tx) clock, Rx(Tx) will
>          * generate bclk and frame clock for Tx(Rx), we should set RCR4(TCR4),
>          * RCR5(TCR5) and RMR(TMR) for playback(capture), or there will be sync
>          * error.
>          */
>
> So would need to update it.
>
> > clock generation. The TCSR.TE is no need to enabled when only RX
> > is enabled.
>
> You are correct if there's only RX running without TX joining.
> However, that's something we can't guarantee. Then we'd enable
> TE after RE is enabled, which is against what RM recommends:
>
> # From 54.3.3.1 Synchronous mode in IMX6SXRM
> # If the receiver bit clock and frame sync are to be used by
> # both the transmitter and receiver, it is recommended that
> # the receiver is the last enabled and the first disabled.
>
> I remember I did this "ugly" design by strictly following what
> RM says. If hardware team has updated the RM or removed this
> limitation, please quote in the commit logs.

There is no change in RM and same recommandation.

My change does not violate the RM. The direction which generates
the clock is still last enabled.

>
> > +             if (!sai->synchronous[TX] && sai->synchronous[RX] && !tx) {
> > +                     regmap_update_bits(sai->regmap, FSL_SAI_xCSR((!tx), ofs),
> > +                                        FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
> > +             } else if (!sai->synchronous[RX] && sai->synchronous[TX] && tx) {
> > +                     regmap_update_bits(sai->regmap, FSL_SAI_xCSR((!tx), ofs),
> > +                                        FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
>
> Two identical regmap_update_bits calls -- both on !tx (RX?)
The content for regmap_update_bits is the same, but the precondition
is different.
The first one is for tx=false and enable TCSR.TE. (TX generate clock)
The second one is for tx=true and enable RSCR.RE (RX generate clock)

best regards
wang shengjiu
