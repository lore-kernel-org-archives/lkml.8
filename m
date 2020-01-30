Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A56C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798BF206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="puvFWiDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgA3X65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:58:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37225 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgA3X65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 18:58:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so1975097plz.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 15:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nnBwEA2giD74itzmaPDJLtfzfFraVmkFwFzES0zVDnk=;
        b=puvFWiDRkG0BzSX3C/l7V98D8skWjWf/yGJxCo+DaTkYZSQk1fUprzzO9S++QH4A6z
         LnLRTrUn4ORyLTk1VGC4g8Cx7oNBFTcfpYCHZKnTTOUSRg1GQjGu5zUalY/rP1XJ8xw8
         V/dxaiIIXfGetpnC1/92U52ynlUcwN/m8g9sCWA/yjMIqgKTdzPYqbU8VCCX6gTrNU6k
         hF7u/fcXpjBk028VWRst6iXxn82KjDIMC0n8auK+C30wEtcRtgpzDOtGxNuVyMpRu4Yh
         ZijiFoS1T5jyXAroSAtO48jJRhmxO/xRWuipzqP2Roq8FOYmx+2UlixHpo5oV0Rqv7Av
         2DyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nnBwEA2giD74itzmaPDJLtfzfFraVmkFwFzES0zVDnk=;
        b=bpUHRHYGClTXyYTGQBhLyrQVZ/QVXFBJUmbXirxz2o9XLgpvV5ZIYaUAZ8R70RnMUO
         gBqGTk3M3xck+lx7tbwJ4LfQXMAcVBtmusJ12UEM85Jig6aRxyZpSJNS2hbWVUYFNNFf
         Lx778RY1v8aouJ9kCDSsoZEYfVdfkwsdrw/QM+AsekCY3eSa78kCV16/jWyfyvUe8KnD
         dDgigOC6ZP6n7oCyKgEOaKWqvDsG3ZReTT88SNc3ic3h2twFolgIoxWWp/t2e8MUKuRS
         2nASeX4RKQwVlYaDB/nAuajY07+u2FcXC7plwgo/wAZ6t2qEUb1Sk+4f2zjjkdT7oAaw
         722A==
X-Gm-Message-State: APjAAAUpPNWkrYJjnC1Hww8UIm5xlMAFZBRldA9GN3GAw1Sm/+Qimqta
        Zmjz0imYKl0An15hGf9rOwuojG5Yp5NsYl5/p6mZHQ==
X-Google-Smtp-Source: APXvYqwSbpScfcJzpgVyKcx6TgNZ6LI68xx2xLHwdPDEW3rfaTNMpnoILEgEjBKDFJHMG838ctNvM1kPlspCdJjT2oA=
X-Received: by 2002:a17:90a:6484:: with SMTP id h4mr8390552pjj.84.1580428736132;
 Thu, 30 Jan 2020 15:58:56 -0800 (PST)
MIME-Version: 1.0
References: <20200128085742.14566-1-sjpark@amazon.com> <20200128085742.14566-2-sjpark@amazon.com>
In-Reply-To: <20200128085742.14566-2-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 30 Jan 2020 15:58:44 -0800
Message-ID: <CAFd5g46fnZBiBYdBDmd=wJctoshbS2Q2JFGVBpoiPbis41Jw_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] mm: Introduce Data Access MONitor (DAMON)
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>,
        SeongJae Park <sj38.park@gmail.com>, acme@kernel.org,
        amit@kernel.org, brendan.d.gregg@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, dwmw@amazon.com,
        mgorman@suse.de, Steven Rostedt <rostedt@goodmis.org>,
        kirill@shutemov.name, colin.king@canonical.com, minchan@kernel.org,
        vdavydov.dev@gmail.com, vdavydov@parallels.com, linux-mm@kvack.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 12:58 AM <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
[...]
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 56765f542244..5a4db07cad33 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4611,6 +4611,12 @@ F:       net/ax25/ax25_out.c
>  F:     net/ax25/ax25_timer.c
>  F:     net/ax25/sysctl_net_ax25.c
>
> +DATA ACCESS MONITOR
> +M:     SeongJae Park <sjpark@amazon.de>
> +L:     linux-mm@kvack.org
> +S:     Maintained
> +F:     mm/damon.c
> +

No one else has complained, so don't feel like you need to do it on my
account, but I have had maintainers tell me that the MAINTAINERS
update should be in its own patch and come at the end of the patchset.
Up to you, but you might want to do it now if you are going to send
another revision for other reasons.

>  DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
>  L:     netdev@vger.kernel.org
>  S:     Orphan
[...]
