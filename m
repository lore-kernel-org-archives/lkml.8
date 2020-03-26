Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D6BC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CFB20719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="taDdNolt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgCZHFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:05:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37392 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZHFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:05:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so6413772wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AJlAnoiw58fGjW5ZSKtwSmqYhPIqzzq4WS5XfLGHaaQ=;
        b=taDdNoltvV89M1V4/Ua8Z67ESbkzBrNMkGyBlzEf3XE9f0SsUv7ZblJVoVMhraN7WZ
         8EqlLRxCw6NMCjtt0NlBFloOHOaoodK3MAaGMKsc48l2HCgugPwGZZ6J1egWFFq4wQrk
         elbKhq0S0N0OlJiVQimE9k7XoI/VP/MiRiMsJagw7tlVoq30Y9Qcc8hb1y9LIcWwzUsa
         4mttZS87clBSM7sRITkRHdgEtPC7P7KNAl+d6feYFc2OQzGwmiZ19VcqcaGMeBnOXyBn
         Ag6B+Mn5dIzucrRYyNUgdUKKLBOTuM6ZvhNRlC5PbOBgdkSAl1guP4KkFz9OXOMhWAm+
         mAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AJlAnoiw58fGjW5ZSKtwSmqYhPIqzzq4WS5XfLGHaaQ=;
        b=hQCG6XF9P7bjdh/yztQJqBhAVpLdBHyyhM5YlPzJ+lRESDNqU56JDnb/ZcPY5G9t+i
         MWyfzDi47UWOn3tkIrm4ODvPLoAT/r9Jn5Ev82b52w4ZOeC++0s+6XfPw3NNIIYefKtE
         V6momsGX3Zj/MrgBT0ZdEszn5DqsoFMEsq2Qc3w8x7Jd6FA6pHQTtX/dkxy1ryzDnJUi
         GBtIaUz05ZrUe8l3AWY6CCbbk7EA82QAT4Xi56TLMfwPVevOJnmjTw+alD5XQrgE6eEt
         K4jReRxdYTTJW7l3Qwurzks3Wfre9jvRWADZ3Nqiwco0IXdoFmB5JMRDuM7PQA6cW0Rg
         r5Bg==
X-Gm-Message-State: ANhLgQ2xuGozLFo9RsTAadyuwj8QhSC4AoUR4Qgfwgbt72JXhjAfllMS
        FPvleNxx5T7he+Oowpv022hSFfflVfGhTMP0GPzmaQ==
X-Google-Smtp-Source: ADFU+vvNUnSHK8fH4kjGh10dV9rtTMZU5X9hIHxfdBcrp1tcqLLnJH5gkaosz3Flj1HyIorU9Bj3JTK5rodtY9QDmZY=
X-Received: by 2002:a5d:4acd:: with SMTP id y13mr7591248wrs.61.1585206320468;
 Thu, 26 Mar 2020 00:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200322110028.18279-1-alex@ghiti.fr> <20200322110028.18279-8-alex@ghiti.fr>
In-Reply-To: <20200322110028.18279-8-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 26 Mar 2020 12:35:08 +0530
Message-ID: <CAAhSdy3kV6kVHM-sL2uFBgq85EOiKWRJrfNvd+MPiOjKQJwavQ@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] riscv: Explicit comment about user virtual
 address space size
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Christoph Hellwig <hch@lst.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 4:37 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Define precisely the size of the user accessible virtual space size
> for sv32/39/48 mmu types and explain why the whole virtual address
> space is split into 2 equal chunks between kernel and user space.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/include/asm/pgtable.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 06361db3f486..be117a0b4ea1 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -456,8 +456,15 @@ static inline int ptep_clear_flush_young(struct vm_a=
rea_struct *vma,
>  #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
>
>  /*
> - * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
> - * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
> + * Task size is:
> + * -     0x9fc00000 (~2.5GB) for RV32.
> + * -   0x4000000000 ( 256GB) for RV64 using SV39 mmu
> + * - 0x800000000000 ( 128TB) for RV64 using SV48 mmu
> + *
> + * Note that PGDIR_SIZE must evenly divide TASK_SIZE since "RISC-V
> + * Instruction Set Manual Volume II: Privileged Architecture" states tha=
t
> + * "load and store effective addresses, which are 64bits, must have bits
> + * 63=E2=80=9348 all equal to bit 47, or else a page-fault exception wil=
l occur."
>   */
>  #ifdef CONFIG_64BIT
>  #define TASK_SIZE (PGDIR_SIZE * PTRS_PER_PGD / 2)
> --
> 2.20.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
