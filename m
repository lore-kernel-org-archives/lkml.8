Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902BCC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE622076B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgD2HpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:45:08 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:39193 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2HpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:45:08 -0400
Received: by mail-oo1-f68.google.com with SMTP id c83so222659oob.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 00:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rEZmeAk6jaK+T2WOTA1eNC+ayuAXk5EqXJwMbJKfWVc=;
        b=COxUhO6GcEiKtiOOCuphEEF+9PSqHEuI2wmw+JlpedWMK9YLhDYqozNVXy/9jrB0ZT
         65h94VN5rlkT4tY2HruAcsT04C5HK67bEylHGoR8+HQk71VV+XZ63Jqez9HF6wWyNXZR
         XgtFRGkIBe0ANyraGIVIRgwPn9nAEHqDXpn7nc8g+1FQpxjaJK2JeMY9VW45Wqi1WgDW
         FN6oLQ7poKJUHT5Z222j3ZMAcDMfQRGs51Gm4x5Fk4Ov8oxx3aRR0sIcIX2jDQFjC45J
         79r7suy/SnfYQdr6DE3A79HKRT6KXkSd8J8DQOwKlG1S2I8GTyhKUC4to41I6B2byNU+
         wxbA==
X-Gm-Message-State: AGi0PubvmJ9JrEMo+7nL6xtz39w9C8q6iK1+kvmredEv9p/xZg79CEF4
        U8fug9vhe8BgrI2flKetn+0tZFGldwitG3Uq2xI=
X-Google-Smtp-Source: APiQypIP3h/7moyhoQ8NqmMh0j1DwjTSMQmWJqAXa8x2R/o6FD1rPckgRmfvL+mogKMUh9WhHIH2d1grrdKwA3kzpE4=
X-Received: by 2002:a4a:eb08:: with SMTP id f8mr2660450ooj.1.1588146307169;
 Wed, 29 Apr 2020 00:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200428194449.22615-1-willy@infradead.org> <20200428194449.22615-6-willy@infradead.org>
In-Reply-To: <20200428194449.22615-6-willy@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Apr 2020 09:44:56 +0200
Message-ID: <CAMuHMdXdHTm2gN2cZFupYpP=qn2ijAViyyQ6jaMGBNKNXMfiAg@mail.gmail.com>
Subject: Re: [PATCH 5/7] m68k: Thread mm_struct throughout page table allocation
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 9:45 PM Matthew Wilcox <willy@infradead.org> wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> An upcoming patch will pass mm_struct to the page table constructor.
> Make sure m68k has the appropriate mm_struct at the point it needs to
> call the constructor.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
