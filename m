Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5E4C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A462072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgD1V6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:58:50 -0400
Received: from smtprelay0147.hostedemail.com ([216.40.44.147]:35370 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726286AbgD1V6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:58:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 2DC23181D341E;
        Tue, 28 Apr 2020 21:58:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rose21_1295f4037b114
X-Filterd-Recvd-Size: 1507
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Apr 2020 21:58:47 +0000 (UTC)
Message-ID: <d367cca3297fc07f5fc155f1e0b9b0e93c1b3cdf.camel@perches.com>
Subject: Re: [PATCH -next] perf script: remove unneeded conversion to bool
From:   Joe Perches <joe@perches.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Zou Wei <zou_wei@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Apr 2020 14:58:46 -0700
In-Reply-To: <20200428175046.GD5460@kernel.org>
References: <1587904265-865-1-git-send-email-zou_wei@huawei.com>
         <20200428175046.GD5460@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-28 at 14:50 -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Apr 26, 2020 at 08:31:05PM +0800, Zou Wei escreveu:
> > This issue was detected by using the Coccinelle software:
> > 
> > tools/perf/builtin-script.c:3285:48-53: WARNING: conversion to bool not needed here
> > tools/perf/builtin-script.c:2839:36-41: WARNING: conversion to bool not needed here
> > 
> > The conversion to bool is unneeded, remove it
> 
> Thanks, applied,

Did you read the patch?
It's broken, unless some other patch was applied.

