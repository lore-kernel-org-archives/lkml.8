Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD4DC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70DF1207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rBkaeThX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgHQIL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgHQILP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:11:15 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE93C061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:11:15 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t4so13761015iln.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lt6hzq5ZQO4HiO3QNUBUTHvgybU3ir4bEXy46hXUV98=;
        b=rBkaeThXVt8B5nb+Cq4kDmKYVxa3SVAFiCNoqheXNihqyvUk+53LxPMfauwnzPS/Na
         VRJpDtqSyoEubgQMwX5GaMPK2SauuRNWBft/Ll8blgxDhTDb280lDQuj3Ua1vXwiKtAL
         5f3iuTgwO8le7b0VoFCIVgWpwHE22MTNbAZbUAF6edvZ7yUV42kD4KbloBmuHLcsa+br
         md9pqQns95LBAeST17auuF2R08fHlmesmmfLAMjB0hmlYLVK0q/BNfJxhRHLzU14ZMIY
         D1l+CW8LUOqZ/eYtjR+lH1FWGMbZ9SkMoSkB800k7o6EHxI711PFk/oynbxsi0OkySqw
         SmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lt6hzq5ZQO4HiO3QNUBUTHvgybU3ir4bEXy46hXUV98=;
        b=s4rixW3JCUYGDX/bKjmFVakN3kOy8MsXOH8xTLZNQmznFxwubjaRWrsRznnaV5Q56W
         m/waKOrGckKNYJFF+g0vPZbk6533Zsf+TOKMA+BG4LGn42E9oY1qL7ZMxiePqACNAKnA
         qfUe7/dfmFxLEfCIhesaIJgq0+r5AddsZRNhTk/tkI+JHubYGAkZE3zWsImvRtOfRKNp
         5Kd/rJMxq+QFtpqInvjvUFGN0WZ4IwytSRytccQqi5ZIoIUx2txeeJtvALXiVc/37O3h
         ep3k+QCFEtFsNnlK09J2tac9aS9qRaXvYWpgkqU9rl543aT1f5gX2aEBksuhmtQnntqF
         GbWw==
X-Gm-Message-State: AOAM531tVVXJDrl9ObKZ87pUYM3Qp5XWeaerr3kYeYUIhfjidU9dX9lL
        EYzDTAMYAy++t9cxQ3SalQ8xvRaiqZ68McyKRUJGyg==
X-Google-Smtp-Source: ABdhPJzyL87H7xo+SFVJo6OxddJRwCf8TqTo/jG/8v4crswXEsNPG1scfuanoeHlA4HikpKT8hXnnNsJOLQbgj4Ix9w=
X-Received: by 2002:a92:c904:: with SMTP id t4mr12816222ilp.257.1597651874349;
 Mon, 17 Aug 2020 01:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <1597644455-8216-1-git-send-email-jiaxin.yu@mediatek.com>
 <1597644455-8216-3-git-send-email-jiaxin.yu@mediatek.com> <CA+Px+wXSbGLb+AZnF8ETRycRUVjqk4xacm5DH6MzuMw0vh6Wzg@mail.gmail.com>
In-Reply-To: <CA+Px+wXSbGLb+AZnF8ETRycRUVjqk4xacm5DH6MzuMw0vh6Wzg@mail.gmail.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 17 Aug 2020 16:11:03 +0800
Message-ID: <CA+Px+wUMXoSL6w0wBduE7obJRWgCteeT8=_=U=8LR34JKTTGZA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: mediatek: mt6359: add codec document
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, howie.huang@mediatek.com,
        eason.yen@mediatek.com, shane.chien@mediatek.com,
        bicycle.tsai@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 3:29 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Mon, Aug 17, 2020 at 2:08 PM Jiaxin Yu <jiaxin.yu@mediatek.com> wrote:
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt6359-sound
>
> The compatible string has been removed since v3.
>
> > +required:
> > +  - compatible
>
> The same here.
>
> > +examples:
> > +  - |
> > +    mt6359codec: mt6359codec {
> > +      compatible = "mediatek,mt6359-sound";
>
> And the same here.

I misunderstood.  It still needs the compatible string to match the
corresponding driver.
