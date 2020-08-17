Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9130AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2D620658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgHQCy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 22:54:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37503 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgHQCyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 22:54:25 -0400
Received: from mail-lf1-f70.google.com ([209.85.167.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1k7VHz-0008Qv-Tk
        for linux-kernel@vger.kernel.org; Mon, 17 Aug 2020 02:54:23 +0000
Received: by mail-lf1-f70.google.com with SMTP id u26so3194448lfk.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 19:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q2jjPmQel1pxO3MR/VLtINS4dkeaCDgPDRMj2nur9GY=;
        b=Y0dzPgWX3MTeTkdARPbBmikQ6t8CpIx/WY8aXxR8VmLBtn0miVLysIkvVd2wqYKOKo
         euKCc+w4VPim30U4Rz9vzS61NA1RquCFpoMdVVEMjxIdvNEsY/IHladtNpW8feJNrE8y
         TffRTf/SKNmKzb/zJoBRtD1TtNIcUa77S4kn1rLaugtn4+gMnzZUXoOdLqUu5/IZ76bJ
         lgR/O8AB+nGcWlLnFxZENG3SkLCT8KF7rCAk4Anvd4n3EJpQbE2w6aJkBKNxJvAMy0rN
         coAMQW8BWR7sk0/TTSFSvDPNcpbAqPpDsnIY2WpCNEOaf1tUu/01N7Gmhd9penDIXyo6
         Hhfw==
X-Gm-Message-State: AOAM532i+WMBqoXNxXCjgN8UaTuJ0NLhj3o94gngoAUpEOHKdlaA7Qix
        z/erqgdkRDycTHuGytFCuIfzIOkfUYYQUnGO2xq+4lWdHaxKTr/EoyQG8gcJsCIYD7sDVaVeQOH
        3mS+EaN6t5JUUOshcKzVcLw1Szo1yjTTPtn/Nql/rwsSJ2Ho9MUSwHuVU
X-Received: by 2002:a2e:5852:: with SMTP id x18mr5999009ljd.132.1597632863219;
        Sun, 16 Aug 2020 19:54:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKXtlo/YWR4lvo0OddtBB/rs+kUFiIctf6mWJJC51t+bciEX3/ht7hX9V6E1ApK6z9Nw/nUfoKWf/ZsXlQ39Q=
X-Received: by 2002:a2e:5852:: with SMTP id x18mr5999003ljd.132.1597632863006;
 Sun, 16 Aug 2020 19:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200813044422.46713-1-po-hsu.lin@canonical.com> <20200814.164354.1568500831741804705.davem@davemloft.net>
In-Reply-To: <20200814.164354.1568500831741804705.davem@davemloft.net>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Mon, 17 Aug 2020 10:54:12 +0800
Message-ID: <CAMy_GT8bnVCDEgDfDEbVexpV6vgmCBRPe+v6WVxnOYdCXft=nQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: rtnetlink: load fou module for kci_test_encap_fou()
To:     David Miller <davem@davemloft.net>
Cc:     kuba@kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 7:43 AM David Miller <davem@davemloft.net> wrote:
>
> From: Po-Hsu Lin <po-hsu.lin@canonical.com>
> Date: Thu, 13 Aug 2020 12:44:22 +0800
>
> > diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> > index 3b42c06b..96d2763 100644
> > --- a/tools/testing/selftests/net/config
> > +++ b/tools/testing/selftests/net/config
> > @@ -31,3 +31,4 @@ CONFIG_NET_SCH_ETF=m
> >  CONFIG_NET_SCH_NETEM=y
> >  CONFIG_TEST_BLACKHOLE_DEV=m
> >  CONFIG_KALLSYMS=y
> > +CONFIG_NET_FOU
>
> You need to assign it a value, not just add it to the file by itself.
Oops!
Patch re-submitted.
Thanks for catching this.
