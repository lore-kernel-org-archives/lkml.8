Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A416C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB2F20884
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgGBGoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:44:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:2267 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgGBGoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:44:00 -0400
IronPort-SDR: sK27BxKgkpmISPrlVOPWObmx+4PFGybaT8u+bCESPR4u7QPASZ0ZM0sKDgRRzAfl3D/nBgQOS2
 SEIkPrWRKYRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="164869501"
X-IronPort-AV: E=Sophos;i="5.75,303,1589266800"; 
   d="scan'208";a="164869501"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 23:43:59 -0700
IronPort-SDR: rHXL0bKhROcvkEdkF2ZKwjC3xqd7t/KLFz9uDJIbOqWn8hBk9exjsQ3r0r4ETueAaQIKkKQqz6
 3f7CdnJwMwNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,303,1589266800"; 
   d="scan'208";a="425846485"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga004.jf.intel.com with ESMTP; 01 Jul 2020 23:43:57 -0700
Subject: Re: [PATCH 14/15] mmc: host: cqhci: Demote faux kerneldoc header down
 to basic comment block
To:     Lee Jones <lee.jones@linaro.org>, ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>
References: <20200701124702.908713-1-lee.jones@linaro.org>
 <20200701124702.908713-15-lee.jones@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <049e68ad-50fb-31d6-0a94-3f7c676a75e7@intel.com>
Date:   Thu, 2 Jul 2020 09:43:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200701124702.908713-15-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/07/20 3:47 pm, Lee Jones wrote:
> cqhci_host_alloc_tdl()'s function header is the only one in
> kerneldoc format.  Which seems odd as it's not part of an
> external API and isn't referenced anywhere else.  Seeing as
> there has also been no attempt to describe the expected
> function arguments either, we're going to assume that this is
> not actually a bona fide kerneldoc use-case.
> 
> Fixes the following W=1 kernel build warning:
> 
>  drivers/mmc/host/cqhci.c:163: warning: Function parameter or member 'cq_host' not described in 'cqhci_host_alloc_tdl'
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ritesh Harjani <riteshh@codeaurora.org>
> Cc: Asutosh Das <asutoshd@codeaurora.org>
> Cc: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/cqhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 75934f3c117eb..8cc277b4ffe9e 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -144,7 +144,7 @@ static void cqhci_dumpregs(struct cqhci_host *cq_host)
>  		CQHCI_DUMP(": ===========================================\n");
>  }
>  
> -/**
> +/*
>   * The allocated descriptor table for task, link & transfer descritors
>   * looks like:
>   * |----------|
> 

