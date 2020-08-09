Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F5DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 21:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82097206B5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 21:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6WXu9+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgHIVA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 17:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgHIVA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 17:00:28 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F645C061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 14:00:28 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d19so3818670pgl.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8aCJEZf4WEBTwITZBbhB6tXQBzDbqQHz0bfAnaUx6qs=;
        b=T6WXu9+xEDiJ7an8AcxVIStPcb1AdtIN3L1aO00LS4X5PRdZMPY5jR04uTlujVuaT7
         kEk++vl2e0HBgGXnmycZT4T3AJTM9WazVKcAI7Ya3NE+yK3vktMd6OwJ9KA0aOCYYv9a
         0VL5UeQ95TtvN0Y6P3MvoQhInCma3tsUdzzEFzl6IAZGNu181WePZO+jQ50Q0trva505
         Tjo9MAsM3fZl8Rfdv7nXhUqPnOXWI22Pg4t3RA9IoW2rRQLLFleBcrnzYxJ9hiW7hTzq
         dX1WqUeg3jbOF0Um72qPTumDwnuRIMZCMs61PT+i7ob8x04hZhGpzZO/5tqc3iR2G92r
         /tYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8aCJEZf4WEBTwITZBbhB6tXQBzDbqQHz0bfAnaUx6qs=;
        b=V8neKcUYnfdUUaGq2IA0A5HmRL3T1AyTjpyHyIk9CoFVklLkivtCzr9MQgBkQfFNnr
         99B0gr1qmqbKS182yap6LTBenbF6UO59NJWq/BUBMdHIPsyDShVgMhyJl/T/Kedq748W
         PtAYXmIrNv8Tfc4BmY6AQiXGIg8RA3oEuYK/51Gd2gLJ/XpDrI26DPCRacRpLNH88mZn
         lUoB8RPD1qJh5so2wmNn7X35RXZBX+kAeSpIDx99IMpAezslPiRvjsKtTLd70OI1yWrS
         lwM4B3fTlhS4Kk8dYQwuclJNz9lWQygCVGEGuBNmxc7YtWtL87xgvlU4sYFVUYAsy/n7
         nCuA==
X-Gm-Message-State: AOAM5317BCznM174NUM7VNe59rs0qodWbYolQ31t8KHXELAma2STnSUF
        RuX+AvzoODo63JZA97tZdhw=
X-Google-Smtp-Source: ABdhPJw7qg6WwEw+c7lgngvfzj1mQ73HM9myLMInvTDB5Phgrfxjwf1VC1+VWbFwlhUIe5FzUV0xFw==
X-Received: by 2002:a65:6289:: with SMTP id f9mr19212430pgv.272.1597006827473;
        Sun, 09 Aug 2020 14:00:27 -0700 (PDT)
Received: from thinkpad ([69.172.171.109])
        by smtp.gmail.com with ESMTPSA id gm9sm17046793pjb.12.2020.08.09.14.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 14:00:26 -0700 (PDT)
Date:   Sun, 9 Aug 2020 14:00:56 -0700
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     xujialu <xujialu@vimux.org>, masahiroy@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: realpath "No such file or directory" warnings when building tags
 from KBUILD_OUTPUT directory
Message-ID: <20200809210056.GA1344537@thinkpad>
References: <20200808202822.GA597061@thinkpad>
 <20200809071627.GC1098830@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809071627.GC1098830@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 09, 2020 at 09:16:27AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Aug 08, 2020 at 01:28:22PM -0700, Rustam Kovhaev wrote:
> > running 'make ARCH=x86_64 COMPILED_SOURCE=1 cscope tags' in
> > KBUILD_OUTPUT directory produces lots of "No such file or directory"
> > warnings from realpath
> > 
> > it seems like commit 4f491bb6ea2a greatly improved tags generation when
> > COMPILED_SOURCE=1 is set, but should we add "-q" flag for realpath in 
> > all_compiled_sources() or probably it would be better to fix root cause
> > and make sure that for example we don't try to find objtool sources and
> > exclude other similar dirs during tags generation? what do you think?
> > 
> > ...
> > realpath: special.h: No such file or directory
> > realpath: warn.h: No such file or directory
> > realpath: sigchain.c: No such file or directory
> > realpath: sigchain.h: No such file or directory
> > realpath: orc_gen.c: No such file or directory
> > realpath: objtool.c: No such file or directory
> > ...
> 
> Care to send a patch for this?
hi Greg, yes i do, thank you!

