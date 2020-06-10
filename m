Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DAFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0481520656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VmhHMiuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbgFJUDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgFJUDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:03:30 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BCDC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:03:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v24so1377158plo.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gMJmfBXQHkqYBkdWFgkIELmfTMw2QzimZzoX9rnpMvg=;
        b=VmhHMiuh5ohUCH3fDJnKjrDQRFL0Ji8PnJG1vfqLFDTNpxPKF/jUW6bjeiV5SjTR6o
         WXLVjXgIO5BzDsgibhA+L18doG6dCY7DA2U8R4aA2THMwHzIRdDqPqVTIOT51M5UhGjo
         pbeqxJDSxr/3GPDIEZHoH3PhBmMXdRDJJDdIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gMJmfBXQHkqYBkdWFgkIELmfTMw2QzimZzoX9rnpMvg=;
        b=H9mIC+u0ehUjflNMuWUDyF0sjhA11q8NCHIlYUhNIA9IcFt24J4WJXEiZjvvu0mUQ0
         N9WCE72rRUnTEl4/Kt4jftKIS9X1/8NLDJF2O362VcXKqnsOxKZBQpT/amK2wgpM/BZ+
         iccV2hnmY/fqrM8tsXTtz8e1LFzRD83EZsdg9b0u3tGa10e0aGGUBoJ5XAI0fY/uqWcx
         LOfQaK4JW5BVfqE1lcTrVs1GukgNSGN9AAao1ZcnfM5gAyOWpNlXSdHW2E0x3vqGDKSY
         SbUZ2qZyCvh2YyFgy8kZ1a9hWxvYamb+Ie3TLfPGLI35f52IY/Dcvq7jr7V7j6rNlhm7
         6Kag==
X-Gm-Message-State: AOAM532vHzEBtONC7Vrf59djsE/uATCbyWHz7x/hnQvM8mPlcjSqJsUz
        trT0cjL4zXS4GyZSNpGTW89UHQ==
X-Google-Smtp-Source: ABdhPJzkqdGCWRf/l2Trk3MffvrvqWcW6Bumgrl4Vv2VZmme66jypNqah8ksfCDrx7bzuNc50pX7OQ==
X-Received: by 2002:a17:90a:cb8d:: with SMTP id a13mr4644611pju.175.1591819409470;
        Wed, 10 Jun 2020 13:03:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l63sm724636pfd.122.2020.06.10.13.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 13:03:28 -0700 (PDT)
Date:   Wed, 10 Jun 2020 13:03:27 -0700
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
Message-ID: <202006101302.AC218FA1@keescook>
References: <20200604134957.505389-1-alex.popov@linux.com>
 <20200604134957.505389-3-alex.popov@linux.com>
 <202006091143.AD1A662@keescook>
 <757cbafb-1e13-8989-e30d-33c557d33cc4@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <757cbafb-1e13-8989-e30d-33c557d33cc4@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 06:47:14PM +0300, Alexander Popov wrote:
> On 09.06.2020 21:46, Kees Cook wrote:
> The inline asm statement that is used for instrumentation is arch-specific.
> Trying to add
>   asm volatile("call stackleak_track_stack")
> in gcc plugin on aarch64 makes gcc break spectacularly.

Ah! Thank you, that eluded my eyes. :)

> I pass the target arch name to the plugin and check it explicitly to avoid that.
> 
> Moreover, I'm going to create a gcc enhancement request for supporting
> no_caller_saved_registers attribute on aarch64.

For arm64 right now it looks like the plugin will just remain
"inefficient" in these cleanup, as before, yes?

-- 
Kees Cook
