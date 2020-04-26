Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71D6C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 20:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6D020700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 20:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDZU7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 16:59:40 -0400
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:37848 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726188AbgDZU7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 16:59:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 47561837F27B;
        Sun, 26 Apr 2020 20:59:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: night17_711ecb5664713
X-Filterd-Recvd-Size: 2026
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Apr 2020 20:59:37 +0000 (UTC)
Message-ID: <93994350620b4809e515c295c55ed23aceb9c3a0.camel@perches.com>
Subject: Re: [PATCH -next] perf script: remove unneeded conversion to bool
From:   Joe Perches <joe@perches.com>
To:     Zou Wei <zou_wei@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Sun, 26 Apr 2020 13:59:36 -0700
In-Reply-To: <1587904265-865-1-git-send-email-zou_wei@huawei.com>
References: <1587904265-865-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-04-26 at 20:31 +0800, Zou Wei wrote:
> This issue was detected by using the Coccinelle software:
> 
> tools/perf/builtin-script.c:3285:48-53: WARNING: conversion to bool not needed here
> tools/perf/builtin-script.c:2839:36-41: WARNING: conversion to bool not needed here
> 
> The conversion to bool is unneeded, remove it
[]
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
[]
> @@ -2836,7 +2836,7 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
>  				break;
>  		}
>  		if (i == imax && strcmp(tok, "flags") == 0) {
> -			print_flags = change == REMOVE ? false : true;
> +			print_flags = change == REMOVE;

Read the deleted code above this again.

(you have inverted the logic)

>  			continue;
>  		}
>  		if (i == imax) {
> @@ -3282,7 +3282,7 @@ static char *get_script_path(const char *script_root, const char *suffix)
>  
>  static bool is_top_script(const char *script_path)
>  {
> -	return ends_with(script_path, "top") == NULL ? false : true;
> +	return ends_with(script_path, "top") == NULL;

and here.


