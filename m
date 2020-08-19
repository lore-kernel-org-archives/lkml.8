Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE7BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2442207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgHSVCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:02:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:29543 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgHSVCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:02:39 -0400
IronPort-SDR: VoSWgiOfmsgktYujjmhu2NltbWaDAvItNfcIuPb2MBbPyDvIj8Qrl7e8J1XzLJto0EjcdIF3gd
 4qBo0OgUj4IA==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="154460071"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="154460071"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 14:02:38 -0700
IronPort-SDR: 0Yqr6WirhGtPp3nZaOvCaw5me76ITpDhOkoyNUDuA/FxcM+wT0Ov/0tZW5UsLLVLCJ/g6dBFLw
 qkVfa5iVxYfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="472380103"
Received: from pbooyens-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.52.107])
  by orsmga005.jf.intel.com with ESMTP; 19 Aug 2020 14:02:35 -0700
Date:   Thu, 20 Aug 2020 00:02:34 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Coly Li <colyli@suse.de>
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v3] docs: trusted-encrypted.rst: update parameters for
 command examples
Message-ID: <20200819210234.GB9942@linux.intel.com>
References: <20200818170002.38145-1-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818170002.38145-1-colyli@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 01:00:02AM +0800, Coly Li wrote:
> The parameters in command examples for tpm2_createprimary and
> tpm2_evictcontrol are outdated, people (like me) are not able to create
> trusted key by these command examples.
> 
> This patch updates the parameters of command example tpm2_createprimary
> and tpm2_evictcontrol in trusted-encrypted.rst. With Linux kernel v5.8
> and tpm2-tools-4.1, people can create a trusted key by following the
> examples in this document.
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: James Bottomley <jejb@linux.ibm.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Stefan Berger <stefanb@linux.ibm.com>

OK, now it is clear. Thank you.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

> ---
> Changelog:
> v3: update commit log with review comments from Jarkko Sakkinen. 
> v2: remove the change of trusted key related operation.
> v1: initial version.
> 
>  Documentation/security/keys/trusted-encrypted.rst | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index 9483a7425ad5..1da879a68640 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -39,10 +39,9 @@ With the IBM TSS 2 stack::
>  
>  Or with the Intel TSS 2 stack::
>  
> -  #> tpm2_createprimary --hierarchy o -G rsa2048 -o key.ctxt
> +  #> tpm2_createprimary --hierarchy o -G rsa2048 -c key.ctxt
>    [...]
> -  handle: 0x800000FF
> -  #> tpm2_evictcontrol -c key.ctxt -p 0x81000001
> +  #> tpm2_evictcontrol -c key.ctxt 0x81000001
>    persistentHandle: 0x81000001
>  
>  Usage::
> -- 
> 2.26.2
> 
