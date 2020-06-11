Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B79DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B9C204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZywH0M/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgFKIZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgFKIZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:25:06 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A612C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:25:06 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e16so3993924qtg.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sj0fSOOfXqojEYfHFUH1jyum0dXnQV1jKSCFe7PzV5s=;
        b=ZywH0M/sfn0GAFf7wYJFuemJ5wAQhoAySsb+zAa7+s2hTbw7MnKoBYX2GWXgLCa8EK
         LSVz2EqYw57+xMYfsnPxyfqGxVlV/Of0VWanwJxYJnW8itvCE4NNoz6bdbC1dIqw/iPS
         GplFw8j4+XCtAi/ay9WSUqHrWXX8tnnWp7FWYGTbgCS5DAA6myFp655kbqtA3v1nJ+MQ
         DrDAAsv5+/DwSJvkh+ICqai/G7phvWAAmKN1WoEi+NJ6UHwGBYMMDpzp7UD8GuU1G9aX
         +HY4DNaFkhK1376ZaQKKg1KHZzf+ABLXbAhZ06xlf4RKR7UGK34xHtC2yS96uCr9C+Bz
         DVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sj0fSOOfXqojEYfHFUH1jyum0dXnQV1jKSCFe7PzV5s=;
        b=RxvU3BN562zaZZ+HjTwJbOQf1dzhOhqyHQGRdBmPgaiB0cP0MB820MmV6RvFCnXRMb
         WaVbRyEH6BZ14953/uiE/wtBCd734hyg0AF8NIgr/TeETnOn+8LYGgEHgYI2zXyGofyn
         BXOXHUtbTNXN9h4PYxzMKzgGBUoSSXd85ZqJtB1icMNyb6Xcogj3MUZvCH7xgacMceVp
         BshXYy1e+J8X6gAnAcGdpLAgbgQs7NVFr4SNij0QZX3KsSlRNxmy9hH8cIXiUNs64PN+
         HJsD9i+6lIcqSrRrJz+GJD+MKThS6cF46xL8IYcUxBehtxhxg4qIxc01t0JkZGgTFtsX
         0pHQ==
X-Gm-Message-State: AOAM531watBaCDVUyNdAzAdq2N+ShyXJ3M300VoH+eaXwOx5Y0yJEExm
        Py/qon49P0soSvp9QZWgz3RWap9yD3aO06NCJHg=
X-Google-Smtp-Source: ABdhPJz7099wVwccHJuiZWXXXzIzlbCNK+rEKPsKtwHwEYpGObsJWeFzknWsyuVoxwM4Tev8OFtKce131EOjx5Org6M=
X-Received: by 2002:ac8:468a:: with SMTP id g10mr7265929qto.6.1591863904847;
 Thu, 11 Jun 2020 01:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200610083502.GF12456@shao2-debian> <20200610095054.GF2531@hirez.programming.kicks-ass.net>
In-Reply-To: <20200610095054.GF2531@hirez.programming.kicks-ass.net>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Thu, 11 Jun 2020 16:24:53 +0800
Message-ID: <CADjb_WSLpKrkt-Oq_3krGBp8ZLjVZ4caUAd0d0s1_6s1tOHdHQ@mail.gmail.com>
Subject: Re: [smp] b2a02fc43a: suspend-stress.fail
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,
On Wed, Jun 10, 2020 at 5:52 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jun 10, 2020 at 04:35:02PM +0800, kernel test robot wrote:
> > Greeting,
> >
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: b2a02fc43a1f40ef4eb2fb2b06357382608d4d84 ("smp: Optimize send_call_function_single_ipi()")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > in testcase: suspend-stress
> > with following parameters:
> >
> >       mode: freeze
> >       iterations: 10
> >
> >
> >
> > on test machine: 2 threads Broxton with 4G memory
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> >
> >
> > the result of this commit:
> >
> > test started
>
> No dmesg output? No splat?
This issue was only found on one of the test machines from lkp team.
 I've borrowed that machine and will try to narrow down and give feedback later.

thanks,
Chenyu
