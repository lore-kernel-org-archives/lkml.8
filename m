Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D1DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959F6246A6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXutoS/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgB1AJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:09:39 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:34804 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbgB1AJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:09:39 -0500
Received: by mail-qk1-f172.google.com with SMTP id 11so1403764qkd.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVD12z7+HGBJ25hvAL2ZOLK0dszXMUkehAgzAwaZMJs=;
        b=cXutoS/O22DmUNAx0wBz5bZRKXrQW1RgDZfbwIMFcsRqCPnclyD3xtyJGyKHhgwfGD
         0RK/iSQCVoJg9xufBzrPCbImzGhEcozwjkSEpVS+k4sc082pwdeU47+oPYhg8GW0KR+d
         T6anl3rmC8IoDy+X7fb141P5hMArecIW2oV/iScwT3xvivaPoHYzl1U55b7/LUIgsOni
         FLv6BJsJGd/O7c1Eb4KzTo3cSGW37eYPfyv2W0e47Hs1CqbHUDR1Bgu1ifz2popmhvmm
         MdwFFLqybiAlmbGPZ0B/ECKRxOxlmgUXk44fN4aMa0rFgME2+y3m4z4SUIvX4bmnlFLv
         /6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVD12z7+HGBJ25hvAL2ZOLK0dszXMUkehAgzAwaZMJs=;
        b=re/kLjQHDbQ5xG4BfV12ltyqLHlXqy6XuWLEX8KXn+xw39RwXryCmnHAo46dqkFlIG
         OsfKtu4VW/Cn5MqlZ1u6RHSjHHudSswIpt7vNks8yVSF7Rsq8npj/lryGdbDw9P7YJjg
         XuUXh8Cg4FYsMXMmRrE2nVojlC1MDGE3tf/pYoVnydUYAKjWCgoPSRjeG0kpYo1Ai09m
         D/h3KzWGqRseCTKmbZPA8ZIxHX6ZxkTPQP27YYwkeHQ52+Uc17ajarCgzJU3AxwYlBp+
         wWFPFB/UFS3iv9yXhUJBORO1AhHttc9LULG+2j6CKfzJbVkyW+7aJUrjsfP3SnbFdvCB
         4qoA==
X-Gm-Message-State: APjAAAWw/h0cvU2yb+KgPX/ZWcyp4lx/X9WwjhUpyFA+7L4hjBgyaIvU
        ylHiecEC12EgXvdlOGxvBOZBDFxrfwYrCAqClw6p7Q==
X-Google-Smtp-Source: APXvYqzTaacBAN5Ah5aNIUgLbjZRHMy8gLlGajSzCoFnld/bi8DzEAZRRHmJu6tkZOJWicpUgdob0q8aoHeeKzK3dks=
X-Received: by 2002:a37:a4d2:: with SMTP id n201mr2120116qke.479.1582848577901;
 Thu, 27 Feb 2020 16:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20200225201130.211124-1-heidifahim@google.com> <20200225222221.GA144971@google.com>
In-Reply-To: <20200225222221.GA144971@google.com>
From:   Heidi Fahim <heidifahim@google.com>
Date:   Thu, 27 Feb 2020 16:09:26 -0800
Message-ID: <CAMVcs3sUtx17C0SeE435Q5aehE_F2RkoQxJWzeJK5v47GgFjBg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: kunit_parser: making parser more robust
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > -TAP_ENTRIES = re.compile(r'^(TAP|\t?ok|\t?not ok|\t?[0-9]+\.\.[0-9]+|\t?#).*$')
> > +TAP_ENTRIES = re.compile(r'(TAP|\t?ok|\t?not ok|\t?[0-9]+\.\.[0-9]+|\t# .*?:.*?).*$')
>
> Since you now strip off prefixes using length, does the old TAP regex no
> longer work?
>

Using old regex (i.e. match instead of search) still works - do you
prefer this be reverted where possible or be changed to search? Search
is a little more relaxed when it comes to alignment of the TAP output
(i.e. some lines could have extra leading whitespaces), but right now
is not necessary.

