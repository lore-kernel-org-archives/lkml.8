Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD9FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4716A2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591670684;
	bh=b+ff4+/UEVwTp+sk9ip5GZLPbGrKFsoDd4CSCh2SFIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zWkmJN9aDW7QhtJe+ZZqtFXZ1AVXMryCM4yYvAPk8MJzwEmZ0Znfpg9sNNG/lLeXR
	 0BhpUYn6uLzBT33YpY7LxDlDJXqwuj1y9l2cmG6gaSy0vzHf6z3e2RcVByS+Lcu8UK
	 tcoKUwOoh6XZVd9JvRbaav5KqpViMbryg+wl6jdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgFICon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 22:44:43 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:55753 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgFICom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 22:44:42 -0400
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 0592iJs1021460;
        Tue, 9 Jun 2020 11:44:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 0592iJs1021460
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1591670660;
        bh=9Z3DzEK10aRjC8fbazjgQsxHhsn2ISmMWoHXi0qgJqg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sphoyTxG1xGPXA5wcykTu7JE6ILkSgEeEOHQthDCTEl7Zh8+3m6uLaRkJd2G6EZ2V
         iSGeyZKStdT0BWDXdvGrKtUzuHwgofCYV+6cfq/gJhVRdOgtcOjDy7kPr3PWKj4KhC
         ahWQb38D8ZchCVP4mgZWNlEp8/Pc5tL8ccK0vAMNYh/bV/nmj0e1A+NtGy+yxyeuvk
         Vo8Xj/v/v/DMqgHjVtv67zQY6sZEHmGLFfrG1aljpK8ySfw8Z5DJfaGBVG7OLMgHcI
         X9uH8031VWkjaln4DbF0sLXCXYBSAwrFgyWmcsIMs+yoe/L5T3BhylZnmnvVQ+/tAh
         5mlTitIr84lAg==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id r9so6611781ual.1;
        Mon, 08 Jun 2020 19:44:20 -0700 (PDT)
X-Gm-Message-State: AOAM533379L+sbNM1t8fpHaAtrOIlWownj81ZSIzCT0eHwOiElwLjjx1
        cdiUuzTh/7b579mR7q09ITQZW6+7HujFD1HMKoo=
X-Google-Smtp-Source: ABdhPJzJiCejPYqLxwGCRkB/z/opOuBrLPXtGw6XfuSPDCR+hLFVsJ59sHKnhk2TF1vhYBTWVIghvjgFOnGuul0M8LI=
X-Received: by 2002:ab0:3ae:: with SMTP id 43mr1162600uau.25.1591670659082;
 Mon, 08 Jun 2020 19:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200608084117.4563-1-jiping.ma2@windriver.com>
 <CAL_JsqKLfSE5tPEPi1=erqBzCF9fceKKDe4qBkywB4O_JhbjGg@mail.gmail.com> <acfc88fc-2a7e-19fe-3dc4-37a03ddabcf9@windriver.com>
In-Reply-To: <acfc88fc-2a7e-19fe-3dc4-37a03ddabcf9@windriver.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 9 Jun 2020 11:43:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQd29g1p4PG=LS-f33R2WUA5DNjKYjoEoWhJ+71CWw72w@mail.gmail.com>
Message-ID: <CAK7LNAQd29g1p4PG=LS-f33R2WUA5DNjKYjoEoWhJ+71CWw72w@mail.gmail.com>
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


Then, this is a problem on your system.






> $ pkg-config yaml-0.1 --libs
> -L/buildarea/jma1/wr-19-0518/19.45/sysroots/aarch64-wrs-linux/usr/lib64
> -lyaml
>
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
