Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF49C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BBE52070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEj2e0uQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgGPHLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgGPHLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:11:35 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DF1C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:11:35 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 145so4608681qke.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ROegDUCMbOPfiff8onpiuWKK5fP10rADXj2kAfYPzfQ=;
        b=WEj2e0uQM4cpTKdNW6Ykzaysy8NWbkSWNfV3nrn9b1/DU3PMRlKvRw9V19Eg6XYY8E
         4+SIqkC9nrqOu5AewYhI4mZvhprvHr6mCEH3bGIHPKOyxlyxMvHOnhaB29Q5GfJHdbxV
         uhBlmmnkgmXh1E29XP6vc3moJtZqN/6MN3WRDgVlLIgeVrfrIM/6DRRzKvSBU3sZqGrj
         awp9EUEhTUj6nZiydt8op1sPqXMDaQ6YTqmLTkWp5uLVLT+ndS842EH8A/tq2BlLRaqV
         OWoqpafaG5W8rWEgMUhVvcsOezi58fBot+W3fSwQ4jnhJUqkf0Q9SjodQFwzwzTX36/e
         RTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROegDUCMbOPfiff8onpiuWKK5fP10rADXj2kAfYPzfQ=;
        b=OJrjDkm9BHqileutWdz3ExbM1/gs0iqiRf/vtoIUUn+E7ja4dA8FXF3UL9dlqH9LwE
         mnRfK7rDgF5Z7ruQRzLf4MrZJOD8LPXKxgfZzVder74AGCg7X2cvBfA0HZrR3OwxDrKh
         fUfeA2B2d0MVDnU4/Kz2E3HZN+jQrGOy6Wh+G8QH88wZz4FzfdVkdEwRLLF1PMsqFNvL
         Aby0nY9tq4d4H9Gg0eGcBr1TwSIvYf3tQR48h2m+jH7UlnfPUmEbtBDUCWFM4AW8Av9n
         I15swMcT7+oyqUu+OM3KXYXNeoO40ZaojWha7QSm5oSe+SEdx7DtuMR22i42HFM+WqjR
         3WjQ==
X-Gm-Message-State: AOAM533rgu6H6Wtsc9iyBz+G6UtaCennDAJg22bHJJxAXIet29Gs1qlI
        5AdPuNsMwfSNwTcTp6GZUv0XVXhS8wvWApMdyX44oFwK
X-Google-Smtp-Source: ABdhPJzNnTtaVx8wrGIAFkZ+oAraxxEDPT2R5W7Xl+2T3Ftueo/ACrghB96323WzQA3uLoqKR/x5XaK8kB74IPIEXsk=
X-Received: by 2002:ae9:f803:: with SMTP id x3mr2510007qkh.488.1594883494596;
 Thu, 16 Jul 2020 00:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594880014.git.zong.li@sifive.com> <28365b581b04d0237e127363a63c1ad72dbea683.1594880014.git.zong.li@sifive.com>
In-Reply-To: <28365b581b04d0237e127363a63c1ad72dbea683.1594880014.git.zong.li@sifive.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Thu, 16 Jul 2020 10:11:18 +0300
Message-ID: <CAOJsxLGHNd1DcStOALkQkcg8u25zj8Hpf0uF1kMj+uO127q+yQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: fix build warning of mm/pageattr
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 9:16 AM Zong Li <zong.li@sifive.com> wrote:
>
> Add hearder for missing prototype. Also, static keyword should be at
> beginning of declaration.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>

Which prototype is missing?

- Pekka
