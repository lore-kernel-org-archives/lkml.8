Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8203C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4D220656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Les6gM1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbgFJUEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgFJUEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:04:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78C5C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:04:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 64so1570553pfv.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DXoJ3aLq9uhplWhtB2O8RgTDmA73SlXyMWG4MRv/Ld0=;
        b=Les6gM1utqz0wgQgKhZ4Nfpc6QS2e+nlg1Z/E14+jR0X69Sr3LwW3Zm/3lj8osjycK
         p6DUplVPD/d8Rthsbcyt2ZdYdwH3RELL5O74k3dxdMf4kX7zka4VtVliwa5J4nSVuu9e
         CL0gdKwiiV/4hvJM+5XPBMzv9WqFgKyQV9MGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DXoJ3aLq9uhplWhtB2O8RgTDmA73SlXyMWG4MRv/Ld0=;
        b=CrlbFXI67l0ttYtK/VuWAZ0v5525tY7ybzIodrRFbUEwa/WFKqDkJUtVOTKH91Vn+W
         4UqpCJbsQ2NzxBe1mMj9bx3dcPXmX5XqJFX3lCSHiIF/lyLOheWpJ2bxVyGkK+RBcm1N
         sRbRfVW252i7xe2BQs123PsfHjNPpy67EVM10BLYVqM6mv48RZoHSXM1RMSRHkfHKN3e
         VMNUTScuF4mIlr/MVs1AJHEe+tNYSejeBYAqVrvpJmi82DLhSwv6tiMWUNsomzG10fPj
         OHoI3sDj2+WmhXJLDThwz/326tNtEkIg8Y6xF3VRyH8n2yR27lXPjtNneTZ9O5f4nZDe
         8K9Q==
X-Gm-Message-State: AOAM533FtB+sY/yXK6492/HrtBd5YiTKGtjas08f9Qh6s8HN46+cSkj8
        rLPJrVjNQKlbc7rWcVwPPJ83hw==
X-Google-Smtp-Source: ABdhPJwC9KNAXjpOXoR+vUMW+1gcz/392CyELM73At2IMG3pDZxxAs+wEHjca9ODW8LTFHMHIMEw8g==
X-Received: by 2002:a63:df48:: with SMTP id h8mr3947452pgj.411.1591819472188;
        Wed, 10 Jun 2020 13:04:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w190sm723093pfw.35.2020.06.10.13.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 13:04:30 -0700 (PDT)
Date:   Wed, 10 Jun 2020 13:04:29 -0700
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
Subject: Re: [PATCH 3/5] gcc-plugins/stackleak: Add 'verbose' plugin parameter
Message-ID: <202006101303.71B51BF1@keescook>
References: <20200604134957.505389-1-alex.popov@linux.com>
 <20200604134957.505389-4-alex.popov@linux.com>
 <202006091147.193047096C@keescook>
 <fb051386-4913-9442-f051-23ed25802c9e@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb051386-4913-9442-f051-23ed25802c9e@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 06:52:10PM +0300, Alexander Popov wrote:
> On 09.06.2020 21:47, Kees Cook wrote:
> > On Thu, Jun 04, 2020 at 04:49:55PM +0300, Alexander Popov wrote:
> >> Add 'verbose' plugin parameter for stackleak gcc plugin.
> >> It can be used for printing additional info about the kernel code
> >> instrumentation.
> >>
> >> For using it add the following to scripts/Makefile.gcc-plugins:
> >>   gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK) \
> >>     += -fplugin-arg-stackleak_plugin-verbose
> >>
> >> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> > 
> > Acked-by: Kees Cook <keescook@chromium.org>
> 
> I see that I will change this patch after leaving alloca() support.
> I'm going to add debug printing about functions that call alloca().
> I have to omit your 'acked-by' for the changed patch, right?

If it changes dramatically, drop my Ack, yes. But since it's going via
my tree, my Ack is mostly just a quick email marker to say "yes, looks
good". :)

-- 
Kees Cook
