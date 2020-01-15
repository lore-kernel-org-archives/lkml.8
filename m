Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FDDC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1722084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2dSAH5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgAOUem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:34:42 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41717 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbgAOUem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:34:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so8731287pgk.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 12:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:cc:from:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=BAybeIS2/ajSEOLd+vnWUzlDR+akOGV8mHEBsCROnyU=;
        b=e2dSAH5fPJyIZw22cC7PLbsbjrsWUxmd71pEWDIqEbRlFb0e7gxVMiUAj1mlmmxsl4
         lLpVRcjiiNzs5/0oXso0mD4JwTDmuavlmq53dlVIvoBIyQVB/pHYH7KxhLR9ZTmfklJA
         yVeyjK6Ute/lTVEIM7KnhIMxpeFeCXhG9QMzntgdkYpDPkniboIT0eVflnNm9blWr3wq
         Bl3NQeuDsqfWCpj+PJxXUyzaqNgYfAzrsvDbP4muyebKDXyeA6Tz6yqFzou4BKRChDZn
         P9m4lZncpvnpQtgDPGpm7zBByspgsDpYTPKnlnDeQXfT2+LdHPpTwo01pALH2ulHJg5L
         1Wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=BAybeIS2/ajSEOLd+vnWUzlDR+akOGV8mHEBsCROnyU=;
        b=aDbCbefJm1P1JZCtBZEbk4bsL/iAlX/q7BTYG4kuIg5U6p924D463ODWvhSNlE/HdB
         QCnOtOGB+prsdirgZoSXxyej79tCe/DGRdsJnHHZ1Hmt5aHwDD4Fp25FdicCOsFf3yFd
         n2a/2pIWJlOvMW+N+wXkYoWQ/+zEDVsRrKViHSmkzD8+9l+Tmn8ZhiTInssHZKKUh5LJ
         uiBan0SQhrsgZE+NBaHAHcQrodgYu2xzU+OY8ynmJEwmf/T16KWUtTxsZ3XxAComWQgv
         c7p24JgA8IpJ4+II3EgbXh5jguQpizi1lPdLRTqmhhqmr7aW2gLGfwBFrYYjQXYNpTuz
         0OyA==
X-Gm-Message-State: APjAAAVqfkJJKUUGlcKwjrIpdwM5e9mfbnGMfhr0cGXbdWexzk6bQ2J0
        wEWrfuT0OqINZv2AeK8190Sh8GUOkSg=
X-Google-Smtp-Source: APXvYqw4eTMMTqAVYwrglsurdZ+SbpGibUuhOnh/i8gjfgB9VPKxJZ1z6e/lNpw/F7S5iWmOpuH4Gw==
X-Received: by 2002:a63:a019:: with SMTP id r25mr33020793pge.400.1579120480702;
        Wed, 15 Jan 2020 12:34:40 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id x18sm23212328pfr.26.2020.01.15.12.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 12:34:40 -0800 (PST)
Date:   Wed, 15 Jan 2020 12:34:40 -0800 (PST)
X-Google-Original-Date: Wed, 15 Jan 2020 12:34:29 PST (-0800)
Subject:     Re: [PATCH v6 3/5] RISC-V: Add SBI v0.2 extension definitions
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        linux-riscv@lists.infradead.org, rppt@linux.ibm.com,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de,
        atishp@atishpatra.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Atish Patra <Atish.Patra@wdc.com>
In-Reply-To: <20191218213918.16676-4-atish.patra@wdc.com>
References: <20191218213918.16676-4-atish.patra@wdc.com>
  <20191218213918.16676-1-atish.patra@wdc.com>
Message-ID: <mhng-5b413aea-2c8d-4bb9-ba38-ac523278c4f4@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019 13:39:16 PST (-0800), Atish Patra wrote:
> Few v0.1 SBI calls are being replaced by new SBI calls that follows
> v0.2 calling convention.
>
> This patch just defines these new extensions.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 1aeb4bb7baa8..9612133213ba 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -21,6 +21,9 @@ enum sbi_ext_id {
>  	SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID = 0x7,
>  	SBI_EXT_0_1_SHUTDOWN = 0x8,
>  	SBI_EXT_BASE = 0x10,
> +	SBI_EXT_TIME = 0x54494D45,
> +	SBI_EXT_IPI = 0x735049,
> +	SBI_EXT_RFENCE = 0x52464E43,
>  };
>
>  enum sbi_ext_base_fid {
> @@ -33,6 +36,24 @@ enum sbi_ext_base_fid {
>  	SBI_EXT_BASE_GET_MIMPID,
>  };
>
> +enum sbi_ext_time_fid {
> +	SBI_EXT_TIME_SET_TIMER = 0,
> +};
> +
> +enum sbi_ext_ipi_fid {
> +	SBI_EXT_IPI_SEND_IPI = 0,
> +};
> +
> +enum sbi_ext_rfence_fid {
> +	SBI_EXT_RFENCE_REMOTE_FENCE_I = 0,
> +	SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
> +	SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
> +	SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
> +	SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
> +	SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
> +	SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
> +};
> +
>  #define SBI_SPEC_VERSION_DEFAULT	0x1
>  #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
>  #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f

With or without SBI_EXT_RFENCE_*, depending on what we do with the spec:

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
