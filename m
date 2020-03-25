Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C57C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F532076F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V04eeOZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgCYU1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:27:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39402 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgCYU1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 16:27:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id m1so1252719pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 13:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6SzOvwdTQqkZQCjlviRpZUVdzAyX4BMCYO6WRGnsRMg=;
        b=V04eeOZmpXZz9+n2K8s89RAUlNtFI2i3/IBt6L+R3HaP2VRpUcKrX06reMGWIzc2c+
         XwtCJxYWfVvX423KhbuO1h44rQttz9YLq0WAz9cdrMlR19jmIZbXEYme+Erycyi1IU2U
         88GPKoBsjo0xyDjf5T8gvQ6OIx9M3dosv2wAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6SzOvwdTQqkZQCjlviRpZUVdzAyX4BMCYO6WRGnsRMg=;
        b=HbjsVlx7XPkzyKEDrHNZxOgxe7jQTgopYwkXe00td2eV7e+Q+EX+iIYPwAqmsxvsBs
         IEakTM7O+JveXTk4xWuY3hxRw+LhNb+liHG6Uh5yGYaPLTNlRAmVvPRjD2kSWcQgU8mX
         R1I8ftfPOp/qI9Y7/svHmcd3n7Kl93pvEGWWZLLeMcOSK2LUIt+oRHgspt9qbYZiq103
         TYCXM5C7V7x4kqLlb2dfFjCtGUGlfbVCI2v6wwmQ/fZoJt2af+sa660aO5R+OXvt2Mdp
         0B6iPXuESRdyan36cJ1f6Y+G+eE6UbaQ8JohYg3JXTgY1ZYm5mMnbExXve/pX97h1sU3
         sNvA==
X-Gm-Message-State: ANhLgQ2b71pCsv+PLiLmsruh8OMqELF9e2JKpGnvimpUDNG0fiXiSxwK
        EvV80znhRMqMWfg9R1YgJmp5Gw==
X-Google-Smtp-Source: ADFU+vswtN+46ClgfmDrS2YQ0+gwH0oaxyACQpe8SmgU+n/NeZSp3mJwpEGmc/BXB2B7g4eNvcGW5w==
X-Received: by 2002:a17:902:fe97:: with SMTP id x23mr4918671plm.167.1585168024550;
        Wed, 25 Mar 2020 13:27:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n22sm100777pjq.36.2020.03.25.13.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 13:27:03 -0700 (PDT)
Date:   Wed, 25 Mar 2020 13:27:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Optionally randomize kernel stack offset each
 syscall
Message-ID: <202003251322.180F2536E@keescook>
References: <20200324203231.64324-1-keescook@chromium.org>
 <CAG48ez3yYkMdxEEW6sJzBC5BZSbzEZKnpWzco32p-TJx7y_srg@mail.gmail.com>
 <202003241604.7269C810B@keescook>
 <BL0PR11MB3281D8D615FA521401B8E320E7CE0@BL0PR11MB3281.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR11MB3281D8D615FA521401B8E320E7CE0@BL0PR11MB3281.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:15:12PM +0000, Reshetova, Elena wrote:
> > > Also, are you sure that it isn't possible to make the syscall that
> > > leaked its stack pointer never return to userspace (via ptrace or
> > > SIGSTOP or something like that), and therefore never realign its
> > > stack, while keeping some controlled data present on the syscall's
> > > stack?
> 
> How would you reliably detect that a stack pointer has been leaked
> to userspace while it has been in a syscall? Does not seem to be a trivial
> task to me. 

Well, my expectation is that folks using this defense are also using
panic_on_warn sysctl, etc, so attackers don't get a chance to actually
_use_ register values spilled to dmesg.

-- 
Kees Cook
