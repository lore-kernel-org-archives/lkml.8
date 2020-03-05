Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8441DC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F031207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="OZOfBJM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgCESvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:51:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33185 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgCESvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:51:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id m5so3185767pgg.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=IYzjB2dKqFRo7lIX50VavsZ/v5imYzKa/DmD2cTl4TU=;
        b=OZOfBJM4XPrMHk8DXLhGfSp0ONxSgSaKDBDmZT6D9DZf55zZlOlkRCjtYnN9ZyZixB
         vQnOoLcZ85Yt1ZY6IpdO3yR/0xhbYRcIQyGUkqxnrAp2qhx8BOFL8J498btZ6N9HJ+IQ
         zZLRv8vE/rJLMlHsNsWAmmXgHEzjYQ+srKeEDxWAS+WKTRtP+7H6mU5vJCCtV2wSVS9P
         otNwL+TgGU0kQWJC0fUOQZ8o+vQPXoNgH3tnhT5qR1fa0kKRRqbYRHWiS4wpS8yHbf3f
         qiZLLUYaNnFrBrnSiYS9iVTTO+hvB91vFdZFbmFXbhQYsaWH/Y70Gqoo658Qac85ifi4
         1UEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=IYzjB2dKqFRo7lIX50VavsZ/v5imYzKa/DmD2cTl4TU=;
        b=jtbKYxjFqREXaLlrfXTpw9HxUdLqvU2OXEkoLZv8atqqyqDoiC5SNRDx+cQS4vF/7W
         x3D9JWhi53rl9XrJW2eFKq30h5lKPjljY6tZauu+KD+8ccxlJWYhsDSUO1qmjCW8Nsr2
         Cis1gQySPQY1l7dDdozhmv2dbfBfr9m8rt2jOJcz/c22aSfZTHYgmV6rAQYilQiPPH6n
         h9FgsuzqyqJNTGyT9zLOzw9sRTm24Z77LkyLdh3Mc76XqjWU6C8/GlUiKRxOODkn+Z6+
         mt+iz03xaK6EMTdGaQuruRWwEd8HRhh6R5Yw+EwCGSeuwXXJTvWe48f6c5q8DqdRWKRI
         85SA==
X-Gm-Message-State: ANhLgQ0+exz9KymA212Ic1hicudY3CttCssp6rjSHeetaWmZ5u+OZp8z
        h12Q7UUK+vZ2CRVVnnA40Cbp/w==
X-Google-Smtp-Source: ADFU+vto1ZaDTJT9k8CN/nl5L7l6QT75MXqh6PBzmrL+xd+PwCclOFjsCOg/xavV+59vlVOyg70qKw==
X-Received: by 2002:a62:fc07:: with SMTP id e7mr9859565pfh.51.1583434269741;
        Thu, 05 Mar 2020 10:51:09 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id m128sm33766981pfm.183.2020.03.05.10.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 10:51:09 -0800 (PST)
Date:   Thu, 05 Mar 2020 10:51:09 -0800 (PST)
X-Google-Original-Date: Thu, 05 Mar 2020 10:51:04 PST (-0800)
Subject:     Re: [PATCH] RISC-V: Don't enable all interrupts in trap_init()
In-Reply-To: <CAAhSdy15mLGz3Xtu_Q7vOCP5Y2hQjWEosU1v8o8FxKfiLDx4qQ@mail.gmail.com>
CC:     atishp@atishpatra.org, Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     anup@brainfault.org
Message-ID: <mhng-3ad99841-64b9-49f9-acd6-2ff2001a315a@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 19:28:38 PST (-0800), anup@brainfault.org wrote:
> On Wed, Feb 19, 2020 at 12:06 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Sun, 02 Feb 2020 03:48:18 PST (-0800), atishp@atishpatra.org wrote:
>> > On Sun, Feb 2, 2020 at 3:06 AM Anup Patel <anup.patel@wdc.com> wrote:
>> >>
>> >> Historically, we have been enabling all interrupts for each
>> >> HART in trap_init(). Ideally, we should only enable M-mode
>> >> interrupts for M-mode kernel and S-mode interrupts for S-mode
>> >> kernel in trap_init().
>> >>
>> >> Currently, we get suprious S-mode interrupts on Kendryte K210
>> >> board running M-mode NO-MMU kernel because we are enabling all
>> >> interrupts in trap_init(). To fix this, we only enable software
>> >> and external interrupt in trap_init(). In future, trap_init()
>> >> will only enable software interrupt and PLIC driver will enable
>> >> external interrupt using CPU notifiers.
>>
>> I think we should add a proper interrupt controller driver for the per-hart
>> interrupt controllers, as doing this within the other drivers is ugly -- for
>> example, there's no reason an MMIO timer or interrupt controller driver should
>> be toggling these bits.
>
> I have always been in support of having per-hart interrupt controller driver.
>
> I will rebase my RISC-V INTC driver upon latest kernel and send it again.
> Of course, now the situation has changed the RISC-V INTC driver will
> have to consider NOMMU kernel as well.
>
> The last version of RISC-V INTC driver can be found in riscv_intc_v2
> branch of https://github.com/avpatel/linux.git

Thanks.  I think I saw some patches go by, so let's talk over there.

>
>>
>> >> Cc: stable@vger.kernel.org
>> >> Fixes: 76d2a0493a17 ("RISC-V: Init and Halt Code)
>>
>> I'd argue this actually fixes the M-mode stuff, since that's the first place
>> this issue shows up.  I've queued this with
>>
>> Fixes: a4c3733d32a7 ("riscv: abstract out CSR names for supervisor vs machine mode")
>>
>> instead, as that's the first commit that will actually write to MIE and
>> therefor the first commit that will actually exhibit bad behavior.  It also has
>> the advantage of making the patch apply on older trees, which should make life
>> easier for the stable folks.
>
> Sure, no problem.
>
>>
>> >> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>> >> ---
>> >>  arch/riscv/kernel/traps.c | 4 ++--
>> >>  1 file changed, 2 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> >> index f4cad5163bf2..ffb3d94bf0cc 100644
>> >> --- a/arch/riscv/kernel/traps.c
>> >> +++ b/arch/riscv/kernel/traps.c
>> >> @@ -156,6 +156,6 @@ void __init trap_init(void)
>> >>         csr_write(CSR_SCRATCH, 0);
>> >>         /* Set the exception vector address */
>> >>         csr_write(CSR_TVEC, &handle_exception);
>> >> -       /* Enable all interrupts */
>> >> -       csr_write(CSR_IE, -1);
>> >> +       /* Enable interrupts */
>> >> +       csr_write(CSR_IE, IE_SIE | IE_EIE);
>> >>  }
>> >> --
>> >> 2.17.1
>> >>
>> >>
>> >
>> > Looks good.
>> > Reviewed-by: Atish Patra <atish.patra@wdc.com>
>>
>> Tested-by: Palmer Dabbelt <palmerdabbelt@google.com> [QMEU virt machine with SMP]
>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> I consider this a bugfix, so I'm targeting it for RCs.  It's on fixes and
>> should go up this week.
>>
>> Thanks!
>
> Thanks,
> Anup
