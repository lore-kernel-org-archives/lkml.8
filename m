Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F7DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA021207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="e7dfnkL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgG3PMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgG3PME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:12:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F05EC061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 08:12:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r2so20171165wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 08:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bd6k9y9ocae6qDNTeHFOtb+QmjW35gPCvFK2OagBbAk=;
        b=e7dfnkL3oHidiv2xiTBuK7S3CHJPYTmyaCn9j9JyOM2kTQgefIxUsl9AW7/EUa/HVv
         jXbUXc3YM0vy5t6Myr7f6toWwSrUmiucL7CmvB/QoT7VWI2tAJ8eg/8gPYgcIC8B3Bx7
         nkEk9bRhEpkjLI7pmsscD/4YjNQ0zmo/0CQBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bd6k9y9ocae6qDNTeHFOtb+QmjW35gPCvFK2OagBbAk=;
        b=RdH0Ou40/7QzUdsTaZ/nAdWtXqsARFkGDaI2y37xPKunfBA8R3KkDrVERJPkPF6iLx
         IvD262fA0jTgtIf4mL5v09YyYKFH8fMzKinha1gXxDQBq2p75yuwNUYCYC8kiSo0k/tw
         pfVESIkC6zx6ZnLYafJq4nOOC7vnNV4/mxA/+A5dj/kgaTUakFgfLysdcPEvBfCVjbBp
         OUkKPIXpVVBWawmHgqQXOGX4LQmNwU3NVWTYERWJ8bfeqaM2aAWpAzDnaDML+T3b6KbH
         hNQc3JAMStgqBwPcmQzLrTbYhC8Eu/rBR4Gb7B0hw2TZmYz1zJk1Jfk6MjZa5YnneUWv
         hsRg==
X-Gm-Message-State: AOAM531tYjTeSJhTaeXuzLudJKekeeCKJ15I51/oUCq+tPTZnpULPIba
        IYSnSEUM6bLYul1q43ZvxHVjucphpjgre+WY5uxv7A==
X-Google-Smtp-Source: ABdhPJyTMKHCgY67oNooR7z73laB6BI1tH8YVqF7S5lwcLdP6Zdqj8V26HYN5HBJVvnd7cd0j/MA/HFSaEVy1Oo4fzk=
X-Received: by 2002:a5d:55c9:: with SMTP id i9mr3145795wrw.31.1596121923069;
 Thu, 30 Jul 2020 08:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200727130517.GA1222569@xps-13>
In-Reply-To: <20200727130517.GA1222569@xps-13>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Thu, 30 Jul 2020 10:11:52 -0500
Message-ID: <CAFxkdAphiZJWnrDUNToVwYJ1Nr9H+E9cSLwA6w3OwSpO4K+pow@mail.gmail.com>
Subject: Re: crypto: aegis128: error: incompatible types when initializing
 type 'unsigned char' using type 'uint8x16_t'
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 8:05 AM Andrea Righi <andrea.righi@canonical.com> wrote:
>
> I'm experiencing this build error on arm64 after updating to gcc 10:
>
> crypto/aegis128-neon-inner.c: In function 'crypto_aegis128_init_neon':
> crypto/aegis128-neon-inner.c:151:3: error: incompatible types when initializing type 'unsigned char' using type 'uint8x16_t'
>   151 |   k ^ vld1q_u8(const0),
>       |   ^
> crypto/aegis128-neon-inner.c:152:3: error: incompatible types when initializing type 'unsigned char' using type 'uint8x16_t'
>   152 |   k ^ vld1q_u8(const1),
>       |   ^
>
> Anybody knows if there's a fix for this already? Otherwise I'll take a look at it.


I hit it and have been working with Jakub on the issue.
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96377

Justin
