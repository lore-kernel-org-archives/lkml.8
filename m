Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61246C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 02:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C632075A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 02:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583633975;
	bh=lYOUYS198D1/0Gr+1+Ic9jjMBLUGg7SoAMQZAnwkh/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YW0grSbVCcdxfWBW+Z/nlZXJnFuSB2wTCPVxb+yMQjaFQT8ycRw0R5yrq4mZoFlz8
	 Jo0JyUt2fVWB7vNiebPN1juqjmjHsLk+o06/8jJQLbejG18x5qIB/4g4eBuuaDzt6f
	 llvCRSeZVJi71amrxVfqXkbD2QCTtqZDWIR8ec7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgCHCTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 21:19:33 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:33242 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgCHCTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 21:19:33 -0500
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 0282JHfY013317;
        Sun, 8 Mar 2020 11:19:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 0282JHfY013317
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583633958;
        bh=MRiJFfd4XzN50K790XI9lYLTj9Bp98INNHajUe+6r64=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CSRFkM+LvCiVVJMAKnKNKED4Bi4v4qwdh2AY46W/45w1GrIJCABBjXmRPJpRlubT4
         5LkpYPXWSOt9KidwivW0GffaSyEIXPlEnHTdmkZMqwkSh9P6Ng2HxSW/dDpC+gUoJu
         OPUcVZ7eT/w7xr+LfEQeUImZYeIW61Na3duvbr/2WPXq+SdpZGjMHp+yv6kDAFbM/X
         tYWdiDJ0oKEAOSGUOcJeLbPF+8tlv7CcGsNZnGgWc0+xl0bMVsLhxcbEF9nyVB9uUW
         mZWWvqJhTsGOCT/DFHdlTbevxIuXMKrHBPjXg732gEXEeIp/WRmvn2NoevmfntXoqw
         pHZN1cO87Y7YQ==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id h22so2095172uap.13;
        Sat, 07 Mar 2020 18:19:18 -0800 (PST)
X-Gm-Message-State: ANhLgQ1uyaO9WHt4NMEtb8H3CMtmOJuq0dxbz6KgpUuz1U/WFgHhfECC
        5Clg2NYtgWBXWhjvPnN3MfTC9SlnCOMn8uvifdY=
X-Google-Smtp-Source: ADFU+vsU5zfX/fbI+PZJ18ZCecEFu4G8aaymDTDagTkIOLYMu7EWSvEB1LjcowfG/2EWb+GKR6g/DiftGunXkHPiUTY=
X-Received: by 2002:a9f:2828:: with SMTP id c37mr5344910uac.25.1583633957239;
 Sat, 07 Mar 2020 18:19:17 -0800 (PST)
MIME-Version: 1.0
References: <20200304032038.14424-1-masahiroy@kernel.org> <20200304032038.14424-3-masahiroy@kernel.org>
 <20200304055520.GA28911@ravnborg.org> <CAL_JsqLA7yq8rnVhM210sLt788yeu2xxFd94Fe0K_CGZw-mqSA@mail.gmail.com>
In-Reply-To: <CAL_JsqLA7yq8rnVhM210sLt788yeu2xxFd94Fe0K_CGZw-mqSA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 8 Mar 2020 11:18:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNATmnfjo2A0x6ytLNeo_rjv1_e9RFyxCnB-K1E1O=fw9jQ@mail.gmail.com>
Message-ID: <CAK7LNATmnfjo2A0x6ytLNeo_rjv1_e9RFyxCnB-K1E1O=fw9jQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] kbuild: allow to run dt_binding_check and dtbs_check
 in a single command
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, DTML <devicetree@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam, Rob,

On Thu, Mar 5, 2020 at 12:19 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Mar 3, 2020 at 11:55 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Masahiro
> >
> > Thanks for the nice improvements to the dt infrastructure.
> >
> > Stealing a thread here..
> >
> > >  It is also possible to run checks with a single schema file by setting the
> > >  ``DT_SCHEMA_FILES`` variable to a specific schema file.
> > Would it be simple to enable the use of dirs for DT_SCHEMA_FILES?
>
> I did name that with the intent of supporting more than one file.
>
> > So I for example could do:
> >
> > make dt_bindings_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/panel/
>
> Does this work?:
>
> make dt_bindings_check DT_SCHEMA_FILES="$(find
> Documentation/devicetree/bindings/display/panel/ -name '*.yaml' |
> xargs)"
>
> Rob


Rob proposed a solution, so
I do not think we should extend this too much.


BTW, there is a limitation that
DT_SCHEMA_FILES must point to file(s)
in Documentation/devicetree/bindings/.


$ cp  Documentation/devicetree/bindings/arm/psci.yaml   ./
$ make  dt_binding_check  DT_SCHEMA_FILES=psci.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
make[1]: *** No rule to make target
'Documentation/devicetree/bindings/psci.yaml', needed by '__build'.
Stop.
make: *** [Makefile:1278: dt_binding_check] Error 2



$(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
does not work if DT_SCHEMA_FILES is outside of
Documentation/devicetree/bindings/, but I have no
solution for this.

--
Best Regards
Masahiro Yamada
