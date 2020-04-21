Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150EBC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 00:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E93252072D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 00:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587430226;
	bh=r3tKm8DqiKKuGskeeBJb1oDrN4NffPJnJeVyUXlHgaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YLhSHBlj1IPwDrAvSxQ8Dpn9QhCnEBsJiCcr+UoCZqzMAprDyILdo3nZuDlCOQose
	 pfzhP8nJ71JRwQVK+Qyop2bN0TtmAgEHyO836sLEo5HljqHJYQW57mJCrrxjZBWEjn
	 ACpvIc6bselkmt+J/yq2zsuw/1FoHQDtBMGhZVTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgDUAuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:50:25 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:43851 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgDUAuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 20:50:24 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 03L0nw6l031854;
        Tue, 21 Apr 2020 09:49:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 03L0nw6l031854
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587430199;
        bh=tZmsfERnblOFkkdqRvhGaxfqugPBY/Xsw0eno3u9EFc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JWZTVonSieQlIcoeJzatS7yOHo1Tb53edJiZFwUnww7hVbHchUGYiv+VODOELpUPh
         AEB00wni+iTryIGJ1miu4huLZtVHrE5SJicRbrkrrbLUKW6TXlVUeA7k3IxCOtDsob
         5smvaBsxmkTuMtFPLrYTPFuHBhsmzZQJAUQN6lMNLZFrrkcWW9QDUc5EgyFmsgbf4C
         uwLD0c+TxyWCSu2dvOvf5Mew3UxQeEwcxKwwlU6BcRRkQaiAMUdw+usm71pF+BoPCk
         Zor9lGrM0iXMCYhoYiYxno2a7Nml+sDxQcHfIpzPO7n9Y5CFyMoIWhEvHWK57oGbEf
         EWcMoDPaLd+Rw==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id 184so7389882vsu.3;
        Mon, 20 Apr 2020 17:49:59 -0700 (PDT)
X-Gm-Message-State: AGi0PuYYtGy9lWfD/34OsATExcOF1QZCJ55YXiwXPgGhUYeNudkTzJt+
        rADLeXypWjVkuTv2nT2WFp/O+C5YUeO+F6rad/0=
X-Google-Smtp-Source: APiQypKqlXEh4Ce4HZmAxQ2hrLYP/wa0UYXU4Q2E85c+CUeQ355bY8h5VqB1Dsq0NV0EEIadu8pZxEw8iSkJ/bpnyxQ=
X-Received: by 2002:a67:e94d:: with SMTP id p13mr10906451vso.215.1587430198386;
 Mon, 20 Apr 2020 17:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200420224953.31327-1-robh@kernel.org>
In-Reply-To: <20200420224953.31327-1-robh@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 21 Apr 2020 09:49:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNATmR09xs0A2VzRmrKepjZsx97BkqswZ1ObuVYbnmaCr_A@mail.gmail.com>
Message-ID: <CAK7LNATmR09xs0A2VzRmrKepjZsx97BkqswZ1ObuVYbnmaCr_A@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: Add a minimum version check for dtschema
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 7:49 AM Rob Herring <robh@kernel.org> wrote:
>
> The dtschema package must be somewhat up to date as the tools and
> meta-schema checks are still evolving. Implement a version check,
> so this can be enforced. This will help ensure new schema submissions
> get checked against the latest meta-schemas.
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Please replace Cc with:

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


> ---
> v3:
>  - Drop leading '0' in version month
>  - Rework with Masahiro's shell commands
>
> v2:
>  - Use a build rule for the version check instead
> ---
>  Documentation/devicetree/bindings/Makefile | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index 1df680d07461..67b0969281da 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -3,11 +3,19 @@ DT_DOC_CHECKER ?= dt-doc-validate
>  DT_EXTRACT_EX ?= dt-extract-example
>  DT_MK_SCHEMA ?= dt-mk-schema
>
> +DT_SCHEMA_MIN_VERSION = 2020.4
> +
> +PHONY += check_dtschema_version
> +check_dtschema_version:
> +       @{ echo $(DT_SCHEMA_MIN_VERSION); \
> +       $(DT_DOC_CHECKER) --version 2>/dev/null || echo 0; } | sort -VC || \
> +       { echo "ERROR: dtschema minimum version is v$(DT_SCHEMA_MIN_VERSION)" >&2; false; }
> +
>  quiet_cmd_chk_binding = CHKDT   $(patsubst $(srctree)/%,%,$<)
>        cmd_chk_binding = $(DT_DOC_CHECKER) -u $(srctree)/$(src) $< ; \
>                          $(DT_EXTRACT_EX) $< > $@
>
> -$(obj)/%.example.dts: $(src)/%.yaml FORCE
> +$(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
>         $(call if_changed,chk_binding)
>
>  # Use full schemas when checking %.example.dts
> @@ -34,11 +42,11 @@ override DTC_FLAGS := \
>         -Wno-avoid_unnecessary_addr_size \
>         -Wno-graph_child_address
>
> -$(obj)/processed-schema-examples.yaml: $(DT_DOCS) FORCE
> +$(obj)/processed-schema-examples.yaml: $(DT_DOCS) check_dtschema_version FORCE
>         $(call if_changed,mk_schema)
>
>  $(obj)/processed-schema.yaml: DT_MK_SCHEMA_FLAGS := -u
> -$(obj)/processed-schema.yaml: $(DT_SCHEMA_FILES) FORCE
> +$(obj)/processed-schema.yaml: $(DT_SCHEMA_FILES) check_dtschema_version FORCE
>         $(call if_changed,mk_schema)
>
>  extra-y += processed-schema.yaml
> --
> 2.20.1
>


-- 
Best Regards
Masahiro Yamada
