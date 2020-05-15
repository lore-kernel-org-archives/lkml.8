Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7EBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4DE20727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgEOT6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 15:58:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:43089 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgEOT6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 15:58:02 -0400
IronPort-SDR: b93uiDPD0nDgqf4jbObbnUGE19reamiSAVoxZ0geDA3xK5i31cYq0/6nDK6TXS9NNkERcwmU8B
 iz+ml8MA+9tQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 12:58:02 -0700
IronPort-SDR: bMcy2/ab4q9wsRnUBLnsKTHVlFjku/UqAiSmwHpDjtMcKcCvi7GWo3MOSlIZOSZa7BdUpFx2Kd
 +kY9guWBgWTQ==
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; 
   d="scan'208";a="464838181"
Received: from spandruv-mobl.amr.corp.intel.com ([10.212.76.184])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 12:58:01 -0700
Message-ID: <6eb0773d64cd5a4e25ca6d1c78c9c3ed7d190f46.camel@linux.intel.com>
Subject: Re: [PATCH] intel-speed-select: Fix json perf-profile output output
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org
Date:   Fri, 15 May 2020 12:58:01 -0700
In-Reply-To: <20200511190628.25661-1-prarit@redhat.com>
References: <20200511190628.25661-1-prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-11 at 15:06 -0400, Prarit Bhargava wrote:

I prefer prefix as: "tools/power/x86/intel-speed-select" instead of
just "intel-speed-select". 

Fixed and applied.

Thanks,
Srinivas

> The 'intel-speed-select -f json perf-profile get-lock-status' command
> outputs the package, die, and cpu data as separate fields.
> 
> ex)
> 
>   "package-0": {
>     "die-0": {
>       "cpu-0": {
> 
> Commit 74062363f855 ("tools/power/x86/intel-speed-select: Avoid
> duplicate Package strings for json") prettied this output so that it
> is a single line for
> some json output commands and the same should be done for other
> commands.
> 
> Output package, die, and cpu info in a single line when using json
> output.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: platform-driver-x86@vger.kernel.org
> ---
>  .../x86/intel-speed-select/isst-display.c     | 26 +++++++++++++--
> ----
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/power/x86/intel-speed-select/isst-display.c
> b/tools/power/x86/intel-speed-select/isst-display.c
> index f6e2ce181123..e105fece47b6 100644
> --- a/tools/power/x86/intel-speed-select/isst-display.c
> +++ b/tools/power/x86/intel-speed-select/isst-display.c
> @@ -316,21 +316,31 @@ void isst_ctdp_display_core_info(int cpu, FILE
> *outf, char *prefix,
>  {
>  	char header[256];
>  	char value[256];
> +	int level = 1;
> +
> +	if (out_format_is_json()) {
> +		snprintf(header, sizeof(header), "package-%d:die-
> %d:cpu-%d",
> +			 get_physical_package_id(cpu),
> get_physical_die_id(cpu),
> +			 cpu);
> +		format_and_print(outf, level++, header, NULL);
> +	} else {
> +		snprintf(header, sizeof(header), "package-%d",
> +			 get_physical_package_id(cpu));
> +		format_and_print(outf, level++, header, NULL);
> +		snprintf(header, sizeof(header), "die-%d",
> +			 get_physical_die_id(cpu));
> +		format_and_print(outf, level++, header, NULL);
> +		snprintf(header, sizeof(header), "cpu-%d", cpu);
> +		format_and_print(outf, level++, header, NULL);
> +	}
>  
> -	snprintf(header, sizeof(header), "package-%d",
> -		 get_physical_package_id(cpu));
> -	format_and_print(outf, 1, header, NULL);
> -	snprintf(header, sizeof(header), "die-%d",
> get_physical_die_id(cpu));
> -	format_and_print(outf, 2, header, NULL);
> -	snprintf(header, sizeof(header), "cpu-%d", cpu);
> -	format_and_print(outf, 3, header, NULL);
>  	if (str0 && !val)
>  		snprintf(value, sizeof(value), "%s", str0);
>  	else if (str1 && val)
>  		snprintf(value, sizeof(value), "%s", str1);
>  	else
>  		snprintf(value, sizeof(value), "%u", val);
> -	format_and_print(outf, 4, prefix, value);
> +	format_and_print(outf, level, prefix, value);
>  
>  	format_and_print(outf, 1, NULL, NULL);
>  }

