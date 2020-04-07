Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E11C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057662072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HXd2UwNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgDGQdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:33:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44365 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgDGQdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:33:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id n13so540753pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 09:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AlcwjOm+1Oh931lo1HzGT/5VUetrnzxIQ7HJJpMAkSA=;
        b=HXd2UwNSpZv1U6uiJdGL+SA6oIP70AZXhiqqbtCpORm55myGT6F8YoYz1KcqrXBzpQ
         6PhnHzrI/1egYgCS4yivmIhASptb/TJE+LdK4qoo7Avb8yNPjTxfipFQpfqNBtoTtKOS
         IPLiKFb99PyptFPWiEJPD71sdfoIvojaqEh0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AlcwjOm+1Oh931lo1HzGT/5VUetrnzxIQ7HJJpMAkSA=;
        b=fO7BbgJw2J8ykAAkYipb3zHfnF9XtCoIfLhD+ewa3a88+M/AjmHQwIoveVc0F1KKk7
         0YLeEB0gY9VG8/LUZAzIBFPIeb0Zl95X1IyfI2pp0Cmx4nDGdq5sIMrxV1frItFsKYx6
         v+vuEU58YZkPBlz4uo2lUABGi53a8uDk/Tb1tEq882FIRP5csb13w8mHpeeMhx2FFxgb
         DH5ERBhAZGKyfhNFkiypAaGeXZ4umGhwqJlaqs55qBA7nwCuy/ZIw1apBGXgb8OXMP22
         E93j1N6+GyvuSszk586bjE1stRfu9rwRarnteHGgW1qFZstOy3TfpB7WSeYWkiJDegMr
         oYrQ==
X-Gm-Message-State: AGi0PubUj7mEqH/4DWTDE7QPS7YAU40RAHV4Ax2dmOYQP9WN/NG6olAU
        4nmcsJHYEcF0NcWv8ZdY2OQtMw==
X-Google-Smtp-Source: APiQypKeLFLniNnmBEATU0CRT1p7cx8eVojEZZ/MBtMP+nCynVZQytfYdqaR6xyI5TtllI5gK89mGg==
X-Received: by 2002:a63:be09:: with SMTP id l9mr2829851pgf.439.1586277198229;
        Tue, 07 Apr 2020 09:33:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b26sm11802653pfd.98.2020.04.07.09.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 09:33:17 -0700 (PDT)
Date:   Tue, 7 Apr 2020 09:33:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     kernel-hardening@lists.openwall.com,
        Emese Revfy <re.emese@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins/stackleak: Avoid assignment for unused macro
 argument
Message-ID: <202004070933.5112AA6@keescook>
References: <202004020103.731F201@keescook>
 <13c90df4-a422-bb73-a119-b8ccd11fc4f1@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13c90df4-a422-bb73-a119-b8ccd11fc4f1@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 06:30:18PM +0300, Alexander Popov wrote:
> Hello Kees,
> 
> On 02.04.2020 11:10, Kees Cook wrote:
> > With GCC version >= 8, the cgraph_create_edge() macro argument using
> > "frequency" goes unused. Instead of assigning a temporary variable for
> > the argument, pass the compute_call_stmt_bb_frequency() call directly
> > as the macro argument so that it will just not be uncalled when it is
> > not wanted by the macros.
> 
> Do you mean "it will just not be called"?

I really did. ;) Thanks, I'll adjust this.

-Kees

> 
> Thanks!
> 
> > Silences the warning:
> > 
> > scripts/gcc-plugins/stackleak_plugin.c:54:6: warning: variable ‘frequency’ set but not used [-Wunused-but-set-variable]
> > 
> > Now builds cleanly with gcc-7 and gcc-9. Both boot and pass
> > STACKLEAK_ERASING LKDTM test.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  scripts/gcc-plugins/stackleak_plugin.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
> > index dbd37460c573..cc75eeba0be1 100644
> > --- a/scripts/gcc-plugins/stackleak_plugin.c
> > +++ b/scripts/gcc-plugins/stackleak_plugin.c
> > @@ -51,7 +51,6 @@ static void stackleak_add_track_stack(gimple_stmt_iterator *gsi, bool after)
> >  	gimple stmt;
> >  	gcall *stackleak_track_stack;
> >  	cgraph_node_ptr node;
> > -	int frequency;
> >  	basic_block bb;
> >  
> >  	/* Insert call to void stackleak_track_stack(void) */
> > @@ -68,9 +67,9 @@ static void stackleak_add_track_stack(gimple_stmt_iterator *gsi, bool after)
> >  	bb = gimple_bb(stackleak_track_stack);
> >  	node = cgraph_get_create_node(track_function_decl);
> >  	gcc_assert(node);
> > -	frequency = compute_call_stmt_bb_frequency(current_function_decl, bb);
> >  	cgraph_create_edge(cgraph_get_node(current_function_decl), node,
> > -			stackleak_track_stack, bb->count, frequency);
> > +			stackleak_track_stack, bb->count,
> > +			compute_call_stmt_bb_frequency(current_function_decl, bb));
> >  }
> >  
> >  static bool is_alloca(gimple stmt)
> > 
> 

-- 
Kees Cook
