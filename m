Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE69C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8116A2074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XXMpqOwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgFEVGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgFEVGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:06:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11E2C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 14:06:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q16so4191479plr.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 14:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jTFZ1Ntt0kQNuevlOB6AQQvurETxN1GO4XXrxqpEowE=;
        b=XXMpqOwrg1ljeko+PJv6zkswcdEPWXabDr5dTWWlyRlic0+6DTvw5i0gF7mWBtLLvi
         hPOrmw2bfjOlzUV/W33tnshN/uzU8OKT3q+so2ymM85dnPPNFjynBw+abclNukvfnc/N
         dtkz4tRiS4qIo8O3v7NcDU93Xiw75XOh/xnIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jTFZ1Ntt0kQNuevlOB6AQQvurETxN1GO4XXrxqpEowE=;
        b=cDmpcg+G1PglMA0ATQYzZDlmXlWpUahI8lcAF1g2xFdt4iUOIAi9whjRnhte63xO+9
         aotayD2GLZT7TuMyZtjwT1W7UG1TFM9kyJ4Av4UYjPg1p0AQ8YZLsqFMejnpSUDGIHGm
         XBYHtmI4E7ollYExbe0sV7HtK3a63xszvZ3EljdI1tQcJX5eWrVPGwGmGLBb1dzSAOHF
         t9L/5rohcKef2u8NnD4jKlZQdf2lETNdgT+I3x5z/mqivcFkOwXs1CTVQMJ6x2rdIjMB
         H/n9+ZsKe5W5/b/IDw0S3MPQXQry/P0VUXJ/o9Oan8TxRYHHRI1Tme0qJQKi2baIAbGy
         qzbQ==
X-Gm-Message-State: AOAM530S28WOv/RLkfbswdEiu6XW6tTPkso+XpXRU6jYMPKzp7ceJ8ee
        w3ju6BSpEcR/nVsrA0lceDh3Ag==
X-Google-Smtp-Source: ABdhPJw9p3+Hn63u4279CMG0IiKsFJJeM4m/W9kT/nl2W8VMXr0TQpj7zoUQQHEP5v/V0lPhv9NCLQ==
X-Received: by 2002:a17:90b:108b:: with SMTP id gj11mr5094045pjb.227.1591391200338;
        Fri, 05 Jun 2020 14:06:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g29sm458387pfr.47.2020.06.05.14.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 14:06:39 -0700 (PDT)
Date:   Fri, 5 Jun 2020 14:06:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vinmenon@codeaurora.org, Matthew Garrett <mjg59@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC PATCH 2/5] mm, slub: make some slub_debug related
 attributes read-only
Message-ID: <202006051406.CB3237B0@keescook>
References: <20200602141519.7099-1-vbabka@suse.cz>
 <20200602141519.7099-3-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602141519.7099-3-vbabka@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:15:16PM +0200, Vlastimil Babka wrote:
> SLUB_DEBUG creates several files under /sys/kernel/slab/<cache>/ that can be
> read to check if the respective debugging options are enabled for given cache.
> The options can be also toggled at runtime by writing into the files. Some of
> those, namely red_zone, poison, and store_user can be toggled only when no
> objects yet exist in the cache.
> 
> Vijayanand reports [1] that there is a problem with freelist randomization if
> changing the debugging option's state results in different number of objects
> per page, and the random sequence cache needs thus needs to be recomputed.
> 
> However, another problem is that the check for "no objects yet exist in the
> cache" is racy, as noted by Jann [2] and fixing that would add overhead or
> otherwise complicate the allocation/freeing paths. Thus it would be much
> simpler just to remove the runtime toggling support. The documentation
> describes it's "In case you forgot to enable debugging on the kernel command
> line", but the neccessity of having no objects limits its usefulness anyway for
> many caches.
> 
> Vijayanand describes an use case [3] where debugging is enabled for all but
> zram caches for memory overhead reasons, and using the runtime toggles was the
> only way to achieve such configuration. After the previous patch it's now
> possible to do that directly from the kernel boot option, so we can remove the
> dangerous runtime toggles by making the /sys attribute files read-only.
> 
> While updating it, also improve the documentation of the debugging /sys files.
> 
> [1] https://lkml.kernel.org/r/1580379523-32272-1-git-send-email-vjitta@codeaurora.org
> [2] https://lore.kernel.org/r/CAG48ez31PP--h6_FzVyfJ4H86QYczAFPdxtJHUEEan+7VJETAQ@mail.gmail.com
> [3] https://lore.kernel.org/r/1383cd32-1ddc-4dac-b5f8-9c42282fa81c@codeaurora.org
> 
> Reported-by: Vijayanand Jitta <vjitta@codeaurora.org>
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
