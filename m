Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE18FC3B185
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28B321739
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EYLK2BU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgBJH6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 02:58:19 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43687 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgBJH6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 02:58:19 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so5410729oth.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 23:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gFmjWJgnqMfOe0WpN++eBCj9oEJM1xbOvI/rc5h7adA=;
        b=EYLK2BU0ZNzLNnSNehbaPGGFWGWYqwmOIUirBH2KPGnRL+SwCdNfxxY8xN/ddppQhu
         CY3w35gZbJ9f2IaAm7+1M5zIycqjNzEgOpqGe/p2xg2BAJqV+yaUSn+Ct3UQyIV3KHTY
         EfG48lMk4qI70TugtoxrclXboKwRAldQ6g31VHXSfy+lNZq+bLnoKX8WpD3jYx2sLLoL
         UIy2lOhUrto1CL8G83+W+C1+4WGJkzDMmu2DpLAGFhZ7nJ//Pyy3oGIwDGYX+Ofj9mc4
         pgLsctw2orkDU8dvYYPRV6bLYj61W3Q7CUB4nn8tsnqBHwkIfVxcfX+xNUeI/033R1ys
         wuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gFmjWJgnqMfOe0WpN++eBCj9oEJM1xbOvI/rc5h7adA=;
        b=EkQdCbR5+SHowx086OvvGDIndXofMk9AUWIKsLRSqy0nLdrCl/M3kP0RTcEZTh1joY
         SyPcaJEWS+Z4/qeyY8P5A3Szsy2nFZ7rJYsyzozM4IU8O9yyAnq14L/DtGJCIAw9CwqI
         Lw7vNP+hOAwHycKNAChA0dVgBSnT9Meg9dfTnjwNLoYXFJUSneXxM/DHpgGu2FM+WcXl
         i1Tm/a005TWJxKF4ZscIvpUx9It2rhEtHuBfntRQvL5y6iXEzNYpH57rmNF9clevjhgU
         T8M452sxKFlZo+Fhd2RfnwmGBWXrRrBWtuO5tudB0ifMZjZEretPNNBR2wxijdBDGAfw
         +gpw==
X-Gm-Message-State: APjAAAX7dNZbJaUIyiTXTCTmb/ITGl6EFiJFxGcGO3O1c9E+569V9xMY
        1Y6+3ZVbRq14DYMpQ/ZBe7vh3lMSzRquUTetU7fj8g==
X-Google-Smtp-Source: APXvYqwFUwCCOEbpz5Jl1bGXHyiSZ+zIVpJGarL0oYqphwoRK0i7lXJGhdsDh6d7COwr74pg3gfjS5LMsGYA9tTW6IY=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr184722otg.2.1581321497301;
 Sun, 09 Feb 2020 23:58:17 -0800 (PST)
MIME-Version: 1.0
References: <20200209182008.008c06f1cf4347a95f9de0a5@linux-foundation.org>
 <2B333FA6-AB17-4169-B9EE-9355FF9C42A4@lca.pw> <20200209200620.883ad431b01bcd38939ff5b4@linux-foundation.org>
In-Reply-To: <20200209200620.883ad431b01bcd38939ff5b4@linux-foundation.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 10 Feb 2020 08:58:06 +0100
Message-ID: <CANpmjNOs-ncPxv1gnzwXwCpf1nqABn59wUhpo-tf8A_8VP0dvQ@mail.gmail.com>
Subject: Re: [PATCH -next v2] mm: mark an intentional data race in page_zonenum
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qian Cai <cai@lca.pw>, Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>, ira.weiny@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 at 05:06, Andrew Morton <akpm@linux-foundation.org> wro=
te:
>
> On Sun, 9 Feb 2020 21:41:56 -0500 Qian Cai <cai@lca.pw> wrote:
>
> >
> >
> > > On Feb 9, 2020, at 9:20 PM, Andrew Morton <akpm@linux-foundation.org>=
 wrote:
> > >
> > > Using data_race() here seems misleading - there is no race, but we're
> > > using data_race() to suppress a false positive warning from KCSAN, ye=
s?
> >
> > It is a data race in the sense of compilers, i.e., KCSAN is a compiler =
instrumentation, so here the load and store are both in word-size, but code=
 here is only interested in 3 bits which are never changed. Thus, it is a h=
armless data race.
> >
> > Marco also mentioned,
> >
> > =E2=80=9CVarious options were considered, and based on feedback from Li=
nus,
> > decided 'data_race(..)' is the best option:=E2=80=9D
> >
> > lore.kernel.org/linux-fsdevel/CAHk-=3Dwg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDn=
FqbY7HL5AB2g@mail.gmail.com/
> >
> > Paul also said,
> >
> > =E2=80=9DPeople will get used to the name more quickly than they will g=
et used
> > to typing the extra seven characters.  Here is the current comment head=
er:
> >
> > /*
> >  * data_race(): macro to document that accesses in an expression may co=
nflict with
> >  * other concurrent accesses resulting in data races, but the resulting
> >  * behaviour is deemed safe regardless.
> >  *
> >  * This macro *does not* affect normal code generation, but is a hint t=
o tooling
> >  * that data races here should be ignored.
> >  */
> >
> > I will be converting this to docbook form.
> >
> > In addition, in the KCSAN documentation:
> >
> > * KCSAN understands the ``data_race(expr)`` annotation, which tells KCS=
AN that
> >   any data races due to accesses in ``expr`` should be ignored and resu=
lting
> >   behaviour when encountering a data race is deemed safe.=E2=80=9D
>
> OK.  But I believe page_zonenum() still deserves a comment explaining
> that there is no race and explaining why we're using data_race()
> anyway.  Otherwise the use of data_race() is simply misleading.
>

I have a better suggestion for page_zonenum(), pending a patch if it
makes sense:
  http://lkml.kernel.org/r/CANpmjNNaHAnKCMLb+Njs3AhEoJT9O6-Yh63fcNcVTjBbNQi=
EPg@mail.gmail.com
If that makes more sense, the patch here could eventually be replaced.

Thanks,
-- Marco
