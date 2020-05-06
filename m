Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB37C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C4A20735
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEQN64F2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgEFSsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbgEFSsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:48:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F0EC061A41
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 11:48:51 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a21so3495750ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 11:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X288OaVurKdukegnulZAEmVQ4pDlcfHNVaAG2YEQ3y8=;
        b=LEQN64F2V4A+8YiuwoPA0zkTKbpVQtVTBzVgrPJcXw1qtpXhjXLZ8Tsq4h3ywPop9e
         fRlqsmBsRs/mLYg2/OuDloL8vg/PGWFGPuQaSgL1Dc00vZe+xih0p78ySiojlp87Rmdi
         LwcL4ZPsYaMOmEeXoYxLnOuKmQ7w/jzhZ1fvMtA65tbi+KhKJfONs1cDeQ3KNWwCSsK/
         /o+mkerCu6VulXGg5ugIPI8Nb+szcj73EFu9lCMYHU9MbK1zX8gWpzvRWmt3XLFL2zOI
         L7R90obbwIKOMXhNKKGYb9WAPariksocM/u/GHEtktElPzbbTPsFCdgDqjGzkMvcu3XV
         qNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X288OaVurKdukegnulZAEmVQ4pDlcfHNVaAG2YEQ3y8=;
        b=qQbxzq3O8AExUaQpcxfyUZXQEGuedNC+xPBEsWYCgNqU9GmndKhrhJIuM7qX56vLl6
         vXtU/8trSYQWllGSQg1hI5p7/xZ5KzQmCfr7o3njPBor0BisssUDibONw10MLlkrEbKi
         pJ/yCu6e8w8jLWE4t+AJblAcrDER/TPTiefTg6jMhfX1dafD/YPMdaS6D7pB246S1+dI
         Ta23Ad6mQdDSNQmIeq2mdMrHJ72R3QFN9jjajYyHfBDBXZh3Y1HBvmKFAE++LMCsJClE
         g2ej+24gG85NymTwzfST81T+Ao0ozlU8THgdiGubVx8mm7GQe5HSI7NZUxyeBl931gB5
         bApA==
X-Gm-Message-State: AGi0PuZzU2oA/alkCs6HXD7dge94DMfmXlhsReZlM2RCI/2pPOWOQBJF
        1DeAyzXlirjRUW9UnwN0BU/HFqUR+T3iPR5XCfg10w==
X-Google-Smtp-Source: APiQypLLZoPNRlHUtRNsU2Uf1M/SP49hVCJR6Pr7fzEevP8WabBtlc94fXbOrs3iAv4ccFfKjuN+v3N0m0lQAR2Fb/c=
X-Received: by 2002:a2e:9012:: with SMTP id h18mr6002694ljg.28.1588790929673;
 Wed, 06 May 2020 11:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200505133602.25987-1-geert+renesas@glider.be> <CA+ASDXO8TJ09vNQaCyoMgfoFVouNQRw7Evx2Vfko1k_03q8GHA@mail.gmail.com>
In-Reply-To: <CA+ASDXO8TJ09vNQaCyoMgfoFVouNQRw7Evx2Vfko1k_03q8GHA@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 6 May 2020 11:48:12 -0700
Message-ID: <CACK8Z6HLhE+n=RUJLMsee5mMktzsaQqCbbkO95YmdD8SY3ntew@mail.gmail.com>
Subject: Re: [PATCH v4 resend 2] dt-bindings: net: btusb: DT fix s/interrupt-name/interrupt-names/
To:     Brian Norris <briannorris@chromium.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 10:38 AM Brian Norris <briannorris@chromium.org> wrote:
>
> On Tue, May 5, 2020 at 6:36 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> >
> > The standard DT property name is "interrupt-names".
> >
> > Fixes: fd913ef7ce619467 ("Bluetooth: btusb: Add out-of-band wakeup support")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Acked-by: Rob Herring <robh@kernel.org>
>
> If it matters:
>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
Acked-by: Rajat Jain <rajatja@google.com>
>
> We're definitely using the plural ("interrupt-names") not the
> singular, so this was just a typo.
>
> Brian
