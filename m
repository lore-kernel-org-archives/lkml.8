Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AA8C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D2820771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FlQhQpkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416784AbgDOSb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2441546AbgDOSbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:31:18 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD416C061A0C;
        Wed, 15 Apr 2020 11:31:17 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id j20so6321435edj.0;
        Wed, 15 Apr 2020 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SnqHof2dPOXKoAKXV6iF52K+2gAJh/5rV8baIqoPo+o=;
        b=FlQhQpkChTKQQKHE/kjZW2JHPP/s2wqj9SshjyqQZHZ1Z085P88gpkVzD7mYH4Ej7H
         /8kITqU0Ici++jfH5rEOOhqHL0jd2qukqDVFVcGnLbYwh/apTw4YNDCH+2M+gmUzrjar
         hoOwAfFifXLoTbP6k1cH7slupuNak1QwX8L8/7m09MQvu3p7JA+AeUIKvRniPPE9ubhi
         Pel0J86HNvqJyD6otKJnogaD9EIB9rzqn4z0qryuqX5unULzwv7/rr5r7rW++KNYstiw
         oWMcguoovE7j4w3t5WO84J6Y3TYN8lQK7tvYJLJAvcFFqrrqRofNt2LxQS7v/bmmp6xn
         WWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SnqHof2dPOXKoAKXV6iF52K+2gAJh/5rV8baIqoPo+o=;
        b=s/ZjJd98cd7CTW6wPeBt2BNTsAu2wt8TWaaVgWykJ7Vb/4Um/MIDxqboJBz7AFWN28
         vFzL1SZFlcijAx347nPf+sCfc1rQK1UywDasrTPvd0oMj5yiptf05ihpqRbarVWuLCQH
         ZdobpWMdzesZtH5RY2n/efeUKVPIg2cWMFePhupVgsarVj5dKKfeitoo3bRiNjBqbiYj
         8f+VFW0BlVgueJyVCOWmsomMwihHibVgSdJibOeYnCMNkp7IO/4cSBV5fM9/rjQsU6TA
         d2gMi/DIMTkoTv42ToFswx8RWdenHavXKUhAlOg+LFfwxOaAmgOP9Z4Ox5XyU8etKVHL
         NNAA==
X-Gm-Message-State: AGi0PuaQTM9UvrdaBMuq+umYbnVgjOl2JPalIVtxj8deLHcayGXl/PRG
        Pd9zTy6OhijXknyYFEegYBk7NlzfeOF6pgz0wSg=
X-Google-Smtp-Source: APiQypIRaOcf7VxFnJh078+KvE/8zI4/yu3CzjaNn7Hoogp4F4FsEu0TUbJADLqHifTfYx7wJfx/Q6y04OU6mhoRBdE=
X-Received: by 2002:a50:c004:: with SMTP id r4mr24970839edb.110.1586975476369;
 Wed, 15 Apr 2020 11:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200414201457.229131-1-martin.blumenstingl@googlemail.com>
 <20200414201457.229131-3-martin.blumenstingl@googlemail.com> <907211b1-c8d5-39cd-5d2b-dd41efbdc7a7@baylibre.com>
In-Reply-To: <907211b1-c8d5-39cd-5d2b-dd41efbdc7a7@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 15 Apr 2020 20:31:05 +0200
Message-ID: <CAFBinCCjHtSNigkeG_M4sVs27SemTMu0hUEQEHk53odAybm6sA@mail.gmail.com>
Subject: Re: [PATCH RFC v1 2/4] dt-bindings: power: meson-ee-pwrc: add support
 for the Meson GX SoCs
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     robh+dt@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, Apr 15, 2020 at 10:51 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> > +            - const: dvin
before I resend, can you please double-check this reset line?
it's the only difference compared to G12A so I thought it would make
sense to check if this is really related to the VPU when we're
switching from one binding to the other anyways (as now is the time to
sort out pending issues - in case there is an issue here)

> > +#define PWRC_GXBB_VPU_ID             0
> > +#define PWRC_GXBB_ETH_ID             1
>
> Should be PWRC_GXBB_ETHERNET_MEM_ID like meson8 bindings.
I can do that, thank you for looking into this!


Martin
