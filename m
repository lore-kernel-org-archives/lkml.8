Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28545C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A7420873
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnIOo7UD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgD3VPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:15:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40970 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726558AbgD3VPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588281321;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=Gpgo8QhStYUhDPmOT7znh0qOxQgcHTQeTAkj6k74Xck=;
        b=PnIOo7UDLGhEyKckUeVzoFRUYhig4DHPOdd4KhUWTKAKkyqhS6/pBKCCC6H40eXYQkf/rA
        2VK9YkHSLR65D4XTkVygk6HtwnJg4utbKb2Nk5hbg98WesPxw15rdVXYBfhrAPy4v9jFsa
        DlzVik4NazzP+0SPupDvzfLJD/6Cv3k=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-ULd9tQIrOZOGb161MJSa3w-1; Thu, 30 Apr 2020 17:15:20 -0400
X-MC-Unique: ULd9tQIrOZOGb161MJSa3w-1
Received: by mail-qk1-f199.google.com with SMTP id a18so7905628qkl.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Gpgo8QhStYUhDPmOT7znh0qOxQgcHTQeTAkj6k74Xck=;
        b=c2DYMOPJw8ssg8k5tROj2l6VG3bt+wjnv++nR7uodjHQ9g2/oCnVDiixDcMRNdUs5T
         NHGejKo/0eAeoVlZmJBVWWf/v/PlUt3jT860LcYk2Qode/S7rLXC3Wh5GEcktShfCLFw
         baZlv0sbQlGYDMKoc93GhU6VZZr4GvCh7dm2DWQZ1jiGk2Mz5P0cRq4n1EvIzLQ6rbSH
         yeDjyAyM+oPkheO/f1vESQfB5rqjF3NHnzWmtWckITQFwsbbCF4qCs7kuM3cS51MCgUM
         F9CfCXlKjQaWc/d9lGHBxB2A+VlHxlhg6W9uaKIfKYQGg/P01nXrEsA8ZMTsqDYTC0nR
         xYzg==
X-Gm-Message-State: AGi0PuZu9iCvSC0D30OTAmPzrnAsOWjwoJfza8dj3AiO537wmqRWAVIu
        wO89OqaN1i+LNbAhJkfQaAaTOe7783T+Beunkt3uW2LFhvGpoDYmITS3nN5gOsxSKkBftFAnFU2
        21/FUoZcjstXT6gKbMZN5UIy9
X-Received: by 2002:a37:9b0f:: with SMTP id d15mr557167qke.62.1588281319657;
        Thu, 30 Apr 2020 14:15:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypK47/YxDMcJQ0hvZtrevVhbt6vQJ5blpDkAeoLIO/G7QMniCYPHE7M/pzWYGebnwVKPPApSsA==
X-Received: by 2002:a37:9b0f:: with SMTP id d15mr557149qke.62.1588281319422;
        Thu, 30 Apr 2020 14:15:19 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id h6sm766622qtd.79.2020.04.30.14.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:15:18 -0700 (PDT)
Date:   Thu, 30 Apr 2020 14:15:16 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Scott Talbert <swt@techie.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi/tpm: fix section mismatch warning
Message-ID: <20200430211516.gkwaefjrzj2dypmr@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Scott Talbert <swt@techie.net>,
        Thomas Gleixner <tglx@linutronix.de>, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200429190119.43595-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200429190119.43595-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Apr 29 20, Arnd Bergmann wrote:
>Building with gcc-10 causes a harmless warning about a section mismatch:
>
>WARNING: modpost: vmlinux.o(.text.unlikely+0x5e191): Section mismatch in reference from the function tpm2_calc_event_log_size() to the function .init.text:early_memunmap()
>The function tpm2_calc_event_log_size() references
>the function __init early_memunmap().
>This is often because tpm2_calc_event_log_size lacks a __init
>annotation or the annotation of early_memunmap is wrong.
>
>Add the missing annotation.
>
>Fixes: e658c82be556 ("efi/tpm: Only set 'efi_tpm_final_log_size' after successful event log parsing")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Minor thing, but should the Fixes be c46f3405692d ("tpm: Reserve the TPM final events table")? Or what am I missing
about e658c82be556 that causes this? Just trying to understand what I did. :)

Regards,
Jerry

>---
> drivers/firmware/efi/tpm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
>index 31f9f0e369b9..55b031d2c989 100644
>--- a/drivers/firmware/efi/tpm.c
>+++ b/drivers/firmware/efi/tpm.c
>@@ -16,7 +16,7 @@
> int efi_tpm_final_log_size;
> EXPORT_SYMBOL(efi_tpm_final_log_size);
>
>-static int tpm2_calc_event_log_size(void *data, int count, void *size_info)
>+static int __init tpm2_calc_event_log_size(void *data, int count, void *size_info)
> {
> 	struct tcg_pcr_event2_head *header;
> 	int event_size, size = 0;
>-- 
>2.26.0
>

