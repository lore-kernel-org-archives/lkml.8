Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1172C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65E92469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt3muHPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgB1TWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:22:13 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42343 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1TWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 14:22:13 -0500
Received: by mail-ed1-f66.google.com with SMTP id n18so4618147edw.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 11:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1D6XTERnADBlFbYpdQMB2hoBZRD3yh+V/F3mcEwTAEE=;
        b=Xt3muHPTFdIA1OqMdIvcoAxpC1lkpCu6pE6KlLI2Eg7M7RKrBKDok8PuzUaRHw+IBW
         2z966EaE/4gheSCvV6lwrLeuS7iSkE/M1aXZ4Hz3luEsk/u9XFsGEopueQ82OoPbCnzH
         GxBaFTYdsIi7xDOVkRMBeBKxUbTtFXpz+OejvDhOcezxrMeTIQk/TYaA863opTMISfBr
         oXfIiCeJhTKuvF+f1xeBtofBGDpdRNqUgXdh5CaN1q54Dq7kc8m7j6ipEB4lrr0xkxu7
         h1vezz7TlW5bpjuLWRblBClur9QBN6LgzaHz1xChxELEj4usxBmDvSRuz1L7inOYlQB8
         KDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1D6XTERnADBlFbYpdQMB2hoBZRD3yh+V/F3mcEwTAEE=;
        b=f2aNgzQHfTYNzOxrUhGORIBPSErhj4t7YmIH001CjniFSQGfnYe1dNvFbN+q5FSdCT
         JXc//SySWyZjXwqC9feA0XsLnTevzFtDm8YMTLlkx1GgAdDFnUeNpCIGalCOXUulHEe8
         R2TsxrGd5iVLBi7KcCrQykW8mYB6nlhed9E+uq1Pn8uFJJLh8HVhB6PslhXEa0WHiuEr
         YFoEuW2VrKG0+ZhStyOIG+QOmxFjwDW4digsgxSPKYdu1rBMzmJw4uVDC9qf8cFuK6gk
         c5HrcepvOrGt1siNfJGVqgp7m5KGE2q3V+2Pg0QMzBTP2WqoQvxMJz7o/YkgMUn1yRbV
         UA1A==
X-Gm-Message-State: APjAAAVs4PSdsSOhmOE+cLyegpqBLmJo0JJcnt1s9j/p7oU5tdXbeOdj
        y+KlcmhnBkLFcUeqnen8P0Fr6FHpKe/pYRBmsFw=
X-Google-Smtp-Source: APXvYqwpBAjFx2hLp/ojkEpCcwA0zZIhZPiKT+w+8K0Buw4zyabuvaaYAA1NLm869+n8P9DkU3OlcNXPKZewOfBwFeg=
X-Received: by 2002:a17:906:edb1:: with SMTP id sa17mr5598441ejb.379.1582917731514;
 Fri, 28 Feb 2020 11:22:11 -0800 (PST)
MIME-Version: 1.0
References: <20200223231711.157699-1-jbi.octave@gmail.com> <20200223231711.157699-30-jbi.octave@gmail.com>
In-Reply-To: <20200223231711.157699-30-jbi.octave@gmail.com>
From:   Robin Holt <robinmholt@gmail.com>
Date:   Fri, 28 Feb 2020 13:22:00 -0600
Message-ID: <CAPp3RGrrurNVniL6Og-+hGuYOBeiiZdjj1iEwvodnx6i3Qs7GQ@mail.gmail.com>
Subject: Re: [PATCH 29/30] sgi-xp: Add missing annotation for xpc_disconnect_channel()
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     boqun.feng@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        Cliff Whickman <cpw@sgi.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 5:18 PM Jules Irenge <jbi.octave@gmail.com> wrote:
>
> Sparse reports a warning at xpc_disconnect_channel()
> warning: context imbalance in xpc_disconnect_channel() - unexpected unlock
> The root cause is a missing annotation at xpc_disconnect_channel()
> Add the missing __must_hold(&ch->lock) annotation
>
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Acked-by: Robin Holt <robinmholt@gmail.com>
