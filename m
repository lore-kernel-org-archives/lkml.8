Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8426EC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55256206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oksKOqpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgDTMXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgDTMXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:23:12 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81731C061A0C;
        Mon, 20 Apr 2020 05:23:10 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z17so7868813oto.4;
        Mon, 20 Apr 2020 05:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dB5fFXDtNZJmKi5W1CbxDiopUm/CrNq1L0Xs/KI3ugA=;
        b=oksKOqpkL5BIT0FQ3tM/1yCv9/QCkBbYAp9oHSGmnD02GSrlJ+H5X28PF7Lhp2B4+3
         c30mxy6tvb98VsH8vSWt0ccXD77/CCm79AR2X4nbroKfgCilofvvz7aOxU3rG3BNwiRh
         WHui24ltdhTl1ZT/EILNfr+ybZ17tMMn24RefPqYIuJchHHpYB+23fF4TC4vY4V7Unmz
         2gqK+KawqQcldK+MKv0JoPXQSd6z+JqZssBruNIqIfA2KxDEPdMdS9N8gRTa1xTOkiqh
         WAb+qQ29Yf+tjLq37uNTEmaXlQz7babkJUE+R2l/R4xEQMa8KJDboJQR16desRHjNAjg
         7vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dB5fFXDtNZJmKi5W1CbxDiopUm/CrNq1L0Xs/KI3ugA=;
        b=UlAZBTrPvQUbz9kCF2H4A91QgqrMQgcrnrE6PTlPM4JUxFRHJAaEZ5tVffXSaq0EWt
         f0by1AlQu0o0UzMgiajpq/yYLV9mcjkpcrgEVwP6lxP4x6tnMIU/VDgnNoluzRQEWXkx
         4N2KI6rrpoai/lP1Fq/UUFIsdVSdW7bj8IE8q4evqUp4pyLivgwr5KUTTWBEn4gCKK8l
         98lvt+/I7QKjtGKKm6WeKTQifqwMg+DMXmb9uJn31Q4m9DBIFF9hyidp2v7f0TWhdTzd
         C0kqDB3YACI9ehWDjNYYWTlawOEkpI0zsRUunEaZUe+sX9a30Nq3lRFkFM/RLwKGMbOA
         JSGg==
X-Gm-Message-State: AGi0PuZdYlx7sHAX50FUlE3fjFZ2K1tBpABkqXraKnzN0mV9E/XY58By
        uevGM29z9V5X155wrPBGCwNdK2Uw6wPfTx1QX8g=
X-Google-Smtp-Source: APiQypKmSZJ8nmissvGU/pkWsPLYQA+fpHEY2Jk4ZHL3avI07b483TyKWn8igklk6qenSoDZ5w/ar4w4V/qRc8lWCLs=
X-Received: by 2002:a9d:19ca:: with SMTP id k68mr9591231otk.232.1587385389897;
 Mon, 20 Apr 2020 05:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200417221341.31428-1-TheSven73@gmail.com> <20200420121542.GB6507@sirena.org.uk>
In-Reply-To: <20200420121542.GB6507@sirena.org.uk>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 20 Apr 2020 08:22:57 -0400
Message-ID: <CAGngYiWauBTnXDcP9UC1S7U5Ogy0B=bUZSdGs1Z9aKZ2+sB=Qw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: add Microsemi ZL38060 binding
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 8:15 AM Mark Brown <broonie@kernel.org> wrote:
>
> > +maintainers:
> > +  - Jaroslav Kysela <perex@perex.cz>
> > +  - Takashi Iwai <tiwai@suse.com>
>
> This is supposed to be people maintianing this specific binding, not the
> subsystem.

That would be Liam and yourself?
