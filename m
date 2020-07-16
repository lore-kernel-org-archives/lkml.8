Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDE6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0AFE2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnwxWB5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGPKNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgGPKND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:13:03 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE25C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 03:13:03 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id l1so5413277ioh.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 03:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UVSUvMmGFLUkKum7MuCJsKB4zScIvSW6XBRGHMBXovI=;
        b=nnwxWB5nbEedMdL5kQECjnAUyHVcThBpkh6AyS0YxPd+lLGuMcdd6ft4Xg2OMx30Ln
         KBjZzmMZkOmtBTJo1yCIriviCdDdEDp7J7WtdD1mvH7IEZaSjkjYnPF6FS2UmIO9flBg
         F7athv29zSKXA9nurBHOa8Plv/B++y7PnIi0rBac5qGardrV4PM8GGF0zRCnUBGExE/y
         k+urYbu5ntw4oFyBiU42isFOleRMLPe7fi2D5elIJ9/rrtaS18g+Aawd2BOQRVaOD80b
         lujgb33HFwX6FX1Egb6uByYdqNqs9gcY26XuWMrMtW6i1WrfaeFKHeyLH43wy8+15r3C
         HduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UVSUvMmGFLUkKum7MuCJsKB4zScIvSW6XBRGHMBXovI=;
        b=h5P0kXO4egHdsPth/8yDYPuZSaNPytk5vMyUiNexu1fQnQ4pX/fNZe9vAbAxsbdhmT
         Ep6+z7QbuusYMfC39OJokvVLV2f+1qf/hkxDzgIwAKqQ97JF9BRzuzN5zn8jdp/gYJSC
         vFYN0PYqnQ7yO6iFXpmjlWfttbTp6GCLFls3muK98A+2k8xx7+PN2lYVe7Ly291b0PBl
         JgRTvNYxj0WDJWcJuGBY8bHqkLHdDj837if7DO2oHBbrl8hNfSk1zjA8Sc16ymDKHRLA
         vrUo68g+t+bQw9zNlZbYPY7ehWtVDsbOsChPYaR2kySlDkPGazUUA9vGXXOBq3gaO+ni
         QGsQ==
X-Gm-Message-State: AOAM530ZOg5rrZ8rzMD7xockMe7pmyMitXeypresuD8n0VLSpX018E/i
        0FBnN3OwmBO6n2axsl/4g2mj0Eg1UqPGhY0wOvE=
X-Google-Smtp-Source: ABdhPJwZ7zUlj1sz0Az8nGVh3eFi91mGEmmIlOpREI9vwpsWQttiLfwEFzvS3P2giktGt3C6aCmxYXO/tcvR/Ws0G8g=
X-Received: by 2002:a05:6638:240f:: with SMTP id z15mr4300797jat.76.1594894382841;
 Thu, 16 Jul 2020 03:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <1594117856-14343-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594117856-14343-2-git-send-email-gene.chen.richtek@gmail.com>
 <b9540dc6-4d43-45e4-8878-15d2df24a268@gmail.com> <20200713065110.GB3500@dell>
 <CAE+NS36uRRqHetQE5QVJ94WX4g7CdQzvD-0VOnLfKAbqdHs3Sg@mail.gmail.com> <20200713104816.GD3500@dell>
In-Reply-To: <20200713104816.GD3500@dell>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Thu, 16 Jul 2020 18:12:51 +0800
Message-ID: <CAE+NS36EEVb0JLDuZ_0tyocu7PeQSpyNGOWm-jWLW2kZFD=jYg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mfd: mt6360: Refactor and fix code style
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B47=E6=9C=8813=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:48=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 13 Jul 2020, Gene Chen wrote:
>
> > Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B47=E6=9C=8813=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=882:51=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Fri, 10 Jul 2020, Matthias Brugger wrote:
> > >
> > > >
> > > >
> > > > On 07/07/2020 12:30, Gene Chen wrote:
> > > > > From: Gene Chen <gene_chen@richtek.com>
> > > > >
> > > > > Rearrange include file.
> > > > > Remove brackets around raw numbers.
> > > > > Indicate sub-dev compatible name by using "-"
> > > > > Combine mt6360 pmic/ldo resouces into mt6360 regulator resources.
> > > > > Rename mt6360_pmu_data by mt6360_data.
> > > > > Rename mt6360_pmu by mt6360.
> > > >
> > > > That seems like a lot of cosmetics. Why is this needed?
> > > > If you think that's needed it should be split up in different commi=
ts, each
> > > > explaining in the commit message why you do that.
> > >
> > > Agreed.  This set is still not broken up enough.
> > >
> > > Please place each logical change into its own patch for review.
> > >
> >
> > 1. Rearrange include file.
> > After check serveral file about coding style, include file seems sort
> > by architecture, not by alphabet
> > 2. Remove brackets around raw numbers.
> > Due to redundant brackets, another reviewer recommended to delete them.
> > 3. Indicate sub-dev compatible name by using "-"
> > Suggestion by Lees when review mfd binding document.
> > 4. Combine mt6360 pmic/ldo resouces into mt6360 regulator resources.
> > Simplify the similar resources object.
> > 5. Rename mt6360_pmu_data by mt6360_data.
> > Not only include pmu part, but also entire MT6360 IC.
> > 6. Rename mt6360_pmu by mt6360.
> > Same reason as above.
> >
> > We try to make code more simpler and easier to understand
> > We can also discard changes if patch 1,2,4,5,6 doesn't make any differe=
nce.
>
> I'm not sure what you're trying to say.
>
> Please place each on of these changes into their own patch.
>

I list all topic and reason why we want to modify.
Before split into patches, can we discuss which topic reviewer can accept?
or I need fix first?

> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
