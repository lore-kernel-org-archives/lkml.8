Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8207C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C9422BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598513356;
	bh=nbSZMecGtdmxZW4q3TGUmYJN2UdboWHon00s9zo57H4=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=EzHcoe0LE4TjzkGKE3PGFfLnlgeEUXjEOoiaWnGMl2nPJDpfo6VvjWEculOoJbYxZ
	 Iz3sDoO6c5QaFS0u69lEYr6JB/3tvyicGGfzfXr8kWNkgD4r818YFaamoWsuW6F+mG
	 5Pja6butc8YAP2vqDcrJ3pYiMUvnHBUj1CnJAnTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgH0H3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgH0H3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:29:09 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F15BB22BF5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 07:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598513349;
        bh=nbSZMecGtdmxZW4q3TGUmYJN2UdboWHon00s9zo57H4=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=1vhWaygJ/COg4tZPDl02n6HNO4/LbDWA8KWd9BXDCUh2IC5CpHXw7iwIxST1HzMoT
         Ma5WMf1KGHu0/lg8PxmCkPbvPbxkmXyKahNu3NSsKuEK8vr44CaGnRTYRnUF+uwMKk
         NJ7DwnlhSIzKlBkn0VI2+tih5GFWTGpjGbsCoVK0=
Received: by mail-ej1-f41.google.com with SMTP id m22so6259939eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:29:08 -0700 (PDT)
X-Gm-Message-State: AOAM532D6M2BiCxBWmRMIxSokmq07xyT/Ii/EdXar+R/jcM+YXKlhgvc
        lG/zvi3DOaN1523GxcVY8/fU4FKl8hcw1ruofl8=
X-Google-Smtp-Source: ABdhPJy8EQNVJk2xtAcp7FmtzkGSLEabjI/9YF46/da9HZesZBfsKqnmi4daxquL1QXjjh23ke3wwOrxNqtH+LnrXmM=
X-Received: by 2002:a17:906:bcd5:: with SMTP id lw21mr19315061ejb.454.1598513347486;
 Thu, 27 Aug 2020 00:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200827072626.23331-1-krzk@kernel.org>
In-Reply-To: <20200827072626.23331-1-krzk@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 27 Aug 2020 09:28:56 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc37f1vRDXjw6fmS5UArVFZ1dDup8Pq9o-mCN0V2ga43w@mail.gmail.com>
Message-ID: <CAJKOXPc37f1vRDXjw6fmS5UArVFZ1dDup8Pq9o-mCN0V2ga43w@mail.gmail.com>
Subject: Re: [PATCH] maiblox: mediatek: Fix handling of platform_get_irq() error
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 at 09:26, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> platform_get_irq() returns -ERRNO on error.  In such case comparison
> to 0 would pass the check.
>
> Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ driver")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 484d4438cd83..76e4dfcf5228 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -525,10 +525,8 @@ static int cmdq_probe(struct platform_device *pdev)
>         }
>
>         cmdq->irq = platform_get_irq(pdev, 0);
> -       if (!cmdq->irq) {
> -               dev_err(dev, "failed to get irq\n");
> -               return -EINVAL;
> -       }
> +       if (!cmdq->irq < 0)

Ah, this is wrong. The irq is u32... without my patch this was so broken...

Best regards,
Krzysztof
