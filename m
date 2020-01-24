Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FFAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 23:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586032072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 23:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JFwEgiMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgAXXNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 18:13:42 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41390 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbgAXXNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 18:13:42 -0500
Received: by mail-wr1-f44.google.com with SMTP id c9so3967421wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 15:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWxAa5bHJ6PMK9NxJf+sotV/H1bquBNTcrRDY2YcrUw=;
        b=JFwEgiMlTVLpCCLAcgaTLVUSaehg81QYgNPM3b1Ym2b5z/nL3KqJQF88KbVz9cdk9r
         CTzjE5+aAMbtk7ELcq2bgO9K+zAzqamtgzbJUMhCE2UtMUId4YJmmt8mZWGNI/msC6uq
         Ib2YT51CLEO/CBYA44ZPxKkuKAAj6vBBknHK61TX41z50xOOv718Q16vwHsm9sWXlCtL
         Wyur4nSjXjUJVz9SkntFxcVa3uFr0o7zR5qlVSxRfX4/BM8/LGrXcy5sKU76ruA40fB6
         +iMCJl1NxAIJAt+H+0XVBK1FOWDcMk82vh+AGN1kASIytgA9VaVBpwknfn4st2dVzmG9
         UfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWxAa5bHJ6PMK9NxJf+sotV/H1bquBNTcrRDY2YcrUw=;
        b=c/T/HOy9KEQ5Gj+2gtqwIA9OHLicrjLjOaMrj5PT1aaVGf/l1GecdwDPfDkTMcgH/9
         xsMnd1D61Z/RiA4k0lW92RMuP49o9joe0YEDrDqgDedRiti0CR0PPZJVrfUAEwwsPuF0
         Ur1WsvAv6hetXVHUz7mXUf/7YCZWFcE+ASKCfoeIAgypfrOf5T6duZwKKfkd8i/kcMTR
         a2jDdV6UPiiunk4PUH6jDZzvQK9GVdPgG/o7Kmc7T3f4dNWYa8Uk/9Wn0z1ZuO8fFh57
         ls3BGFXM2yJ1hjxpG6imyiHOhBwtxy0EKxKM3eqIQvyP88E9ia63xA7wSZJ3OxiBsE2U
         JETg==
X-Gm-Message-State: APjAAAVBdFP1PGTTi4VBWb8ltHkf2SQ0OPT1S0VqDx1rBTQwQoqOutWP
        OQvUh1ztvWFQqAvz8RlzImFmninQSXztIiciTN6y+w==
X-Google-Smtp-Source: APXvYqxN872w0DTvxW+Wn3EovolGmqBFSzUcrBBwdJKbLKF5OkwRRiPnROfW46WxRCPlK/8cwRgFRMGQxMTCJGencF4=
X-Received: by 2002:a5d:6344:: with SMTP id b4mr6722428wrw.414.1579907619941;
 Fri, 24 Jan 2020 15:13:39 -0800 (PST)
MIME-Version: 1.0
References: <20200124194507.34121-1-davidgow@google.com> <CAFd5g46Jym_HX+QmX8ffVYfL1KATNjs9U6sR1Qv9SoVLx5GKDg@mail.gmail.com>
In-Reply-To: <CAFd5g46Jym_HX+QmX8ffVYfL1KATNjs9U6sR1Qv9SoVLx5GKDg@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 24 Jan 2020 15:13:28 -0800
Message-ID: <CABVgOSnVLyOAYMi2eFaOXtm96SdmrO8hmJ4f2gKbDJ7wS_8d5w@mail.gmail.com>
Subject: Re: [PATCH] Fix linked-list KUnit test when run multiple times
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah <shuah@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 2:01 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
> Oh good, I am glad we are getting rid of those static variables. (I
> thought we already dropped those - whoops.) I think this drops this
> last of them, can you confirm David?

Yeah, this is the last of them.

I vaguely recall a suggestion that it may be worth testing that the
LIST_HEAD() macro works with static, but as mentioned in the
description, the for_each_entry_* tests probably aren't the best place
to do that anyway...

-- David
