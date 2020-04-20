Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70930C55183
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49CCB207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2gZRkkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgDTVV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728150AbgDTVVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:21:21 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382ECC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:21:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r20so5558329pfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uz86WyXpZD4aK01AvgFxQcTobO1DIrQdnvHxYZU+v1g=;
        b=s2gZRkkKndLNkblWDyduoAGXU7tONSnx+h22+LKPEu1xCNTfj167lk3xFNDWULdibf
         QMmXoDoT+rU+/n0juU+cbwD3L89pQX8B7RqM6b/aCSeqv4YXlqrOO4AKDghtv3+qqQ5c
         9xGQ4xxcmUoGHJ2YasmZ+sQeoagJSOnbrLjQzqJ1Ny1eOugWVGpZQbRU3wquHEACr5DE
         jB6hPIIYqEb0mnGVUYO1tWwukp01nqN8oS52m7KJbvQ/CcUKezRRcKNOfYp8yr3Bvgwr
         WbhbJEhTDJz7ylqzkcGzSU7/R6hGkYphU0+6heCLt/VkVdVJD5Ozhfv8SC5l0apGuE7i
         dUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uz86WyXpZD4aK01AvgFxQcTobO1DIrQdnvHxYZU+v1g=;
        b=OGl5Ur5sammFYf236fCl61t/V7so7zC97srAE4/a46pvby5B7EBZmNW6jjJI9SPzeJ
         XbqmWwF4fmLbxl8sjVCxrlBHBjR74jk9zodc26KN/A0+RCR+HOwrXCTRd9o4mcSCS6q/
         SbdX+i++qiL7n9o4idK5xKB4mGm7nYPCXyHCJuiylkDRpqAcWHT3kbipk4DzVV7QfXXG
         l/rdipoghAM/rWaTjEfiNAjcwf9/TsYmhs77rGJysndaA0oDNAbr4/T7HebA9t1rlZBG
         USqgPZ8QI150aDsnyOz8zJ/mxiwReTsiu/vpr6pI12judRTWl1UrTNwIb36LGIqdpUPc
         5/8w==
X-Gm-Message-State: AGi0PuZC2AUvlwBklX9gcRP7UnHnVKwQSDWVnD0MBJOoXeXP2sDrUZez
        QO+9vzBQk9mq2fA52fptQlxPfw==
X-Google-Smtp-Source: APiQypIJ5dgZXInWQPnOxgl2H83kMh9t0kDEIPA3YY9dlUHOLn8dCodScN3RstdO6CqW8s/+YrPGlA==
X-Received: by 2002:a63:145a:: with SMTP id 26mr19419317pgu.238.1587417680555;
        Mon, 20 Apr 2020 14:21:20 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id 127sm423902pfw.72.2020.04.20.14.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:21:19 -0700 (PDT)
Date:   Mon, 20 Apr 2020 14:21:14 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 02/12] scs: add accounting
Message-ID: <20200420212114.GA77284@google.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200416161245.148813-1-samitolvanen@google.com>
 <20200416161245.148813-3-samitolvanen@google.com>
 <20200420171753.GD24386@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420171753.GD24386@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 06:17:55PM +0100, Will Deacon wrote:
> > +#ifdef CONFIG_SHADOW_CALL_STACK
> > +		       nid, sum_zone_node_page_state(nid, NR_KERNEL_SCS_BYTES) / 1024,
> > +#endif
> 
> Why not just use KB everywhere instead of repeated division by 1024?

This was to correctly calculate memory usage with shadow stacks <1024
bytes. I don't think we need that anymore, so I'll change this to _KB in
the next version.

Sami
