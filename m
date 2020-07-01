Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E17C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339A020760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593616961;
	bh=PO/wvKtcjevG75AgbZ6AssGESP3rXuHm2UYLhEfrFaw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Av3JS1cfwQxid2YSXrp7MrgmrEcsHT/o3V2t6Rag93pouwqMFDuppdK6J0i7j9AbT
	 MEKIPJkU4GZUY0+OujHXB87Xr8wuqjlMgPxwbNty0gTvZ8PFK/nEQR/WTJmn03SKHp
	 0XzeHJMe8qdmLdogA5GyirAmYD5fNbAZXYl9Xi9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbgGAPWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:22:39 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:27852 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731586AbgGAPWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:22:39 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 061FMDgR020065;
        Thu, 2 Jul 2020 00:22:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 061FMDgR020065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1593616934;
        bh=1dn5itpzXrL1Yb4IZyaIk9goXSF0W9d58pHZXzlUtrA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q6W2o3cRaQ74HW4ba2McVZkLZZkQgEgbhXnkz6UvX1BUQc14FR3YzdEVFzz2STM0B
         za/pvXmqTtefp1WpFseT245w5JmqR5bhHRjfmgXqfPDNftg0fTRinLh7cWXfgljTSf
         02eQBpQ4WL5R2ty6L/wjOXSmgJuMHHzlNuXLh06XrfhNXlPTSzDmqjHQvwlHGcR8uJ
         Fvm5bPtk0mvdu3omac6wb/lmyGkXCcCjTH+ieElGYnQbp8PLKJP2HOXH6mBdHshArR
         n/miOHXLAvqwwk9ErFjvMgGM+Gcv1ocxqXIlj05zeBaVLFHHjvKVR3JEYFSNfUe+vy
         Gw/Y7cPfCOOKg==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id k7so12159702vso.2;
        Wed, 01 Jul 2020 08:22:13 -0700 (PDT)
X-Gm-Message-State: AOAM532y+NvjXXuoELBHM1IUdFQg6Ch1FzeheTSdxBzHjkAkEeoh7aDM
        ckmEQgLLZv9EqHDzN3NPnN+hNdM+Qjzd04hMJLA=
X-Google-Smtp-Source: ABdhPJwdeFoDOciGsBE9zH1V0GkEJHQgzTkjq5VFcOmrSz01NaMtS4WP9jPHX27izYNK4pL1K38AjMWFuLeyN+1VtME=
X-Received: by 2002:a67:6c84:: with SMTP id h126mr17444371vsc.181.1593616932914;
 Wed, 01 Jul 2020 08:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593498345.git.mchehab+huawei@kernel.org>
 <6f7162e40f127e76c7169315d33a14946a85719a.1593498345.git.mchehab+huawei@kernel.org>
 <20200630084835.4db1331f@coco.lan>
In-Reply-To: <20200630084835.4db1331f@coco.lan>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 2 Jul 2020 00:21:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNARjZWwKeFXMbDy76jYu21oCckz8qxkMSu7y1xmL+a3C3g@mail.gmail.com>
Message-ID: <CAK7LNARjZWwKeFXMbDy76jYu21oCckz8qxkMSu7y1xmL+a3C3g@mail.gmail.com>
Subject: Re: [PATCH v3.1 7/7] kconfig: qconf: navigate menus on hyperlinks
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 3:48 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Instead of just changing the helper window to show a
> dependency, also navigate to it at the config and menu
> widgets.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>
>
> ---
>
> I ended re-sending the same version as on patch series 2.

Do you mean this one should substitute 7/7 in v3, right?

Applied to linux-kbuild.



> Please
> consider this patch instead.
>
> diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
> index 6a327b69ff5f..fd721c6c4c94 100644
> --- a/scripts/kconfig/qconf.cc
> +++ b/scripts/kconfig/qconf.cc
> @@ -1233,7 +1233,6 @@ void ConfigInfoView::clicked(const QUrl &url)
>         char *data = new char[count + 1];
>         struct symbol **result;
>         struct menu *m = NULL;
> -       char type;
>
>         if (count < 1) {
>                 qInfo() << "Clicked link is empty";
> @@ -1243,7 +1242,6 @@ void ConfigInfoView::clicked(const QUrl &url)
>
>         memcpy(data, str.constData(), count);
>         data[count] = '\0';
> -       type = data[0];
>
>         /* Seek for exact match */
>         data[0] = '^';
> @@ -1256,15 +1254,8 @@ void ConfigInfoView::clicked(const QUrl &url)
>         }
>
>         sym = *result;
> -       if (type == 's') {
> -               symbolInfo();
> -               emit showDebugChanged(true);
> -               free(result);
> -               delete data;
> -               return;
> -       }
>
> -       /* URL is a menu */
> +       /* Seek for the menu which holds the symbol */
>         for (struct property *prop = sym->prop; prop; prop = prop->next) {
>                     if (prop->type != P_PROMPT && prop->type != P_MENU)
>                             continue;
> @@ -1273,16 +1264,13 @@ void ConfigInfoView::clicked(const QUrl &url)
>         }
>
>         if (!m) {
> -               qInfo() << "Clicked menu is invalid:" << data;
> -               free(result);
> -               delete data;
> -               return;
> +               /* Symbol is not visible as a menu */
> +               symbolInfo();
> +               emit showDebugChanged(true);
> +       } else {
> +               emit menuSelected(m);
>         }
>
> -       _menu = m;
> -       menuInfo();
> -
> -       emit showDebugChanged(true);
>         free(result);
>         delete data;
>  }
> @@ -1731,6 +1719,7 @@ void ConfigMainWindow::setMenuLink(struct menu *menu)
>                         list->setSelected(item, true);
>                         list->scrollToItem(item);
>                         list->setFocus();
> +                       helpText->setInfo(menu);
>                 }
>         }
>  }



-- 
Best Regards
Masahiro Yamada
