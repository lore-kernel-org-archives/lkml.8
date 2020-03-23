Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111CAC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7542076A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584972367;
	bh=rtWWonGLfxabgsUxnmMPRo60omiZSTtJ80dw6Vbw4es=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bXEEDAcH0O2sfSCfMKDSQVHhDqL0LYPo1dGKiEFllyBDRdpz2wHLjEfDF8CLo+Rzi
	 2SAQ76ElPpnDxrXGe2U3zUiUHboQAo7LoWsRzgOHhPxkj3s3VW47KC0FogzpKsL+Tv
	 q2cfbF28vRHQNrbeLiuskyKJqD/VPJnsNyO+MmMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgCWOGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 10:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728533AbgCWOGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 10:06:06 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFD7420774;
        Mon, 23 Mar 2020 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584972366;
        bh=rtWWonGLfxabgsUxnmMPRo60omiZSTtJ80dw6Vbw4es=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SElm5W7pa722XBgeSvhII7RNPt+79YfN17KVpXWJeQwlBUHiIyy6Mm69BnVBGRcbb
         IYy7bT+WHy50PQ73gJ9am9RicQKsJJpafJFUi+8v5BRqRxZT64FQ0jPvJ6jLQdz/Lk
         zGASeP/jN8Oqrb2S7rZPRijZW1d/rIJDFy/2wrKs=
Received: by mail-qk1-f171.google.com with SMTP id i6so6213312qke.1;
        Mon, 23 Mar 2020 07:06:05 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2buaJ7g6cKVdivvB013insJmXnMzLe64Xjcr/Y1WW6CdeuDbZ+
        0B74nHmrkZFZNECT65mmfMARdx/z6YPgBFFaWQ==
X-Google-Smtp-Source: ADFU+vssGZPgRXjn5lVxKqjaxrDoxTeAGBRjs0X7b5X6jo0bCqsPmFn5vlA7NzuNLIW/8VWFJ4jmMC4dOnuNvGBspuc=
X-Received: by 2002:a37:4a85:: with SMTP id x127mr21299038qka.152.1584972364987;
 Mon, 23 Mar 2020 07:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <66b8da28bbf0af6d8bd23953936e7feb6a7ed0c2.1584966325.git.mchehab+huawei@kernel.org>
 <491d2928a47f59da3636bc63103a5f63fec72b1a.1584966325.git.mchehab+huawei@kernel.org>
In-Reply-To: <491d2928a47f59da3636bc63103a5f63fec72b1a.1584966325.git.mchehab+huawei@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 23 Mar 2020 08:05:53 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+KtuzU9tvWyka-e84PS+UMnS3=TQ=Q_5GE1tdige4hrg@mail.gmail.com>
Message-ID: <CAL_Jsq+KtuzU9tvWyka-e84PS+UMnS3=TQ=Q_5GE1tdige4hrg@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: dt: update reference for arm-integrator.txt
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 6:25 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> This file was renamed. Update references accordingly.
>
> Fixes: 78c7d8f96b6f ("dt-bindings: clock: Create YAML schema for ICST clocks")
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Stephen should pick this up.

Acked-by: Rob Herring <robh@kernel.org>
