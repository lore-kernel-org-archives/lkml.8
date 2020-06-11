Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D75C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 21:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 092F52074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 21:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WpZItS0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgFKVW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 17:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgFKVW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 17:22:27 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA7AC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 14:22:27 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q24so2902206pjd.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 14:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2WL77hiAzb90wuEqJ5UyE+b+qKfSpj9bKKe0Q8kvd8=;
        b=WpZItS0vXXqlMWB8ryeAOCq74Job8TOExQ5dkpfjAlF5u8sbOTyw2RHRoXgj3vyL+i
         ziuhIJipaNvWBKFxaaU8ULv79UnqNkk/hdSdgsbzPIDMvIs/zDKiJf3UhrPyFS0udtlz
         of4eOmyBCC6SJ4Oj1sptd4RGCP1Oywa7H2udyXh32hyAZi+bTXs5g6cASTp3Xoj4z4rJ
         6ojnEev9FzwemoFNm2MURW5PMNbkGpQ1YvpsplPbEv4R9uZfdFqtwtZrFF2F5PErLIEF
         CoMoj19FHpYgr0FQUaJjlOuhpXD0yLQtEkO+3UbYYiDMTra0chfwArtoWSXeW5NfjdAA
         rWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2WL77hiAzb90wuEqJ5UyE+b+qKfSpj9bKKe0Q8kvd8=;
        b=IdV4TJcJhI85UoOqx8KEf/sGGxNjrjDW7aZ4SRVqvgu4R3zYwCkLsKwGmNpCAhh5xN
         hKk4QDcjJubObJiuWox1gfVmLsx4GIetU3O1Nd963w5XAevp8rDLt9K2KvB5uylUnaCN
         xXMf1cc18HAaedOFSDfP3aF96gwyeXhHcXo9NairaDQNWaQuDixkn+CiEAFWQFDSofnj
         1ZsM/2vCVIhXOu2ZyvFzogji/bbFVAsWEOEgF4ZwWzdqRB0NdhrczWLeAjBbMNGw4/fD
         Xgf+2NenUfdnNauC3VNRmS9HJ7K5JDhi+PR8kcGiVf0EskEv3U4aFbx6wB/Gwx9V6Pct
         Is/g==
X-Gm-Message-State: AOAM533lJnAH3Yhz7LrjglxyI2cjuFzsNYBeb1B/PPc5KZFMdIE7Sm6p
        9bmZQyzjux2Jt1TYGuvKS+WaPV3otWVWeJFto7Y92w==
X-Google-Smtp-Source: ABdhPJzc9BjwWRB35loqLZC1e1TrbrLfLfcMj8L5zj+R49P0QegJX42IfCg2XZ7QwBCv9yz22w/xfIypD77Q5i2FdA0=
X-Received: by 2002:a17:90a:3321:: with SMTP id m30mr9849633pjb.20.1591910546427;
 Thu, 11 Jun 2020 14:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200611210545.173886-1-urielguajardojr@gmail.com>
In-Reply-To: <20200611210545.173886-1-urielguajardojr@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 11 Jun 2020 14:22:15 -0700
Message-ID: <CAFd5g465Srr04ToYC76P3QGH6eYbQMeCN5jBLiNLo=A_soMNYA@mail.gmail.com>
Subject: Re: [PATCH] kunit: show error if kunit results are not present
To:     Uriel Guajardo <urielguajardojr@gmail.com>
Cc:     Uriel Guajardo <urielguajardo@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 2:17 PM Uriel Guajardo
<urielguajardojr@gmail.com> wrote:
>
> From: Uriel Guajardo <urielguajardo@google.com>
>
> Currently, if the kernel is configured incorrectly or if it crashes before any
> kunit tests are run, kunit finishes without error, reporting
> that 0 test cases were run.
>
> To fix this, an error is shown when the tap header is not found, which
> indicates that kunit was not able to run at all.
>
> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
