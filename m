Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F93C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A881120890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kDfdoao3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgFRT7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728960AbgFRT7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:59:52 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D5AC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 12:59:51 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u8so3024337pje.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 12:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U3QGsT97pDvvMvvKXcBgwyDJ7+zbhoAH55hk1yJyQBg=;
        b=kDfdoao3jkV76yu/0HQcS3EdiHt3zKaFYqcTf17EemKjFtUc8coz/vWxbiHhGjx7UE
         4qr1wV3n/HPnsU6f94HAma3Bav2YpG8RYXjlFrN4Cy6aAXixK/rHNLa8qacKRWJgVYvv
         9B5xci1yRjZO38wdAorzOdAl92gM+bj9VtlO9KPmnq2L1UzWVlJae4ntR8G0lL4nX5Cj
         FQouYMXp9h/bHz02yvkFfqyURyShCumixKXeqHUKEZrGZ5V8wH+JOMWyySrTbp6O9azN
         4FUofGkpJg+/jin7yR9UTjFF4F0YZJKQrxqesr1LVb6DKtYu4CLewdIyQpTSNTi4ongi
         u/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U3QGsT97pDvvMvvKXcBgwyDJ7+zbhoAH55hk1yJyQBg=;
        b=oDTp2p98A9OFaJDJJUwAKSCSjy+z4V24+heEidyFh4biuZMJXPOK5g2wuWgY9NFUfd
         E8M8s2PL0/1SzYKjuXHL26yGqJtdg50EBAe/F3eZsUruZhr/pkMjDuJas7wwSRlGJ5pr
         09o3foPLL6rDKYmvQt4kV+1CduHc8MA4SQ4vyekKVtaadvRJmOZXGr8RXXbI6HJcH+td
         BiM3qICmX3cnJQ1PF0V4yEpkaX1ocXMCFrLWKC40ctgBqi7DgTllLZ5sdBq0ou7EjiPM
         9Dux/6QzO6dDSLb+hZQS2xiz7BztJ7nd01V8FcYUYEm+O8pBT0JOOCmxAJzXutYfAc4y
         ilvg==
X-Gm-Message-State: AOAM532ug3Uqyt6FoFkhhmgMuC1rLh7amh7/P9InT9W1NhTvWoqX3JY/
        qol8h/NhGeRF2gFpxVwM8mAqgQ4TWuhw8GasEpz4tQ==
X-Google-Smtp-Source: ABdhPJyVCjvMmGy+J9LEg5lcRDKDvsw8LvlLWpJqVH2+6OGAJF76y8MYaaNzBmYqJ0LtUvWFUmZP28zjVCgPZgcgvYc=
X-Received: by 2002:a17:90a:3321:: with SMTP id m30mr29183pjb.20.1592510390785;
 Thu, 18 Jun 2020 12:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200616064730.123871-1-davidgow@google.com>
In-Reply-To: <20200616064730.123871-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 18 Jun 2020 12:59:39 -0700
Message-ID: <CAFd5g45M-Kzexz9_BRguh7AMP+pP1gijvdjYvTyS=cTk8ZpCdg@mail.gmail.com>
Subject: Re: [PATCH] kunit: kunit_tool: Fix invalid result when build fails
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 11:47 PM David Gow <davidgow@google.com> wrote:
>
> When separating out different phases of running tests[1]
> (build/exec/parse/etc), the format of the KunitResult tuple changed
> (adding an elapsed_time variable). This is not populated during a build
> failure, causing kunit.py to crash.
>
> This fixes [1] to probably populate the result variable, causing a
> failing build to be reported properly.
>
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=45ba7a893ad89114e773b3dc32f6431354c465d6
>
> Signed-off-by: David Gow <davidgow@google.com>

Oh wow! This is an old issue.

Nice work!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
