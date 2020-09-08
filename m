Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4003DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E7C21D46
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbgIHTS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:18:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:59407 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731142AbgIHQCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:02:52 -0400
IronPort-SDR: po/k/mVz/rKQaNpunDFGyqwHb7oftmN3x2KIS4nbF4kaHt0gr1UPXQFvpe6SXoijBbRbG+rTUl
 bDB2wMf4hAtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="145860470"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="145860470"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 07:41:11 -0700
IronPort-SDR: GwGJVhQl5LsZCtYfS7A9iPjpGOoLjIqPKg8jU0lNh+QzaUUg/j/tOkU/84RoXAzvNqvUBXGq2n
 hbejdvwrRCjQ==
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="480050658"
Received: from dpdesmon-mobl1.amr.corp.intel.com (HELO [10.212.58.192]) ([10.212.58.192])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 07:41:03 -0700
Subject: Re: [PATCH] tracing: fix double free
To:     trix@redhat.com, rostedt@goodmis.org, mingo@redhat.com,
        natechancellor@gmail.com, ndesaulniers@google.com,
        baohong.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20200907135845.15804-1-trix@redhat.com>
From:   "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Message-ID: <84df7ef3-0a36-0929-3fa9-74ab773ca12e@linux.intel.com>
Date:   Tue, 8 Sep 2020 09:41:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200907135845.15804-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On 9/7/2020 8:58 AM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analyzer reports this problem
> 
> trace_events_hist.c:3824:3: warning: Attempt to free
>    released memory
>      kfree(hist_data->attrs->var_defs.name[i]);
> 
> In parse_var_defs() if there is a problem allocating
> var_defs.expr, the earlier var_defs.name is freed.
> This free is duplicated by free_var_defs() which frees
> the rest of the list.
> 
> Because free_var_defs() has to run anyway, remove the
> second free fom parse_var_defs().
> 
> Fixes: 30350d65ac56 ("tracing: Add variable support to hist triggers")
> Signed-off-by: Tom Rix <trix@redhat.com>

Good catch, thanks for fixing this!

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>

> ---
>   kernel/trace/trace_events_hist.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 0b933546142e..1b2ef6490229 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -3865,7 +3865,6 @@ static int parse_var_defs(struct hist_trigger_data *hist_data)
>   
>   			s = kstrdup(field_str, GFP_KERNEL);
>   			if (!s) {
> -				kfree(hist_data->attrs->var_defs.name[n_vars]);
>   				ret = -ENOMEM;
>   				goto free;
>   			}
> 
