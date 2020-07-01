Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6895C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1AA520760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593616998;
	bh=2rJml+GTUlYgOXyKahfajOOLXGPO3bZ1TFD1ndyRFEQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pgkaFRN2AXUuiG9gYKhEVJPVhpyEpCSt6efNzol02a9jLxSs6xqWPUR8odbpU7TtD
	 iQnuHcSvRecvnVE1bWmSr6I+Ls91SVEPxPYolA5o/DZjVRdOmIOaFywkTAFWUsBpfk
	 OCRlr3allVS7XOTuKXSGjRwY/k6febvKb5vhokQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbgGAPXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:23:17 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:19989 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731586AbgGAPXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:23:16 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 061FN0Gh017066;
        Thu, 2 Jul 2020 00:23:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 061FN0Gh017066
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1593616981;
        bh=hySH+OTgticgVm27Iw/te0QrzOknXx7UAK2K5UJp1a0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PJJ96sxVPNxyR4WYCmLv0qA89EPPwt8JLvFJPTxDED64WDFNIZX2xBkZYm9FhbV/R
         ReacK4T0OyOd1EKp9x7RKnR42zx6wfr5nferw23VPf/O3/bgFJzEZd/2lPoPOJDaD9
         kO6YTfPY5t8t9fOv0stdsL4MUidaW6PPtNWcmQ3QBr6YklwWQzDV6ONPiSpgLjj968
         PLLYV0nz8OVHlIyl71fAHpcCoZaQA4RSJbllCYCPsU9aF05cbJklg6/z5/odGgzGbO
         9V/JXAtmXtHZKuBWaE5Zo/ceG+uDdvkIryK01xTt0VsF8hRaDRMXBTTiXo06l6Co3/
         2umEsLomyVdJQ==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id e15so13514863vsc.7;
        Wed, 01 Jul 2020 08:23:01 -0700 (PDT)
X-Gm-Message-State: AOAM532WMhB1v/XJZig1KWhDXMmhWbySDq6QNQ5N2EUGMmEHWBaoy5fe
        Aj45E65H1Cv1ev0iQFg4gJckscpFok4kt8EBtZE=
X-Google-Smtp-Source: ABdhPJzE9mlFmWc0tDTOl4fbqFowpZZGndM5TZ0vODKclFyDgt8KY9hO8HwQuWuiFaQ2OCyFcY9+ITCQXxJtXiSFzr0=
X-Received: by 2002:a67:22c7:: with SMTP id i190mr19417660vsi.179.1593616979994;
 Wed, 01 Jul 2020 08:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <3f61abe3ae457bb5b61fb217394bbb9590ca17ef.1593499731.git.mchehab+huawei@kernel.org>
In-Reply-To: <3f61abe3ae457bb5b61fb217394bbb9590ca17ef.1593499731.git.mchehab+huawei@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 2 Jul 2020 00:22:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNATkdfnFYGaKBr1-CFath=btDW8uudeWfq0GWE5JMX5Aog@mail.gmail.com>
Message-ID: <CAK7LNATkdfnFYGaKBr1-CFath=btDW8uudeWfq0GWE5JMX5Aog@mail.gmail.com>
Subject: Re: [PATCH] kconfig: qconf: parse newer types at debug info
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 3:49 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> There are 3 types that are not parsed by the debug info logic.
> Add support for them.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---


Applied to linux-kbuild.


>  scripts/kconfig/qconf.cc | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
> index fd721c6c4c94..4a616128a154 100644
> --- a/scripts/kconfig/qconf.cc
> +++ b/scripts/kconfig/qconf.cc
> @@ -1154,6 +1154,9 @@ QString ConfigInfoView::debug_info(struct symbol *sym)
>                 case P_DEFAULT:
>                 case P_SELECT:
>                 case P_RANGE:
> +               case P_COMMENT:
> +               case P_IMPLY:
> +               case P_SYMBOL:
>                         debug += prop_get_type_name(prop->type);
>                         debug += ": ";
>                         expr_print(prop->expr, expr_print_help, &debug, E_NONE);
> --
> 2.26.2
>


-- 
Best Regards
Masahiro Yamada
