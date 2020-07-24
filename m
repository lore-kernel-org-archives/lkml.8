Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD71C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 749BA206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WU9slZt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgGXRmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXRmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:42:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9F8C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:42:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 72so4884162ple.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XwpNl/RSgSBBWaddv3urfADovlU2IQQNUsOQ5gJRgfo=;
        b=WU9slZt/60VXkdmS1OpvEXJ8mEGSsVlwVeByIAqKlB/4k4px26WInz/NJ5KOpt9C7f
         71G2bwjhucwf/lZMokI1XX2uVD8KUgvc/COEJEVz2m64NkyoZ/IbSDZCGM/fR83z0Ctk
         /0825/9u+PETjTUByM40o6Ma8MVukMZWFS+Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XwpNl/RSgSBBWaddv3urfADovlU2IQQNUsOQ5gJRgfo=;
        b=PRynL75lLEQB8Ye6nAGoS1kHC5vCT41WHZXpbhAcLfEk6jK4J3BWLICyFB3jW8G13g
         9+Qqw2pR+SKgnYQq4Fe2C5EYHb9PqnFe7jJO/IMRgUlX+IulC3Fmthqy48yXfptIi2/Z
         4dbSzGDD5w68b+RkmVot6gc4zPKhqVed9d19F3zS1iH7koa+zylvzXtet5aiCKxIL8BH
         UHOdfIDj9sYygTZP9SEZp3g0/JXAJVPbg7iJoo+9Pf54ixfK47w5uq+aABE+PrSIisU1
         c/nEIqM5TAnYf7zRlBdAKfxg9SaokJtt6YtWv0rpxENdJr8TOvkMQIfI64dn6r/JjDUD
         hBsQ==
X-Gm-Message-State: AOAM530JdxsYzNDYx/LeFabiQILdeTZ5TyRIKQB1+31Ez3kFGdm+RaVN
        YejLpbQ2gi/ZDSFQktVovlKPOg==
X-Google-Smtp-Source: ABdhPJzuAMEgACl6KnJ/cKznCSDX4BZLn6+ziD98Tx6G4Jv3sBo+cq7KrfZKMmeGTt0N9+kxSsv5rA==
X-Received: by 2002:a17:90b:1812:: with SMTP id lw18mr208834pjb.70.1595612541740;
        Fri, 24 Jul 2020 10:42:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p11sm6540646pfq.91.2020.07.24.10.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 10:42:20 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:42:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 30/75] x86/head/64: Setup MSR_GS_BASE before calling
 into C code
Message-ID: <202007241041.71B4B3E@keescook>
References: <20200724160336.5435-1-joro@8bytes.org>
 <20200724160336.5435-31-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724160336.5435-31-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 06:02:51PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> When stack-protector is enabled a valid GS_BASE is needed before
> calling any C code function, because the stack canary is loaded from
> per-cpu data.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
