Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EABC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 14:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCDD42072D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 14:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDW/42cq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgHHOMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 10:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgHHOMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 10:12:08 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58BDC061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 07:12:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t23so5106188ljc.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 07:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LMqHyf3LXGIDXUbopLnPGbd9R8RdUtyLXfTrrDv3V38=;
        b=pDW/42cq+vOIDqCqYbV1QXe4jg8FuD4oivqyfWq1sfqthNl2URn5YsPARBeX8q2PiE
         0ModzwAvC58HmS4KecqMUZL31Mvvj+FE7uXTzFD+8l/TvzB3OH0ltSb+D5klpnMfGQWC
         OCa81PRHOyaCG7Lic9LljJPI3QbbC4WF+6KhiXfp5CbVKhBs6+fNXho4xae/aewQRKAX
         k0ySsgQ8t1ZSH3QUlKi0lMxLPBuP4ljK44WVvbORPlEbKtqT9tc7ZhmstVXKfnr8CbhW
         VD5WrTKArIJ9DndkmX3kUuSN5DODE6Pd5sLUh5yXo35APmmFoupN3gg6dhnX24IQpn/x
         es/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LMqHyf3LXGIDXUbopLnPGbd9R8RdUtyLXfTrrDv3V38=;
        b=YucLg5DJMnGvQnHc1M29itKs0757/bFw45ESPjn2WFDc8IIfGt6nrsXSvoCPzin19j
         iYOnl4OliT9WdeoJADX2N5x7i0Daeet/uoimR3hl2G/9VofQQlyDzCC+iOs3X7LDymMC
         ty5/GW8hnCrtqsTHoeHAM87T6FhR6wLeN0Vlrchgxjv+F3nXRlB+dHjqzIhvQHiyLhIJ
         1pnnUZf+ElIvBuytlQH9iMEbvf531WiC0+C3J2aRCC0lJZ+qpZolCGljb2OU58WTBWD9
         TUMQb4dFRpkhXB92ck1BqIQ5GHQmAiS0TLYDTHM6CnFwOJpVK2zNm90mP9hhhRP7gnOS
         HIrQ==
X-Gm-Message-State: AOAM533NDyxyPzc6AF9sR/XvNyKWscV2o7Qj03hYeQnkpLi9vSH7w6BG
        bMjnjti5ALp3qJonAnlw0hMy0SAjPb9Y4Y5J+eDXm8Gj
X-Google-Smtp-Source: ABdhPJw7eAXuL/cm4AaSYkulhCbbgUwXjubMMqsZbtXk26kQ274cYmXXsiRxvkBFTfMkv1vnfLV3N0TTNiTBpoT3LYE=
X-Received: by 2002:a2e:920c:: with SMTP id k12mr8968852ljg.29.1596895926202;
 Sat, 08 Aug 2020 07:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200708125622.14443-1-grandmaster@al2klimov.de>
In-Reply-To: <20200708125622.14443-1-grandmaster@al2klimov.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 8 Aug 2020 16:11:55 +0200
Message-ID: <CANiq72m=pUsU9_4ZTGDKiO8DHtxcsofF3Nk6cfSKCyiWQPueSA@mail.gmail.com>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: AUXILIARY DISPLAY DRIVERS
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Wed, Jul 8, 2020 at 2:56 PM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
>
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
>
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Thanks! Queuing it up.

Cheers,
Miguel
