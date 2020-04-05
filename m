Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9DDC2BA17
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229FA20672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBUX/QBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgDEOhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 10:37:24 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34885 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgDEOhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 10:37:21 -0400
Received: by mail-yb1-f195.google.com with SMTP id i2so1721447ybk.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 07:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHN0S4zcuSIZtTM9i2ZMDZn8NuC8WBR+knYnvHF4CPM=;
        b=YBUX/QBpHavrPbx08qSfbhWxlD//0632rVP7PPw+5ooUiObSkyqF42fevVfH8iZ3n2
         CrqexY6AnrVhplA0PyXUkNKbqpCzAIIL2E5IrgGp9Jco/lEQDB7WxrI7+kEQe/Tk0Mgy
         Wz/DMp/cZU1wQE/zC/20w5pVpHwLadIB+hkxrflJxGq3WAys9evCy49hW6QIqQuVPY1X
         cBmr3Mc+vCqfOyXu1ZWrKZpOhuccIk63oMN4tBoWKJQMCwLSK1136hn2Bb5ennLFyxHB
         4ZFQ5Di6aYLYe2U+EMAy8Z6w+JJxrzGmfGNMAAgED7cqj2Ye7Odk0Gr/7hcKyCyJGO5a
         gSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHN0S4zcuSIZtTM9i2ZMDZn8NuC8WBR+knYnvHF4CPM=;
        b=D3tddPx+qnL1UATSxPal9AI5iIzwdioVIrQm0xGuJKzFJoJ7Mcxx9YlgHxf8YQPH+O
         J9hygQ6ELiM2ohzecX1Zga6OnVUYyjLc+qh66OHlMdHXQg4JdaAFrzDsV6zK2+KeKT+2
         3T73W4WWZxhfrS6BPT5QDyoik/v0Shrfs5faL2CI4CqJPx7BcblNo5Halu/zK+HsqRRN
         HFs4y0OoBTySmHYoJjwQpm5lS3eibsyJtpDSLE7LHBWWCZQGmJLT+/qQ8y7xpPFbd/6z
         3J+vjDUBE7nG7X8hNpWevGzZzglB2yvOFUCii4bp8OXeBgE8f5bRfA62qzu5YbE9tMxZ
         Y/nQ==
X-Gm-Message-State: AGi0PubBdvc1yrS0LOPXDiGbKw7bty4hSECDekGHnp7QuCW4k4xlKGEq
        xmolfuUxVmA1W0AjIEAnsRGkFg46WyMVr6EOU+P4Hw==
X-Google-Smtp-Source: APiQypLhSCJzKzKa7GMp1kDQo0x/zD19XBoiLY5yjYmiAf4WNIi99hXylQklXOC+n/1Ys5XG56AMYyMRXVNuZf1VH38=
X-Received: by 2002:a25:ae8c:: with SMTP id b12mr26352809ybj.392.1586097440870;
 Sun, 05 Apr 2020 07:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200318011144.91532-1-atish.patra@wdc.com> <20200318011144.91532-9-atish.patra@wdc.com>
In-Reply-To: <20200318011144.91532-9-atish.patra@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Sun, 5 Apr 2020 22:37:10 +0800
Message-ID: <CAEUhbmUdv=BX8JdZchgJMx4LbOvkGmXheC8TZuJSbus4jHbhtQ@mail.gmail.com>
Subject: Re: [PATCH v11 08/11] RISC-V: Export SBI error to linux error mapping function
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
> All SBI related extensions will not be implemented in sbi.c to avoid
> bloating. Thus, sbi_err_map_linux_errno() will be used in other files
> implementing that specific extension.
>
> Export the function so that it can be used later.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 2 ++
>  arch/riscv/kernel/sbi.c      | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
