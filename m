Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EC6C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761262145D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BYccWULQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgEHLWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:22:02 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:34923 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgEHLWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:22:02 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 40b22dac
        for <linux-kernel@vger.kernel.org>;
        Fri, 8 May 2020 11:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=0MY6Mw/EZHF53e5MH48vmSaxiAw=; b=BYccWU
        LQHIoCLTRYzmvjHLB6n2DoWH9m8GvfoWb1avPFbL8RF8TZ20xMkYB2OCDkgSgt8N
        c8ys6j6kIQuswHBjuIfgviHOntMuRPuG9UzU1n2p+FR6rs210hgWn78kfMkSJRf9
        gxk6ZPQyY1yvIK1yCYoQC6IG08T0JPle5yeewsCj6KricGVdXRjH2E6oK1CA3gE1
        aAYT/BhyxOOS0Soor2sx1zs1rJa1/NP2j7B1h6fkHaZKrGpotIWhF+YqVl5IvfaQ
        lRapNbZecBKtaP5Sj+Tl3xVGrJdc/XfpPIYfw8+uXpuHODP3LyiCXQ6BTF8BzTs6
        bOeYPZdqMgUhbbpA==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 91458a76 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 8 May 2020 11:09:04 +0000 (UTC)
Received: by mail-il1-f173.google.com with SMTP id s10so1040595iln.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 04:21:59 -0700 (PDT)
X-Gm-Message-State: AGi0PuZnuXQZ/ooRGw/Ivwet+Xq+50vY79FfWD73zXHTUr3TO9z65jX/
        XTyjGrTypR7cf8zuU2LJ/aYu8bf2gknlxIB1itw=
X-Google-Smtp-Source: APiQypLFnQSgFDdjLZRMfEaCRugPXSsE6tPis6ZXTH794HynfB81S+yf3+o9C6+jWPwK45mIitGlseqB81EGVOqAoCw=
X-Received: by 2002:a92:5f46:: with SMTP id t67mr2135081ilb.64.1588936918705;
 Fri, 08 May 2020 04:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200507224530.2993316-1-Jason@zx2c4.com> <20200508090202.7s3kcqpvpxx32syu@butterfly.localdomain>
In-Reply-To: <20200508090202.7s3kcqpvpxx32syu@butterfly.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 8 May 2020 05:21:47 -0600
X-Gmail-Original-Message-ID: <CAHmME9pTZTa9AEUL0-ojTr7P-F7NYe8OR9=-GBPaQNpnSDrEiw@mail.gmail.com>
Message-ID: <CAHmME9pTZTa9AEUL0-ojTr7P-F7NYe8OR9=-GBPaQNpnSDrEiw@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: default to CC_OPTIMIZE_FOR_PERFORMANCE_O3 for
 gcc >= 10
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 3:08 AM Oleksandr Natalenko <oleksandr@redhat.com> wrote:
>
> Should we untangle -O3 from depending on ARC first maybe?

Oh, hah, good point. Yes, I'll do that for a v2, but will wait another
day for feedback first.

Jason
