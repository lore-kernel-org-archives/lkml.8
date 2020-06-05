Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8610C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50752077D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgFERNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:13:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:62614 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgFERNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 13:13:14 -0400
IronPort-SDR: m78o2lRndsVRUxuXvV9mueNAVtBf6Su0AzxPpTyjp39kn8c3uclHFALrh0Us1QpUkCxYvV4hnY
 bQi7gYYAk3fw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 10:13:14 -0700
IronPort-SDR: 8dXeibKw9Oymx4zZCYxphg3R+QpK3j/MMW6EYOklYlz1iNt6dXs2V1i7rgC+IijYWiuL9QozSq
 vrfI0EMm/8Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,477,1583222400"; 
   d="scan'208";a="273530919"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga006.jf.intel.com with ESMTP; 05 Jun 2020 10:13:13 -0700
Date:   Fri, 5 Jun 2020 10:13:13 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oliver O'Halloran <oohall@gmail.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v10 4/6] powerpc/papr_scm: Improve error logging and
 handling papr_scm_ndctl()
Message-ID: <20200605171313.GO1505637@iweiny-DESK2.sc.intel.com>
References: <20200604234136.253703-1-vaibhav@linux.ibm.com>
 <20200604234136.253703-5-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604234136.253703-5-vaibhav@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 05:11:34AM +0530, Vaibhav Jain wrote:
> Since papr_scm_ndctl() can be called from outside papr_scm, its
> exposed to the possibility of receiving NULL as value of 'cmd_rc'
> argument. This patch updates papr_scm_ndctl() to protect against such
> possibility by assigning it pointer to a local variable in case cmd_rc
> == NULL.
> 
> Finally the patch also updates the 'default' clause of the switch-case
> block removing a 'return' statement thereby ensuring that value of
> 'cmd_rc' is always logged when papr_scm_ndctl() returns.
> 
> Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
> 
> v9..v10
> * New patch in the series

Thanks for making this a separate patch it is easier to see what is going on
here.

> ---
>  arch/powerpc/platforms/pseries/papr_scm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 0c091622b15e..6512fe6a2874 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -355,11 +355,16 @@ static int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc,
>  {
>  	struct nd_cmd_get_config_size *get_size_hdr;
>  	struct papr_scm_priv *p;
> +	int rc;
>  
>  	/* Only dimm-specific calls are supported atm */
>  	if (!nvdimm)
>  		return -EINVAL;
>  
> +	/* Use a local variable in case cmd_rc pointer is NULL */
> +	if (!cmd_rc)
> +		cmd_rc = &rc;
> +

This protects you from the NULL.  However...

>  	p = nvdimm_provider_data(nvdimm);
>  
>  	switch (cmd) {
> @@ -381,12 +386,13 @@ static int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc,
>  		break;
>  
>  	default:
> -		return -EINVAL;
> +		dev_dbg(&p->pdev->dev, "Unknown command = %d\n", cmd);
> +		*cmd_rc = -EINVAL;

... I think you are conflating rc and cmd_rc...

>  	}
>  
>  	dev_dbg(&p->pdev->dev, "returned with cmd_rc = %d\n", *cmd_rc);
>  
> -	return 0;
> +	return *cmd_rc;

... this changes the behavior of the current commands.  Now if the underlying
papr_scm_meta_[get|set]() fails you return that failure as rc rather than 0.

Is that ok?

Also 'logging cmd_rc' in the invalid cmd case does not seem quite right unless
you really want rc to be cmd_rc.

The architecture is designed to separate errors which occur in the kernel vs
errors in the firmware/dimm.  Are they always the same?  The current code
differentiates them.

Ira

>  }
>  
>  static ssize_t flags_show(struct device *dev,
> -- 
> 2.26.2
> 
