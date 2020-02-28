Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B81C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49491246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7Eu1OiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgB1G7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:59:37 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:40099 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgB1G7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:59:36 -0500
Received: by mail-qv1-f67.google.com with SMTP id ea1so879012qvb.7;
        Thu, 27 Feb 2020 22:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c6hyoD8zfmHfdvTYAWzSR1LNa/TqLChPyCgM+JY7rNU=;
        b=b7Eu1OiVC2aJps+SPPzuhzjoMER1rqPqa/VvZX29dIM7lR539TlgLa+v3GMZHBRQAZ
         eKx85GB9ht9NaHJX6T/qVdHk4UDIucXgAZ6/aTIRLJejLwfsNbAR9Vmt7SJ502TZP55S
         vEcKJZJKg3jJMQS7ipLyZjqQ8/4Lu6AuWQH60NG0cRLgtElo+6LZM3G144uugbn3JbGw
         aN1TMFE54ow0CXGU/EKnklzGqnXqBKBifIDgNq9Kwdebmqj94szrMo2DFayQGYxP6Nqi
         QjRJlEYjd9OZA88814HnrlYzMwEvul1UBw6wj8PovvjrQe6Y5v7z18EmT/zb+a0ydbDW
         DuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6hyoD8zfmHfdvTYAWzSR1LNa/TqLChPyCgM+JY7rNU=;
        b=Z3DhWfVEArlGbA68QPpjFWUD4tB3U2kruTEfR4KKnEmY/+svqnBu/fZUSHKtDGK853
         PkuRv42XHtgn6uGsP8Mti72HoxcYWBJqMs6JIRCA02wdQ7o/WSe2FIQVaqq8bEwX65nt
         jveRJ8eh5YvYPP2K5rTqod9xLAjNWYbW500XzD8Hzk2vPl74KF+R+wPlqEASGOCxF0kF
         VrHtUdOQlQcPBf03B6sIuskdAmkTbPIsAd/7Azk1IPzbYKrR7lGD4Ejyr+Ko5QTwLqlH
         w3JApIhm4dmQiNR2g4OQ7cvPrGt+0atiZNgw+7VeMLx7V0uYgZTkdnn1PADwItwPEA6Q
         FU0Q==
X-Gm-Message-State: APjAAAV+Cs0bBvsCCOqv2oja6Te3LLaft73jw1GZQGb67gubVsbNHYf7
        cNYfUYBBax3OhBO7r1qM5zsjU1fRTp6SBgy7QtM=
X-Google-Smtp-Source: APXvYqx4Mglpr2YgBhx2B/bWVdjJWIXLSKGQv1V/Zpmwn53wJsLruUiOcUOlVokZfkaeflXerQVi8nrguOcbktfRu5Y=
X-Received: by 2002:ad4:52eb:: with SMTP id p11mr2292548qvu.211.1582873174403;
 Thu, 27 Feb 2020 22:59:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582770784.git.shengjiu.wang@nxp.com> <d9aebf5ef9a92623db10dc537161b3ecdb1d8b18.1582770784.git.shengjiu.wang@nxp.com>
 <20200227183926.GA456@NICOLINC-LT.nvidia.com>
In-Reply-To: <20200227183926.GA456@NICOLINC-LT.nvidia.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 28 Feb 2020 14:59:23 +0800
Message-ID: <CAA+D8ANFN9irpX25VnKYDm3cfU16ht7bcB4-zjDOyHMj8NM9Qw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ASoC: fsl_asrc: Move common definition to fsl_asrc_common
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 2:41 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Thu, Feb 27, 2020 at 10:41:56AM +0800, Shengjiu Wang wrote:
> > There is a new ASRC included in i.MX serial platform, there
> > are some common definition can be shared with each other.
> > So move the common definition to a separate header file.
> >
> > And add fsl_asrc_pair_internal and fsl_asrc_internal for
> > the variable specific for the module, which can be used
> > internally.
>
> I think we can just call it "priv", instead of "internal", since
> it's passed by the "void *private" pointer.
>
> And it'd be nicer to have an extra preparational patch to rename
> existing "struct fsl_asrc *asrc_priv" to "struct fsl_asrc *asrc".
>
> Something like:
> struct fsl_asrc *asrc = yyyy;
> struct fsl_asrc_pair *pair = xxxx;
> struct fsl_asrc_priv *asrc_priv = asrc->private;
> struct fsl_asrc_pair_priv *pair_priv = pair->private;
>
> Thanks
> ------
>
ok, will change it.

best regards
wang shengjiu
