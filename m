Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008BAC54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C872820753
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589287876;
	bh=HXOMNAAV5i7uryc5jqMFnXGloB/kWRu8vcUFOMkisMU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vcqyar3viSW3/DFb5ySfKjATu6sYoro2B/X5pJLUuppcLJbrPLtNb2B3NpDJWNLHf
	 NECfD1Gi7cIoOddv/kIT93bGbrUJAdtGWwU3XS5ZwQvUpNAGQb8LkwKu52l+uICoVF
	 yssYYp7NEmg56gG52vA6/RhunzcYZ09cV0QhmzWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgELMvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:51:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgELMvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:51:15 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48D9920753;
        Tue, 12 May 2020 12:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589287875;
        bh=HXOMNAAV5i7uryc5jqMFnXGloB/kWRu8vcUFOMkisMU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MyTktIuf9gYyDHEdCKCEbjxi//J1qwvBN2D/FfKuWua0SBNVrk+U3zI4FyJU+tRSn
         uf0DlYCvy8pOITWv3pNJO4unGPVWJYaQXdnz4C5Jpuuv2tI4J3YHN06au52gTHBgVA
         OdRhiIBh25xilLIVcs5/OZnQeGS5/jiej1TnP61Q=
Received: by mail-oi1-f177.google.com with SMTP id v128so1255645oia.7;
        Tue, 12 May 2020 05:51:15 -0700 (PDT)
X-Gm-Message-State: AGi0PubSqUqyxcT5lKo1OyoiF1yXanLTMcCp0Mu8U7MCxtgf57JkPeNE
        kQqP0LXUEZnAKMMEh5KD9AcW+28wwzmcdKgHag==
X-Google-Smtp-Source: APiQypIYDL2e2mHa7jZluV0BjNao3zn0dcuxxGE3/39KlraczebWuS2rF27T0TgdeZFNrIkXqJJqsGvz5JnqcKMT69M=
X-Received: by 2002:aca:51c3:: with SMTP id f186mr10992380oib.147.1589287874633;
 Tue, 12 May 2020 05:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <1589268410-17066-1-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1589268410-17066-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 12 May 2020 07:51:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ_XKH0etPaX-qZq1t+2Z+2dhXeerCQhU5U5ypZXjr=7A@mail.gmail.com>
Message-ID: <CAL_JsqJ_XKH0etPaX-qZq1t+2Z+2dhXeerCQhU5U5ypZXjr=7A@mail.gmail.com>
Subject: Re: [PATCH net-next v2] dt-bindings: net: Convert UniPhier AVE4
 controller to json-schema
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 2:27 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Convert the UniPhier AVE4 controller binding to DT schema format.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>
> Changes since v1:
> - Set true to phy-mode and phy-handle instead of $ref
> - Add mac-address and local-mac-address for existing dts warning
>
>  .../bindings/net/socionext,uniphier-ave4.txt       |  64 ------------
>  .../bindings/net/socionext,uniphier-ave4.yaml      | 111 +++++++++++++++++++++
>  MAINTAINERS                                        |   2 +-
>  3 files changed, 112 insertions(+), 65 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
>  create mode 100644 Documentation/devicetree/bindings/net/socionext,uniphier-ave4.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
