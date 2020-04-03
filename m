Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C4CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BBF206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TThcSQqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390253AbgDCBeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 21:34:24 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44248 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389857AbgDCBeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 21:34:23 -0400
Received: by mail-ot1-f66.google.com with SMTP id a49so5645338otc.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 18:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qIYcq8W/wQaQKfS0jsKTD0GfgP5XZSOsMql1SZeV8I8=;
        b=TThcSQqFzxjcnGoBrPzGePjj9boBinqTKW5qbM/NNKEIc7LLsiunbROtFCJs4fD437
         SxmMXNOMo4eGuijwSNVJ787GhJBHTbloiZL1Xp6xQt76ih9QsEZ9XwUN+Uo7s3iSoqti
         TyN98rdormsnsYYlEyoA04p4x/Ov/Cv9G1FbDK/Go4W7B99p3HSFB7n03CHx8lH6iEoI
         KLnZ4QgMqXg+BmunRK/fCp0X6PA9GPDy/LEWTqP7GuadHjiOfAhRAxrgQmEgcHr+Bh/K
         VPRWSEyQKmX4tZrUlhEMWrUQCJCApxpEINOqoaa4aJ1DBKgS50Xynl1mosTS6X9SBO1P
         MM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qIYcq8W/wQaQKfS0jsKTD0GfgP5XZSOsMql1SZeV8I8=;
        b=Vxi+of6V/m81Lgn0K5LMGUdLi4fY5IvuAeIfWAMjwPsTODXt30IOmEP3QK9hYVE1iY
         CZ3OX0q0P/7GP1QKtN8Pr/fNMliRKG1lab2Wyz4+Ximxce9Lw33Jmf9oXOJKS5CiYJ8+
         loJgO198xEF/3X5UFHqW1vQat1RQfHwi/Zy81U6fw++9W4p/wI67V5CCPPsoy8/aL7FD
         J1tz8HTJ1bKtpW6u05bd5Sv4HqahE4+PQijcIsXJ1k51owoICJzG9gvboVg626MKhzfU
         IEgznM9zMtlKuQXrAS+51RVhff/uSsaaNRJwLN7hVNzwVomHTq4RRaPWZQqmpDGA0CU2
         995A==
X-Gm-Message-State: AGi0PuYxhukWO1qoUOj6Y4qDz+BLzWuyGi/eF0EUNdoktRKuHTf3v1eD
        nVSLrqnD+jp694gTZF/Iw3A=
X-Google-Smtp-Source: APiQypLKiSm1NyuRjd4p5t7tz0TqIH1wuqzKrOCp3b2UGGucVP9oEsz1Tfa6lQ5dtIWNU1yzXue2bQ==
X-Received: by 2002:a9d:4810:: with SMTP id c16mr4551484otf.138.1585877663188;
        Thu, 02 Apr 2020 18:34:23 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id 68sm1756076oon.14.2020.04.02.18.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Apr 2020 18:34:22 -0700 (PDT)
Date:   Thu, 2 Apr 2020 18:34:20 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] drm/legacy: Fix type for drm_local_map.offset
Message-ID: <20200403013420.GA11516@ubuntu-m2-xlarge-x86>
References: <20200402203317.GA34560@ubuntu-m2-xlarge-x86>
 <20200402215926.30714-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402215926.30714-1-chris@chris-wilson.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 10:59:26PM +0100, Chris Wilson wrote:
> drm_local_map.offset is not only used for resource_size_t but also
> dma_addr_t which may be of different sizes.
> 
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Fixes: 8e4ff9b56957 ("drm: Remove the dma_alloc_coherent wrapper for internal usage")
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: Nathan Chancellor <natechancellor@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  include/drm/drm_legacy.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_legacy.h b/include/drm/drm_legacy.h
> index dcef3598f49e..aed382c17b26 100644
> --- a/include/drm/drm_legacy.h
> +++ b/include/drm/drm_legacy.h
> @@ -136,7 +136,7 @@ struct drm_sg_mem {
>   * Kernel side of a mapping
>   */
>  struct drm_local_map {
> -	resource_size_t offset;	 /**< Requested physical address (0 for SAREA)*/
> +	dma_addr_t offset;	 /**< Requested physical address (0 for SAREA)*/
>  	unsigned long size;	 /**< Requested physical size (bytes) */
>  	enum drm_map_type type;	 /**< Type of memory to map */
>  	enum drm_map_flags flags;	 /**< Flags */
> -- 
> 2.20.1
> 

Thanks for the quick fix!

I ran it through my set of build tests and nothing else seems to have
broken (at least not any more than it already is...).

Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build
