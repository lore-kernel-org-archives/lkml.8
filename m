Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C11C4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 152A920663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aH742N84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbgEDSMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730828AbgEDSMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:12:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B586C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 11:12:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x15so5939283pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 11:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2t85iJlph6Ef8JKJOUjpWg5TqaXW+ZWxyKsRV3ThBgw=;
        b=aH742N842oe7OA3iNJcOds5bSKnEuHAMCXh+aDAwkdSSQRtoymdunTd5VQAjlYHQOM
         OjULy3JBZp5yb7vg5p5qDxupV9iTMJr5cLcgxy/lXqRpmEnMPzqfvH6f95xCs9eY01RT
         47Si/yLCW7fX1qR5gKrcSyaoD4LfqSwa/YQyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2t85iJlph6Ef8JKJOUjpWg5TqaXW+ZWxyKsRV3ThBgw=;
        b=ZBNg3nI5ieMXDwCkAxUOmJx2pjeP2dR2raLANKvdfQGuARMjYCHnpkET5bvqyullG0
         l8ICCoJaRVS5MOgkObf7JmMbDMZlaGXylssknz7/crP1wo5FcCZItZlFFvQPGB24gTm9
         wO5D9VgiE4y15THUo8uml2UZRsos39HQeBbYsPVnYk461IN4AOhJrZASHk0q7iPuJVlx
         oVJJGaZT4+lEKns5G3z6xEziVTYHt77n4M05nDHw4FVuOM/Gyp6fDr0SPw7+mX0zRC8C
         lZW3Zl6VnHP6WeMtTD1QGuzLOeF/7YclC+mACVNodjYWEfMJLU1+JrsnfJcfpx46kM7I
         80Vw==
X-Gm-Message-State: AGi0Pubfgui0UEC2GfgeelSQfLUC0Df8g0/r8699XY/gzxGVMdAdY7s7
        im0aTMRigTEYbyd+FvgnIziK3A==
X-Google-Smtp-Source: APiQypJwXwd6yTrLo+nsjAM60TJxP6uE+6NhJJmcwz/VBqP3Hf1U27dr+P3P+V/0llWuVJfNyCsDzQ==
X-Received: by 2002:a63:951b:: with SMTP id p27mr194840pgd.49.1588615963952;
        Mon, 04 May 2020 11:12:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l5sm1558594pgt.92.2020.05.04.11.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 11:12:43 -0700 (PDT)
Date:   Mon, 4 May 2020 11:12:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>, jmorris@namei.org,
        sashal@kernel.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/3] printk: honor the max_reason field in kmsg_dumper
Message-ID: <202005041111.D803E731@keescook>
References: <20200502143555.543636-1-pasha.tatashin@soleen.com>
 <20200502143555.543636-2-pasha.tatashin@soleen.com>
 <20200504131500.5f6c8860@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504131500.5f6c8860@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 01:15:00PM -0400, Steven Rostedt wrote:
> On Sat,  2 May 2020 10:35:53 -0400
> Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> 
> > kmsg_dump() allows to dump kmesg buffer for various system events: oops,
> > panic, reboot, etc. It provides an interface to register a callback call
> > for clients, and in that callback interface there is a field "max_reason"
> > which gets ignored unless always_kmsg_dump is passed as kernel parameter.
> > 
> > Allow clients to decide max_reason, and keep the current behavior when
> > max_reason is not set.
> > 
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/linux/kmsg_dump.h |  1 +
> >  kernel/printk/printk.c    | 16 +++++++++-------
> >  2 files changed, 10 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
> > index 2e7a1e032c71..c0d703b7ce38 100644
> > --- a/include/linux/kmsg_dump.h
> > +++ b/include/linux/kmsg_dump.h
> > @@ -28,6 +28,7 @@ enum kmsg_dump_reason {
> >  	KMSG_DUMP_RESTART,
> >  	KMSG_DUMP_HALT,
> >  	KMSG_DUMP_POWEROFF,
> > +	KMSG_DUMP_MAX = KMSG_DUMP_POWEROFF
> 
> Hmm, I didn't realize that enums were allowed to have duplicates. That can
> usually screw up logic. I would recommend making that a define afterward.
> 
> #define KMSG_DUMP_MAX KMSG_DUMP_POWEROFF
> 
> As is done in other locations of the kernel.

I've seen it also be the last item in an enum, then comparisons can just
do "< KMSG_DUMP_MAX" instead of "<= KMSG_DUMP_MAX".

-- 
Kees Cook
