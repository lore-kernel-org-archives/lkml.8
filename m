Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D681BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24632098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC6Brlut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgFPNJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgFPNJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:09:46 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE0CC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:09:45 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i3so18910735ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W5lNDN4XvhgVJGDzZjuQGBV6vCS7u5Q0qv4S3R0f6HA=;
        b=fC6BrlutBv4Ev4Mlah+M7GxZQOjrLGixf9S9YBCTFbH2jJWAW6bl2+GxOVJae2obkx
         g4lE1TieN62xSEq1lMoza9PQ+pbVlEPkMc4rkC1Ekhcflrm5ccFTzyk9KiNJRgd5M1RB
         ZXPB44WqY2gpoS/LIw9loE+mBpoNj8RhC6Tj3zjxHaWW5Ln6/kQzoznzL5tNemVR/HUn
         /LM8F1mQ03A8IESTfVT12kTprlJrOPyrupDixiyZLr/z4VDxJ9ItKbgKpjMzrvP/HCEE
         1O7/HvLf2jE1IuqfN70Q1iXHvbkzX2otf2syGiqq5atadnP7xbhcmTCa7Isqv7QK1csQ
         5nXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W5lNDN4XvhgVJGDzZjuQGBV6vCS7u5Q0qv4S3R0f6HA=;
        b=Z5u2nMJ/9NK1DcIFd6EE7/XDeL5Iapi2JRB+/kzBaA8axf1X8ae8lqdwGJ+G5M1Ab6
         2n5RriydGP/bXyW1O0h1AVnpwXNeJALCU3UwoDriN9KMfn3wvvUf0IlMETGB4gjK7jir
         zfZhHV2IAjXf/bCuQbMl64P+9+YoRo7PvbjyWTk2T7ikL7UoiNKqz9hH99Dd9tAg/neO
         8BSTaql8FpH6EIQ1NdmIzHgb6osbdXPiCLve0xY9o9LOXr6HAcGQEIZ65FrBSO0zyvM2
         PxvaKs9SVBCz7hIKur1qhM6jY8goDui8gCzzNROGYfKy5szPY1mY+w5g6vfXHwemxsn3
         XRWw==
X-Gm-Message-State: AOAM533TdlElvIR8zUFagUqPgtD/ciS+EtTaxnMabl79JGwgWXnVOYcg
        2uswQXmEll6giq7gvnaSWZyltr90Uend0ll67mE=
X-Google-Smtp-Source: ABdhPJy1/EsjFjJVgeAmSX0WUaO/aC4zyoYgXp9YqJysj+VPhOPIg2WvsRAzxBgAeFYr6Q+NTosAKeRXCsvgqfuooBs=
X-Received: by 2002:a2e:1558:: with SMTP id 24mr1386210ljv.202.1592312984261;
 Tue, 16 Jun 2020 06:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <202006160328.6MfJNuqX%lkp@intel.com> <20200615231529.GA119644@google.com>
In-Reply-To: <20200615231529.GA119644@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 16 Jun 2020 15:09:33 +0200
Message-ID: <CANiq72kH3mw3yRpyjrCNxKMXtRmx8a_Yto_bOct2O0OZ_UMyuA@mail.gmail.com>
Subject: Re: [PATCH] compiler_attributes.h: Support no_sanitize_undefined
 check with GCC 4
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Tue, Jun 16, 2020 at 1:15 AM Marco Elver <elver@google.com> wrote:
>
> UBSAN is supported since GCC 4.9, which unfortunately did not yet have
> __has_attribute(). To work around, the __GCC4_has_attribute workaround
> requires defining which compiler version supports the given attribute.
>
> In the case of no_sanitize_undefined, it is the first version that
> supports UBSAN, which is GCC 4.9.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---

I am happy to see the `__GCC4_has_attribute` workaround is useful
outside the file, too (originally the list was meant to be used inside
the file itself, but I see it is good to reuse it).

Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
