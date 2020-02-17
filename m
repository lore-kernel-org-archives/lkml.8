Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45551C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1FF22B48
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="drLOmyEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgBQPoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:44:24 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45051 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbgBQPoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:44:23 -0500
Received: by mail-pf1-f195.google.com with SMTP id y5so9077697pfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 07:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TJXDZSCq2C/hzS0+s/A5abIsTN6ZxXYpE+Pc/HXSqLk=;
        b=drLOmyEZ4On7Q0EGZ6WeMzgYMsbPPXEW0fs1U8SREyy45mFunqI9xcCxFAvSFkd/5P
         KlsS59REzQvT0qK/lWsmxh15FuH5z0EzabavpU5gDo61b9KOoHv2HJMjSIknIIwqLmK3
         tMEnXMXUcGbnwVY2V2tlk9SYAskk6wRrXBO11z7lc6qhbOe4d/UrTTNTzw0XKmmldUNp
         YQor96RvSt2btWB7uCE3S8kvTstl0ZQPKLv74zRdcon0DNXdPIUjJaj4++eFAEd2HvzQ
         Ri1vZ5LZb4xIWXjuWIw1hir3pMq/ao3o37afR5rJ9pwZ5w3FuItdYRWjRRlCHQhTGStn
         GnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TJXDZSCq2C/hzS0+s/A5abIsTN6ZxXYpE+Pc/HXSqLk=;
        b=ZIZvu0pLVoJ57I7YjxuusoOW6CsTgfdTbHhP0MLUrEaWDmo7eJKqjNeSPNgXDdT/VX
         SsGmYdzVhGT4Ky6UBL/Wi6JWY7H5gc7XTKd7Zv5hAmS85xQrkD3HkSrQ51tKa6Sud2T4
         bECcGZfFVMUUZRH5TF67+onMeVXnScBctuGNeto3vACpDlh8p0//lipTihW5GGM6g6zH
         7vd4xNsyMa3ECjHav6o82LuVw43IXkahzd+HPE2iQ38IAtxcyTDCaImQBUB8eE/9kn/I
         xBxk75+4kgtQILvj2C/hpQRImvldojq9MMmV+v+ND8tr8P8dSbXQo/WtI18Mu3JKZlre
         ts5g==
X-Gm-Message-State: APjAAAUIqNX84GwvPCQ/+M4onaqxDzn8lW4euT0SjBSu0pZzaJH+xNtu
        YkOinIU0rGeM3IUoQO77K8w/BQ==
X-Google-Smtp-Source: APXvYqxKKpZ5Wald3xIFqMGCzo3CdKzSugQnZ88lDLONA9k2+lVLBsaPE438KLhQsNycxQOCwVxdLg==
X-Received: by 2002:aa7:8582:: with SMTP id w2mr16351595pfn.89.1581954261663;
        Mon, 17 Feb 2020 07:44:21 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id b133sm1314225pga.43.2020.02.17.07.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Feb 2020 07:44:21 -0800 (PST)
Date:   Mon, 17 Feb 2020 23:44:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v4 0/5] perf cs-etm: Fix synthesizing instruction samples
Message-ID: <20200217154402.GA20241@leoy-ThinkPad-X240s>
References: <20200213094204.2568-1-leo.yan@linaro.org>
 <20200215032259.GA21048@leoy-ThinkPad-X240s>
 <CANLsYkyw__tnn5FC=ro-LuaOibP19UhGvPPndjvJDodxcj6Ukg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkyw__tnn5FC=ro-LuaOibP19UhGvPPndjvJDodxcj6Ukg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Mon, Feb 17, 2020 at 08:30:37AM -0700, Mathieu Poirier wrote:
> On Fri, 14 Feb 2020 at 20:23, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > On Thu, Feb 13, 2020 at 05:41:59PM +0800, Leo Yan wrote:
> > > This patch series is to address issues for synthesizing instruction
> > > samples, especially when the instruction sample period is small enough,
> > > the current logic cannot synthesize multiple instruction samples within
> > > one instruction range packet.
> >
> > Thanks a lot for Mike's review.
> >
> > Hi Mathieu/Suzuki, I'd like get your green light before we can ask
> > Arnaldo to help merge this patch set.  Thanks!
> 
> At the very least, please wait 10 days before pinging maintainers
> about patch reviews.  I have never failed to review coresight patches
> and this time is no different.

Understand and sorry for hurry pushing.  Take your time for reviewing
and no rush :)

Thanks,
Leo
