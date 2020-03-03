Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDA1C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E6A20838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583243194;
	bh=vGEryNKJXcCT8a512mUV3y5gUnsXj9RciNHteo1Sa94=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=l1f3hXKIkRViS94HoSJhfHUvLNb5BJdAKAPXw8fdwvNq4cN1DrrivZM8kWxbrbAGd
	 eqzsuZO6qdohJg6OODrxqZ2U3Qre2llK1XYE9hgMA1fHr45GyM7cMiPK0WoEuqZm0v
	 EE7N/5eHKoRjXx8XeCGBEF00fMgwr/Ip9pij1Oww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgCCNqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:46:32 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:38270 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgCCNqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:46:32 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 023DkNuj001527;
        Tue, 3 Mar 2020 22:46:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 023DkNuj001527
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583243184;
        bh=I0dB0E0Ppgz9TfglvmGFKRBJvWtxB1020ETEw+zES8k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r8faXJ+BlS6Qk+t3Ed1/ouhSRxGoBFaiF3DCRJ25taCMU7nJDnr+svsg8p3eaXn2r
         g9BYXlTOmA5MbqSfx+e4QRvyFdJQwqyaVx3+h/2O4V4ZhgE0uRpdd0xQq8iqgr5Dn/
         moY4CpHlo+ip6adRt843TeyP2hQU+psGsVqQLeMiov/uEweC4zIDD+SfU1Yo+CTK3W
         LUHPuOKsZE25mE+t/IkFyBA+dQDZdrz6VB1JBbSC5Q89dSDl6Cgikzf09kYKLQGp+H
         6ZgiwtdWDmdQaAU/Z/qcGoo4dmQeQ2VRYlGEiWFJV7qX4M9LNVCzK3eg42X74ppr8W
         7g9nY8pNNlmUw==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id w142so2352836vsw.9;
        Tue, 03 Mar 2020 05:46:24 -0800 (PST)
X-Gm-Message-State: ANhLgQ0xII2jz37IHuddeWaFM0hKABhW8mm+Oz4AyHMpqGAsRH769vMz
        XSTMcEzRYvvG3vDNS3XNSdvuWVT380W+vpHclik=
X-Google-Smtp-Source: ADFU+vsjmSig+hI85BfC9o+2I1Nt3rsoH9lkQysVJ+WWf8bKa68CI2DD2CprMOpxEX7H5tqzk/VJC2tBrHCTfTlcbI0=
X-Received: by 2002:a67:bc0c:: with SMTP id t12mr2269458vsn.215.1583243183172;
 Tue, 03 Mar 2020 05:46:23 -0800 (PST)
MIME-Version: 1.0
References: <20200229003731.2728-1-robh@kernel.org> <CAK7LNAQUbfVvYYSuMNnB2OyNbuYZkzY0gsKRybe-0P9GuYZN2w@mail.gmail.com>
 <CAL_JsqLqZYZXGg8-FnoV8EFKSK8moQjEWe93+FazEbh9GTxQpw@mail.gmail.com>
In-Reply-To: <CAL_JsqLqZYZXGg8-FnoV8EFKSK8moQjEWe93+FazEbh9GTxQpw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 3 Mar 2020 22:45:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNATr5TX+CnxHhoa5qcNes6mTp9h0TJ_5=0fGzzq3M8FKxg@mail.gmail.com>
Message-ID: <CAK7LNATr5TX+CnxHhoa5qcNes6mTp9h0TJ_5=0fGzzq3M8FKxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: Always validate DT binding examples
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 1:06 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Feb 28, 2020 at 10:25 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Hi Rob,
> >
> > On Sat, Feb 29, 2020 at 9:37 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > Most folks only run dt_binding_check on the single schema they care about
> > > by setting DT_SCHEMA_FILES. That means example is only checked against
> > > that one schema which is not always sufficient.
> > >
> > > Let's address this by splitting processed-schema.yaml into 2 files: one
> > > that's always all schemas for the examples and one that's just the schema
> > > in DT_SCHEMA_FILES for dtbs.
> > >
> > > Cc: Michal Marek <michal.lkml@markovi.net>
> > > Cc: linux-kbuild@vger.kernel.org
> > > Co-developed-by: Masahiro Yamada <masahiroy@kernel.org>
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > > Masahiro, given you pretty much re-wrote this, I added you as
> > > Co-developed-by.
> >
> >
> >
> > I can apply both to my kbuild tree.
>
> Please apply to your tree.


Done.
Thanks.


-- 
Best Regards
Masahiro Yamada
