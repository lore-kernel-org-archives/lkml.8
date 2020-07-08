Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4D6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BE882078A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DBkvy0NK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgGHIWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgGHIWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:22:31 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EFFC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 01:22:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j19so14446809pgm.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 01:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+WHZEkgbRn1GZtipugYZWIhuk4XxfES0a92pxk+TNa4=;
        b=DBkvy0NK9CykHdZtUaT89e+b6Y27pzscN8ahqFm4CMwWXSsJByCy67sccdKQlgY8Aq
         vwsQRJFEnbkMuUHtXP3L/yjY3q4YqZTBY8UJS1AJyH11wU2pwzsI3OXgWrFgIQcSj9WC
         vXDhlloTMo7pr+v8fqPCeWTNycNcdpV2oXD8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+WHZEkgbRn1GZtipugYZWIhuk4XxfES0a92pxk+TNa4=;
        b=msyTnBwNTZdw/f6z2VMr6c+Mu8j9S1g/f4mf3TrT4rreEWEYsv95rZbr9H48QLxozy
         FGi1LQ4A/duP74lVcj3Ns6LyIq3J29x7HkWnFZ2fATw7KDeY6L/gzDo+KA5Eo3Saje9r
         XaBg+s45yPhhBK4U6GqQzJ+Ns/u/ztYKASrDicGNOj9nh8p85L1rDPhtUBDF/uKlzH3R
         02gZCPV2fpa46GeXs4JmtzBfpffXIAIXMWlVtb6skKBY4X21LpYo70WQjEYM1dJbiz+h
         XchcUnO3tSxmhcBDpUMQ7FdIErHv1wEOdGWjLHpXiQZimfgeuL7s4zG+MQqu2mHIAlTI
         OVCQ==
X-Gm-Message-State: AOAM533oqTLOz+Z4U2Ejj81m+bTizyFDU3u3fhmMsPgeWrqB1TjNtm14
        PcAUc5D6Gx2Ax8oKJXh2HwOhDQ==
X-Google-Smtp-Source: ABdhPJwhpW2H06JUZuBCREiFew172FWggpN7+VciY6tAUc7EP1G0jkq6LVyX1PvI0ZZ8Hy1nUwgU0Q==
X-Received: by 2002:a63:531e:: with SMTP id h30mr46674003pgb.165.1594196549725;
        Wed, 08 Jul 2020 01:22:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d14sm4720225pjc.20.2020.07.08.01.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 01:22:28 -0700 (PDT)
Date:   Wed, 8 Jul 2020 01:22:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     corbet@lwn.net, Randy Dunlap <rdunlap@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        SeongJae Park <sjpark@amazon.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org,
        tech-board-discuss@lists.linuxfoundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] CodingStyle: Inclusive Terminology
Message-ID: <202007080108.454C937@keescook>
References: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 12:23:59AM -0700, Dan Williams wrote:
> Linux maintains a coding-style and its own idiomatic set of terminology.
> Update the style guidelines to recommend replacements for the terms
> master/slave and blacklist/whitelist.
> 
> Link: http://lore.kernel.org/r/159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com
> Cc: Jonathan Corbet <corbet@lwn.net>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Dave Airlie <airlied@redhat.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Acked-by: SeongJae Park <sjpark@amazon.de>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Chris Mason <clm@fb.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes since v1 [1]
> - Drop inclusive-terminology.rst, it is in the lore archives if the
>   arguments are needed for future debates, but otherwise no pressing
>   need to carry it in the tree (Linus, James)
> 
> - Update the recommended terms to include replacement for 'master' and
>   'whitelist' (Kees, Andy)
> 
> - Add 'target' as a replacement (Andy)
> 
> - Add 'device' as a replacement (Mark)
> 
> - Collect acks and signed-off-bys. Yes, the sign-offs are not reflective
>   of a submission chain, but I kept "Signed-off-by" if people offered
>   it.

In that case, I will "upgrade" my Ack. ;)

Signed-off-by: Kees Cook <keescook@chromium.org>

:)

> - Non-change: I did not add explicit language as to what to do with
>   existing usages. My personal inclination is to prioritize this
>   coding-style cleanup higher than others, but the coding-style document
>   has typically not indicated policy on how cleanups are handled by
>   subsystems. It will be a case by case effort and consideration.

While I'd like to have published guidance on fixing existing language
(which is already underway[1]), I agree: let's start here.

> [...]
> +For symbol names, avoid introducing new usage of 'master/slave' (or

For symbol names, comments, documentation, and other language, avoid
introducing ...

> +'slave' independent of 'master') and 'blacklist/whitelist'. Recommended
> +replacements for 'master/slave' are: 'main/{secondary,subordinate}',
> +'primary/replica', '{initiator,requester}/{target,responder}',

the main and primary should be merged, IMO:

	'{primary,main}/{secondary,replica,subordinate}'

> +'host/{device,proxy}', or 'leader/{performer,follower}'. Recommended

leader/performer does not track for me. Split it out?

	'leader/follower', 'director/performer'

I have also seen:

	'controller/worker'

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20200630174123.GA1906678@kroah.com/
    https://lore.kernel.org/lkml/20200701171555.3198836-1-gregkh@linuxfoundation.org/

-- 
Kees Cook
