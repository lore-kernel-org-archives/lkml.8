Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B70C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDC92078C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbgDAPTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:19:51 -0400
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:44396 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732504AbgDAPTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:19:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id E5210180238C3;
        Wed,  1 Apr 2020 15:19:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: plane54_3880c5014bc02
X-Filterd-Recvd-Size: 2018
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed,  1 Apr 2020 15:19:48 +0000 (UTC)
Message-ID: <9de4fb8fa1223fc61d6d8d8c41066eea3963c12e.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Warn about data_race() without comment
From:   Joe Perches <joe@perches.com>
To:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, apw@canonical.com,
        Will Deacon <will@kernel.org>
Date:   Wed, 01 Apr 2020 08:17:52 -0700
In-Reply-To: <20200401101714.44781-1-elver@google.com>
References: <20200401101714.44781-1-elver@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-01 at 12:17 +0200, Marco Elver wrote:
> Warn about applications of data_race() without a comment, to encourage
> documenting the reasoning behind why it was deemed safe.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5833,6 +5833,14 @@ sub process {
>  			}
>  		}
>  
> +# check for data_race without a comment.
> +		if ($line =~ /\bdata_race\s*\(/) {
> +			if (!ctx_has_comment($first_line, $linenr)) {
> +				WARN("DATA_RACE",
> +				     "data_race without comment\n" . $herecurr);
> +			}
> +		}
> +
>  # check for smp_read_barrier_depends and read_barrier_depends
>  		if (!$file && $line =~ /\b(smp_|)read_barrier_depends\s*\(/) {
>  			WARN("READ_BARRIER_DEPENDS",

Sensible enough but it looks like ctx_has_comment should
be updated to allow c99 comments too, but that should be
a separate change from this patch.

Otherwise, this style emits a message:

WARNING: data_race without comment
#135: FILE: kernel/rcu/tasks.h:135:
+	int i = data_race(rtp->gp_state); // Let KCSAN detect update races

