Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA8DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C325A206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgFKQzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:55:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:20679 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgFKQzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 12:55:03 -0400
IronPort-SDR: YCWyZyaPZQ599GCvFlLqHyxboK0SlZ7tTye9/jNG0nuPLhCZ7dmvNeTi44LX2alogPsueBeQhM
 hc415sJ4azCw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 09:55:02 -0700
IronPort-SDR: Ef2XuKghJgE8L6SfyU+0HSf0iDCJCNDtGYczQaweh33FbW/8yzebkcQeuiy1853rMx+NurZF3k
 fR4zNmXm54FA==
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; 
   d="scan'208";a="419166114"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 09:55:02 -0700
Date:   Thu, 11 Jun 2020 09:55:00 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH] x86/mce: fix a wrong assignment of i_mce.status
Message-ID: <20200611165500.GA3503@agluck-desk2.amr.corp.intel.com>
References: <20200611023238.3830-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611023238.3830-1-zhenzhong.duan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Yazen

On Thu, Jun 11, 2020 at 10:32:38AM +0800, Zhenzhong Duan wrote:
> The original code is a nop as i_mce.status is or'ed with part of itself,
> fix it.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> ---
>  arch/x86/kernel/cpu/mce/inject.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
> index 3413b41..dc28a61 100644
> --- a/arch/x86/kernel/cpu/mce/inject.c
> +++ b/arch/x86/kernel/cpu/mce/inject.c
> @@ -511,7 +511,7 @@ static void do_inject(void)
>  	 */
>  	if (inj_type == DFR_INT_INJ) {
>  		i_mce.status |= MCI_STATUS_DEFERRED;
> -		i_mce.status |= (i_mce.status & ~MCI_STATUS_UC);
> +		i_mce.status &= ~MCI_STATUS_UC;

Boris: "git blame" says you wrote this code. Patch looks right (in
that it makes the code do what the comment just above says it is trying
to do):

         * - MCx_STATUS[UC] cleared: deferred errors are _not_ UC

But this is AMD specific, so I'll defer judgement

-Tony
