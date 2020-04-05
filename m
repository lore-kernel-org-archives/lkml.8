Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623E3C2BA17
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396C820672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEqjKUhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgDEOh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 10:37:29 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33718 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgDEOh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 10:37:26 -0400
Received: by mail-yb1-f193.google.com with SMTP id e17so7299718ybq.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mg+J5XS0nK+zoa4Dm5ITK5YdaJ7PSdz6gYixjtBG6RI=;
        b=lEqjKUhi2UaTN5PtzwT/7m5VaXfHxWJhlGqJC8zLutFwjRy57edPXRJnCiDHJyyLx8
         qfxmbARD7wXjfCkxhPUq7WIIJyduJUsdGTHklqQdCG8mezs5TRbe8suxyVCF8aYjALgV
         mw4BRuiQ5RWEEM7nAQKX9PrB+yCk85o2e/bJWJ6F5jeEX/7/tdnxf9cDM0BG54AS7wce
         jtAuzlwSLxo/M29dcyMbLhSInOpimWmJSpxGAP8Uo7OPxHeRnMfd4wSF9MgzwOkCKFXX
         m18mm4NNYiBin6jaRJuJkpnv50s5qlB4X52jTXhOk9+vjAcxL6P7rUVHglNNxvFlmt9A
         MehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mg+J5XS0nK+zoa4Dm5ITK5YdaJ7PSdz6gYixjtBG6RI=;
        b=ZJ1TtkPKPbob5yNL7XDBUmcRx/AwYChTz068MUA/CjxjjeR8ENgkTtfFfyqdntkqSl
         8DICE9+OhjVwVKQu+aQ3vtWRBZ/0S/oAXyNBt0kBoB1NtKzAq0o8zcqE7iojqe6bgMsK
         n1dC/MvJ92SPg6imD9Ug+HOw+Jtq3xP3K/EzqHkOkaQVBKSqcVYB9/YierTMZHxY7T/O
         dpLOGItDwzSeb65CFwdCk8/x4L6OkoCDBLFqOpXHsWdDkMYRev3AgyWyCi5gZAcUZWZE
         i9nNuxkxZxbXKeoUpQjvhDHnqsiKvQYX2Z5zmjDOIL27GOarzfoWZdzst9FT0jC7AHET
         2kIQ==
X-Gm-Message-State: AGi0PuYn5Cez92qir5dOV4fUFPk2ffXc9gsc+xktATsmVDnRhAgw0DEC
        1L4kE6iwsGb9uZ22dzxDl4tFRmNx+jz6OseObxk=
X-Google-Smtp-Source: APiQypITa9uud77MgWOKfv5/bsyn1AtoDPFMqkWwa7SrGmMbocGqNVZM2IwZmmqQHyvfExGpiqMI4qU0IVkaOZx2RVw=
X-Received: by 2002:a5b:344:: with SMTP id q4mr28492863ybp.29.1586097444396;
 Sun, 05 Apr 2020 07:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200318011144.91532-1-atish.patra@wdc.com> <20200318011144.91532-10-atish.patra@wdc.com>
In-Reply-To: <20200318011144.91532-10-atish.patra@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Sun, 5 Apr 2020 22:37:13 +0800
Message-ID: <CAEUhbmW-Peu4UrQvSgSkZWGRwHzKavZ-dXzG8Yhq5C9uiHq42Q@mail.gmail.com>
Subject: Re: [PATCH v11 09/11] RISC-V: Add SBI HSM extension definitions
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, Gary Guo <gary@garyguo.net>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 9:12 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> SBI specification defines HSM extension that allows to start/stop a hart
> by a supervisor anytime. The specification is available at
>
> https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc
>
> Add those definitions here.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
