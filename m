Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED98C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 23:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD9220672
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 23:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tb2Gnslj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgDYXvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 19:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgDYXvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 19:51:14 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866C7C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 16:51:14 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so6853376pfn.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 16:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gNimARR7f1InDIfM/YjZDsAudijPL9d0Tv5eGXZAxXU=;
        b=tb2Gnsljf6aXV7dwlLH5sp9kijyWYRxFCCSRWnn1B48dkzbnMrb+e+xolMNhnwLX5D
         gTPXec/jswTdMHouu/wipRx1fhg6N8SevPBgY8tHqL68tIk8846iFIfy5xQKw7DCxNZj
         m9sBu+Ev2hJ5de/BogDeUpdkOV04QPRXM9N9iIt6Dm89H25CxJNZjHeinekgKTXK3AUj
         /GhQYtmrpt0YST+VcuWgdQb9tTUzJG3uJoMsE5msVmoJvSYhh8Q+DaaL61BX+K7erBg/
         MD/s6ZPjqy8Vx1LogmDwji94pKc2+YShQbzHRXjM65HAm6lQZeD0h/aErFQLQBd1W9zx
         TVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gNimARR7f1InDIfM/YjZDsAudijPL9d0Tv5eGXZAxXU=;
        b=R/ZQYtLqCX2A+/1JF1pZZscgOk5mDcwf2HIoR5fxgl0hBgso1cRqW3K+c6uWopHh6c
         9sixeLmnfoqTKHOIImdYTsu59aM8SzcT9x6tQ0NBqNJUnKYgjmPD2kQQAy3PBy3YIWPT
         jZz3fL9FaANWK+AWAHPVlm6b2kpyaHUYIHESwdERPUwSq3DSlkPWQBXuQkBOuYAE+5ak
         8HF6Tm/uO4XjblGM+3jRs0Hd//bSEqGFSYAvjYk36VkBwhkNVTOrBBPTNPQSgrfP9SMI
         wrkMraoEzezP7UrkYV3uBVRZIP9xct0buEXywbmznU0HU/04J41hZOeceY9/NTX1BLu2
         dMCg==
X-Gm-Message-State: AGi0PubHe7KsCo2poYJcpa/J6xKDQtvuW+A1ntqSi+rNHePwhjkNMbP8
        t9E0L/6Dtb6D3XX6MFyXogk=
X-Google-Smtp-Source: APiQypJ3VkFB8XKBGSV4Z1WVyA4rnrjzxPXZwzod4p2Pk/ePnhc2dul3oeLQQlHLTEsIERYMClccGw==
X-Received: by 2002:a63:4d4f:: with SMTP id n15mr15654301pgl.399.1587858674077;
        Sat, 25 Apr 2020 16:51:14 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id d29sm7395596pgm.83.2020.04.25.16.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 16:51:13 -0700 (PDT)
Date:   Sun, 26 Apr 2020 07:51:05 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] mm/slub: do not place freelist pointer to middle of
 object if redzone is on
Message-ID: <20200425235105.sye7fsbndbv24b46@mail.google.com>
References: <ca36745b-1939-2640-aeed-390c8c39114e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca36745b-1939-2640-aeed-390c8c39114e@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 10:24:45PM +0200, Markus Elfring wrote:
> > Fixes: 3202fa62fb ("slub: relocate freelist pointer to middle of object")
> 
> Will a longer commit identifier be safer for the final change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=b2768df24ec400dd4f7fa79542f797e904812053#n183
>
I used to give 12 charactors, but this time I lost two. :)

> Regards,
> Markus

-- 
Cheers,
Changbin Du
