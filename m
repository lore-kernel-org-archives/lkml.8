Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC212C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11A62075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpp0i421"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgHGPFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 11:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgHGPFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 11:05:31 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D71AC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 08:05:31 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o23so2443619ejr.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ndkXqoYXV4SRjcjs22mzin/GG9waZBtSgJal0L6r/yk=;
        b=cpp0i421XHrpqv9BHWnksM3Y8nY1WTLJuOWw1ohGMXGpoLu3SbZ9hi707ZAw4pwd/c
         /+ygev/hR8olZUEVF7weNEW+i63CRwJDRoO2Jir57xfi+T8akwxkNaRDlrHBH8mSYF55
         7UKeGVq6pBKKDP30sFiJ9cZ11VGMJq1fMXsdM0Ih+OUGqmchqxVCgmgQSD24QcYEujkh
         QezX74PVkvalNZ1T8oFsaKll7GcuQZaIjk9GxQHCiED+OcBAo+rrYC8fLxOAXqv18gih
         eF9FC4cESf3S86DNGBKanFI/bzX3hbEhIqdWQJ5Knm+h88M2Nl5X4YLhSmrKkngHnpp8
         BLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ndkXqoYXV4SRjcjs22mzin/GG9waZBtSgJal0L6r/yk=;
        b=LMGO/GIrKOggr8yvJtZnBFTyyXtB716+Z3HwIENXZDNGJf5rrDmANc/OPsEHmRj3BE
         Gbe59o0wev0i2EWkxX0/l9dR2ld2QSj6gHLngFa7dnCYPgEloSzbI2T5zQlGbjx/6NuQ
         FWzu90Ioaohh+JOlnSccoGLYAXwgwqBMShKGuojfW2WqOM91kIGS6PuVogLDbUpVlgVz
         IzN9gAw1rvyjRz3PXbE+n8BmayhJofmUwDwX16e9AQJmuBDG1g9S23QfdcvZZoqx2jWW
         pYC5sSN2qcrRywFNRWaHMUrlB2X8Euou8xjVOeMPMdjwfbUM56eBSqqw1DLZn0Wkz09V
         PFuw==
X-Gm-Message-State: AOAM533yGMk56d/zHOOzTwqqRPYlL90X8YewxaT3WPIxBVZSAOTW0ll6
        o38qAoPbrHNw22PWW4+ZyEA=
X-Google-Smtp-Source: ABdhPJxvaX5Is9P48ICEEubLyvdT8KenxYxQx5zVjTleP8VwNO2ruyRIonq6WmPhj9xrE3aKeAt7Lw==
X-Received: by 2002:a17:906:f847:: with SMTP id ks7mr10245835ejb.402.1596812729607;
        Fri, 07 Aug 2020 08:05:29 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:5975:4576:7691:7d5b])
        by smtp.gmail.com with ESMTPSA id dm5sm5706647edb.32.2020.08.07.08.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 08:05:28 -0700 (PDT)
Date:   Fri, 7 Aug 2020 17:05:26 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: fs/erofs/zdata.c:198:22: sparse: sparse: non size-preserving
 integer to pointer cast
Message-ID: <20200807150526.vkbkslhiyy7gb6dc@ltop.local>
References: <202008072005.Myrby1lg%lkp@intel.com>
 <20200807144801.GA30258@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807144801.GA30258@hsiangkao-HP-ZHAN-66-Pro-G1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 10:48:12PM +0800, Gao Xiang wrote:
> On Fri, Aug 07, 2020 at 08:08:10PM +0800, kernel test robot wrote:
> > sparse warnings: (new ones prefixed by >>)
> > 
> > >> fs/erofs/zdata.c:198:22: sparse: sparse: non size-preserving integer to pointer cast
> >    fs/erofs/zdata.c:282:22: sparse: sparse: non size-preserving integer to pointer cast
> >    fs/erofs/zdata.c:1094:24: sparse: sparse: non size-preserving integer to pointer cast
> 
> I don't think these are valid warnings.

Indeed, they're not.
 
> All these three lines are using cmpxchg struct page * (which is equivalent to unsigned long
> in these cmpxchg macros) and nothing special at all in my opinion (Especially the last two
> lines).

What is special is that s390 use __sync_val_compare_and_swap() to implement
cmpxchg(). This builtin has a return type which depends on its arguments
while sparse was always using 'int' as the return type.

A patch is on the way.

Regards,
-- Luc Van Oostenryck
