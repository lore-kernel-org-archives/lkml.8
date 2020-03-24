Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C798C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59E9205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585040791;
	bh=gYVo3vXUCpPxsNjxo+ialPZllvTngSepFgiVoyRn2Is=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MzXUi0xI1U/14CcPOWE8OWAja3PNyCzOdbxpussmU9Ks8Id9m73HKqJkv/8Z4aqYx
	 c0x6l5Ep8Z12Mdt8l6o46vrmyucqdkU5XwrsubySG1n3tqFqlmyPwDgyTidJX0knK+
	 oWucHGzYmLWIKSYbmjYClfToDbfOocg1xlHprRgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgCXJGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:06:30 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:58977 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgCXJGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:06:30 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 02O96OYB016945
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 18:06:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 02O96OYB016945
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585040785;
        bh=qOMGdUkveaVDXO2a8tz7KDZMeyMjPwlo2zkk9aWn2yk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=abGPExP4D1sYBI7tPhEZcdatkhXRKqNWlNd7xPenlzv8y2Vn6rzO8UoOAVHb+IG5g
         glzcLqemGnSi9Wk09pGESHDhNS7m+NIch8FbmBu0bSijii7+ciTWysQ6YOHULWeQHw
         W0a+oYGxrYcJmEb62rrbzLkEY15/ZXt8D4F8D+gwLyF5URLGelpDNt+08xi5bHeEfT
         foFrk5p2mwogfea59ZWytYhm3xX63WcyEOYU1+KXarswWYPxUATxJYjmEAlO/Jz0uw
         eU5qA1VIIy/TbJ60Vb1K8d9Y2l9nX/hJbTSh73rJZfDhYURpCJ5Xf7/sH7n42uwKfA
         yndAMBaTfdgOw==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id r47so5995168uad.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 02:06:25 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1aObmZgKC1VTy1rZMlK0xkfOb6G/8hCbfljXQviRFW+GGDQfb9
        euBLxHpG1y2Z463fk1fmnYsuFvBCOw0n5dwkqEo=
X-Google-Smtp-Source: ADFU+vtTr9ggPn7FesvFuHnglv5MtvnxnuDVGKuKqUPW04U7K+2TYBqG5kpqPNh3Go/OGTDteyzcCatZgbB4q1/WETc=
X-Received: by 2002:ab0:3485:: with SMTP id c5mr16446308uar.109.1585040784226;
 Tue, 24 Mar 2020 02:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200323021053.17319-1-masahiroy@kernel.org>
In-Reply-To: <20200323021053.17319-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 24 Mar 2020 18:05:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNARf0VwM309LsT_HaoF1Jq4Dx0XuFCAOOSr6yHXw50bR9g@mail.gmail.com>
Message-ID: <CAK7LNARf0VwM309LsT_HaoF1Jq4Dx0XuFCAOOSr6yHXw50bR9g@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: remove always-defined CONFIG_AS_MOVNTDQA
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi i915 maintainers,


On Mon, Mar 23, 2020 at 11:12 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> CONFIG_AS_MOVNTDQA was introduced by commit 0b1de5d58e19 ("drm/i915:
> Use SSE4.1 movntdqa to accelerate reads from WC memory").
>
> We raise the minimal supported binutils version from time to time.
> The last bump was commit 1fb12b35e5ff ("kbuild: Raise the minimum
> required binutils version to 2.21").
>
> I confirmed the code in $(call as-instr,...) can be assembled by the
> binutils 2.21 assembler and also by Clang's integrated assembler.
>
> Remove CONFIG_AS_MOVNTDQA, which is always defined.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---


Please discard this.

I decided to fold this (10/16) into the following big series
because I was suggested to do so.

https://lore.kernel.org/patchwork/project/lkml/list/?series=435391





-- 
Best Regards
Masahiro Yamada
