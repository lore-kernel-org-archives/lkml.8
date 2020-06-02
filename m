Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA93C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D672072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WgkU/r3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgFBTbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBTbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:31:08 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA377C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:31:07 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o6so5618876pgh.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6w+XkUkU5h5LP0oH8IvcLuw6U3W/97W5DvOiXSMn/mA=;
        b=WgkU/r3jMF9n33U8WloHJaM9zXFQJe2XsKzRsi/9mRzHgTDM8IZ97uCi0DdfxuBerD
         26V8O/NVxAOOvlGJyZO9cfboF+5RY/Lp2TTyeRE9QzjgRLbAvonU6TpkcjihKBsoOVpF
         QahWqbXJnNbkfidvMqq9c7UQcS2luBejKZl+olP8pzlszbI5SGw/956jai2htH3Lh9Bc
         2tbSkAvw14Q2ds0/JMN7GjEs7y59z2iCOULnoF2g77jIleJ84sjve+uNP/KO8FVQmuN5
         K95bNpISSjfOJFkStw24uui2/zSOmjMaiPW4GT0qMVAiV78fu1CWTEb9n5Qtn6vCpox3
         x5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6w+XkUkU5h5LP0oH8IvcLuw6U3W/97W5DvOiXSMn/mA=;
        b=ZM9MaKwDoZ43w8KMsm8zuoOKkPvswMlpqwPgq1gP+W/lKx3EEFizqgW8t+7Ln9VWQx
         SDW/CPs5QHQn+Wp8ow+tVcYq/kEaAvNxMnNQqW69pWGShRN0Oba/oQB0dyrtTTdG44Ik
         +UWBCIbflLPRA1JTDrmrNYra/KpkJ+6+5Foxqnhooii2TEsyVTXPEzFlP86P+bfhBuNC
         JYbo5SunxxuH7uX32tlzubjcNT2WukhXXtNQA63QLhHJhR9zTqj2HJM9odAZ+sswVwk/
         Uv5xBnpk/fhVym2neyuChpGH4fmcHVVx/h8PCg/t+YLYehoZbMxSiXJkKt9AGWflBIJv
         e/pQ==
X-Gm-Message-State: AOAM5323VoNs8Q6wA4o3c2gSeeEsRWVWREuKWO3a563MkTVfA6QESgB6
        fJX64WEa4r7yHxeS81i1QPL74DqeUC6lyg==
X-Google-Smtp-Source: ABdhPJyv+MI97viRmZ6Mwyl2wRJj7hDq6oxKKSr+JdzibxHzmCC73fMp5Fx+ItV+U3VgzYvK9x8iAw==
X-Received: by 2002:a17:90a:d809:: with SMTP id a9mr823280pjv.212.1591126267247;
        Tue, 02 Jun 2020 12:31:07 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id e12sm3086572pfj.137.2020.06.02.12.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 12:31:06 -0700 (PDT)
Subject: Re: [PATCH RESEND v3 0/6] arm64: add the time namespace support
To:     Andrei Vagin <avagin@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200602180259.76361-1-avagin@gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <3906fa01-1b3c-76f7-5587-b1f5cf6b6066@arista.com>
Date:   Tue, 2 Jun 2020 20:31:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200602180259.76361-1-avagin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrei,

On 6/2/20 7:02 PM, Andrei Vagin wrote:
> Allocate the time namespace page among VVAR pages and add the logic
> to handle faults on VVAR properly.
> 
> If a task belongs to a time namespace then the VVAR page which contains
> the system wide VDSO data is replaced with a namespace specific page
> which has the same layout as the VVAR page. That page has vdso_data->seq
> set to 1 to enforce the slow path and vdso_data->clock_mode set to
> VCLOCK_TIMENS to enforce the time namespace handling path.
> 
> The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
> update of the VDSO data is in progress, is not really affecting regular
> tasks which are not part of a time namespace as the task is spin waiting
> for the update to finish and vdso_data->seq to become even again.
> 
> If a time namespace task hits that code path, it invokes the corresponding
> time getter function which retrieves the real VVAR page, reads host time
> and then adds the offset for the requested clock which is stored in the
> special VVAR page.
> 
> v2: Code cleanups suggested by Vincenzo.
> v3: add a comment in __arch_get_timens_vdso_data.
> 
> Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dmitry Safonov <dima@arista.com>
> 
> v3 on github (if someone prefers `git pull` to `git am`):
> https://github.com/avagin/linux-task-diag/tree/arm64/timens-v3

Thanks for adding arm64 support, I've looked through patches and don't
see any major problems.

Reviewed-by: Dmitry Safonov <dima@arista.com>

> 
> Andrei Vagin (6):
>   arm64/vdso: use the fault callback to map vvar pages
>   arm64/vdso: Zap vvar pages when switching to a time namespace
>   arm64/vdso: Add time napespace page
>   arm64/vdso: Handle faults on timens page
>   arm64/vdso: Restrict splitting VVAR VMA
>   arm64: enable time namespace support
> 
>  arch/arm64/Kconfig                            |   1 +
>  .../include/asm/vdso/compat_gettimeofday.h    |  11 ++
>  arch/arm64/include/asm/vdso/gettimeofday.h    |   8 ++
>  arch/arm64/kernel/vdso.c                      | 134 ++++++++++++++++--
>  arch/arm64/kernel/vdso/vdso.lds.S             |   3 +-
>  arch/arm64/kernel/vdso32/vdso.lds.S           |   3 +-
>  include/vdso/datapage.h                       |   1 +
>  7 files changed, 147 insertions(+), 14 deletions(-)
> 

Thanks,
          Dmitry
