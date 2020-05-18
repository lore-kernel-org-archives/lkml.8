Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF177C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC2020674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgERNvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:51:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33907 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgERNvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:51:15 -0400
Received: from mail-ej1-f72.google.com ([209.85.218.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1jagAj-0002Ma-3a
        for linux-kernel@vger.kernel.org; Mon, 18 May 2020 13:51:13 +0000
Received: by mail-ej1-f72.google.com with SMTP id u24so5279045ejg.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 06:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7hu+iWhNpwsjT8JCVNUPdNUhRLVOPLZBCQR9T/nGBw=;
        b=VnjWZq1Nc05jSNaYq72Fl1isA6NR1YAHk8vjyQW2eQtoGXbKm4gZCCVE24ZJTnz9gf
         tjaUBy81yeSRGiVipZUMcJ0jmX9uAWWl6jzqgPoGxtlNgIgUTKH/C+SeQyeuo1UTgWmp
         RkuFdSFrqaVY4nrlE1zSHYCg8v7aTMQOClUmoycaZEesnWRPDendKqWiQiPJrjtOdRbj
         W5dbtJKzVQf9wIkpyq+iKf8PrsKGwlXh4vX1oBThPMaI9GRqvBt0m86tbx+nIyE34GaH
         /f6YOWcC5lWFGZxCu2FfIYW2+3OZXTav9AVmMzLeITAd6JUmM/npQWlORvkc8Htd+ZfY
         xfvA==
X-Gm-Message-State: AOAM532OIUXcf6V11Dwx2TWhJ7ZbSq6mQ3pdS+EHd2BkCrSML90dnb8O
        3Dk8r31Dnyxv0NS7IKKFURIi9n5FOvomVNTpoFR8kG1rDQE0HXmQNVx4sOLJBvkc6awqEHECAzX
        iI02BTjO3tCkWzpRg40I9Ub5B88HANUpTWPrxBmitq72n3QydYyuPE74pjg==
X-Received: by 2002:a50:dac4:: with SMTP id s4mr1154931edj.84.1589809872826;
        Mon, 18 May 2020 06:51:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgbq5M3t9GyFs8CX1A2dVN1oxIyEH0opyQqFB6u1APwAyHroua3cFI3LrqWIumMgzIw6tcjVsFSADLRenfwsY=
X-Received: by 2002:a50:dac4:: with SMTP id s4mr1154911edj.84.1589809872621;
 Mon, 18 May 2020 06:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200507215946.22589-1-gpiccoli@canonical.com>
 <20200507160438.ed336a1e00c23c6863d75ae5@linux-foundation.org>
 <CALJn8nNDqWwanhmutCiP-WBLN1eSg2URrG2j5R4kzgHTYObs7Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2005081129100.236131@chino.kir.corp.google.com>
 <CAHD1Q_wF6Mzf5JipXGZKvn2YDR+FQ6ePuKOe-1W-t_VapxMCxg@mail.gmail.com>
 <alpine.DEB.2.22.394.2005101821160.172131@chino.kir.corp.google.com>
 <CAHD1Q_zrQmUTRpdW3bZ0CRKuu2dKgueXUjqCNtC5oyZ67CGp2A@mail.gmail.com>
 <6bf5e178-f2c8-f453-9035-93e31995bb53@sony.com> <CAHD1Q_yk4GhUgTMc5KcvpaW-oMNEfvSj7vxOCOQGALs4qe8VUQ@mail.gmail.com>
 <cd43b4d6-7a2e-3e92-0a15-19597e9df4fd@sony.com>
In-Reply-To: <cd43b4d6-7a2e-3e92-0a15-19597e9df4fd@sony.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Mon, 18 May 2020 10:50:36 -0300
Message-ID: <CAHD1Q_wF_ZoS2xuiTJo5P4f1_1ZEyx3jY0bN+Qsm7rZo2x9C6Q@mail.gmail.com>
Subject: Re: [PATCH] mm, compaction: Indicate when compaction is manually
 triggered by sysctl
To:     "Enderborg, Peter" <Peter.Enderborg@sony.com>
Cc:     David Rientjes <rientjes@google.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gavin Guo <gavin.guo@canonical.com>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 9:54 AM Enderborg, Peter
<Peter.Enderborg@sony.com> wrote:
> Usually change existing causes confusion. It should not be a problem but it happen.
>

I am sorry, but I really didn't understand your statement, can you be
more specific?
Thanks again!
