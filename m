Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E325AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FD3206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgFBVVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:21:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:40557 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgFBVVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:21:24 -0400
IronPort-SDR: 6fGXS/pnLWMV21RalINYW+IijYIz9gaCOCZRaPw+N3BgUy5bc6yf87J0jW9WS7bngNxJwxfSVA
 O8E5AG0n/BIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 14:21:23 -0700
IronPort-SDR: EEhUn07lmi4P8XEIms+7mISCZo6Hbipu2OAakqiDzCXegZjKU3IFYy+VS8AuKGL1yBiwXGfZhF
 J37NFW7669zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,465,1583222400"; 
   d="scan'208";a="257242816"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jun 2020 14:21:23 -0700
Date:   Tue, 2 Jun 2020 14:21:23 -0700
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
Subject: Re: [RESEND PATCH v9 1/5] powerpc: Document details on H_SCM_HEALTH
 hcall
Message-ID: <20200602212122.GB1676657@iweiny-DESK2.sc.intel.com>
References: <20200602101438.73929-1-vaibhav@linux.ibm.com>
 <20200602101438.73929-2-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602101438.73929-2-vaibhav@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 03:44:34PM +0530, Vaibhav Jain wrote:
> Add documentation to 'papr_hcalls.rst' describing the bitmap flags
> that are returned from H_SCM_HEALTH hcall as per the PAPR-SCM
> specification.
> 
> Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ira Weiny <ira.weiny@intel.com>

Acked-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
> 
> Resend:
> * None
> 
> v8..v9:
> * s/SCM/PMEM device. [ Dan Williams, Aneesh ]
> 
> v7..v8:
> * Added a clarification on bit-ordering of Health Bitmap
> 
> Resend:
> * None
> 
> v6..v7:
> * None
> 
> v5..v6:
> * New patch in the series
> ---
>  Documentation/powerpc/papr_hcalls.rst | 46 ++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/powerpc/papr_hcalls.rst b/Documentation/powerpc/papr_hcalls.rst
> index 3493631a60f8..48fcf1255a33 100644
> --- a/Documentation/powerpc/papr_hcalls.rst
> +++ b/Documentation/powerpc/papr_hcalls.rst
> @@ -220,13 +220,51 @@ from the LPAR memory.
>  **H_SCM_HEALTH**
>  
>  | Input: drcIndex
> -| Out: *health-bitmap, health-bit-valid-bitmap*
> +| Out: *health-bitmap (r4), health-bit-valid-bitmap (r5)*
>  | Return Value: *H_Success, H_Parameter, H_Hardware*
>  
>  Given a DRC Index return the info on predictive failure and overall health of
> -the NVDIMM. The asserted bits in the health-bitmap indicate a single predictive
> -failure and health-bit-valid-bitmap indicate which bits in health-bitmap are
> -valid.
> +the PMEM device. The asserted bits in the health-bitmap indicate one or more states
> +(described in table below) of the PMEM device and health-bit-valid-bitmap indicate
> +which bits in health-bitmap are valid. The bits are reported in
> +reverse bit ordering for example a value of 0xC400000000000000
> +indicates bits 0, 1, and 5 are valid.
> +
> +Health Bitmap Flags:
> +
> ++------+-----------------------------------------------------------------------+
> +|  Bit |               Definition                                              |
> ++======+=======================================================================+
> +|  00  | PMEM device is unable to persist memory contents.                     |
> +|      | If the system is powered down, nothing will be saved.                 |
> ++------+-----------------------------------------------------------------------+
> +|  01  | PMEM device failed to persist memory contents. Either contents were   |
> +|      | not saved successfully on power down or were not restored properly on |
> +|      | power up.                                                             |
> ++------+-----------------------------------------------------------------------+
> +|  02  | PMEM device contents are persisted from previous IPL. The data from   |
> +|      | the last boot were successfully restored.                             |
> ++------+-----------------------------------------------------------------------+
> +|  03  | PMEM device contents are not persisted from previous IPL. There was no|
> +|      | data to restore from the last boot.                                   |
> ++------+-----------------------------------------------------------------------+
> +|  04  | PMEM device memory life remaining is critically low                   |
> ++------+-----------------------------------------------------------------------+
> +|  05  | PMEM device will be garded off next IPL due to failure                |
> ++------+-----------------------------------------------------------------------+
> +|  06  | PMEM device contents cannot persist due to current platform health    |
> +|      | status. A hardware failure may prevent data from being saved or       |
> +|      | restored.                                                             |
> ++------+-----------------------------------------------------------------------+
> +|  07  | PMEM device is unable to persist memory contents in certain conditions|
> ++------+-----------------------------------------------------------------------+
> +|  08  | PMEM device is encrypted                                              |
> ++------+-----------------------------------------------------------------------+
> +|  09  | PMEM device has successfully completed a requested erase or secure    |
> +|      | erase procedure.                                                      |
> ++------+-----------------------------------------------------------------------+
> +|10:63 | Reserved / Unused                                                     |
> ++------+-----------------------------------------------------------------------+
>  
>  **H_SCM_PERFORMANCE_STATS**
>  
> -- 
> 2.26.2
> 
