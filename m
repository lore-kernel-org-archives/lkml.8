Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53530C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2977F21897
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594720660;
	bh=hNW9W2Vz2G01a6+b/5TCKBR4AJdJhr905IRI2y7Qq9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZPKQ1RCZMfms9Pq6Rg+jsbXJ4Y05lBDDRcCddDo+sLzeEr7o2K+l8FLyn0+t2tMkb
	 G2JnPclHOJr/Aod/wsvNeAVzpcYgr072i9IKy6tMPMbfsqhOaFDF9PCl6zRISpoodn
	 UPSDft2w17316ANcS0zlV5Neb1+pBYzxeOFhAW2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgGNJ5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:57:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgGNJ5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:57:34 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67D57217A0;
        Tue, 14 Jul 2020 09:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594720653;
        bh=hNW9W2Vz2G01a6+b/5TCKBR4AJdJhr905IRI2y7Qq9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GT2Fnc8Nd8fldrNjNzy6BNnEog9o1ZynKR5MFpuH8NEMwV4GaGZuOWE0AtCUnlCdT
         PxB9fyxbz5d9sb3GfvVmXGT9SSM+U/bWLQfxIuq+6QJdW5f+cvqM58Oek6uFNlap2Z
         QiN7WSGNk+dUuAHQXeUM8k5P55G9p8tu6at8AozM=
Date:   Tue, 14 Jul 2020 12:57:26 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     adobriyan@gmail.com, corbet@lwn.net, mchehab+huawei@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: filesystems: proc: Remove stray '-' preventing
 table output
Message-ID: <20200714095726.GA1181712@kernel.org>
References: <20200714090644.13011-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714090644.13011-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 09:06:43PM +1200, Chris Packham wrote:
> When processing proc.rst sphinx complained
> 
>   Documentation/filesystems/proc.rst:548: WARNING: Malformed table.
>   Text in column margin in table line 29.
> 
> This caused the entire table to be dropped. Removing the stray '-'
> resolves the error and produces the desired table.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  Documentation/filesystems/proc.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 996f3cfe7030..53a0230a08e2 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -545,7 +545,7 @@ encoded manner. The codes are the following:
>      hg    huge page advise flag
>      nh    no huge page advise flag
>      mg    mergable advise flag
> -    bt  - arm64 BTI guarded page
> +    bt    arm64 BTI guarded page
>      ==    =======================================
>  
>  Note that there is no guarantee that every flag and associated mnemonic will
> -- 
> 2.27.0
> 

-- 
Sincerely yours,
Mike.
