Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1892C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F02206F8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sfQnsXjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgCWTZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:25:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37213 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgCWTZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:25:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id x1so2311161plm.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPnPEDtKkbhlSrwIDL6PW6t3VVGfbYBFp7NvAloc0iU=;
        b=sfQnsXjIWtuUaNkNjkq1645xDvzSwYj4KKzzlXQefM/UILQCV8xsyn8oGKF2zm+FDF
         UJ267VnsJnrj2eA0kigh1LjdFqg5jQmKSYVy+SxlFetVDPg+U0hBmpNta81LXfd4fh/0
         UlioblXsm9Ae+2qNcIHbkyqd4XaAkIIy/x1A8DVP4+/H7hOcFHay35yIwziwWNkUEaCM
         3zxTzPuJ2f2CC/TnO0fPBBMFdQONufRWSBUw2o6sOMKYZU6UFLK2REbJ8OrCqjAx2Qqy
         dVeFyaceNkSTn/dMNBsEMjF7msxOR/nzUZqj2GAcup6vxrbcVe6wlLcsLA1kYcadi5Qx
         Gdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPnPEDtKkbhlSrwIDL6PW6t3VVGfbYBFp7NvAloc0iU=;
        b=Bs4lqMRYZOMvNhQfHe9zFbKFaJz3aqTflGv/+xzypa/i+aj64tZ8QQIqbSFhDQm0z9
         fN9X3yv7etkNIIWla0UWQZ8genskafIPVYVgf4IITOaUcoQ0946+ruPQTI0HgvrJH6wY
         XY+YspsaoJIhlxVjtAr6EsbJNmw4XZO6P0ZMyuL7/0hMQTVKIZNPWTv3WyZ0lBSvY26M
         AWLhDOtVUtDQLv9fq4deceh3qHLAEi9jbkWDoXr6yX/hexi9Ra7/BL/Spo4I0alB6K0x
         r9RLwN9wqN8H0NuOgjUa7bqKsxLj1A849BBQO/8GsKes0j9HI2TUb9Gxe+lauIg+/osq
         +xhg==
X-Gm-Message-State: ANhLgQ28tm1DHL5w2mTWzlcGjVv4ld3xj2xaJtoFcA7HG5OKzCNU7FPs
        /edBRRbl3EL14nc1tp43N0XUWOhMJ5cgoIBWcie8AQ==
X-Google-Smtp-Source: ADFU+vtoC47+tQ0c03ehJyLiStK4kkYypznRSFTXRbYuTjHC1n4Sx/iBeZMIroiv6y+aROtKNm0J+zALmkf0dL1qTH0=
X-Received: by 2002:a17:90a:7789:: with SMTP id v9mr202393pjk.29.1584991501748;
 Mon, 23 Mar 2020 12:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200323173653.41305-1-brendanhiggins@google.com>
 <e5f7db19-4468-8679-9ed1-3565a0adcfc0@kernel.org> <CAFd5g46GqBqdrRk6743bnUQyS+yStP3DpkVNWsAMEHDS3i3FBw@mail.gmail.com>
In-Reply-To: <CAFd5g46GqBqdrRk6743bnUQyS+yStP3DpkVNWsAMEHDS3i3FBw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 23 Mar 2020 12:24:50 -0700
Message-ID: <CAFd5g44R6yTQENSsS+LSnQppzO=gDVfPB-TxLn_+aT8UpLiTcQ@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: tool: add missing test data file content
To:     shuah <shuah@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        Heidi Fahim <heidifahim@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 12:15 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Mon, Mar 23, 2020 at 11:44 AM shuah <shuah@kernel.org> wrote:
> >
> > On 3/23/20 11:36 AM, Brendan Higgins wrote:
> > > A test data file for one of the kunit_tool unit tests was missing; add
> > > it in so that unit tests can run properly.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > ---
> > > Shuah, this is a fix for a broken test. Can you apply this for 5.7?
> >
> > Can you please add more details on what kind of data this file supplies
> > and which test fails if it doesn't exist.
>
> Sure,
>
> This adds a raw dmesg test log to test the kunit_tool's dmesg parser.
> test_prefix_poundsign and test_output_with_prefix_isolated_correctly
> fail without this test log.
>
> I will send a new revision with this information in the commit message.

I just sent a new revision with an updated message.
