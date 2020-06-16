Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C781CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC7C4208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbgFPPxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:53:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:18167 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732872AbgFPPxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:53:31 -0400
IronPort-SDR: +GX5zpiKg9S70I6vLwu+9LKaHWE1FICZvpwX5a88odMu1LNRaOBQaDftpfDB7l72wXaQUp+wpB
 AggKvKFV2nYQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 08:53:31 -0700
IronPort-SDR: 32dYBv2owofkmcFcC7+eD2fGm3/30Ysrb7wMsXvpee2tni0E9LmWtycV6fkzvVYPdHFs1wWz6G
 BQ3nJS/V03GQ==
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="308499265"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 08:53:31 -0700
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 638986367;
        Tue, 16 Jun 2020 08:53:31 -0700 (PDT)
Date:   Tue, 16 Jun 2020 08:53:31 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] doc: x86/speculation: length of underlines
Message-ID: <20200616155331.GA28297@mtg-dev.jf.intel.com>
Reply-To: mgross@linux.intel.com
References: <20200615203645.11545-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615203645.11545-1-xypron.glpk@gmx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+1
reviewed-by: Mark Gross<mgross@linux.intel.com>

Thanks!

--mark


On Mon, Jun 15, 2020 at 10:36:45PM +0200, Heinrich Schuchardt wrote:
> The lengths of underlines must match the titles to avoid build warnings.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  .../hw-vuln/special-register-buffer-data-sampling.rst       | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst b/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
> index 47b1b3afac99..3b1ce68d2456 100644
> --- a/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
> +++ b/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
> @@ -14,7 +14,7 @@ to the core through the special register mechanism that is susceptible
>  to MDS attacks.
> 
>  Affected processors
> ---------------------
> +-------------------
>  Core models (desktop, mobile, Xeon-E3) that implement RDRAND and/or RDSEED may
>  be affected.
> 
> @@ -59,7 +59,7 @@ executed on another core or sibling thread using MDS techniques.
> 
> 
>  Mitigation mechanism
> --------------------
> +--------------------
>  Intel will release microcode updates that modify the RDRAND, RDSEED, and
>  EGETKEY instructions to overwrite secret special register data in the shared
>  staging buffer before the secret data can be accessed by another logical
> @@ -118,7 +118,7 @@ with the option "srbds=".  The option for this is:
>    ============= =============================================================
> 
>  SRBDS System Information
> ------------------------
> +------------------------
>  The Linux kernel provides vulnerability status information through sysfs.  For
>  SRBDS this can be accessed by the following sysfs file:
>  /sys/devices/system/cpu/vulnerabilities/srbds
> --
> 2.27.0
> 
