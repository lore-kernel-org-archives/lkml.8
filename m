Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4798C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 03:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B67820782
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 03:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alibaba-inc.com header.i=@alibaba-inc.com header.b="wooVeoiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHLDv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 23:51:58 -0400
Received: from out0-144.mail.aliyun.com ([140.205.0.144]:53784 "EHLO
        out0-144.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgHLDv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 23:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alibaba-inc.com; s=default;
        t=1597204316; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        bh=TNk7ZQEYpdWl+weNrqRzEn2dqhypAbPEQrZXXGATTm8=;
        b=wooVeoiDxbO5bl0U/ApUVfO6AkqZZjETHEtRQeseSfTc6HjUo5DCUYAfKYfjO8Ki9mTokn9M6tQGGOnkag3AxJgaZByo7Slmv1G8sekb2CP18AZ5t9bzbFlVZjs2F3zN8iJ3RjoPm5e6xAkJguHXCk3XUYjCsZdPp64/jb8/T+4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e02c03308;MF=tianchen.dingtianc@alibaba-inc.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---.IGJMTNn_1597204314;
Received: from DC02319ZC1144(mailfrom:tianchen.dingtianc@alibaba-inc.com fp:SMTPD_---.IGJMTNn_1597204314)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Aug 2020 11:51:55 +0800
From:   "=?UTF-8?B?5LiB5aSp55Cb?=" <tianchen.dingtianc@alibaba-inc.com>
To:     "'Mel Gorman'" <mgorman@suse.de>
Cc:     "'Ingo Molnar'" <mingo@redhat.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Juri Lelli'" <juri.lelli@redhat.com>,
        "'Vincent Guittot'" <vincent.guittot@linaro.org>,
        "'Dietmar Eggemann'" <dietmar.eggemann@arm.com>,
        "'Steven Rostedt'" <rostedt@goodmis.org>,
        "'Ben Segall'" <bsegall@google.com>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'??????'" <yun.wang@linux.alibaba.com>
References: <44875b14-00ea-4e61-aba7-4809808c4b2a.tianchen.dingtianc@alibaba-inc.com> <20200811110154.GY3510@suse.de>
In-Reply-To: <20200811110154.GY3510@suse.de>
Subject: RE: [RFC PATCH] sched/numa: fix bug in update_task_scan_period
Date:   Wed, 12 Aug 2020 11:51:54 +0800
Message-ID: <000401d6705b$eba56bf0$c2f043d0$@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI0MlYutHNQskgVXAmO6rSH2dIAnAHL4oAlqGnvAwA=
Content-Language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK. Thanks for your advice and I'll use label instead.
In the case of migration failures, if there are still new failures after
clearing (meaning the node is still overloaded), the scanning period would
be doubled, just like not using this patch. However, if the failures do not
increase again, then the scanning period should be adjusted according to the
following rules (i.e., ps and lr ratio). I believe this is the original
design idea, right?

> -----Original Message-----
> From: Mel Gorman <mgorman@suse.de>
> Sent: Tuesday, August 11, 2020 7:02 PM
> To: Tianchen Ding <tianchen.dingtianc@alibaba-inc.com>
> Cc: Ingo Molnar <mingo@redhat.com>; Peter Zijlstra
> <peterz@infradead.org>; Juri Lelli <juri.lelli@redhat.com>; Vincent
Guittot
> <vincent.guittot@linaro.org>; Dietmar Eggemann
> <dietmar.eggemann@arm.com>; Steven Rostedt <rostedt@goodmis.org>;
> Ben Segall <bsegall@google.com>; linux-kernel <linux-
> kernel@vger.kernel.org>; ?????? <yun.wang@linux.alibaba.com>
> Subject: Re: [RFC PATCH] sched/numa: fix bug in update_task_scan_period
> 
> On Tue, Aug 11, 2020 at 04:30:31PM +0800, ????????? wrote:
> > When p->numa_faults_locality[2] > 0, numa_scan_period is doubled, but
> > this array will never be cleared, which causes scanning period always
> > reaching its max value. This patch clears numa_faults_locality after
> > numa_scan_period being doubled to fix this bug.
> >
> 
> An out label at the end of the function to clears numa_faults_locality
would
> also work with a comment explaining why.  That aside, what is the user-
> visible impact of the patch? If there are no useful faults or migration
failures,
> it makes sense that scanning is very slow until the situation changes. The
> corner case is that a migration failure might keep the scan rate slower
than it
> should be but the flip side is that fixing it might increase the scan rate
and still
> incur migration failures which introduces overhead with no gain.
> 
> --
> Mel Gorman
> SUSE Labs

