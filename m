Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F89C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE0452075E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgEFXzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 19:55:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:35789 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgEFXzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 19:55:12 -0400
IronPort-SDR: KalZq54Oz8cpvJ54mgz0aB6PhEHsrWGqnyP86TSIWP55PU7Yc+lRWWEk8fAVh7IBB9jbp/Ls4U
 yZgQ2YgXEldA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 16:55:12 -0700
IronPort-SDR: 8uV+o9DMkbRCZJrfBMeresfQg4ugxP9wEo7+afyPb5zb+Mf7wiEi2GQu4UhXM1rCL/qfOU/rhM
 k2FNqT33HigA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; 
   d="scan'208";a="260348959"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [10.212.25.49]) ([10.212.25.49])
  by orsmga003.jf.intel.com with ESMTP; 06 May 2020 16:55:11 -0700
Subject: Re: [PATCH v2] checkpatch: add GENL_SET_ERR_MSG et al. to 80 column
 exceptions
To:     linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
References: <20200506235327.3878021-1-jacob.e.keller@intel.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <52137a35-1b41-866e-5ac4-22859f198d53@intel.com>
Date:   Wed, 6 May 2020 16:55:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506235327.3878021-1-jacob.e.keller@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/6/2020 4:53 PM, Jacob Keller wrote:
> The GENL_SET_ERR_MSG, NL_SET_ERR_MSG, and NL_SET_ERR_MSG_MOD macros are
> used to report a string describing a specific error to userspace.
> 
> Often, these strings can exceed the normal 80 column limit. However,
> just like with strings printed to the kernel log, it is preferred to
> keep these on a single line.
> 
> Add these macros to the logFunctions exception list in checkpatch.pl
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>

Joe, Jakub,

I will also be sending a patch to fix the newlines in uses of
NL_SET_ERR_MSG_MOD, but since they all appear to be in net drivers, I
think it should go through the netdev list.

Thanks,
Jake

> ---
> Changes since v1:
> * add GENL_SET_ERR_MSG to the list
> * Reword the commit message slightly
> 
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index eac40f0abd56..818a5b21587d 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -471,6 +471,7 @@ our $logFunctions = qr{(?x:
>  	WARN(?:_RATELIMIT|_ONCE|)|
>  	panic|
>  	MODULE_[A-Z_]+|
> +	GENL_SET_ERR_MSG|NL_SET_ERR_MSG|NL_SET_ERR_MSG_MOD|
>  	seq_vprintf|seq_printf|seq_puts
>  )};
>  
> 
