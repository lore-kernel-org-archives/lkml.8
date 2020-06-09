Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ECEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8893C206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591671253;
	bh=ZHGH67ddZaKnIGZ+GUujmres+KjJb1wQUw/0hpt2RBI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ijke2j9cu92KQUvBtTiwV/yEdeyWdACX3bO4UrxWaUyInE5TSPcO+5iU3aOFkNo5z
	 D81gBBjdJDaoJ8uPeJruqIoT3A4lrhok9ALEHLweZOjPle/BJn9mF6pyjRnDxqsNey
	 KVzGZqiatJ6I1nR7alXgSot22yB+u1SJWYTRVSh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgFICx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 22:53:57 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:50514 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgFICx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 22:53:57 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 0592rUJ8013934;
        Tue, 9 Jun 2020 11:53:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 0592rUJ8013934
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1591671211;
        bh=mujRQ0cxOo6OPOJ8dVrqjK7M7O6Nf2q2d3tlIpH50xA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=khKBJu/XO182b8eTMlMt+O+VayyPunlN6lESOwHzwN+DXuObI/3/I2bW58siexI72
         8d7j62plIxfAq/c+4GUuVYeS5TYhZ+lvCr7hdRUjh5XAnDZ6+YuZMkanf5fl2SdexE
         k3Dp72pfCFXORG+8ONK+rpGTcCawlYYBeYoNq76+GwfTibWDtvMdKKZ6INjreIca15
         jD+nGf0WtdnsYvqPc/88Ki4ysmU9B6VurCUfNYxGIuXzkmRzn2UaBdN+iAdDq2MoPK
         VDMUHspvPXIu0Tp9GPou0WRSHLQeqnVF+jVpic7HtoTQJEHcuzZWVf2qW74AiR5KPI
         3PqoGn2NqPXDQ==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id y123so11083028vsb.6;
        Mon, 08 Jun 2020 19:53:30 -0700 (PDT)
X-Gm-Message-State: AOAM533dwjzE613/MZGf2cP1R9DCx/tPkOVNKYXLJVQ87duWlAsJFxrP
        ChSroNoQ6pSofZpD6OPt4FA0tu6zffTli9D8h40=
X-Google-Smtp-Source: ABdhPJzg+CEE8DiwhgKfoV4hbjmrtcMM113weZ2EiqDMkEYESySC0JZFhDlyAA48B31EDBwwoM/OOEzkooc0XERDwnQ=
X-Received: by 2002:a67:2d42:: with SMTP id t63mr1258891vst.181.1591671209825;
 Mon, 08 Jun 2020 19:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200608084117.4563-1-jiping.ma2@windriver.com>
 <CAL_JsqKLfSE5tPEPi1=erqBzCF9fceKKDe4qBkywB4O_JhbjGg@mail.gmail.com> <acfc88fc-2a7e-19fe-3dc4-37a03ddabcf9@windriver.com>
In-Reply-To: <acfc88fc-2a7e-19fe-3dc4-37a03ddabcf9@windriver.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 9 Jun 2020 11:52:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS3xOvkUWZzZcb7Mk2YsWo+A6XTjzTZjxjvkYCjWjQvFg@mail.gmail.com>
Message-ID: <CAK7LNAS3xOvkUWZzZcb7Mk2YsWo+A6XTjzTZjxjvkYCjWjQvFg@mail.gmail.com>
Subject: Re: [PATCH] dtc: also check <yaml.h> for libyaml
To:     Jiping Ma <Jiping.Ma2@windriver.com>
Cc:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 9, 2020 at 10:01 AM Jiping Ma <Jiping.Ma2@windriver.com> wrote:
>
>
>
> On 06/09/2020 03:09 AM, Rob Herring wrote:
> > On Mon, Jun 8, 2020 at 2:42 AM Jiping Ma <jiping.ma2@windriver.com> wrote:
> >> yamltree.c includes <yaml.h>, If /usr/include/yaml.h does not exist,
> >> it fails to build.
> > Does this patch fix your issue?:
> >
> > https://lore.kernel.org/linux-devicetree/20200505100319.741454-1-masahiroy@kernel.org/
> No, it did not fix the issue.
>
> $ pkg-config --cflags yaml-0.1
>
> $ pkg-config yaml-0.1 --libs
> -L/buildarea/jma1/wr-19-0518/19.45/sysroots/aarch64-wrs-linux/usr/lib64
> -lyaml




If I install libyaml to a non-standard location
(/home/masahiro/foo), my pkg-config shows as follows:



masahiro@oscar:~$ pkg-config --cflags   yaml-0.1
-I/home/masahiro/foo/include
masahiro@oscar:~$ pkg-config --libs   yaml-0.1
-L/home/masahiro/foo/lib -lyaml







> >
> >
> >> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
> >> ---
> >>   scripts/dtc/Makefile | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
> >> index b5a5b1c..b49dfea 100644
> >> --- a/scripts/dtc/Makefile
> >> +++ b/scripts/dtc/Makefile
> >> @@ -18,9 +18,13 @@ $(error dtc needs libyaml for DT schema validation support. \
> >>   endif
> >>   HOST_EXTRACFLAGS += -DNO_YAML
> >>   else
> >> +ifeq ($(wildcard /usr/include/yaml.h),)
> >> +HOST_EXTRACFLAGS += -DNO_YAML
> >> +else
> >>   dtc-objs       += yamltree.o
> >>   HOSTLDLIBS_dtc := $(shell pkg-config yaml-0.1 --libs)
> >>   endif
> >> +endif
> >>
> >>   # Generated files need one more search path to include headers in source tree
> >>   HOSTCFLAGS_dtc-lexer.lex.o := -I $(srctree)/$(src)
> >> --
> >> 1.9.1
> >>
>


-- 
Best Regards
Masahiro Yamada
