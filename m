Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2D8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223E920768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oOpZTa5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403814AbgFXOwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389400AbgFXOwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:52:09 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814F8C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:52:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p3so1539268pgh.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+LYpavnNuYqsfOkUttYqicpUlIfIv5Cp3lganI3VZyY=;
        b=oOpZTa5+wogd5Zo5i06YBiLJFA99TNpd/R+dpAjxia0I1HX72p/pYJ8+r7FI6VpwER
         kzA4slLqc797d9hmoYdf7UkLvHZBonG0ASsGwrh3JEmkqkxa0R9ukdqOi+fcffkssEzd
         F5YHRwr3LVOa1RW5jvA3hKVCIR9zUCv3CwZ08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+LYpavnNuYqsfOkUttYqicpUlIfIv5Cp3lganI3VZyY=;
        b=qR3MGL2PdQbR1jmltsX7fZPikDv7G34lUtQ2f8coDrlIdchlHE1wQVb4HsUOmBfcpF
         PGQfsl4b2v5IrUEuHDRTzZf0xU8wQw5wbiV7gYb2uojvbJu56y+8RbI9IoQ2LlFJITVQ
         axsR4JULkkPp0traxQrJ/++/1bbzB5JSZZdFBagHeYqgQnpYsLTGcGHO24HwxrASkTpV
         gaTd4Cmq1hCs+d3hyoNaowDTL0lOAnvjjSZNMx1JwpU95kCMceicKizNNq3ZCvlacNel
         K/4nLA95ilnikFrtEWmy/pqDPioI6tVGviWIK1NEXD9ndzBbxOGX4MiA2j5mFhV4DeAe
         9h4g==
X-Gm-Message-State: AOAM533Bq+TCfenR77Zk9xEIwxNX5AqNNK4Hf5IDvGNYpzFRMI/nTi/4
        d2EBkJiPCVXzxaUngnqTsG89ig==
X-Google-Smtp-Source: ABdhPJwjhADjsZkiUiV63C7UdjS0kr8znYCOvlhuYeRyXXM/eucbfSwVQB3WasGrTPrLaBRSEotjoQ==
X-Received: by 2002:a63:8b42:: with SMTP id j63mr22776554pge.131.1593010327982;
        Wed, 24 Jun 2020 07:52:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cm13sm5609737pjb.5.2020.06.24.07.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:52:07 -0700 (PDT)
Date:   Wed, 24 Jun 2020 07:52:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Jann Horn <jannh@google.com>, Emese Revfy <re.emese@gmail.com>,
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
Subject: Re: [PATCH v2 1/5] gcc-plugins/stackleak: Don't instrument itself
Message-ID: <202006240751.30293A1@keescook>
References: <20200624123330.83226-1-alex.popov@linux.com>
 <20200624123330.83226-2-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624123330.83226-2-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:33:26PM +0300, Alexander Popov wrote:
> There is no need to try instrumenting functions in kernel/stackleak.c.
> Otherwise that can cause issues if the cleanup pass of stackleak gcc plugin
> is disabled.
> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> Acked-by: Kees Cook <keescook@chromium.org>

Thanks! Applied to for-next/gcc-plugins.

-- 
Kees Cook
