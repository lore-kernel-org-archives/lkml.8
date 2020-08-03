Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BCBC433E3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0515822C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIJROpGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgHCVO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbgHCVOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:14:54 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B868C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 14:14:54 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d188so12916025pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFs5N7Aj94X2p4Itvu8tYvN2B3/GsCmBFKnespcHSO0=;
        b=BIJROpGSryxlCfoh5rldvY+j0NKCC0TMSDj/SFN4RZMbQXx5jWPcy71uC+SEtNDxX7
         BqHAgLfMCOWFh5CNKROZfxPZ7EGqxWAg93Z6IjH7NzGlBMXrZcz89dtyCQzcWdK51/rc
         4fcRl1C9vlx4ysv8yE4M/BFzdQHtnm+whqM3MeFrq5DQOznOUiZWtnNMCG0/nmJ4d/7y
         rB4POQCJpPpNHFNFza1crYxYA9RRemn99Fll6ery5GoKvTgmgHezyhpPaFZuHLcvyRsN
         GEAKftb1k0JcKY4VpjWXVi9+noA+0KYRnOD0pfyJCTCONpF6xVqUst0vVvw9lVpCHj9e
         mamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFs5N7Aj94X2p4Itvu8tYvN2B3/GsCmBFKnespcHSO0=;
        b=X8uhJs5bHUHCqYdXCfg9RUBkG0GdEO7lA0J+oEgn0xGG6O1g7NmpAV2dFXJNUqLlle
         rbFOiLDOBbBdXuQLPHCpHYxSfWA7VyXfjl+NvXvb2Ed5bk53iMO0S4w+YF1sNMnHGjq+
         QQ9PVyaRgS540GvqyyqOBb7UPFH1eonHP8FLMZzxyi7zNaVqNVyp3Yp1fSgdshXkYxMs
         4w/60gxLeDjS+Ci3gjbBtXb7/yMHo0F1wsNUGthq3PTpf84Jf5eQG9XQB8aqZMokJ11p
         x57gp3XNZmdQPiXW6n1X4neOnZDCn8xidqE1pOqvsZiG6IpmsXCKc+p5U5SFeUzgOvwK
         ZzQg==
X-Gm-Message-State: AOAM5310PsYqAvxpX6rpn9G80LLoHS+3ABHpsohDqDspn30erelTF0y0
        aAJefqeBPO2nwdm2ZtqqZWWD+7w0lh7jCiTXsxHWeA==
X-Google-Smtp-Source: ABdhPJxN74uGPSyFq/sMHzSrAyVNydvv3a1KRtp+ugVWRWUR4XzuGsQSZAk1SzJ3Mge5oZFXZ7/TRU4deckwnTL4Mdg=
X-Received: by 2002:a62:7b89:: with SMTP id w131mr16526946pfc.284.1596489293882;
 Mon, 03 Aug 2020 14:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200803025939.21106-1-98.arpi@gmail.com>
In-Reply-To: <20200803025939.21106-1-98.arpi@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 3 Aug 2020 14:14:42 -0700
Message-ID: <CAFd5g47u5u=cVAM_5rBj0mA4YcKjanebb35Po1EN13mNrEH7KA@mail.gmail.com>
Subject: Re: [PATCH v2] lib: Convert test_uuid.c to KUnit
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 2, 2020 at 8:00 PM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Converts test lib/test_uuid.c to KUnit.
> More information about KUnit can be found at
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
> This change is beneficial as KUnit provides a common framework for
> unit tests in the kernel. KUnit is fast as well.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
