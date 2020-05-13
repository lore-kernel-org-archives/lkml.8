Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6522C2D0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965A920769
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KvbUf9n7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbgEMHrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgEMHrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:47:12 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB23CC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:47:10 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u35so4429681pgk.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Knn0jf0/vclS0Ugurfak7uxD0jycVtPvhoKug+BNtc8=;
        b=KvbUf9n7O1VSTSebKcFo14zCjmdMbhsq8ZWvqNyxzkE8949GHFqBUZayBMdjhqgFlB
         xn1CV9cIdzasYxiGE0WmehiVhnd6ovEQwElhi00QZk2giKfc1FY5je+pPT4PlO8hMxqu
         tnZjtU94cdMBgnqy4W4xP44dLPh+t7uUbutn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Knn0jf0/vclS0Ugurfak7uxD0jycVtPvhoKug+BNtc8=;
        b=jFZm154n9yQ3TVHfrc5hlXrTF90dyTioGwYA4H7y2W9MjLKeTVqfMo8U9nbXiLbTko
         zqo2Kqv6WLylfEeeeRoHF4xwseF/OBrjwNQbvzeLIVlJLG8HC9Z0jTPsp4sbyZpPuRqX
         zhNlaQY3ariizkgbboqt7G/y1qNNOvhJe+yFgmGalAz9HHEKUibxisELdiOqMHKaT3Hf
         EXt9mKE0rT66oBWXqiPj67qdTYfhtJzl5zSeiPnied5O/yTldBNveezSSdgJ3wXxNJdg
         L7gmoOVZo0JmO/0981VPVL7jSl+73Am6Vk/bZ5HFVIjNNBn9xVmb7iTMbQ/pEWoF2wfj
         rb0A==
X-Gm-Message-State: AGi0PuaJFaGeMj0wKWPotqKMaoO4boeN2aQMx/ZqRnZwZGCCe/LFjrkQ
        s5WU+jEZXWZSVw7mSULUum/Ucg==
X-Google-Smtp-Source: APiQypIOFJRoYFPckLNU7gCMIEAOvHkJqV8/zbo2htRrA5RmROIhxl9oM/nTS9P72UyT7EVbGgOvlg==
X-Received: by 2002:a62:144b:: with SMTP id 72mr25566659pfu.246.1589356030444;
        Wed, 13 May 2020 00:47:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m63sm14307808pfb.101.2020.05.13.00.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 00:47:09 -0700 (PDT)
Date:   Wed, 13 May 2020 00:47:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/6] allow ramoops to collect all kmesg_dump events
Message-ID: <202005130045.EF013D12E@keescook>
References: <20200506211523.15077-1-keescook@chromium.org>
 <20200512131655.GE17734@linux-b0ei>
 <CA+CK2bBMUxxuTBicQ7ihKpN3jK94mMjcNCXhnAXUaODce09Wmw@mail.gmail.com>
 <20200512155207.GF17734@linux-b0ei>
 <202005121111.6BECC45@keescook>
 <20200513073448.GG7340@linux-b0ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513073448.GG7340@linux-b0ei>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 09:34:49AM +0200, Petr Mladek wrote:
> On Tue 2020-05-12 11:45:54, Kees Cook wrote:
> > Here are the problems I see being solved by this:
> > 
> > - lifting kmsg dump reason filtering out of the individual pstore
> >   backends and making it part of the "infrastructure", so that
> >   there is a central place to set expectations. Right now there
> >   is a mix of explicit and implicit kmsg dump handling:
> > 
> >   - arch/powerpc/kernel/nvram_64.c has a hard-coded list
> 
> It handles restart, halt, poweroff the same way.  I wonder if anyone
> would want to distinguish them.
> 
> >   - drivers/firmware/efi/efi-pstore.c doesn't expect anything but
> >     OOPS and PANIC.
> >   - drivers/mtd/mtdoops.c tries to filter using its own dump_oops
> >     and doesn't expect anything but OOPS and PANIC.
> >   - fs/pstore/ram.c: has a hard-coded list and uses its own
> >     dump_oops.
> >   - drivers/mtd/mtdpstore.c (under development[3]) expected only
> >     OOPS and PANIC and had its own dump_oops.
> 
> The others handle only panic or oops.
> 
> What about splitting the reason into two variables? One for severity
> and other for shutdown behavior. I mean:
> 
>   + reason: panic, oops, emergency, shutdown    (ordered by severity)
>   + handling: restart, halt, poweroff
> 
> Or we might just replace KMSG_DUMP_RESTART, KMSG_DUMP_HALT,
> KMSG_DUMP_POWEROFF with a single KMSG_DUMP_SHUTDOWN.
> 
> Then the max reason variable would make sense.

That would work for me, yeah. Pavel, is that enough granularity for you?

-- 
Kees Cook
