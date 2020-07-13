Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71494C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DCA3206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AG4m+3cV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgGMDBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 23:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGMDBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:01:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7D1C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 20:01:03 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u185so5392742pfu.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 20:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GV4IomG6qj4F1GMNLsaNJW9pUDWfsK4KtOliKaa9r4M=;
        b=AG4m+3cVsDUZHrXHV7Dg997rQayoox9XRupkxW5sz3TXp1nMng3UKLPXZxaL9cvZUg
         WRGwnE0EQkpAm7E2PQHh7TGOMcrfswpGcx3ai4Vma1rkZ+CQsBLNa0GxwWCRJxqY7DL5
         fwKVtyZaY0IJVisG8EOAq6xLLp931xNoBm+0+h1qZ/F01pydZ2hIAJM7QTK34uCBY0hM
         OLlSAbuiGqapTUjqJJOm1WE5MJr8o2V/xYiiVgIHCVKALHnGPz6xBXvHsxw62dqtVor/
         OyxPXIXMc0p09EvsK5sA+zicimEm+TMI34/RgbC6r2AQ+OAb6JWSUaNkoFBVueHH6tlA
         MeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GV4IomG6qj4F1GMNLsaNJW9pUDWfsK4KtOliKaa9r4M=;
        b=gVLych7q/YOa9TYJO9u5WW5E4cytkyttqe4EZ0EmnmyNKZrn+W5EPCSiNH+Ai9Xy3d
         WYjao75yRDR7JM4TnsyaUJf4CcD/6N+Mgz+doe+LoXrPGwJzKisrt37gSS0BtL35S8Cz
         TLrP17q+RFbyP0Q0zGn0Kn0JCW2KMAGNQ4ptMFUcviokzDO+Uvx0lw0kxt4b8Nj0WwRL
         H2zvg9G0NHbqz7v1xGYDrS9EZPrFfongrhribKNEPvo0VemEF1zAsPK2jEa/Za8SMjsY
         Rju+MZzi3LNI9knLO9y8KCivzNpk2w2WJfDlvk7gN4zyUOq730xbHDaBFJBgYtx4Z1g1
         GiRQ==
X-Gm-Message-State: AOAM530/KXBXJ7tQeYLhwPXdCDy/EgeMlYFAGtq6thevSMGYKTfPgKO7
        4bJeE/zD+yA21O5lsrLW8kgG
X-Google-Smtp-Source: ABdhPJy+HlXUxaa/u4zIP4jzIn73PFiw/wD7SgvPDfi3JVrz26O53QmdcVR5DxpZn5oiTEhi+yyPug==
X-Received: by 2002:a63:7246:: with SMTP id c6mr67503848pgn.422.1594609262825;
        Sun, 12 Jul 2020 20:01:02 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:985:5688:92a:5a4d:636b:c45f])
        by smtp.gmail.com with ESMTPSA id b128sm11834488pfg.114.2020.07.12.20.00.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Jul 2020 20:01:01 -0700 (PDT)
Date:   Mon, 13 Jul 2020 08:30:56 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Tomer <amittomer25@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 10/10] arm64: dts: actions: Add uSD support for
 Cubieboard7
Message-ID: <20200713030055.GA2978@Mani-XPS-13-9360>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
 <1593701576-28580-11-git-send-email-amittomer25@gmail.com>
 <20200712173044.GL6110@Mani-XPS-13-9360>
 <CABHD4K8+cZMwA=pQx4Gvv5Z4xLof8Ln6fUNrB0=-SS2M_0_3aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABHD4K8+cZMwA=pQx4Gvv5Z4xLof8Ln6fUNrB0=-SS2M_0_3aw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 12:15:28AM +0530, Amit Tomer wrote:
> Hi,
> 
> On Sun, Jul 12, 2020 at 11:00 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Thu, Jul 02, 2020 at 08:22:56PM +0530, Amit Singh Tomar wrote:
> > > This commit adds uSD support for Cubieboard7 board based on Actions Semi
> > > S700 SoC. SD0 is connected to uSD slot. Since there is no PMIC support
> > > added yet, fixed regulator has been used as a regulator node.
> > >
> > > Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
> > > ---
> > > Changes since v4:
> > >       * No change.
> > > Changes since v3:
> > >         * No change.
> > > Changes since v2:
> > >         * No change.
> > > Changes since v1:
> > >         * No change.
> > > Changes since RFC:
> > >         * No change.
> > > ---
> > >  arch/arm64/boot/dts/actions/s700-cubieboard7.dts | 41 ++++++++++++++++++++++++
> > >  arch/arm64/boot/dts/actions/s700.dtsi            |  1 +
> > >  2 files changed, 42 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> > > index 63e375cd9eb4..ec117eb12f3a 100644
> > > --- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> > > +++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> > > @@ -13,6 +13,7 @@
> > >
> > >       aliases {
> > >               serial3 = &uart3;
> > > +             mmc0 = &mmc0;
> > >       };
> > >
> > >       chosen {
> > > @@ -28,6 +29,23 @@
> > >               device_type = "memory";
> > >               reg = <0x1 0xe0000000 0x0 0x0>;
> > >       };
> > > +
> > > +     /* Fixed regulator used in the absence of PMIC */
> > > +     vcc_3v1: vcc-3v1 {
> > > +             compatible = "regulator-fixed";
> > > +             regulator-name = "fixed-3.1V";
> > > +             regulator-min-microvolt = <3100000>;
> > > +             regulator-max-microvolt = <3100000>;
> > > +     };
> >
> > Is this regulator used somewhere?
> 
> This is something I copied from bubblegum dts as I wasn't sure what is right way
> to include these regulators.
> 
> Also, another day tested it without having these regulators in , and
> still it seems to
> work.  So should these be removed ?
> 

Fixed regulators are used to nicely model the regulators which aren't tied to
any PMIC. But for some cases we use them to represent supplies when there is
no support for the specific PMIC present in the kernel and they are turned
on/configured by the bootloader (this is what happening here).

And there is no use of declaring fixed regulators when there is no consumer.
Even if you don't define these, the corresponding supplies in the board will
always be in the same state configured by the bootloader. So I'd suggest you
to remove this for now.

Since I don't have the schematics to check, please make sure you name the
regulators as mentioned in the schematics (this could vary from board to board,
so don't just copy from others).

Thanks,
Mani

> Thanks
> -Amit
