Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435A6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F5A20734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U99j7Jwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbgFISqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgFISqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:46:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4B0C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 11:46:42 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bg4so8385194plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 11:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7dtLX6XP7HnlQbHJsaggWu4QmeqwjrddfqDvUbVDx4s=;
        b=U99j7JwkXu9xDjTaNwOqMNsfY/1JGbl0JiVGPVKaBXgK5sILh3SCCo6eu1pc4epTXg
         OFJZw9ln4TBPmUC0pW0XxrKMH3JsdoIHM3vcI+UatnP+BjixVR5jhLwwCKfajn4CK89/
         LsKyztUzZULA3YetUMhR5C2itWjI8K5031e9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7dtLX6XP7HnlQbHJsaggWu4QmeqwjrddfqDvUbVDx4s=;
        b=qp3lFyV2oe+tWsxgyY+ZgyCawEDZM6Qy19I4DixHko6l29pFsTkV7BAhEm9kvUelt/
         QFHFJZ411o0tZ3RuWS04H8DcOHpCR0UYop9a7/p1bLu6hPpG2DapXWJj4kftchdD7L9w
         Fdj9zSjybNtTxrY7cfxpmZAWur1mOo85EA0gYSSOTtiedQlfNB2miik5ZQKU7OhbE83i
         s2Sp0DXdxms7P7aycBw9O3W3WX1YDSEsCReRKdYrl+4tPzX/D/RYyuFLEfSYzDxG/Vyc
         rvKusXoQix8sn/xC/1TKmxvGm2hsTSMNUsitoTX4aQ1Us7ZwfNItsrqZDES4LO+aBUCZ
         Odng==
X-Gm-Message-State: AOAM532f8+Un4LAyhhRePLpxoyhyo6e4ZVb2fiMmn+I1mo2eXxxLF4mK
        AFGrFJeoPMLoe6/3tb13zgYsgw==
X-Google-Smtp-Source: ABdhPJwL5HN0U2KSWusdzlMqd2urfWL8t6YS0AxExIzAB1X6VceO1GflzGC9ecX1Ma+jdmYtMYrhFQ==
X-Received: by 2002:a17:90a:3489:: with SMTP id p9mr6357379pjb.56.1591728402460;
        Tue, 09 Jun 2020 11:46:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lt14sm3139209pjb.52.2020.06.09.11.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 11:46:41 -0700 (PDT)
Date:   Tue, 9 Jun 2020 11:46:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Emese Revfy <re.emese@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Alexander Monakov <amonakov@ispras.ru>,
        Mathias Krause <minipli@googlemail.com>,
        PaX Team <pageexec@freemail.hu>,
        Brad Spengler <spender@grsecurity.net>,
        Laura Abbott <labbott@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel-hardening@lists.openwall.com, linux-kbuild@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org, notify@kernel.org
Subject: Re: [PATCH 2/5] gcc-plugins/stackleak: Use asm instrumentation to
 avoid useless register saving
Message-ID: <202006091143.AD1A662@keescook>
References: <20200604134957.505389-1-alex.popov@linux.com>
 <20200604134957.505389-3-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604134957.505389-3-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 04:49:54PM +0300, Alexander Popov wrote:
> Let's improve the instrumentation to avoid this:
> 
> 1. Make stackleak_track_stack() save all register that it works with.
> Use no_caller_saved_registers attribute for that function. This attribute
> is available for x86_64 and i386 starting from gcc-7.
> 
> 2. Insert calling stackleak_track_stack() in asm:
>   asm volatile("call stackleak_track_stack" :: "r" (current_stack_pointer))
> Here we use ASM_CALL_CONSTRAINT trick from arch/x86/include/asm/asm.h.
> The input constraint is taken into account during gcc shrink-wrapping
> optimization. It is needed to be sure that stackleak_track_stack() call is
> inserted after the prologue of the containing function, when the stack
> frame is prepared.

Very cool; nice work!

> +static void add_stack_tracking(gimple_stmt_iterator *gsi)
> +{
> +	/*
> +	 * The 'no_caller_saved_registers' attribute is used for
> +	 * stackleak_track_stack(). If the compiler supports this attribute for
> +	 * the target arch, we can add calling stackleak_track_stack() in asm.
> +	 * That improves performance: we avoid useless operations with the
> +	 * caller-saved registers in the functions from which we will remove
> +	 * stackleak_track_stack() call during the stackleak_cleanup pass.
> +	 */
> +	if (lookup_attribute_spec(get_identifier("no_caller_saved_registers")))
> +		add_stack_tracking_gasm(gsi);
> +	else
> +		add_stack_tracking_gcall(gsi);
> +}

The build_for_x86 flag is only ever used as an assert() test against
no_caller_saved_registers, but we're able to test for that separately.
Why does the architecture need to be tested? (i.e. when this flag
becomes supported o other architectures, why must it still be x86-only?)

-- 
Kees Cook
