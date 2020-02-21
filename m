Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EC6C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 06:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C6E20637
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 06:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="k78bxUZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgBUGDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 01:03:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37899 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgBUGDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 01:03:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id e8so619864wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 22:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqtAvwxT6JrwXsCKyiro+Lp0pOc/Ni4qRf2FDo8jA7I=;
        b=k78bxUZhB4k7Cc+JUEXD+nAd1mPCAv1V4W58+FtztDdj7Rs7vyd2zu2MHyjhqMI8Ti
         IPUICzblgtxDIA60pRkSRhgKpiGZbivYVHmk5FzLgEo23O7c3gwutPCqjLIGmGw8nKuQ
         n2s9xe2RhD8kyX09Jg1QMBvWv3q1aG5SUfawDmQuAg7Mj6Q0+r8MMTO9UY+mcYp8WQlc
         l6JrcYXFOL8gtYGTwKRclqO59hlX4+KG2Ngp8uicdiMobm15Ry91KQFUEjUctfXzJFmE
         BN+7qP7+ef3/LUCCD83C7N+GQF/HqipJTkBpBv36LRFeiJ/fD36AYZ3TMj/lwhVRjpwi
         ZS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqtAvwxT6JrwXsCKyiro+Lp0pOc/Ni4qRf2FDo8jA7I=;
        b=VC7rrnJPMAEuMePn8XUoW0gQRUYxVxmIHXTdYEKU6uzJHt0DFN2SpUHtNbTHJBaGLz
         6WROtw+5uKHATyULNHDV0J/0G1M6F67wYOudS4kPBugBAj1qNQEOVhYsGio8jPJQ3ns4
         254NujShwQAz4HqikqbNpHkdvj5obF3sT9GjWLVND/VOp3a8yb2reLbvcgWvrSlqxdt0
         B//oMVngb2lRrOZ0YefuMid90l97ldZYcLlp4C+rBzFwO/Yv7t4nE2CkC61DMUwFZEvH
         1bfskeCnGeklIhTkuJsuB6XfmRwxNk9gL0SKGtMbA7HMKf0bC/3beMsQcTapJnZKDzcf
         /cbw==
X-Gm-Message-State: APjAAAWhvgPdmYB1IFzFuI/CQ8dUjroCE4nWV0HXU7qbpJqCJr9IaO21
        gngRBCG/QAFhnp3gRIq48JvuYpjmZ1XAoVurq8Z8ww==
X-Google-Smtp-Source: APXvYqzKt9n9Xq8la74Z+xvm6ahETvrqRFQztSYDibW0kIX5kMERSsw3QEO1Kd+rVdcG/sAhQmnfak0jzNiUTghp8IA=
X-Received: by 2002:adf:f28f:: with SMTP id k15mr45926753wro.230.1582265032524;
 Thu, 20 Feb 2020 22:03:52 -0800 (PST)
MIME-Version: 1.0
References: <20200221004413.12869-1-atish.patra@wdc.com> <20200221004413.12869-10-atish.patra@wdc.com>
In-Reply-To: <20200221004413.12869-10-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 21 Feb 2020 11:33:40 +0530
Message-ID: <CAAhSdy10hJ=Ucc27JZvq1fZ8pBuFnQukMTk6=ghNLOmNqrOyxg@mail.gmail.com>
Subject: Re: [PATCH v9 09/12] RISC-V: Add SBI HSM extension definitions
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mao Han <han_mao@c-sky.com>, Marc Zyngier <maz@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 6:14 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> SBI specification defines HSM extension that allows to start/stop a hart
> by a supervisor anytime. The specification is available at
>
> https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc
>
> Add those definitions here.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index abbf0a7d3b6e..0981a0c97eda 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -26,6 +26,7 @@ enum sbi_ext_id {
>         SBI_EXT_TIME = 0x54494D45,
>         SBI_EXT_IPI = 0x735049,
>         SBI_EXT_RFENCE = 0x52464E43,
> +       SBI_EXT_HSM = 0x48534D,
>  };
>
>  enum sbi_ext_base_fid {
> @@ -56,6 +57,19 @@ enum sbi_ext_rfence_fid {
>         SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
>  };
>
> +enum sbi_ext_hsm_fid {
> +       SBI_EXT_HSM_HART_START = 0,
> +       SBI_EXT_HSM_HART_STOP,
> +       SBI_EXT_HSM_HART_STATUS,
> +};
> +
> +enum sbi_hsm_hart_status {
> +       SBI_HSM_HART_STATUS_AVAILABLE = 0,
> +       SBI_HSM_HART_STATUS_NOT_AVAILABLE,

Rename "_AVAILABLE" to "_STARTED" and
"_NOT_AVAILABLE" to "STOPPED" to match
SBI v0.2-rc1 spec.

> +       SBI_HSM_HART_STATUS_START_PENDING,
> +       SBI_HSM_HART_STATUS_STOP_PENDING,
> +};
> +
>  #define SBI_SPEC_VERSION_DEFAULT       0x1
>  #define SBI_SPEC_VERSION_MAJOR_SHIFT   24
>  #define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
> --
> 2.25.0
>

Otherwise, looks good to me.

Reviewed-by: Anup Patel <anup.patel@wdc.com>

Regards,
Anup
