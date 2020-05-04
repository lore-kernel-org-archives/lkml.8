Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C86C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 215BD20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NSx6akBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgEDReG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729549AbgEDReF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:34:05 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922C1C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:34:05 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w65so5865183pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PrY9RkQAS2W4bvl/VgQNbnvFW03G7lNRCloDxmlrbTs=;
        b=NSx6akBsnMeQfEHZMVzRywWho3NUk5G1Vo0x9NmA2cdAFkj2Jt+bh+ps+QVmtbKP6P
         Zml20Z7STNcLk6CRZra57o6MZBjJkz/1+fx7yVrRrpKS0u6X7Tiy5VZSn9MegaYT6ZOm
         a4Y9ctFI/tzyT4DFAtGg2FqiJ2zkHVYo53oNdDszflXKgRFIY9gWSJku6qzMvTeTmhJY
         FewTT7B04sS1GWkGafkaO5BjJaa9EIGdXsEtvWPQNoW4vfSk7SKcNZgCtH6TJjNl/rJ1
         EzzEaVpjzUUNwwIoQZfhQiJC05upym6vjJqsM4/7CQCTICTvXtXrgnJ4NFPjTdE1aQkL
         NUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PrY9RkQAS2W4bvl/VgQNbnvFW03G7lNRCloDxmlrbTs=;
        b=MaG1KcyTklo1KLwDDIW8wvKr5abBy+RvaWwqn0g5yZ6Pp1Szp8dV/RqUfuZBPciFos
         CjYNfOxdF5lLCBYHIv1Mzrb2wLUGzaEUha6wHfAN7njzibsVMCPgB46bYt4PE9pRhs70
         NR9ClTgfJwHneA2f/mPA5wulkKJWnuu0GLHMI/VWKs36o/Y7oc7gfgVfF2kgrQUg67Jc
         6d3zHNKwGGKG7/wH+w6ikt3VmxKeoMY8Svb+YhsAyDTKwfBUDs2d6EoLSNVRa9J6zGj2
         35L9dc0oqeXFqjxwDChKliLc5zuFXYexnIM6d7Rfq6+eTMA8DUBvUIqttZl3A30N1QMH
         AB7g==
X-Gm-Message-State: AGi0PuY+asJYtIexwD39bEANg/7TTPv7gIrO+t08iDJDONFcSHhbFrW7
        aGmIJZ0ZiWg3/CicTQ+v7kObAg==
X-Google-Smtp-Source: APiQypKurnJqa9FCEdm9LaSAgNsP73wdOybQtoVO9KgHsIEow7TzATK6FCFw0kO5pS7r5hlTl3puzA==
X-Received: by 2002:a63:2943:: with SMTP id p64mr91169pgp.36.1588613644620;
        Mon, 04 May 2020 10:34:04 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id w69sm9342974pff.168.2020.05.04.10.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 10:34:03 -0700 (PDT)
Date:   Mon, 4 May 2020 10:33:56 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 01/12] add support for Clang's Shadow Call Stack (SCS)
Message-ID: <20200504173356.GA7200@google.com>
References: <20200416161245.148813-1-samitolvanen@google.com>
 <20200416161245.148813-2-samitolvanen@google.com>
 <20200420171727.GB24386@willie-the-truck>
 <20200420211830.GA5081@google.com>
 <20200422173938.GA3069@willie-the-truck>
 <20200422235134.GA211149@google.com>
 <202004231121.A13FDA100@keescook>
 <20200424112113.GC21141@willie-the-truck>
 <20200427204546.GA80713@google.com>
 <20200504165227.GB1833@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504165227.GB1833@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 05:52:28PM +0100, Will Deacon wrote:
> On Mon, Apr 27, 2020 at 01:45:46PM -0700, Sami Tolvanen wrote:
> > I agree that allocating from a kmem_cache isn't ideal for safety. It's a
> > compromise to reduce memory overhead.
> 
> Do you think it would be a problem if we always allocated a page for the
> SCS?

Yes, the memory overhead was deemed too large for Android devices, which
have thousands of threads running.

Sami
