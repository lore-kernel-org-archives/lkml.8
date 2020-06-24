Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557FEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30C4B206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388811AbgFXFPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:15:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:47644 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgFXFPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:15:30 -0400
IronPort-SDR: 660xc90y3KVV4bLk+hZm/6SVFFd75CoQ9JIwT2wFmAi7Fsth3WMpf6delxqwyG/gA1sOlLV1t1
 GQUFulAsbQQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="162419109"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="162419109"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 22:15:29 -0700
IronPort-SDR: /Dt28ta8rN+tZIFIxUGmlX1VPGaRWT9vksDFxOabvmB8rrnT9glL1nmSXUdQdyvGojTsAd71jw
 9LiSq+fYg92A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="319347138"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2020 22:15:29 -0700
Date:   Tue, 23 Jun 2020 22:15:29 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libnvdimm/security: Fix key lookup permissions
Message-ID: <20200624051529.GC2617015@iweiny-DESK2.sc.intel.com>
References: <159297332630.1304143.237026690015653759.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159297332630.1304143.237026690015653759.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 09:35:26PM -0700, Dan Williams wrote:
> As of commit 8c0637e950d6 ("keys: Make the KEY_NEED_* perms an enum rather
> than a mask") lookup_user_key() needs an explicit declaration of what it
> wants to do with the key. Add KEY_NEED_SEARCH to fix a warning with the
> below signature, and fixes the inability to retrieve a key.
> 
>     WARNING: CPU: 15 PID: 6276 at security/keys/permission.c:35 key_task_permission+0xd3/0x140
>     [..]
>     RIP: 0010:key_task_permission+0xd3/0x140
>     [..]
>     Call Trace:
>      lookup_user_key+0xeb/0x6b0
>      ? vsscanf+0x3df/0x840
>      ? key_validate+0x50/0x50
>      ? key_default_cmp+0x20/0x20
>      nvdimm_get_user_key_payload.part.0+0x21/0x110 [libnvdimm]
>      nvdimm_security_store+0x67d/0xb20 [libnvdimm]
>      security_store+0x67/0x1a0 [libnvdimm]
>      kernfs_fop_write+0xcf/0x1c0
>      vfs_write+0xde/0x1d0
>      ksys_write+0x68/0xe0
>      do_syscall_64+0x5c/0xa0
>      entry_SYSCALL_64_after_hwframe+0x49/0xb3
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Suggested-by: David Howells <dhowells@redhat.com>
> Fixes: 8c0637e950d6 ("keys: Make the KEY_NEED_* perms an enum rather than a mask")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/nvdimm/security.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index 89b85970912d..4cef69bd3c1b 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -95,7 +95,7 @@ static struct key *nvdimm_lookup_user_key(struct nvdimm *nvdimm,
>  	struct encrypted_key_payload *epayload;
>  	struct device *dev = &nvdimm->dev;
>  
> -	keyref = lookup_user_key(id, 0, 0);
> +	keyref = lookup_user_key(id, 0, KEY_NEED_SEARCH);
>  	if (IS_ERR(keyref))
>  		return NULL;
>  
> 
