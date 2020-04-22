Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FE4C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA04320575
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgDVAWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:22:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:1638 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgDVAWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:22:11 -0400
IronPort-SDR: t0dZwvw70O8a96s/2znUoZHIcw0rUUMG15J+lagSXsXxrqvaj33n7mfvJWndcAp7UJmzuvkbw6
 hW/85+G6/4wg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 17:22:10 -0700
IronPort-SDR: ioLFI8Oies2tQceQHW5FhAPYccVYMPIQHLf3JYSTRcwhME9BmtM4uU0ts/eYrleZot+mcxiBVm
 K2j+PvoAXFuw==
X-IronPort-AV: E=Sophos;i="5.72,412,1580803200"; 
   d="scan'208";a="402360242"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.142.125])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 17:22:10 -0700
Message-ID: <ec43c672a4a98729ee011f89168ec68d3d5185f5.camel@linux.intel.com>
Subject: Re: [PATCH] intel-speed-select: Fix
 speed-select-base-freq-properties output on CLX-N
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org
Date:   Tue, 21 Apr 2020 17:22:09 -0700
In-Reply-To: <20200420141054.26173-1-prarit@redhat.com>
References: <20200420141054.26173-1-prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-20 at 10:10 -0400, Prarit Bhargava wrote:
> On CLX-N, the perf-profile-level's output is terminated before the
> speed-select-base-freq-properties are output which results in a
> corrupt
> json file.
> 
> Adjust the output of speed-select-base-freq-properties by one on CLX-
> N.
Applied.

Thanks,
Srinivas

> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: platform-driver-x86@vger.kernel.org
> ---
>  tools/power/x86/intel-speed-select/isst-display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/x86/intel-speed-select/isst-display.c
> b/tools/power/x86/intel-speed-select/isst-display.c
> index 51dbaa5f02ec..f6e2ce181123 100644
> --- a/tools/power/x86/intel-speed-select/isst-display.c
> +++ b/tools/power/x86/intel-speed-select/isst-display.c
> @@ -470,7 +470,7 @@ void isst_ctdp_display_information(int cpu, FILE
> *outf, int tdp_level,
>  				_isst_pbf_display_information(cpu,
> outf,
>  							      tdp_level
> ,
>  							  &ctdp_level-
> >pbf_info,
> -							      level +
> 1);
> +							      level +
> 2);
>  			continue;
>  		}
>  

