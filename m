Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6246C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF9C2074C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TzqBcARb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgCMXge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:36:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43211 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCMXge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:36:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id c144so6214338pfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 16:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pd46IjK0yt6XO4QbOjAhJTVOuU89Qv/mYd0OnSTaqqU=;
        b=TzqBcARbIEe1MXAyG/voQg5JT04CeA+MLX+H8A5ZD2w7Po+wO2rZvmgzQg8Y67qBmh
         cCOAvsJZeRtxbT2rPswjcZVrFA8ILE/hnRAeNv5+zWsTy3BvSP6TUzew7Qu8DosKL5Vx
         CG1NQVuV+A6yHtcHoYjquf+mGZc2346Ekt0HPPd6Mi5H3kWFneB8R7H4DgbPnwy1Xob7
         v3vNSN97R1en00gwOA3MKshxyeApuQrAu+0CLoteNVYyPsoQ9VPyjcmxWTmSjkduYAhB
         JGjCCTBWkEuHNOvr9Tgd7CpwU1bc23IHTuc/c+FVm60NAxOfLgbgz/kkcMK/Mkh5bYAC
         m6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pd46IjK0yt6XO4QbOjAhJTVOuU89Qv/mYd0OnSTaqqU=;
        b=nn9Vnmiv7gRgW2c0rmkP7HgrpbmG5UIfoIskysRTz83eCeNcG4jZz6gAayobxLAr4J
         lCjLFwXmV/P5m2ymo+fIcBqDQfMEFSBfLvA0YVtIoXeXa/hnHRITgi29A07WoBapW1cn
         jVV/ftpzF8OFvekeCZCJ84shm/bS08tXPaYP5SFEjJ19GOnflXi2KkAupNmFeSdoLWLX
         6KlcxrziDwL4ANntRnT7VrcRQjDEbarjhleb+zQonwVzVs79m2prJDgrbTZ5AynMc28q
         udutxWq7lcXPw2Plr6CYAXQcLzs9lAaW/cI2mVO9FAIJuySnOartbfpZJCoEwmNVIVJv
         KCvQ==
X-Gm-Message-State: ANhLgQ3CoUvK2fDbSO73QOQQ3xsB77Vn/HlgB5brp73BqE7uLL2EY62d
        m7pe0uxovYPvFgCO6MPFUSWXedeSwPCx5lg0NUwi8Q==
X-Google-Smtp-Source: ADFU+vuPGMOBQ3z8n/rq9B/aDhOBpRIqAjYEM7FF4sWCjC1HFmv002fpapxfNj8+wxSu7fimilu0kTczHUAGvKiGd5c=
X-Received: by 2002:aa7:8283:: with SMTP id s3mr16224344pfm.106.1584142592983;
 Fri, 13 Mar 2020 16:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200228191821.42412-1-davidgow@google.com> <dd15aa59-d2ef-d42e-1a4f-82b42e2ea350@gmail.com>
 <ec2f35ef-54d2-cd67-5e30-33ce7612a6d4@kernel.org>
In-Reply-To: <ec2f35ef-54d2-cd67-5e30-33ce7612a6d4@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 13 Mar 2020 16:36:21 -0700
Message-ID: <CAFd5g46DnKGXNzUe_om+f+kc6efKUP5PFZHwo1VcN6PpWJGicQ@mail.gmail.com>
Subject: Re: [PATCH v4] Documentation: kunit: Make the KUnit documentation
 less UML-specific
To:     shuah <shuah@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Frank Rowand <frank.rowand@sony.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 9:05 AM shuah <shuah@kernel.org> wrote:
>
> On 3/2/20 9:50 AM, Frank Rowand wrote:
> > Hi David,
> >
> > On 2/28/20 1:18 PM, David Gow wrote:
> >> Remove some of the outmoded "Why KUnit" rationale, and move some
> >> UML-specific information to the kunit_tool page. Also update the Getting
> >> Started guide to mention running tests without the kunit_tool wrapper.
> >>
> >> Signed-off-by: David Gow <davidgow@google.com>
> >> Reviewed-by: Frank Rowand <frank.rowand@sony.com>
> >> ---
> >> Sorry: I missed a couple of issues in the last version. They're fixed
> >> here, and I think this should be ready to go.
> >>
> >> Changelog:
> >>
> >> v4:
> >> - Fix typo: s/offsers/offers
> >> - Talk about KUnit tests running on most "architectures" instead of
> >>    "kernel configurations.
> >> v3:
> >> https://lore.kernel.org/linux-kselftest/20200214235723.254228-1-davidgow@google.com/T/#u
> >> - Added a note that KUnit can be used with UML, both with and without
> >>    kunit_tool to replace the section moved to kunit_tool.
> >> v2:
> >> https://lore.kernel.org/linux-kselftest/f99a3d4d-ad65-5fd1-3407-db33f378b1fa@gmail.com/T/
> >> - Reinstated the "Why Kunit?" section, minus the comparison with other
> >>    testing frameworks (covered in the FAQ), and the description of UML.
> >> - Moved the description of UML into to kunit_tool page.
> >> - Tidied up the wording around how KUnit is built and run to make it
> >>    work
> >>    without the UML description.
> >> v1:
> >> https://lore.kernel.org/linux-kselftest/9c703dea-a9e1-94e2-c12d-3cb0a09e75ac@gmail.com/T/
> >> - Initial patch
> >
> > Thanks for all the changes.  The documents are now much more understandable
> > and useful.
> >
>
> Is this ready to go? If it goes through doc tree:
>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
>
> Otherwise, I can pic it up.

Yep, looks good to me.
