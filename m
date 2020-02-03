Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D63C3524E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E516E20661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580722801;
	bh=90PTvB49gOGO55ExQ0APc/RsiX8s5nixQEtQ0hlwaRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yCldRHX6C97MK83YmfdrXLsw1OOJ8+yLFJdwWFirpRAdhrbSRcwEFfnjrb5cnm/eM
	 XrLv9hl8yQv3RxeX5YqfrKzzVzHGHkD0GqNnltY84hV/wNiCtOn8rQtMzNDH6PATcU
	 YONwFsZPAoEWHPtEcCPCQDq777vff3aytgjbp5vA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgBCJkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 04:40:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727630AbgBCJj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 04:39:59 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BC7E2080D;
        Mon,  3 Feb 2020 09:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580722798;
        bh=90PTvB49gOGO55ExQ0APc/RsiX8s5nixQEtQ0hlwaRY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZnrtPPt0E/qGj4mQVzMR6msPqTfcMyQCYaCwHAW8zWi1onwkHFFLxCcb/WhZ2c9F/
         H8B+3nhoo7cCwrWT1XjKX59Eg7rsCWRiqBAw34wXE12h6d0crOA230IFq0g9NOOCNu
         bmjzjaHZduJWoB/vujKoB8R3xpEujaLfTeVrRb64=
Received: by mail-qt1-f177.google.com with SMTP id h12so10934615qtu.1;
        Mon, 03 Feb 2020 01:39:58 -0800 (PST)
X-Gm-Message-State: APjAAAVWRmgZiaCos6yQHZXEXdoOT1knj4QCyqzAwEaoisuj2CZIPkRN
        Hng2q8/LfYDQLBIVKmDhfc8WQvbbs3GL0dzu+g==
X-Google-Smtp-Source: APXvYqy7yMTTAlW5+O0G7s/WzsgPHbziXztEbOqnsDKjoXJTTDypK4XTLXpxAwgULfdRVhFdXanI6iKHKIjNLLuzvSw=
X-Received: by 2002:ac8:1415:: with SMTP id k21mr23000069qtj.300.1580722797545;
 Mon, 03 Feb 2020 01:39:57 -0800 (PST)
MIME-Version: 1.0
References: <20200203052507.93215-1-sboyd@kernel.org> <20200203052507.93215-2-sboyd@kernel.org>
In-Reply-To: <20200203052507.93215-2-sboyd@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 3 Feb 2020 09:39:46 +0000
X-Gmail-Original-Message-ID: <CAL_JsqJObO2AgP6m_=Z=7eWHA7C6q-Vrv20v08h_r0EL4pOfAg@mail.gmail.com>
Message-ID: <CAL_JsqJObO2AgP6m_=Z=7eWHA7C6q-Vrv20v08h_r0EL4pOfAg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt/bindings: clk: fsl,plldig: Drop 'bindings' from
 schema id
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org, Wen He <wen.he_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 5:25 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Having 'bindings' in here causes a warning when checking the schema.
>
>  Documentation/devicetree/bindings/clock/fsl,plldig.yaml:
>  $id: relative path/filename doesn't match actual path or filename
>          expected: http://devicetree.org/schemas/clock/fsl,plldig.yaml#
>
> Remove it.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Wen He <wen.he_1@nxp.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  Documentation/devicetree/bindings/clock/fsl,plldig.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

There's actually a more few of these in clock bindings. I am going to
do a tree wide fix on this. I was waiting until the clock tree is
merged.

And I didn't really mean to commit this check to dtschema until all
these were fixed, so I've reverted it for now.

So either go ahead and apply this or I'll get it.

Acked-by: Rob Herring <robh@kernel.org>

Rob
