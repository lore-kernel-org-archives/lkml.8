Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084E1C35242
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 00:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14332072C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 00:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wS2WUDV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgAYACn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 19:02:43 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:37949 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbgAYACm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 19:02:42 -0500
Received: by mail-pl1-f179.google.com with SMTP id t6so1432908plj.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 16:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ynnd2SGOMXK9FL1OzGl6AxrSQz4LtuhsqKDnn7ScKAo=;
        b=wS2WUDV/7szOKx4WVC47xljWaVANkCKfZcuv4uHhbjYz8UVMGzJv/WtL/ZUOKDQdBT
         eYKLwXmid6jl1YRudXdCBMuqnvIseNtqbAjpFg1AAUB32FlW/sheZ1UyRwpm2Ae32/N0
         REx3X4Shn79Y4OBsMWBOIC6Ci9/Zwn9BYqS1hkbN86VMoVePiyaNzCteKN1JK0MWbm7u
         WkXiyWWM0y4updTQjFCJv2PU0aqyfDUWFH3MScocS5IBubO89Gzjl7AlpVBYiSN+qJyL
         8V87+5EtGpLiSJuC9XOx18ttmdsqMY/at42xiNqJ04q7X9QND3wLHDohtF8JFIZ1jQcK
         kvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ynnd2SGOMXK9FL1OzGl6AxrSQz4LtuhsqKDnn7ScKAo=;
        b=XVdw96F8+oprcllgiURDYVA62pWLwTsyh/UilAKks8nr3QJaDYwCYrhZkk8gHkfqNO
         3ijfR/oNSUYU97B0X/dEHMc2VnWoeXmPvRmw4Rvierbcv2HQ/r/JPuitnjChrCe0ZrRD
         pZwJxtJFf0ev8NrkhxyupK01CETX3A2BJsM0a9T0OWJFG4I4AxHxkqoMJqSmEDWr8Lum
         5u9Ywe3fSY/bhbDJt75MJoNAkPsCmMcrW2ZwpveGylKlYeSPbctdCfV9eCn6TkPSXYPA
         GvvVaBlKb/FXGthOBgRcQAj3fyQ8kmrRA/Xwx/lsSDdZMLywMro23ipjmTsIvWL0ANVU
         HoMA==
X-Gm-Message-State: APjAAAXT3PfMGzuysesGGrP/utsVxcp6yXQ9svlUwYVsQ/oa6KRgG4Nu
        9oNxLD7AE7KNA8dZdY3QiSwVBlfn8zlU5Tyu4pW1JQ==
X-Google-Smtp-Source: APXvYqyXmULqKveIYsTuaC/0YteujlFex6MeZFhH/+/P6TgnbeZ8qAKVrqmlm1erknjpKVF2xDqMtmfOVWrRbPLVHiU=
X-Received: by 2002:a17:90a:c390:: with SMTP id h16mr2010910pjt.131.1579910561819;
 Fri, 24 Jan 2020 16:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20200124194507.34121-1-davidgow@google.com> <CAFd5g46Jym_HX+QmX8ffVYfL1KATNjs9U6sR1Qv9SoVLx5GKDg@mail.gmail.com>
 <CABVgOSnVLyOAYMi2eFaOXtm96SdmrO8hmJ4f2gKbDJ7wS_8d5w@mail.gmail.com>
In-Reply-To: <CABVgOSnVLyOAYMi2eFaOXtm96SdmrO8hmJ4f2gKbDJ7wS_8d5w@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 24 Jan 2020 16:02:30 -0800
Message-ID: <CAFd5g45x3A2SdbUtZfGRGmpdEoe0BYsofRogyCXigR+xT_Jy=w@mail.gmail.com>
Subject: Re: [PATCH] Fix linked-list KUnit test when run multiple times
To:     David Gow <davidgow@google.com>
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

On Fri, Jan 24, 2020 at 3:13 PM David Gow <davidgow@google.com> wrote:
>
> On Fri, Jan 24, 2020 at 2:01 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> > Oh good, I am glad we are getting rid of those static variables. (I
> > thought we already dropped those - whoops.) I think this drops this
> > last of them, can you confirm David?
>
> Yeah, this is the last of them.
>
> I vaguely recall a suggestion that it may be worth testing that the
> LIST_HEAD() macro works with static, but as mentioned in the
> description, the for_each_entry_* tests probably aren't the best place
> to do that anyway...

Ah, I think I missed that. Makes sense.
