Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FBBC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 01:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7143F20772
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 01:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cAQW8ecD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgFFB6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 21:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgFFB6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 21:58:55 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EFAC08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 18:58:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n23so5959950pgb.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 18:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ubiyZ733CfEJjdLHhaoOsVA1qzS8di3dJmbcr/gH2uM=;
        b=cAQW8ecDYpX05sVWOHMBk1sbV5DXDbFHVqcQUUOEWATk8Z077CtX6sGKmDYPmCQo0j
         cWwStNFFXcL5bGQ5XRO2g4V/CRmVQxBRaFMK96+FjTNOA4HtICtpU1S+KzQYWjz+6hS/
         l+X7QQX1smTeSTPqjUrYKWb3GMIRmesyECBZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ubiyZ733CfEJjdLHhaoOsVA1qzS8di3dJmbcr/gH2uM=;
        b=spwgF+lsoZjWxhPwh2XnZm740pQMvgXF+6gT8mTr1Cbinc+GTs1b94gYBleHpXh3ML
         e/KQzauudwJSnQhXROODg0VCrjz3DycOgjodBwhdgThv6fI1DTt/41ZGiAaKka4cKZ8G
         u4nFyMb41AB7MeyKKk2Ud43jpnhdxRUHg5SUruv7dmQbuIJ6gusLI1T/VDWb0FufsAyd
         pU9QZer5nfPcazGR+zA+EJ5QyQY4unGZpMQr7JBSNl33xDk8Osm1BnL/ccrkln9GQc6N
         uCiJ25yF3Y+DeiKhaltL4cyYZj7gVCWydVSWzG07SiiadP1ncvP/R35Ioj5hVInHL9Ab
         KDKw==
X-Gm-Message-State: AOAM532boYS/1GW6Kl7A7KkRtQ/EKwCxNJtPKqmk16ReBiWIBiltxc70
        kHxgCbiyF01CnvxiK6bGz94kwUDXHkXVag==
X-Google-Smtp-Source: ABdhPJyeGr9iCUKxjFBLcQwcqAStcKGLhCd1nJ9DaQgFhqK2lIGzXeCTkSGZWy0vIFqUT4/Fcwv0Dw==
X-Received: by 2002:aa7:8bd0:: with SMTP id s16mr12878768pfd.80.1591408733436;
        Fri, 05 Jun 2020 18:58:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y136sm787864pfg.55.2020.06.05.18.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 18:58:52 -0700 (PDT)
Date:   Fri, 5 Jun 2020 18:58:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-afs@lists.infradead.org,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/27] afs: Detect cell aliases 1 - Cells with root
 volumes
Message-ID: <202006051849.746915FD@keescook>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
 <159078973503.679399.3701716594246594498.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159078973503.679399.3701716594246594498.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 11:02:15PM +0100, David Howells wrote:
> +static struct afs_volume *afs_sample_volume(struct afs_cell *cell, struct key *key,
> +					    const char *name, unsigned int namelen)
> +{
> +	struct afs_volume *volume;
> +	struct afs_fs_context fc = {
> +		.type		= 0, /* Explicitly leave it to the VLDB */
> +		.volnamesz	= namelen,
> +		.volname	= name,
> +		.net		= cell->net,
> +		.cell		= cell,
> +		.key		= key, /* This might need to be something */
> +	};
> +
> +	volume = afs_create_volume(&fc);
> +	_leave(" = %px", volume);
> +	return volume;
> +}

This really doesn't seem like a justified[1] place for %px. (Even if
_leavel() is debug-only, all the rest of _leave() uses are %p.)

> +	default:
> +		BUG();

And nothing should add BUG() to new code[2].

-Kees

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#p-format-specifier
[2] https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on

-- 
Kees Cook
