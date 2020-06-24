Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4542FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2080720723
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PFUTEJVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404466AbgFXPVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404333AbgFXPVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:21:30 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04968C061795
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:21:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k1so1189025pls.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hipZu7svv8YCOGWfV429rAgefIwLANWXqxhaAHNlUDs=;
        b=PFUTEJVQwh2+4QRR1nFSJ1vpBf1P1htrZ93UyqcsZYbdOmeZSMIhkYQd42QutBKyJs
         TJmRw7i1dvHgb8fEVkq9MnKeDv9Rz3iq8rIhQJBq5dr5O8JseercMwc1JUo8HpJOhm/L
         hgo66dKugSbGc/w9UC2Psf+VHkXtb5H5cZmBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hipZu7svv8YCOGWfV429rAgefIwLANWXqxhaAHNlUDs=;
        b=c7ZwM7xWSaM8j/K75ANdZOCoftSsaaOyq+Cir2sguotkquYsiIE8pq3x09thHCIG9H
         ixFn2PrMB4UPWeD3hkDDqhGfo4O9D3nxW6qLPoz2SnimsXUZRsAZ/nSp/oFuovCHDdxj
         LDGk68+ECtZawFNDnKCf90PpujsHx1JNNPv3dqhWoatbwhwAVg2m2MNV7bHeVRgvr8D/
         m47s5cb14i6ruil2SZjbWEeHn1ckQOCb6yRD+PXMeFCSC1zpM+ehgy4LMJqXnTBarZUT
         5AbF3tc3R8pmdvEqcKhGNVOn+zuN7uTBvDe26SMnlMuI49RPMTzqssO+esknOETxDXVf
         VMYw==
X-Gm-Message-State: AOAM531ZrzlRqSkpo0+8ykpvk7/A7P0is+su7C1lSWqA4HV80RVGOOLk
        9S776wgj9HrwAGOjLt3gpnG2AQ==
X-Google-Smtp-Source: ABdhPJz6Pb/Uq4DmJN0BF/hWfnaErTToTjkFKWI6VNCSQl12WLTaojfbfbhCZdSTruAF/RMm4+CkOA==
X-Received: by 2002:a17:90a:cc09:: with SMTP id b9mr25741536pju.223.1593012088520;
        Wed, 24 Jun 2020 08:21:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m8sm5504017pjk.20.2020.06.24.08.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:21:27 -0700 (PDT)
Date:   Wed, 24 Jun 2020 08:21:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Fangrui Song <maskray@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/9] efi/libstub: Remove .note.gnu.property
Message-ID: <202006240820.A3468F4@keescook>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-4-keescook@chromium.org>
 <20200624033142.cinvg6rbg252j46d@google.com>
 <202006232143.66828CD3@keescook>
 <20200624104356.GA6134@willie-the-truck>
 <CAMj1kXHBT4ei0xhyL4jD7=CNRsn1rh7w6jeYDLjVOv4na0Z38Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHBT4ei0xhyL4jD7=CNRsn1rh7w6jeYDLjVOv4na0Z38Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 12:46:32PM +0200, Ard Biesheuvel wrote:
> I'm not sure if there is a point to having PAC and/or BTI in the EFI
> stub, given that it runs under the control of the firmware, with its
> memory mappings and PAC configuration etc.

Is BTI being ignored when the firmware runs?

-- 
Kees Cook
