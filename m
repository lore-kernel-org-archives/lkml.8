Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30505C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 21:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CAD120674
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 21:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U0K8hs7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGIV10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 17:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGIV1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 17:27:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C771EC08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 14:27:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 1so1551030pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 14:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P6+NCDCknn8HOgMcidJ1cpk0+00o/dYEdlgP9Ug2JXQ=;
        b=U0K8hs7/zYjp7v6F9ZR0fL5JhJLp3BIds9vhqJf2265qv/ZHjllCR5v3zSFeia4CsR
         +EOcB437kV+ilxEY9/9dAmY0RNN9e4akCQ+yXnZZFh47RUQ2m07YrVaSJ4saerDfOXxz
         UbCF/9Uvk4aNIDng14O2SKqn/pJ87PuNKcNyIc+x2rKAUMFEObjYSSakH6bIrobp4Ntw
         qqi//hfYgvXoG+ru3XaE4AgodDXYWgilv3R0mumWm8lVsRpqLftnfh0DYv2gisIY2C/h
         38cIIqfAJfwIYqPViwrKxeazgqb58FCQW3W+yr1DKKIFOcn5WJIG/GR4qlUnw1g74olg
         ytbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P6+NCDCknn8HOgMcidJ1cpk0+00o/dYEdlgP9Ug2JXQ=;
        b=oAYImMBGB8ZZuqmgO3ESWFkFZbEUt3WV0U/uxDBZSy1bu7yodZF2tuArZ51kCN6Nel
         CQRgYjV+Ss4GCy4j3fyMuo028WmBea/Ybp08qdrz9ULJRfgyzElaWzPAVI9goauyyAuD
         Q7Jbs8DoaXxvIvd1zzM2FdSvfsDwvfM1xVAfGOxIDA0OUAX+grH4Lq48Bgatu84oYnHY
         i/zOT61vEcUjERPccyHD6hTkvEnmhaRTQvmNxnjIQrOGWkn1kZu6d6AKvu20DRPQeq3o
         UbDzabw9eVIDrWY3a1riM1bqPo4A+de8ZrxoLZubl8eYGSv1u+hO9T3y2kZm+hUWo9n0
         fgMg==
X-Gm-Message-State: AOAM532O19aOgjTqpVk08E9G7pYssh+WDn2os9/xrqRBadQhcV/7bhkD
        oiptFfXVK3cF6Tmrh5v4kKk4w8EuNzvqkuBiLrcTtw==
X-Google-Smtp-Source: ABdhPJx8egPGks6+3+oORiSQ45+RR3TBGylO9r7zpEbA49xi5mzsqd1sWKcvr8LLoluatQ8o7TnwdJ7iJmqu24JCpYo=
X-Received: by 2002:a63:4c08:: with SMTP id z8mr53932099pga.201.1594330045176;
 Thu, 09 Jul 2020 14:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200708213543.1365306-1-chenwi@google.com>
In-Reply-To: <20200708213543.1365306-1-chenwi@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 9 Jul 2020 14:27:14 -0700
Message-ID: <CAFd5g45C8Pn8-QaQxvQaAQcKHEtonw8CFaKEzqUd-ttG0ypWZA@mail.gmail.com>
Subject: Re: [PATCH] kunit: capture stderr on all make subprocess calls
To:     Will Chen <chenwi@google.com>
Cc:     David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 2:37 PM Will Chen <chenwi@google.com> wrote:
>
> Direct stderr to subprocess.STDOUT so error messages get included in the
> subprocess.CalledProcessError exceptions output field. This results in
> more meaningful error messages for the user.
>
> This is already being done in the make_allyesconfig method. Do the same
> for make_mrproper, make_olddefconfig, and make methods.
>
> With this, failures on unclean trees [1] will give users an error
> message that includes:
> "The source tree is not clean, please run 'make ARCH=um mrproper'"
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=205219
>
> Signed-off-by: Will Chen <chenwi@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
