Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C747C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2769F2068D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591643381;
	bh=ScyHgiTEWVsjSltSHfU5CEirBNfWdqcMaSWHrvzGXI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eI9vbcbJLuHHbAeplMTWtrcieBpJjW3kFY060w4ucuxtNY67iFzJ6Ub5X/L7v/+w/
	 H7MFyu0Z2Naj2xt1CLBRRDJpVrGWE3bGQxojNngEadoCgMxyIL/nSFE8JCsHPh8A6H
	 wN3S/1GIc4R3ZzonNYbH4mU3jmDqE/iBM3pVeGqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgFHTJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:09:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgFHTJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:09:40 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A929206A4;
        Mon,  8 Jun 2020 19:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591643379;
        bh=ScyHgiTEWVsjSltSHfU5CEirBNfWdqcMaSWHrvzGXI0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0HI5Qf2uaXoyxIZbmo9cCzld6vkS4PF2GJEARZqh4lxJgpuIWeDBvJW0VA7kP5N4b
         Vym17/Nx2BSqAbtk8/vIlLBm9muAWf5aCWxC2xSHASLij6u+JsSqS24Diielz58iZf
         DH9B6v3YP3mO1YrKO15+8WP+zAjs0QAFoItkyqYo=
Received: by mail-oi1-f180.google.com with SMTP id s21so16334265oic.9;
        Mon, 08 Jun 2020 12:09:39 -0700 (PDT)
X-Gm-Message-State: AOAM531So9dIYcMx0uaae4v+31WjztEIkfJz+YyzrGaieJuOGVdswzrP
        H3KW0rLO0GocM/8yFUobgeGNOyXJrsib6CJhmw==
X-Google-Smtp-Source: ABdhPJy4Vp6GDix7BLisOjJclsiusfBkLpi//arVNwprm8DvK2iq5xKeK5uY+f9/ewYrYnZiFE4QNF7QCSWvtL+McUo=
X-Received: by 2002:aca:6004:: with SMTP id u4mr690754oib.106.1591643378869;
 Mon, 08 Jun 2020 12:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200608084117.4563-1-jiping.ma2@windriver.com>
In-Reply-To: <20200608084117.4563-1-jiping.ma2@windriver.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Jun 2020 13:09:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKLfSE5tPEPi1=erqBzCF9fceKKDe4qBkywB4O_JhbjGg@mail.gmail.com>
Message-ID: <CAL_JsqKLfSE5tPEPi1=erqBzCF9fceKKDe4qBkywB4O_JhbjGg@mail.gmail.com>
Subject: Re: [PATCH] dtc: also check <yaml.h> for libyaml
To:     Jiping Ma <jiping.ma2@windriver.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 2:42 AM Jiping Ma <jiping.ma2@windriver.com> wrote:
>
> yamltree.c includes <yaml.h>, If /usr/include/yaml.h does not exist,
> it fails to build.

Does this patch fix your issue?:

https://lore.kernel.org/linux-devicetree/20200505100319.741454-1-masahiroy@kernel.org/


> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
> ---
>  scripts/dtc/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
> index b5a5b1c..b49dfea 100644
> --- a/scripts/dtc/Makefile
> +++ b/scripts/dtc/Makefile
> @@ -18,9 +18,13 @@ $(error dtc needs libyaml for DT schema validation support. \
>  endif
>  HOST_EXTRACFLAGS += -DNO_YAML
>  else
> +ifeq ($(wildcard /usr/include/yaml.h),)
> +HOST_EXTRACFLAGS += -DNO_YAML
> +else
>  dtc-objs       += yamltree.o
>  HOSTLDLIBS_dtc := $(shell pkg-config yaml-0.1 --libs)
>  endif
> +endif
>
>  # Generated files need one more search path to include headers in source tree
>  HOSTCFLAGS_dtc-lexer.lex.o := -I $(srctree)/$(src)
> --
> 1.9.1
>
