Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663AAC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 01:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317E820716
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 01:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599183540;
	bh=e3vi9pOZxLBWDH9YDqClNEAwwwNSsng8M6fZbprTZOs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0lD0IsxDq/tfxuKIJoW3B6rILy+FnJS2qkAVR/3XoDI6eyyffqE65FSBfrWDHCcfN
	 a75rOaW1A3pGuUfx7HQXgpXm0JemohXSkc+t3ZW0vwosBkVvtDGNy+zveCLkR8erZM
	 OqqFSX7QUcSNqHj0/WvsDC9r2NEnSwGeE8E6wQiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgIDBit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 21:38:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34024 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgIDBis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 21:38:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id t10so5141385wrv.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 18:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1hXmxaa9eDQu/xGt+lQGpkM5jO075CAO1twSKZMMa+g=;
        b=AAcXNe+NtfI0eMasmd2zMVbbt5d4t9ZwyJwcmFbkVS9LCnqMbZIXkeBfzDQ/srZVpC
         Ld6fBabeyHoRGO2EGPzQCFVqASVjl4zbG6FPtqfUANdF7XWhnUgVT7mMFzd6baPapv6z
         Z70vSm9Rv4ofidpVgnp5PmJ3PP3XGZ7jToU3JroH0H13LPb38U2+wTdhhXCDu+di5lVm
         mYr2pQE7WmhbOSVhtZvW7aFegYa4Fa9TIJrueU7r7xvlTHYlQ8ZUufFPps9TN65G+gE9
         IOsf0cO24bbOc5y+EWCAyURQZP6h6Rm3qoitBWSXW/v1xsHEb7BIJfE1u8Iiu/vXWJlO
         FiSw==
X-Gm-Message-State: AOAM530jksYzSc4d3eFwQI2MHPn0nxmqLveBgFhob1WK3pPiGRAyIhsp
        WWxxmjoOFXtK1kvh/RRxl14+YUrWftXpF5TQ122PttymfPc=
X-Google-Smtp-Source: ABdhPJxe1rXybgNse316SIx5wi/yvon0K+0qHsws9djrXYFGWI/dKmnj41JAKOKQGraoa+GFLjnpyGStqc+HNhaaIQk=
X-Received: by 2002:adf:e481:: with SMTP id i1mr4951064wrm.391.1599183526201;
 Thu, 03 Sep 2020 18:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200903152510.489233-1-namhyung@kernel.org> <CAP-5=fULG7CbwB0vOBkStsRV5j7=XX_F0x+fzK7KHyqp-9Y0_g@mail.gmail.com>
 <20200903184123.GB3495158@kernel.org>
In-Reply-To: <20200903184123.GB3495158@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 4 Sep 2020 10:38:35 +0900
Message-ID: <CAM9d7cg+aGuPPMp7-QjmgN5GGK+D9su2GCNRT__wPZvw4vp+HA@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Fix suspicious code in fixregex()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        William Cohen <wcohen@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo and Ian,

On Fri, Sep 4, 2020 at 3:41 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Thu, Sep 03, 2020 at 10:47:39AM -0700, Ian Rogers escreveu:
> > On Thu, Sep 3, 2020 at 8:25 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > The new string should have enough space for the original string and
> > > the back slashes IMHO.
>
> > > Cc: John Garry <john.garry@huawei.com>
> > > Cc: Kajol Jain <kjain@linux.ibm.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > Definitely looks like the right fix. I'm surprised this hasn't shown
> > up in sanitizer testing.

I guess the code didn't run on most arch (including x86) since
they don't have backslashes.

>
> Yeap, good catch! Namyung you forgot to add the Fixes tag + Cc the patch
> author that introduced that bug, I did it:
>
> Cc: William Cohen <wcohen@redhat.com>
> Fixes: fbc2844e84038ce3 ("perf vendor events: Use more flexible pattern matching for CPU identification for mapfile.csv"
>
> Please consider doing it next time :-)

Oh, right!  Will do it later..

Thanks
Namhyung
