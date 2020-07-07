Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E78C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78AC7206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594122900;
	bh=wJlrCzG4qh5OvTGkXxyvY/7JXDN1JNDLwLoVLA++wdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ia/6CN8KV/mW8epp18+P7k2/lcnbTnoxFrKzvMLx2p6YW0G/UizDtAPWGiEa1YqPQ
	 KRTaU3ZzRiMjBU0118sPPTfjZ28m/+dAGjpCwbGiA7wvStd6DDgR2omrcdU6aaWLIH
	 +3WNEP873oUjm4J08zW+QRirXDJb/mhEXepMD3RI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgGGLy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:54:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33758 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGLy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:54:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id f18so36771313wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PaBT0lPoXs7IdlUtnsvP+VH1DgYh/P2jJzUAU6vUbNU=;
        b=Q13pbxrcK+HRySyiIEDZQ+mZ946lf6+CjB/a9Z/edBxh6JsEdU9bpVxEom0ZATA678
         uAhMOLPQucWlV3BsWGacu3uY2n7iFWN5PvrjqMblS/MNTs0nTY2JnGBwenehidtSTBaG
         KMY9yz7pNCY2X79KMqiueyRMe2t5l8tb8XoAOjbSS1z4kp6mlun2nmoiaX7x47zD77ro
         hhbSoTcCxyIJM7vyadqyurFBnVGBzbKWZ7ONYGlgt6cKWYKyEQAu+IUFyp5cvtjdZgDw
         aXc+TpcglCr2vBNT44/QcGIBoBDj/YsFwPX4QjV9Jn3ZZeDnHj/uExe2LkBkUesvk0+Z
         C3sQ==
X-Gm-Message-State: AOAM531F6xq0a9zkIPcl5H71XCt/1C+OwlkTSeZSeQBL5UDXjuktrBE7
        FqI1x3yfXblzY/UnGoHtkew=
X-Google-Smtp-Source: ABdhPJzjupRW40+WN4FUZja0iCFY7iXyazV3EiU8SfOuII8h8MCdacV4SFghHmY4jlkuWGms463J9Q==
X-Received: by 2002:a5d:4dc2:: with SMTP id f2mr54625097wru.399.1594122896601;
        Tue, 07 Jul 2020 04:54:56 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id m10sm791787wru.4.2020.07.07.04.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 04:54:55 -0700 (PDT)
Date:   Tue, 7 Jul 2020 13:54:54 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jia He <justin.he@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Message-ID: <20200707115454.GN5913@dhcp22.suse.cz>
References: <20200707055917.143653-1-justin.he@arm.com>
 <20200707055917.143653-2-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707055917.143653-2-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-07-20 13:59:15, Jia He wrote:
> This exports memory_add_physaddr_to_nid() for module driver to use.
> 
> memory_add_physaddr_to_nid() is a fallback option to get the nid in case
> NUMA_NO_NID is detected.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  arch/arm64/mm/numa.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index aafcee3e3f7e..7eeb31740248 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
>  
>  /*
>   * We hope that we will be hotplugging memory on nodes we already know about,
> - * such that acpi_get_node() succeeds and we never fall back to this...
> + * such that acpi_get_node() succeeds. But when SRAT is not present, the node
> + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback option.
>   */
>  int memory_add_physaddr_to_nid(u64 addr)
>  {
> -	pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);

Does it make sense to export a noop function? Wouldn't make more sense
to simply make it static inline somewhere in a header? I haven't checked
whether there is an easy way to do that sanely bu this just hit my eyes.
-- 
Michal Hocko
SUSE Labs
