Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9307C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA3A20720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPcxV2TT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgGJP4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJP4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:56:43 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920ABC08C5CE;
        Fri, 10 Jul 2020 08:56:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s9so7004718ljm.11;
        Fri, 10 Jul 2020 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2jwZ+DTUt+/0PqQHnFq2z8XoC0/BJ4auZW7z0y2jMc=;
        b=cPcxV2TTJwQAiEaNbWP9z9+K7QbPnltMgTaQkNRkoL+hPRj3AOYIRRDmsdv/HjLhBd
         QvJiD8IR9r8qqV2d54iir0ckD+EGZcJ9osiT6dAYQ07Q3u8xGJ4VZtAX5my6LSb8p/Vz
         CT7foH3UaZI6yhK/BRmU9znL15f9QPHj4X9fgptTeyMfil+x+vjm0kD9OO7UoswiEPRE
         y3W0VMwfRDm5KoxyIQMSdr7l0soRN7p8Ia2Y+gjLihA9bwVeV1ySYn8qIO3oHJ7Yt2yq
         QiG8TFkp4VSo/ozVaLwVhRVsUXdKcQW5nFAp7wN+TegnAoWCDKCeQSbfbTd5tvjtAVz7
         9New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2jwZ+DTUt+/0PqQHnFq2z8XoC0/BJ4auZW7z0y2jMc=;
        b=NJ4YtsXwqzflrAFIV/q/2WvN+OesSbgj9TUZPHYhFTyKquPzuUoMdXnDoFqVwfntRp
         7aorPSgH08PIOSHC1K0cBJTL1Dqlkc3arvCpj/WqBHYPomCDieqy1B5WBtXiLJC4g84H
         pZb1F1fvv36ZuxDIfug44aF1trtq2S4PyyXxPbghg2juXM+WFTBXYlUCAUeZpOvLF+EE
         ZvvZ5EiW8L2CdUXIyBhRvfhzBZ/2Kr5L6vujJs+IcfQ/G9Mi4gxGnczmJ8irj3M+dxoC
         q6x748U9z2GL7Who4JmXm/qHhlTbDBEMY8X4SBG3whH+3UKJiMfhZUPr3z/fgoaRdLX/
         nydg==
X-Gm-Message-State: AOAM533U2SoS/Gro47RTlR+EfLxBwDMfpBWR1xzWy4va3l9qz/gu5YHJ
        HRIWf6mullXvM3m9Bbra7ZQIFdQrTm0AK1N9YZA=
X-Google-Smtp-Source: ABdhPJwHbAjospPHQTV5mJl6B9f6wI4iNS+jAIysLM7TFCmtAmWHcGftNV+CXq627FmF99I/vmuICSp7n8AyiSuBo4I=
X-Received: by 2002:a2e:880e:: with SMTP id x14mr29680040ljh.218.1594396600956;
 Fri, 10 Jul 2020 08:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200710154935.697190-1-philippe.schenker@toradex.com>
In-Reply-To: <20200710154935.697190-1-philippe.schenker@toradex.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 10 Jul 2020 12:56:29 -0300
Message-ID: <CAOMZO5DvArJPAJ+PzDi=zpDmTdr3u0j9nbd3wSVT5tdV+STmWw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: usb: ci-hdrc-usb2: add property disable-runtime-pm
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

On Fri, Jul 10, 2020 at 12:51 PM Philippe Schenker
<philippe.schenker@toradex.com> wrote:
>
> Chipidea depends on some hardware signals to be there in order

I think this description is too vague.

Could you please provide more details so that a user can know if their
hardware falls into this category?

It is not clear from seeing this series what is the hardware details
that would require this property to be used.
