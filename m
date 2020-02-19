Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26B2C7114E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DAE24670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fDVP0rmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgBSV6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:58:08 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33918 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgBSV6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:58:07 -0500
Received: by mail-pl1-f193.google.com with SMTP id j7so649961plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 13:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KF6Ikjhc00+h8hjJ+WbvK3v8JSlaDqUUFDoxDuJGfnw=;
        b=fDVP0rmVmfaRyZajaUQvr6a/x5EutBan6IauHsq4C2c4AYYR3O/Uiaphfxs0Qm9/+1
         9HEY1k7N++6wzXaMZ7YTpG7/U+gy2siuF8eV6i9Yqa6xv1pDebxXJt9J49cUaqj5hDDq
         MdA1vIjrEgcd0lZCZ8hDU6zLvYCVOAjwYd/qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KF6Ikjhc00+h8hjJ+WbvK3v8JSlaDqUUFDoxDuJGfnw=;
        b=O60XRRZGohNqcnxjM6XS0+EDyrveaTx7i0dWEqxBmh52kHrN1+WveVIQbk+SF/Uh9g
         VOOSyKTGsOy74r6hoT8H/eeRPliUxC7G/LHuUnfSlwfsvGlBQvw11g6YdVUYR7TUqGNG
         r+6OQvXXbBk1kKCc8qqdrW0+cBo5UTDNXQzEj2RF7VKrhiRWp/jAbrNJQBkeHOBQUwMU
         BHqKPt0djJ0laNiVRWioGQsYClFBN9LCcN2WXaiQENazWrB/bbHqAUrk0udOX3inglm/
         NehEYnPaZEtS5fien9RSTgHEzXL+yrzXgQtTlkP3X6ISXWgx2gfj+1etTclI1g/HjFoy
         cdtQ==
X-Gm-Message-State: APjAAAW8Ofmb3m0K0edvnKRPDaLEbPXZa9xCkLLDkO8kOEAGT6xWLQfL
        XmEs89FSbbSVIHw/kMMSv/i3tgjqL8s=
X-Google-Smtp-Source: APXvYqxci4yNSCG7aUsFPR+7KxF+DGdHGDCSajewzDiDDRHSdsp8i+NaMDr3bHf0GQAdxnxTv73ZZQ==
X-Received: by 2002:a17:90a:c389:: with SMTP id h9mr11876916pjt.128.1582149487227;
        Wed, 19 Feb 2020 13:58:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l25sm655494pgt.85.2020.02.19.13.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 13:58:06 -0800 (PST)
Date:   Wed, 19 Feb 2020 13:58:05 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Jann Horn <jannh@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib/test_stackinit: move a local outside the switch
 statement
Message-ID: <202002191347.B689E5B43A@keescook>
References: <20200218094815.233387-1-glider@google.com>
 <202002190916.EFA74B50C@keescook>
 <CAG_fn=X-BeOooHDCKczm+KzWDBp_TY5e2VTnUxiqbHpipoF-sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=X-BeOooHDCKczm+KzWDBp_TY5e2VTnUxiqbHpipoF-sg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 06:56:38PM +0100, Alexander Potapenko wrote:
> On Wed, Feb 19, 2020 at 6:36 PM Kees Cook <keescook@chromium.org> wrote:
> Am I understanding right that these warnings only show up in the
> instrumented build?

Correct.

> According to the GCC manual:
> 
>    -Wswitch-unreachable does not warn if the statement between the
> controlling expression and the first case label is just a declaration

Right, just a declaration is okay. An initializer is not handled:

        switch (argc) {
                int foo = 0;
        case 0:
...

foo.c:6:7: warning: statement will never be executed
[-Wswitch-unreachable]
    6 |   int foo = 0;
      |       ^~~

The problem I had with the "simple" stackinit GCC plugin was that it
didn't handle padding. What I don't understand is why structleak (with
seemingly the same initialization) _does_ initialize padding:


structleak:

        PASS_INFO(structleak, "early_optimizations", 1, PASS_POS_INSERT_BEFORE);
...

        /* build the initializer expression */
        type = TREE_TYPE(var);
        if (AGGREGATE_TYPE_P(type))
                initializer = build_constructor(type, NULL);
        else
                initializer = fold_convert(type, integer_zero_node);

        /* build the initializer stmt */
        init_stmt = gimple_build_assign(var, initializer);
        gsi = gsi_after_labels(single_succ(ENTRY_BLOCK_PTR_FOR_FN(cfun)));
        gsi_insert_before(&gsi, init_stmt, GSI_NEW_STMT);
        update_stmt(init_stmt);

vs stackinit:

        register_callback(plugin_name, PLUGIN_FINISH_DECL, finish_decl, NULL);
...

        type = TREE_TYPE (decl);
        if (AGGREGATE_TYPE_P (type))
                DECL_INITIAL (decl) = build_constructor (type, NULL);
        else
                DECL_INITIAL (decl) = fold_convert (type, integer_zero_node);

I assume the difference is due to either pass ordering or the former's
basic block splitting. I haven't had time to dig in and figure it out.

-- 
Kees Cook