> >  def consume_non_diagnositic(lines: List[str]) -> None:
> > -     while lines and not TAP_ENTRIES.match(lines[0]):
> > +     while lines and not TAP_ENTRIES.search(lines[0]):
> >               lines.pop(0)
> >
> >  def save_non_diagnositic(lines: List[str], test_case: TestCase) -> None:
> > -     while lines and not TAP_ENTRIES.match(lines[0]):
> > +     while lines and not TAP_ENTRIES.search(lines[0]):
> >               test_case.log.append(lines[0])
> >               lines.pop(0)
> >
> >  OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
> >
> > -OK_NOT_OK_SUBTEST = re.compile(r'^\t(ok|not ok) [0-9]+ - (.*)$')
> > +OK_NOT_OK_SUBTEST = re.compile(r'\t(ok|not ok) [0-9]+ - (.*)$')
> >
> > -OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) [0-9]+ - (.*)$')
> > +OK_NOT_OK_MODULE = re.compile(r'(ok|not ok) [0-9]+ - (.*)$')
>
> Same here.
>
> > -def parse_ok_not_ok_test_case(lines: List[str],
> > -                           test_case: TestCase,
> > -                           expecting_test_case: bool) -> bool:
> > +def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
> >       save_non_diagnositic(lines, test_case)
> >       if not lines:
> > -             if expecting_test_case:
> > -                     test_case.status = TestStatus.TEST_CRASHED
> > -                     return True
> > -             else:
> > -                     return False
> > +             test_case.status = TestStatus.TEST_CRASHED
> > +             return True
> >       line = lines[0]
> >       match = OK_NOT_OK_SUBTEST.match(line)
> > +     while not match and lines:
> > +             line = lines.pop(0)
> > +             match = OK_NOT_OK_SUBTEST.match(line)
> >       if match:
> >               test_case.log.append(lines.pop(0))
> >               test_case.name = match.group(2)
> > @@ -150,12 +150,12 @@ def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
> >       else:
> >               return False
> >
> > -def parse_test_case(lines: List[str], expecting_test_case: bool) -> TestCase:
> > +def parse_test_case(lines: List[str]) -> TestCase:
> >       test_case = TestCase()
> >       save_non_diagnositic(lines, test_case)
> >       while parse_diagnostic(lines, test_case):
> >               pass
> > -     if parse_ok_not_ok_test_case(lines, test_case, expecting_test_case):
> > +     if parse_ok_not_ok_test_case(lines, test_case):
> >               return test_case
> >       else:
> >               return None
> > @@ -202,7 +202,7 @@ def parse_ok_not_ok_test_suite(lines: List[str], test_suite: TestSuite) -> bool:
> >               test_suite.status = TestStatus.TEST_CRASHED
> >               return False
> >       line = lines[0]
> > -     match = OK_NOT_OK_MODULE.match(line)
> > +     match = OK_NOT_OK_MODULE.search(line)
> >       if match:
> >               lines.pop(0)
> >               if match.group(1) == 'ok':
> > @@ -234,11 +234,11 @@ def parse_test_suite(lines: List[str]) -> TestSuite:
> >       expected_test_case_num = parse_subtest_plan(lines)
> >       if not expected_test_case_num:
> >               return None
> > -     test_case = parse_test_case(lines, expected_test_case_num > 0)
> > -     expected_test_case_num -= 1
> > -     while test_case:
> > +     while expected_test_case_num > 0:
> > +             test_case = parse_test_case(lines)
> > +             if not test_case:
> > +                     break
> >               test_suite.cases.append(test_case)
> > -             test_case = parse_test_case(lines, expected_test_case_num > 0)
> >               expected_test_case_num -= 1
>
> Do we use this variable anymore?

Yes, this decides whether we are expecting another test case or if
we've completed the test suite
>
> >       if parse_ok_not_ok_test_suite(lines, test_suite):
> >               test_suite.status = bubble_up_test_case_errors(test_suite)
> > @@ -250,7 +250,7 @@ def parse_test_suite(lines: List[str]) -> TestSuite:
> >               print('failed to parse end of suite' + lines[0])
> >               return None
> >
> > -TAP_HEADER = re.compile(r'^TAP version 14$')
> > +TAP_HEADER = re.compile(r'TAP version 14$')
> >
> >  def parse_tap_header(lines: List[str]) -> bool:
> >       consume_non_diagnositic(lines)
>
> Cheers
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20200225222221.GA144971%40google.com.
