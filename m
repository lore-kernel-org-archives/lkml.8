Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77A8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8537A207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TYqT8GKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgESPjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 11:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgESPjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:39:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009EAC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 08:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Aa9gF0hDhcPwg63zlVfnviiqmzwslNvVPcnx2YFTytA=; b=TYqT8GKOoN0wLlBBymPjw/5+YN
        /1xXDv2Ropz+PJ4l4dHuQVH14ACICh4pMthZzFd1AuC56uYZQ3BaESj9LAVIgrG8qyPo3lYTBTRB/
        J2WwNFNJrLkRtT0eI43AM3NLSi+u3rmUeqirED0rTEUVKdjeSRb2+vtDhVUE3TNbKhOEx/YghAPai
        ypUhCemSb7ZW+ePbaswZ4OUUU3dI4NlvEO7YUofV5TPshkBmij5EPfZv/rqc2DvIr6Nt9gv92n1mP
        e9FoygA7Y98vxvvOpKYYfFkos24ctGIct8Hgg7jUCrcXYn/g6dahwDU59uDiymGfZrbXlG0ZWO3ok
        f/IYierA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb4LO-00010w-BL; Tue, 19 May 2020 15:39:50 +0000
Subject: Re: [PATCH v2 4/4] arch/x86: Add L1D flushing Documentation
To:     Balbir Singh <sblbir@amazon.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, tony.luck@intel.com, keescook@chromium.org,
        benh@kernel.crashing.org, x86@kernel.org, dave.hansen@intel.com
References: <20200406031946.11815-1-sblbir@amazon.com>
 <20200406031946.11815-5-sblbir@amazon.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5def424d-c7d5-c6fa-60b9-363f6bca6bc6@infradead.org>
Date:   Tue, 19 May 2020 08:39:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200406031946.11815-5-sblbir@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

Comments below. Sorry about the delay.

On 4/5/20 8:19 PM, Balbir Singh wrote:
> Add documentation of l1d flushing, explain the need for the
> feature and how it can be used.
> 
> Signed-off-by: Balbir Singh <sblbir@amazon.com>
> ---
>  Documentation/admin-guide/hw-vuln/index.rst   |  1 +
>  .../admin-guide/hw-vuln/l1d_flush.rst         | 40 +++++++++++++++++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 Documentation/admin-guide/hw-vuln/l1d_flush.rst

> diff --git a/Documentation/admin-guide/hw-vuln/l1d_flush.rst b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
> new file mode 100644
> index 000000000000..73ee9e491a74
> --- /dev/null
> +++ b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
> @@ -0,0 +1,40 @@
> +L1D Flushing for the paranoid
> +=============================
> +
> +With an increasing number of vulnerabilities being reported around data
> +leaks from L1D, a new user space mechanism to flush the L1D cache on
> +context switch is added to the kernel. This should help address
> +CVE-2020-0550 and for paranoid applications, keep them safe from any
> +yet to be discovered vulnerabilities, related to leaks from the L1D
> +cache.
> +
> +Tasks can opt in to this mechanism by using an architecture specific
> +prctl (x86 only at the moment).
> +
> +Related CVES

           CVEs

> +------------
> +At the present moment, the following CVEs can be addressed by this
> +mechanism
> +
> +    =============       ========================     ==================
> +    CVE-2020-0550       Improper Data Forwarding     OS related aspects
> +    =============       ========================     ==================
> +
> +Usage Guidelines
> +----------------
> +Applications can call ``arch_prctl(2)`` with one of these two arguments

end above sentence with period or colon (colon might require the following
bullet items to be indented -- I'm not sure about that).

> +
> +1. ARCH_SET_L1D_FLUSH - flush the L1D cache on context switch (out)
> +2. ARCH_GET_L1D_FLUSH - get the current state of the L1D cache flush, returns 1
> +   if set and 0 if not set.
> +
> +**NOTE**: The feature is disabled by default, applications to need to specifically

                                        default; applications need to

> +opt into the feature to enable it.
> +
> +Mitigation
> +----------
> +When ARCH_SET_L1D_FLUSH is enabled for a task, on switching tasks (when
> +the address space changes), a flush of the L1D cache is performed for
> +the task when it leaves the CPU. If the underlying CPU supports L1D
> +flushing in hardware, the hardware mechanism is used, otherwise a software
> +fallback, similar to the mechanism used by L1TF is used.
> 

thanks.
-- 
~Randy

