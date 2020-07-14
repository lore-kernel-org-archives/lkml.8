Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AB7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C8912256C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594749190;
	bh=Vj9u8QF9x99xMmejTwSLhX1eTftkeD98fKJvUc1Dfws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gZm+myhD70sWKqZzMvyahbaGutgZdNiw4/Olgr9mCYH/TfXwz0IMtOWm0h6WOpPND
	 WbF/RwwbOiviiFWSc/5NTIXgYsj5c4x5YfnGTfpqnWXfUDwjJv+ekMdjoHadVp+f+q
	 rIMa+dKI1VaSYtieCgAzvacMWYI9n/PXCMLOPhOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgGNRxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgGNRxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:53:09 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70E5E2256C;
        Tue, 14 Jul 2020 17:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594749188;
        bh=Vj9u8QF9x99xMmejTwSLhX1eTftkeD98fKJvUc1Dfws=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h/LcrFQhreoRzvurbroMwkTmQ359hV48l9cybtWCBaOFtWTXb4wI4GMJFqJ1yaZwS
         17nUkwG5qYZIEPugizU2WFZGkh4XDeo9yrcMshphwgzT2wfk4nQ04mAarfL4g4vK+W
         YI5C9xFqehV0JuttYHL4lLcddwPuD7JqlQ7F4iTE=
Received: by mail-oi1-f173.google.com with SMTP id k6so14572868oij.11;
        Tue, 14 Jul 2020 10:53:08 -0700 (PDT)
X-Gm-Message-State: AOAM532oajVipUrTyLccnmcL3uep0f+wk1mRqq0qOQhdihvaXUMkKKtR
        a3I22+at2Knckf1bSo0QKFTPkLtAeUaiPk3Fcg==
X-Google-Smtp-Source: ABdhPJzeQjKGJO3Po7FN1n6GH1S+VMKuEzA4tWJk8eA1Ub0hYOYIbQ9EQOL3U26bSjQVI/j843zgHlHyOlWhcVywtCA=
X-Received: by 2002:aca:bb82:: with SMTP id l124mr4795615oif.106.1594749187884;
 Tue, 14 Jul 2020 10:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200623114005.791643-1-yamada.masahiro@socionext.com>
 <20200714022252.GA1151466@bogus> <CAK7LNAQrdqztMrHtAHnbMkxeaDLLyBS68WVovev+zytHdD7RVQ@mail.gmail.com>
 <20200714095259.GB4900@sirena.org.uk>
In-Reply-To: <20200714095259.GB4900@sirena.org.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Jul 2020 11:52:56 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLvMbeMQL+SFgA58cZ=+FueSB5qYKf0f-CBy83S4sQ4cQ@mail.gmail.com>
Message-ID: <CAL_JsqLvMbeMQL+SFgA58cZ=+FueSB5qYKf0f-CBy83S4sQ4cQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: ASoC: Convert UniPhier EVEA codec to json-schema
To:     Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        DTML <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        - <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 3:53 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jul 14, 2020 at 03:13:26PM +0900, Masahiro Yamada wrote:
>
> > What do you mean by Reviewed-by ?
> > Do you expect this to go to the asoc tree?

Yes.

> > I just thought the schema conversion
> > would go through the dt tree.
>
> No, bindings changes usually go through the subsystem - if there's any
> other work on the binding then it'll usually also involve driver
> changes.

I have been taking some conversions so I can test them when they are
standalone, there's a low chance of other changes, and the maintainer
tends to be slow to apply and pickup fixes (not Mark).

Rob
