Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02796C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 06:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF4342071A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 06:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtPuXKAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgFMG46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 02:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgFMG45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 02:56:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF48C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 23:56:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l26so9791150wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 23:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OFFZRUuwZyciolFutHUZy+k3hDO5IWFL+Mp7cEZTf1o=;
        b=TtPuXKAeBC4b7WRt8j5QlCvQ7mq3sQssnKqhuC8v1kjpfVTco+fsFkYswB9EdOATuX
         CAQ5eTEC7dTFj4dGzRkx4QX92FcQ0ZmMwQ220MlEnm5nXRwUf+c81iouibty9uX7iwSb
         AbCQ2Helzyo7TWlXliHGkSoX7ihF28qag1IFHomseE8hakNgDCZ9J5UC7O/UDdbN7WoL
         F/iLQGDVivhvyJx1U2pC9TkEvQbdby8dDNiuw6jiuPX7eaoDMfVR2PAE6hkkaVOBHVT9
         2NlNf2m5ByPos85L+6pKsBDYOdx/6fo+sDHHeeq5V9EGuw1pwoWtLAdt13n1wTRsWccC
         Fnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFFZRUuwZyciolFutHUZy+k3hDO5IWFL+Mp7cEZTf1o=;
        b=WZht1fRQlJHhXfCea177RfpWzVuJS0eBQgW2yxVosT4A4iLYqFaEuOXIzOv+HVBEdy
         mLNvWzeGjkkPZ/4p0zfryLdl9thmw3Fm1A6iDPqwFtb/Mw8xYPycxEoRRMLYCMY0/oSo
         PYhTNOqKNB+0LY85h21qPqIexkuZLybkwwIPE5DRe7BcQEVlg4Gd2Pdz4WM7wsHRdTKa
         6X7HVcmKQ9UvTqJrQvSQGz4/SEfMs+0rHDKQnyDW3JUAPNSiYDAwFlvzTol2Lnr9ubVf
         OpdRkBqKvMHrXtnjv2brlCB24+RFqeaHFelMPiekqbim8cetgK4hnV5rYBJGjETFjHlb
         gvjQ==
X-Gm-Message-State: AOAM532Ya0XbPwfue/EYe0ElLhVtBPUwmwOfV0jm6dN6wmVjm05yGPsG
        C3KcKeed6lRY6uujbOuMHy1l4Xmz67xEb2gj1nhjBg==
X-Google-Smtp-Source: ABdhPJyXtTYSMyQ6wXdEQDy9VIp/SQ0LjE3BFblFW22MQ9kE0ZSsESdPTCKrAA1RGJrKDw9Ctu3dijpN+V/HBa0mMrE=
X-Received: by 2002:a1c:a444:: with SMTP id n65mr2429963wme.99.1592031415287;
 Fri, 12 Jun 2020 23:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200611215501.213058-1-vitor@massaru.org>
In-Reply-To: <20200611215501.213058-1-vitor@massaru.org>
From:   David Gow <davidgow@google.com>
Date:   Sat, 13 Jun 2020 14:56:43 +0800
Message-ID: <CABVgOSkMv22GDGin8GCqq4Vd=Bff7-VzEycmzKhUeKj9tErD7Q@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit_test_overflow: add KUnit test of
 check_*_overflow functions
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Kees Cook <keescook@chromium.org>, linux@rasmusvillemoes.dk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 5:55 AM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> This adds the convertion of the runtime tests of check_*_overflow fuctions,
> from `lib/test_overflow.c`to KUnit tests.

Nit: couple of minor typos here: convertion -> conversion, and
functions -> functions

> The log similar to the one seen in dmesg running test_overflow can be
> seen in `test.log`.
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>

I've tested that this builds and runs on my system, and it all seems
to be working fine!

Tested-by: David Gow <davidgow@google.com>

> ---
>  lib/Kconfig.debug         |  17 ++
>  lib/Makefile              |   1 +
>  lib/kunit_overflow_test.c | 590 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 608 insertions(+)
>  create mode 100644 lib/kunit_overflow_test.c

Echoing what Brendan and Kees mentioned, it'd be nicer to have this
replace the existing test, both because there's no need for redundant
tests (one will get out-of-date), and so that we can have a nice diff
showing the changes made as part of the conversion.

Cheers,
-- David
