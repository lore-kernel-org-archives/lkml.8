Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77D4C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790CE246A5
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ES/p+9CI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbgB1Agi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:36:38 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:36445 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbgB1Agh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:36:37 -0500
Received: by mail-pl1-f182.google.com with SMTP id a6so508660plm.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ecjs5n8zwN/9MsVfX6exqhP2XFiFuVu/JHGa+4oDJtc=;
        b=ES/p+9CII3zuPnEnjew7hIvK058/D5Rzlh3DNVA0W7HBD9ZoaCbcFvP9g95cwWv6Bd
         8QxT+AIkangkqK5XZwAJXNpUQ8mI84c0lrhZeadwaazQkTc6PKHt4XBUJ0LdDdcDvQDT
         2mcFoK7LyDN2R4uy/yj4vnU9TkBwapAEVDs4JFAoPuU+1LYWpNMr2xmfxhzz8zD/FgMc
         VtNjb5P2kOk4VDl2mP2/OXxGpEugB+8aSLWssJocVpT9p2xhmmTR/vgAe7i2B8BFobow
         LQ5GWz9trKkAHbyT0H8DJGOEH8OzaYYagd0N/aHFHKCy85+mBQEI7e1ynMtywIKwshSU
         JRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ecjs5n8zwN/9MsVfX6exqhP2XFiFuVu/JHGa+4oDJtc=;
        b=ZxxhLe++Jaao3lyN4hejqiLLJ2jVdNZXOiF3DAHiQQe1c8lxDoN9T3HAbhrudQdP+Q
         3GszCWpX5Ur0ho3gErAt0IZP9xlDGHxEYGF2xajCVNNCXnZ3ojgiOEkeplKdnRQjau3l
         N+6ts6KSlkMZuqcWSs2OtRLgIN1Yvvw4yj3m/81xhvD74WCtfS5wugFvewmp9kEI24Yb
         Ob5tJ1ZQxD+lAtZ+hNXg60elFNineQ9kqMZB763tsirk/Cpal8fKaxGkrriqz+yjjZe+
         txg3+I1dXEsj/BBWmdejluux2wVfBJNdC3AhsvKVkHmdnjqjdV4mlgk21G6/8y/ZTIz7
         DRvA==
X-Gm-Message-State: APjAAAWcVCn1XXQTcAfoBd4/x8RIl1UK2KTiqxM4OijPhJpNFcJj/24S
        mPh69pH3zWnuZztJNsljzmAFCKIAV7kSal0dnsatyw==
X-Google-Smtp-Source: APXvYqzydJIXOtxTzekybI/ez2R/Ic2Dsh7bais/fao6j35qpckyCLsm/Za0Xaa6ECQoolTjS+XZA+G/7J7o8rH26E4=
X-Received: by 2002:a17:90a:6c26:: with SMTP id x35mr1629902pjj.84.1582850195008;
 Thu, 27 Feb 2020 16:36:35 -0800 (PST)
MIME-Version: 1.0
References: <20200225201130.211124-1-heidifahim@google.com>
 <20200225222221.GA144971@google.com> <CAMVcs3sUtx17C0SeE435Q5aehE_F2RkoQxJWzeJK5v47GgFjBg@mail.gmail.com>
In-Reply-To: <CAMVcs3sUtx17C0SeE435Q5aehE_F2RkoQxJWzeJK5v47GgFjBg@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 27 Feb 2020 16:36:22 -0800
Message-ID: <CAFd5g44ZMYigCbg4u7_Bfhgqt-hPJRbumoHNf3Buz50fkm_Y7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: kunit_parser: making parser more robust
To:     Heidi Fahim <heidifahim@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 4:09 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> > >
> > > -TAP_ENTRIES = re.compile(r'^(TAP|\t?ok|\t?not ok|\t?[0-9]+\.\.[0-9]+|\t?#).*$')
> > > +TAP_ENTRIES = re.compile(r'(TAP|\t?ok|\t?not ok|\t?[0-9]+\.\.[0-9]+|\t# .*?:.*?).*$')
> >
> > Since you now strip off prefixes using length, does the old TAP regex no
> > longer work?
> >
>
> Using old regex (i.e. match instead of search) still works - do you
> prefer this be reverted where possible or be changed to search? Search
> is a little more relaxed when it comes to alignment of the TAP output
> (i.e. some lines could have extra leading whitespaces), but right now
> is not necessary.

I would prefer keeping the old regexes. It makes the change smaller. I
also would prefer to not relax the alignment if we don't need to.

> > >  def consume_non_diagnositic(lines: List[str]) -> None:
> > > -     while lines and not TAP_ENTRIES.match(lines[0]):
> > > +     while lines and not TAP_ENTRIES.search(lines[0]):
> > >               lines.pop(0)
> > >
> > >  def save_non_diagnositic(lines: List[str], test_case: TestCase) -> None:
> > > -     while lines and not TAP_ENTRIES.match(lines[0]):
> > > +     while lines and not TAP_ENTRIES.search(lines[0]):
> > >               test_case.log.append(lines[0])
> > >               lines.pop(0)
> > >
> > >  OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])

[...]

> > > @@ -234,11 +234,11 @@ def parse_test_suite(lines: List[str]) -> TestSuite:
> > >       expected_test_case_num = parse_subtest_plan(lines)
> > >       if not expected_test_case_num:
> > >               return None
> > > -     test_case = parse_test_case(lines, expected_test_case_num > 0)
> > > -     expected_test_case_num -= 1
> > > -     while test_case:
> > > +     while expected_test_case_num > 0:
> > > +             test_case = parse_test_case(lines)
> > > +             if not test_case:
> > > +                     break
> > >               test_suite.cases.append(test_case)
> > > -             test_case = parse_test_case(lines, expected_test_case_num > 0)
> > >               expected_test_case_num -= 1
> >
> > Do we use this variable anymore?
>
> Yes, this decides whether we are expecting another test case or if
> we've completed the test suite

Ah gotcha. Sorry, I am not sure how I missed that.

> > >       if parse_ok_not_ok_test_suite(lines, test_suite):
> > >               test_suite.status = bubble_up_test_case_errors(test_suite)
> > > @@ -250,7 +250,7 @@ def parse_test_suite(lines: List[str]) -> TestSuite:
> > >               print('failed to parse end of suite' + lines[0])
> > >               return None
> > >
> > > -TAP_HEADER = re.compile(r'^TAP version 14$')
> > > +TAP_HEADER = re.compile(r'TAP version 14$')
> > >
> > >  def parse_tap_header(lines: List[str]) -> bool:
> > >       consume_non_diagnositic(lines)

Cheers!
