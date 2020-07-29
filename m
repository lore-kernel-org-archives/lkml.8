Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EBDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F412075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgG2R5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 13:57:06 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:56472 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG2R5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 13:57:06 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9FB3172CCDC;
        Wed, 29 Jul 2020 20:57:04 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 83A2B4A5036;
        Wed, 29 Jul 2020 20:57:04 +0300 (MSK)
Date:   Wed, 29 Jul 2020 20:57:04 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        peterz@infradead.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: Should perf version match kernel version?
Message-ID: <20200729175704.gsbh4gkbqxas5j2t@altlinux.org>
References: <20200729155647.xte33krus3mak3wu@altlinux.org>
 <20200729160220.GB2655@hirez.programming.kicks-ass.net>
 <7CEC30D2-0C1E-4E88-A1D2-35C121EB1013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <7CEC30D2-0C1E-4E88-A1D2-35C121EB1013@gmail.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, Arnaldo,

On Wed, Jul 29, 2020 at 01:27:32PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> 
> On July 29, 2020 1:02:20 PM GMT-03:00, peterz@infradead.org wrote:
> >On Wed, Jul 29, 2020 at 06:56:47PM +0300, Vitaly Chikunov wrote:
> >> Hi,
> >> 
> >> It seems that most distros try to have perf version to match with
> >> running kernel version. Is is requirement? Would it be better to have
> >> single perf from kernel mainline to work with any (older) kernel
> >> version?
> >> 
> >> We have different kernel versions in ALT Linux (stable for 4.19, 5.4,
> >> and 5.7) and I want to understand if we should have three perfs or
> >> single package will be enough.
> >
> >We strive to have it all compatible, older perf should work on newer
> >kernel and newer perf should work on older kernel.
> >
> >How well it's all tested is another.
> >
> >Personally I often use a very old perf.
> 
> Yeah, never was a requirement, if you find some problem using a new perf on an old kernel or the other way around, please report.

That's great to know. Thanks for the answers!

