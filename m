Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51FBC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24E320656
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gp7gddSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgGPU56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgGPU55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:57:57 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03CDC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 13:57:56 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 1so4248252pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 13:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1SwyEMFp+ErfmRvKBfavJObkX63ZHWDlBU0AZqSA3cM=;
        b=gp7gddSHwynljdzF5Pyi++VHHXp3523+j+ksaqQyiIBE3mx/gOdWkqz/gLXrQTZWMa
         6Qln6bbQpO6HX6NhUySTEo234kx7nIdZEA8CEvV4UaepMbKIpUuPusb29LxB39YcZ1fI
         Uy7xcxFbX6dp6pKS5vDRBdEMuDh4MclXF+8vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1SwyEMFp+ErfmRvKBfavJObkX63ZHWDlBU0AZqSA3cM=;
        b=S/WSGpAs3q4MzpOHMI/zPlSj8CkEk0dOxZrqIqSrmmKvcu3vBoU3DcmsyatwTY0DUa
         rqPIggcN/uXktQ+TNSfz72o6Vn89PzG6klq6QjLnwEF98Ok5jKhzV/aLvFxLJPRB0cB4
         5nDViCVkK/3gVzO1vTC9Pe58/8JnAeMiJ4hoYEGTb0kjBn+DTVaeUWoXkEq+ImN3xKqP
         ZowROtQuy6Kk3URm/Q55ibz82MY2pphD0L3FKKKj9q8QDYdk+IcKgXuz3I4RmV44EK9l
         9J+QV2JZRylxgRT4YkqaDtbkfBgKxhleIH5eOMXyhnj0XEz44Obcj7hxxv0TA2TaYb0u
         xZtw==
X-Gm-Message-State: AOAM530xj8Lu6wzU9JaIXTJ1vNGeKH+gJw+PbBC/qP+mCBgKf/sErz2R
        /MYzrkqtnA4vbzRWxr9+b/MuTA==
X-Google-Smtp-Source: ABdhPJxcvVP5+z1lNxoACOmOIX5dg+crk6+nC/bsWsDAWi7zo0SyljXZtoO8siv16OCxbzLZZR5h8w==
X-Received: by 2002:a63:9201:: with SMTP id o1mr5156170pgd.99.1594933076523;
        Thu, 16 Jul 2020 13:57:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t20sm5704209pfc.158.2020.07.16.13.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 13:57:55 -0700 (PDT)
Date:   Thu, 16 Jul 2020 13:57:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [patch V3 07/13] x86/ptrace: Provide pt_regs helpers for
 entry/exit
Message-ID: <202007161357.70EF223F@keescook>
References: <20200716182208.180916541@linutronix.de>
 <20200716185424.658427667@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716185424.658427667@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 08:22:15PM +0200, Thomas Gleixner wrote:
> As a preparatory step for moving the syscall and interrupt entry/exit
> handling into generic code, provide pt_regs helpers which allow to:
> 
>   - Retrieve the syscall number from pt_regs
>   - Retrieve the syscall return value from pt_regs
>   - Retrieve the interrupt state from pt_regs to check whether interrupts
>     are reenabled by return from interrupt/exception.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
