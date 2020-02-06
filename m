Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34480C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 04:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0427621775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 04:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgBFE2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 23:28:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:12764 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbgBFE2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 23:28:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 20:28:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,408,1574150400"; 
   d="scan'208";a="225157132"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga007.fm.intel.com with ESMTP; 05 Feb 2020 20:28:11 -0800
Date:   Wed, 5 Feb 2020 20:28:11 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] percpu_ref: Fix comment regarding percpu_ref_init flags
Message-ID: <20200206042810.GA29917@iweiny-DESK2.sc.intel.com>
References: <20191209215420.19157-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209215420.19157-1-ira.weiny@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 01:54:20PM -0800, 'Ira Weiny' wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The comment for percpu_ref_init() implies that using
> PERCPU_REF_ALLOW_REINIT will cause the refcount to start at 0.  But
> this is not true.  PERCPU_REF_ALLOW_REINIT starts the count at 1 as
> if the flags were zero.  Add this fact to the kernel doc comment.

Did this get picked up?  Or am I wrong in the comment?

Ira

> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  lib/percpu-refcount.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
> index 4f6c6ebbbbde..48d7fcff70b6 100644
> --- a/lib/percpu-refcount.c
> +++ b/lib/percpu-refcount.c
> @@ -50,9 +50,9 @@ static unsigned long __percpu *percpu_count_ptr(struct percpu_ref *ref)
>   * @flags: PERCPU_REF_INIT_* flags
>   * @gfp: allocation mask to use
>   *
> - * Initializes @ref.  If @flags is zero, @ref starts in percpu mode with a
> - * refcount of 1; analagous to atomic_long_set(ref, 1).  See the
> - * definitions of PERCPU_REF_INIT_* flags for flag behaviors.
> + * Initializes @ref.  If @flags is zero or PERCPU_REF_ALLOW_REINIT, @ref starts
> + * in percpu mode with a refcount of 1; analagous to atomic_long_set(ref, 1).
> + * See the definitions of PERCPU_REF_INIT_* flags for flag behaviors.
>   *
>   * Note that @release must not sleep - it may potentially be called from RCU
>   * callback context by percpu_ref_kill().
> -- 
> 2.21.0
> 
