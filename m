Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF163C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 02:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B72620409
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 02:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pygvSvd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgCXC4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 22:56:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36070 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgCXC4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 22:56:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id g62so1915876wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 19:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0+7iyULVUw6dbuIVInQO+4nPeWfn4xVz7ibloxImNQ=;
        b=pygvSvd+eSrvDdmSvX8FjMjj6JJjC9drPpobUWysZJHmY2+uVcZ/CK1j3o67YZSFev
         7rH2WjQYGKxuNOjOFg+MHVI1bcoY5f0hf6x2eHxK5zhTR4Opqgl4TJ4lHni0I/AE0Yhg
         t5QlwixxmXc68bdC1BDiwlnLNRKc4fPy/CexA1KMFW/JPN1/EWVb1MD55t6360/gh0Tr
         WvmGSqyc86YOZeRUPbn5LNVcMXD6H2cZc3+WNrK8It/KS/Fvkhi1g5e6Cs1LVFqrfZEi
         ce7M60lZ9CwU7UmHn0ok9azJpMCYwYBxhO+KCVpn63hS0jP/NswzeGUTC+OU6wiUAu3l
         5qOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0+7iyULVUw6dbuIVInQO+4nPeWfn4xVz7ibloxImNQ=;
        b=RdRwLm9z3Et+pPBs/9aiBGiq+LIeC8QG2vCnh03I5xgqtdKE/ZX0PPep5RoIloOlPx
         faHlw0B2eH77Qa48yTlrMS1S92UxOfrSsXgkL13jvxQ+o7XHioqWhBBTHid/WHClJZ6l
         7mxmHXt4OEMpUrp0AhYDvxVDR5ZwXhh1zVaUhxjYTb9i3HHvm94wdckvzE3gZqElmZtH
         9rQ7M1UgiZc8QGDFxIpZ+XMvqof6nWERCxVgevx3ltzAY89MGbIQK/1BNBeLQfckRMQW
         7VekB0rXxIACh6GMlyBlvOuu8WfioCXE+FX6VMscKL6bDLBRtdWTrnBa0Z8tVT8w9iW9
         ZVLQ==
X-Gm-Message-State: ANhLgQ3/RLc0W3Q8XEK4n6Iap9xjPRpPdKsWPDV/DBQvzO3eLHGCasPe
        sZyaEKuXNVzNH5282S0JNL9UBahGRQFZ4Qmrur1BLw==
X-Google-Smtp-Source: ADFU+vtDDkbuzT5Gw8bD3VQH7XBa3+hEnpPF8q/9mh4Mk8cuXyVL3lDQtyD9qM5xo1O9D4wQLY3hbJhIkJv3u9c9FXE=
X-Received: by 2002:a1c:2404:: with SMTP id k4mr2634050wmk.87.1585018574854;
 Mon, 23 Mar 2020 19:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200323192236.70152-1-brendanhiggins@google.com>
In-Reply-To: <20200323192236.70152-1-brendanhiggins@google.com>
From:   David Gow <davidgow@google.com>
Date:   Mon, 23 Mar 2020 19:56:03 -0700
Message-ID: <CABVgOSkf58zMRhpqoZY3cZuAfujnTwVe14xOMcS6VBC4S2+vEw@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: add missing test data file content
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, Heidi Fahim <heidifahim@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 12:22 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Add a missing raw dmesg test log to test the kunit_tool's dmesg parser.
> test_prefix_poundsign and test_output_with_prefix_isolated_correctly
> fail without this test log.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Tested-by: David Gow <davidgow@google.com>

This patch does indeed fix the kunit_tool's unit tests (run with
./tools/testing/kunit/kunit_tool_test.py).

Beforehand, it failed with the errors below:
======================================================================
ERROR: test_prefix_poundsign (__main__.KUnitParserTest)
----------------------------------------------------------------------
Traceback (most recent call last):
 File "./tools/testing/kunit/kunit_tool_test.py", line 208, in
test_prefix_poundsign
   self.assertEqual('kunit-resource-test', result.suites[0].name)
IndexError: list index out of range

======================================================================
FAIL: test_output_with_prefix_isolated_correctly
(__main__.KUnitParserTest)
----------------------------------------------------------------------
Traceback (most recent call last):
 File "./tools/testing/kunit/kunit_tool_test.py", line 116, in
test_output_with_prefix_isolated_correctly
   self.assertContains('TAP version 14\n', result)
 File "./tools/testing/kunit/kunit_tool_test.py", line 96, in
assertContains
   str(needle) + '" not found in "' + str(haystack) + '"!')
AssertionError: "TAP version 14
" not found in "<generator object isolate_kunit_output at 0x7f4e88d85ed0>"!

----------------------------------------------------------------------
Ran 20 tests in 0.022s

FAILED (failures=1, errors=1)
