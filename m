Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EDAC55181
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 06:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617F6206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 06:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587535961;
	bh=c6L/ujVQTQL0TnAwUEqo427p7N8N5kfS43dF8UhEOlQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LvtNcGmxG8k4nxFk4N06tvMo4RWqeLP5AlTzh6FizuxKEdQe4z5Z4JOsGK4sqksYQ
	 Pih9w9nHCEK2TQYMBt/2sXGUb1BDq5Lt2aa17yyNlsW2zuoVvimQtiwBwq9PKYDxkS
	 jYlo5udIH2bWk6EQdz6fa+utq+kitOzf7xGnEquY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgDVGMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 02:12:40 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:34683 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgDVGMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 02:12:40 -0400
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 03M6CEZl005309;
        Wed, 22 Apr 2020 15:12:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 03M6CEZl005309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587535935;
        bh=2N4ogK/xNZ9Tcr1uui85RgzhGfb7g+7gbY4VR3JRGOA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IJtX1X81JLIfQMEJO1MOXtCfMAhRnjlEQkPvLexmR7OchgBX7Lj+wXEr0R4r10oEM
         G7UmWPEvTsBmRof+SmhjQ/3pTlZrbqZdFawRRffA0NuEVk8ejW+GrkqDKp+bjyCVQ0
         Vha2lpAHt9S1LXc4bY3kQNIVIT2IEo3EekoQTrl5yn4rd/tT1rncDLA22gpBUezwOy
         f0YaEZ9dWadVHoWu/wdsCWhXzVcSureo2vl2syzl9oBcI282sPO/F/sBbjpmTEggEN
         6DUUMhXbzE08kE0dBbTDVHIdqxb06GY6JTm8EENMFSxTotLnjADeEtcjnNYm7btn76
         Gru5WWeyBZasg==
X-Nifty-SrcIP: [209.85.221.169]
Received: by mail-vk1-f169.google.com with SMTP id f7so337494vkl.6;
        Tue, 21 Apr 2020 23:12:15 -0700 (PDT)
X-Gm-Message-State: AGi0PuZFqlJHh/gPJJXCSeifZ77sT3RvM9qRT3fwX768Kg2cfZdbUmWn
        UdX69/EHAStinffVHFQw9tQheE3NptE8wXbhDUU=
X-Google-Smtp-Source: APiQypJEYRRS/lXyTbmDGUbuZl3wp8m2ZRnb5bPSWFob7zAmPgZEqqb5f7K4YEwuM+ahptC/SgrUdOy/NpFcLxgm0sw=
X-Received: by 2002:a1f:5c03:: with SMTP id q3mr18950417vkb.66.1587535934133;
 Tue, 21 Apr 2020 23:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200421212004.6146-1-robh@kernel.org> <20200421212004.6146-2-robh@kernel.org>
In-Reply-To: <20200421212004.6146-2-robh@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Apr 2020 15:11:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNARUPhOsyv3W0hgdU8=NuKDay0h5PPPksf7bu-LQtPq=3A@mail.gmail.com>
Message-ID: <CAK7LNARUPhOsyv3W0hgdU8=NuKDay0h5PPPksf7bu-LQtPq=3A@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: Re-enable core schemas for dtbs_check
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 6:20 AM Rob Herring <robh@kernel.org> wrote:
>
> In commit 2ba06cd8565b ("kbuild: Always validate DT binding examples"),
> the core schemas (from dtschema repo) were inadvertently disabled for
> dtbs_checks. Re-enable them.
>
> Fixes: 2ba06cd8565b ("kbuild: Always validate DT binding examples")
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


> ---
>  Documentation/devicetree/bindings/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index 1c1cad860b7c..c66e8329a645 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -2,6 +2,7 @@
>  DT_DOC_CHECKER ?= dt-doc-validate
>  DT_EXTRACT_EX ?= dt-extract-example
>  DT_MK_SCHEMA ?= dt-mk-schema
> +DT_MK_SCHEMA_USERONLY_FLAG := $(if $(DT_SCHEMA_FILES), -u)
>
>  quiet_cmd_chk_binding = CHKDT   $(patsubst $(srctree)/%,%,$<)
>        cmd_chk_binding = $(DT_DOC_CHECKER) -u $(srctree)/$(src) $< ; \
> @@ -38,7 +39,7 @@ override DTC_FLAGS := \
>  $(obj)/processed-schema-examples.yaml: $(DT_DOCS) FORCE
>         $(call if_changed,mk_schema)
>
> -$(obj)/processed-schema.yaml: DT_MK_SCHEMA_FLAGS := -u
> +$(obj)/processed-schema.yaml: DT_MK_SCHEMA_FLAGS := $(DT_MK_SCHEMA_USERONLY_FLAG)
>  $(obj)/processed-schema.yaml: $(DT_SCHEMA_FILES) FORCE
>         $(call if_changed,mk_schema)
>
> --
> 2.20.1
>


-- 
Best Regards
Masahiro Yamada
