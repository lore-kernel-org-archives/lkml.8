Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D00EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38234207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590744940;
	bh=WuvCWYSoxjZDnwvGT6QMvnfE18lJW9kUniAIAcbu06A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PQDGy7D3UGENGBU7ZGUsYuwGX2mJgy2nZaQv8TT5sZcLJqF+3ITUHaLW2kOX7GrdC
	 Jvcw8Hocsh5yrrGW1NdHW3Sd7vXjsWDYjdAScGvNmvF0zdAhAhCREt+XoEwdJIQUi0
	 j+ImCIFd2kicTMAtaK6WccYwghjCzxnJmwgw+nso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgE2Jfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 05:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgE2Jfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 05:35:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160A1C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 02:35:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x13so2746786wrv.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 02:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ToPxSaOoj0DNEZ06UuiZScRcLMvkK2ku9epXRqdczHI=;
        b=a8gGgg0dQUGi16OAaO9qNEgcHC01Ll8qxHYXbEb1MZu+vv226Is+/QbLEN/4WcsHzE
         6EOn7Gzsd0fHLDa10s2jeKVs2bFHksDtPdgWhGbscMb96oWwa8warZ0jvJtuXXfTM8r3
         iwZeRiv8grmmSi/yS4JBQwel4ahoARfLpxS02vx9k3pBL8kPuUxlaw1D7Z0xTwdu7O6W
         YPziys8BQF3inZZTcxX2/XM0BnAuBk7G1GklVGCUwqcPaRQMLXD5ueR4kaUVxGakOIG7
         E6Fy3aG+f4AgieJhiz21nJ6mRHSm/4omoH9XLHBZu6RrFcCS4lbZHr79n+Dg3n9Y0zfg
         bCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ToPxSaOoj0DNEZ06UuiZScRcLMvkK2ku9epXRqdczHI=;
        b=KxyfFm+zsrdSHMwlveRXLsDDAVQTqvMQbqvk9XM5mJWsMF8111LeWkJW/Jjocz0sXG
         BkOoCAt9D/T8o9RMTUCqHdCtHGkA9zv+q2TQyJT2ze0byCdYNjb8iSwZ0MaGZs1WPaH3
         QXxrh6CHqbI/sTgI3d1in1okBl8BYfOvB/QWZ+BD8FRG7ynO7ESQe4SURZh86wsZ8zwK
         rX3jx6mUzyd44jxhjhI8aoVWV+OgEDgi7MzUmj0tuZklVero3rIVJHWhjtX8tPrYkICI
         IP4pL/6anMpJMIplgoA1cWxRgLpZE6CEdFVM+imNEeNjaWG6aA1H+ioQT0qK0+1c9Bsf
         i1hg==
X-Gm-Message-State: AOAM530eOqlF9XYcnw0tSflXVjk4CAWq71q43BpNrTD73T8AYjyFSLLg
        gb0UCZNUDgcC9uGlaCQWitVdFPKC
X-Google-Smtp-Source: ABdhPJwL7zh5EgF2GKPmKCQQAXNyVfF8NKtApb8FVRQtfNF6oqs/MqHOmVLemrjWWprvKIie6c32yQ==
X-Received: by 2002:a5d:6601:: with SMTP id n1mr7485830wru.23.1590744936823;
        Fri, 29 May 2020 02:35:36 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c25sm10333846wmb.44.2020.05.29.02.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 02:35:36 -0700 (PDT)
Date:   Fri, 29 May 2020 11:35:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [git pull] coredump infoleak fix
Message-ID: <20200529093534.GE790247@gmail.com>
References: <20200527213447.GH23230@ZenIV.linux.org.uk>
 <20200528070255.GA790247@gmail.com>
 <20200528070552.GJ23230@ZenIV.linux.org.uk>
 <20200528074442.GB790247@gmail.com>
 <20200528125022.GK23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528125022.GK23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Al Viro <viro@zeniv.linux.org.uk> wrote:

> IOW, copy_xstate_to_kernel()/copy_xstate_to_user() needs not only to map
> from compacted format to standard one; it also needs to compensate for
> that "we might skip saving the components that are in init state; we'll
> report which ones got skipped by way of ->header.xfeatures" thing.
> 
> Again, those leaked uninit chunks are *not* in the same places for all
> threads.  Without any overflows, etc. involved.  And at least for
> the set 0 (x87 registers) the init state is not all-zeroes, so blanket
> memset() done first is not going to give the right results.

I'm not arguing against your fix (at all!) and I'll pull it in for 
v5.8 if Linus doesn't beat me to it.

I was arguing:

  >> shouldn't we also zero-initialize the dump data

with emphasis on the 'also'. :-)

To me the biggest practical fail here was the exposure of genuinely 
uninitialized data - not that the dumped information might not be a 
100% semantically correct FPU dump.

[ Unless I'm missing some non-coredump aspect of all this (such as the 
  wrong saving done in signal handling context for example?), which is 
  always a possibility. ]

Thanks,

	Ingo
