Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7CFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F24920786
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598372511;
	bh=PoI9JF5btHk5sSTw0bcJpdoiKWYA/9tmzXn+FNP0WxI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EERE796prbgeRHZtmD8rSJBuWL2nwkYL+xjMRhA18IunD7dAtAit3/vmgjUFtaKHA
	 lxZFvvJJWBXX7uXzyWlZD0M+qy4Tpit0tuoFBiM9mnCiIMIt0UroIvY22Id3z7kHYZ
	 kCbDLp9ue++RaJ1wrtRL3PD9u39xm8170YrEKmr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgHYQVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:21:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgHYQVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:21:25 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF16920866;
        Tue, 25 Aug 2020 16:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598372476;
        bh=PoI9JF5btHk5sSTw0bcJpdoiKWYA/9tmzXn+FNP0WxI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0ufv1R6f98uidMZFudDJ8MTfpbqeHXQrWZGk9/QedpzZuvlM0UPwbt0hgfL48dfqZ
         scO2df1aOvVhBo7drveZAJd3yqqxhWHzwJKtRlQgImvQcFH5NzR/pbmCr6OyNmwcp1
         DhYvoOXlfXSW/00+rsrIqYg5xhe4Vy5Q9zWScBwk=
Received: by mail-oo1-f46.google.com with SMTP id u28so2830810ooe.12;
        Tue, 25 Aug 2020 09:21:15 -0700 (PDT)
X-Gm-Message-State: AOAM531erWDC7PYzJ1+4F/XQpuA0r+Afp3yGEKtGNdsSu1XhqanRX6UC
        uB5EydXsqIwbgosRZMa59/vQCMTxNalkQuichQ==
X-Google-Smtp-Source: ABdhPJzxUfkNriotpHAGv5AQAyBKuk14XowJiqNyCzseH1wr+QZWzE8abqHiFPx6mMQ/UOoJUCGoJ/0E0Jxv6EzFixo=
X-Received: by 2002:a4a:330b:: with SMTP id q11mr7411742ooq.50.1598372475009;
 Tue, 25 Aug 2020 09:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <1598255421-8274-1-git-send-email-sagar.kadam@sifive.com>
 <1598255421-8274-2-git-send-email-sagar.kadam@sifive.com> <20200824173539.GA2939042@bogus>
 <DM6PR13MB3451089239FDA8F87BA6410497570@DM6PR13MB3451.namprd13.prod.outlook.com>
In-Reply-To: <DM6PR13MB3451089239FDA8F87BA6410497570@DM6PR13MB3451.namprd13.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 25 Aug 2020 10:21:03 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+AfvgpXDt4vQmg2UcV7ARYKPw6hxJvuLotJH5xApz6cw@mail.gmail.com>
Message-ID: <CAL_Jsq+AfvgpXDt4vQmg2UcV7ARYKPw6hxJvuLotJH5xApz6cw@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: riscv: sifive-l2-cache: convert bindings
 to json-schema
To:     Sagar Kadam <sagar.kadam@openfive.com>
Cc:     "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        Yash Shah <yash.shah@openfive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 2:47 AM Sagar Kadam <sagar.kadam@openfive.com> wrote:
>
> Hello Rob,
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Monday, August 24, 2020 11:06 PM
> > To: Sagar Kadam <sagar.kadam@openfive.com>
> > Cc: aou@eecs.berkeley.edu; devicetree@vger.kernel.org; Paul Walmsley (
> > Sifive) <paul.walmsley@sifive.com>; robh+dt@kernel.org; Yash Shah
> > <yash.shah@openfive.com>; palmer@dabbelt.com; linux-
> > kernel@vger.kernel.org; linux-riscv@lists.infradead.org
> > Subject: Re: [PATCH 1/1] dt-bindings: riscv: sifive-l2-cache: convert bindings
> > to json-schema
> >
> > [External Email] Do not click links or attachments unless you recognize the
> > sender and know the content is safe
> >
> > On Mon, 24 Aug 2020 13:20:21 +0530, Sagar Kadam wrote:
> > > Convert the device tree bindings for the SiFive's FU540-C000 SoC's L2
> > > Cache controller to YAML format.
> > >
> > > Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
> > > ---
> > >  .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 51 ------------
> > > .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 93
> > > ++++++++++++++++++++++
> > >  2 files changed, 93 insertions(+), 51 deletions(-)  delete mode
> > > 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > >  create mode 100644
> > > Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > >
> >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
>
> I had checked using DT_SCHEMA_FILES option due to which it didn't catch any error on other
> schemas. Without this I could regenerate the error you mentioned.
> I will fix it and update. Sorry for the error.

Update your kernel. DT_SCHEMA_FILES setting no longer matters on
current tree. It only affects 'dtbs_check' now.

Rob
