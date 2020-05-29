Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5970BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40CDC2077D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgE2S2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:28:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:54409 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgE2S2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:28:03 -0400
IronPort-SDR: OvALlU9qycgr62Y9E05QvTQMBw5aube7SZbY1E/htnwegBjFlG29obN/xro5ycTcaSVNYkkuAV
 BAc9QJi1JDyg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 11:28:02 -0700
IronPort-SDR: OnGxUWz/W+brZ8Z3zLKT0VmMfeD5jfx66oT9F6hM9qLWxAOicxcxROTsAO89g//A/fVEmLBzrQ
 ZE50sqzwZW7w==
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; 
   d="scan'208";a="267645129"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.20.190]) ([10.251.20.190])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 11:28:01 -0700
Subject: Re: [PATCH] x86/resctrl: fix a NULL vs IS_ERR() static checker
 warning
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200529122744.GA1217265@mwanda>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <e27321cb-293e-7919-33fe-ad8381cd9993@intel.com>
Date:   Fri, 29 May 2020 11:28:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529122744.GA1217265@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 5/29/2020 5:27 AM, Dan Carpenter wrote:
> The callers don't expect *d_cdp to be set to an error pointer, they only
> check for NULL.  This leads to a static checker warning:
> 
>     arch/x86/kernel/cpu/resctrl/rdtgroup.c:2648 __init_one_rdt_domain()
>     warn: 'd_cdp' could be an error pointer
> 
> I don't think this will lead to a real life bug, but it's easy enough to
> change it to be NULL.

Using "I don't think" could be a bit vague to the reader. It could be
changed to:

"This would not trigger a bug in this specific case because
__init_one_rdt_domain() calls it with a valid domain that would not have
a negative id and thus not trigger the return of the ERR_PTR(). If this
was a negative domain id then the call to rdt_find_domain() in
domain_add_cpu() would have returned the ERR_PTR() much earlier and the
creation of the domain with an invalid id would have been prevented.

Even though a bug is not triggered currently the right and safe thing to
do is to set the pointer to NULL because that is what can be checked for
when the caller is handling the CDP and non-CDP cases."


> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 23b4b61319d3f..3f844f14fc0a6 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1117,6 +1117,7 @@ static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
>  	_d_cdp = rdt_find_domain(_r_cdp, d->id, NULL);
>  	if (WARN_ON(IS_ERR_OR_NULL(_d_cdp))) {
>  		_r_cdp = NULL;
> +		_d_cdp = NULL;
>  		ret = -EINVAL;
>  	}
>  
> 


The below fixes tag may be helpful:
Fixes: 52eb74339a62 ("x86/resctrl: Fix rdt_find_domain() return value
and checks")

Thank you very much for catching this and sending a fix. I just have the
commit message comments, apart from that the your fix looks good to me.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
