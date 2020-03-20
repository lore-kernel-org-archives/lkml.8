Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1287C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 01:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B0220752
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 01:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6AR+D3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgCTBFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:05:46 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34839 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCTBFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 21:05:45 -0400
Received: by mail-il1-f196.google.com with SMTP id o16so1524076ilm.2;
        Thu, 19 Mar 2020 18:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pIKmKtPK9inyHBgOdGiW1cUuusmeVK05PlwwC7X+p5I=;
        b=i6AR+D3jHyppvVrFUj442iIkudhoNOYo5aGJ+CNFj4M/c4ChNUL/eyGofj6hWNHBuY
         4P5MAkxAR1/5Xr1GPtYHWDK8fooG4Eg0/nh4cqrwaKcwhHE83DU8URq9JUcY7FBq86ng
         Vt124ONAuGsAl7gw8EKfp4oYNlMq73CH1Kxszez5Mh6pTu6dFBmXZiCJtqgpEgooOJDx
         KgXJSjHjsuscAUJZZsQMV60PVMH5V77m5x48qnL1DHE9FGkbNGCDZ7AJpgWJYieESVsU
         U0ZGI+6jQT7vCtloA+JY0ChZq4krmDE97EP5hRb7DEKbqDtb3GxDbLrpJex67SaSbs8R
         4e5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pIKmKtPK9inyHBgOdGiW1cUuusmeVK05PlwwC7X+p5I=;
        b=AmMijwL9Z4nfq+FamPavlwDSyzU5f9b5c4mtvPFelpK5y3A1LEsm+cv3TyoLcW1038
         fnfzqDg24G/7LUL2C9FNlDtSm0hql8z7nPrm9ymfsK9mh4PYVZ2Ri0rPsBHzmE0gWb4q
         gIEEyOnxBo19rxvvz/T7zIteiWprJ/49vzDSnUtWECEy0O5pgsvuA8QNaQFflrgt8nGY
         NBn14e/WJXQhhKtrDc7DjonNWZRv5ce1rpmxfu9DN6V8FJBVA3n40ENNtKzOIkUX3/9i
         MWBXvSz/jrniXmGGt+edXqR0cWsmnrT4d+GLR4jKDLYGuj+kv+WKbI1g3vMjoRb7rI51
         BJ3g==
X-Gm-Message-State: ANhLgQ3KOBar4pIglDmuzoaX10bVOdZwZSQm5tSjeDIsSOx0RwntkWgL
        aAdC7NEfG4C/Z78Wiugfw0p2Pla/cXwlyEootMU=
X-Google-Smtp-Source: ADFU+vsXyzyi+qYF7P30xEdl3SKnMs0e3iLkESTh2BBQsMZWVdzJW5b85BdQP4rcWeSVIDarW3qIa5gY6lsuDO93L54=
X-Received: by 2002:a92:5fc5:: with SMTP id i66mr5814798ill.303.1584666344631;
 Thu, 19 Mar 2020 18:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com> <1583664775-19382-3-git-send-email-dennis-yc.hsieh@mediatek.com>
In-Reply-To: <1583664775-19382-3-git-send-email-dennis-yc.hsieh@mediatek.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 19 Mar 2020 20:05:33 -0500
Message-ID: <CABb+yY04NbSvHkQ0sVHd+KjU3ZFZSZD=H99OSNjoeu+Qpk7R8g@mail.gmail.com>
Subject: Re: [PATCH v5 02/13] mailbox: cmdq: variablize address shift in platform
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Devicetree List <devicetree@vger.kernel.org>,
        wsd_upstream@mediatek.com, dri-devel@lists.freedesktop.org,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 8, 2020 at 5:53 AM Dennis YC Hsieh
<dennis-yc.hsieh@mediatek.com> wrote:
>
> Some gce hardware shift pc and end address in register to support
> large dram addressing.
> Implement gce address shift when write or read pc and end register.
> And add shift bit in platform definition.
>
> Signed-off-by: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c       | 61 ++++++++++++++++++------
>  drivers/soc/mediatek/mtk-cmdq-helper.c   |  3 +-
>  include/linux/mailbox/mtk-cmdq-mailbox.h |  2 +
>
Please segregate this patch, and any other if, into mailbox and
platform specific patchsets. Ideally soc/client specific changes later
on top of mailbox/provider changes.

Thanks
