Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E19C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D351E206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EPH1rPQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgDUUNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgDUUNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:13:45 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E3EC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:13:44 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h11so5670422plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zU+Qe13RM8w9jiKui1cp9m/91Pj+sZI1Kh2v8CmodJU=;
        b=EPH1rPQ6rCi6kTPTHAzZ3NTtXgmEgpZIXTaZcdakKQMCZt3v62s1FcKJkiV7cemrsw
         MqaOSQOiMEsKU9FuKRNqcsPFnSxO3RJ90PztyxI+rZaTItXDeP77iHsLjR1nz1C2zhYg
         2Iw8iWXN5z3VLZwF7c6REihQ7wMffPCcjcZW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zU+Qe13RM8w9jiKui1cp9m/91Pj+sZI1Kh2v8CmodJU=;
        b=i6mahuJ/VZFfWdH3pNSs2rfJf8THhPJpYFofG27E7FTfWY5rfCne+jeFxAZvzHGB2R
         ZeoANEl0yIOS/tRT7qdtguCD+aUTRoYl0YLnowlfVDzW2bd4+TIz/sRqhYCi3eC2YXvM
         51tS80EB7kiT9W/L4UkeYSNo2r57BF+JZzGzSJ7MCFxQoQPidN7Hg/Wmf5STugdV2pny
         vybSIVYrInG/4S/0TnVR2itiDWY/3CGAOeysQuAYtcCpCgPXHcm9q8dELLL7UgrRlJqB
         83H9REKeJ8KnKLubWkcQs3+GZAY4WDlzQu4J8GfR17LdlKVtp2D3++4DDK6Hj1M7lnOy
         xlFA==
X-Gm-Message-State: AGi0Pub/k9q39M+MdWcD1wTDlIgdf4Vy56G9209PwGtdgyaZ2WXzShaF
        lRm3eVps80ZTLVeWSeMF4aRYuuGvlQM=
X-Google-Smtp-Source: APiQypL7cUB9UH2M34v8Tu2Ef4Wz7oX/K/T2h7kVallC0yil+djyZF8+t+dIOZi6w/mScJV+o0aq1A==
X-Received: by 2002:a17:902:ba89:: with SMTP id k9mr22880374pls.199.1587500024421;
        Tue, 21 Apr 2020 13:13:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l185sm3125944pfl.104.2020.04.21.13.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 13:13:43 -0700 (PDT)
Date:   Tue, 21 Apr 2020 13:13:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] objtool: optimize insn_hash for split sections
Message-ID: <202004211313.8B7F529CE@keescook>
References: <20200421180724.245410-1-samitolvanen@google.com>
 <20200421180724.245410-3-samitolvanen@google.com>
 <20200421194749.GX20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421194749.GX20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 09:47:49PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 21, 2020 at 11:07:23AM -0700, Sami Tolvanen wrote:
> > When running objtool on vmlinux.o compiled with -ffunction-sections,
> > we end up with a ton of collisions in the insn_hash table as each
> > function is in its own section. This results in a runtime of minutes
> > instead of seconds. Use both section index and offset as the key to
> > avoid this, similarly to rela_hash.
> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> 
> I already have this queued:
> 
>   https://lkml.kernel.org/r/20200416115119.227240432@infradead.org
> 
> which looks very similar.

Ah! Yeah, just no insn-arg helper to do the hash call; cool.

Please consider both:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
