Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1710C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B819C2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594614052;
	bh=QLevX36hnBiyCwyM2OQ5VeflAbrIBCR7yUZkYW2R1B8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NmoukzAmrqYeylBz9uXhOcU11KRAUWLGZZoA2cHqYbd0CO/0Md8Pz5OjTnnf6rq00
	 iHJjRUvpXyBNtll8WMLPfN5mfL4sC/53Z3fj44jJ0wb7JJmIHHKqu5mG7SCOl1l5JK
	 b5Xj5UynKSF7y2YLJyjaCccm7KK4RCvyFa5JMZlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgGMEUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 00:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgGMEUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 00:20:50 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0085520724;
        Mon, 13 Jul 2020 04:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594614049;
        bh=QLevX36hnBiyCwyM2OQ5VeflAbrIBCR7yUZkYW2R1B8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GDmwqzwl1djCWvsOEjEXW3r+pJHLGuY02cAzp8Q/rI3KVqmsBCVZomzen/fyb2g5M
         J4+2gWuvmjJBBfKXM/0haqfYFiAFozjsqzkqA3Ed/bBn58dGFknplLTHAHfNRW9gLZ
         KvLn1VQDfm/rm0dcTWIa+5HavZdK20VMGcGERBwM=
Date:   Mon, 13 Jul 2020 09:50:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     corbet@lwn.net, ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dave Airlie <airlied@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Ksummit-discuss] [PATCH v3] CodingStyle: Inclusive Terminology
Message-ID: <20200713042043.GN34333@vkoul-mobl>
References: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 08-07-20, 11:14, Dan Williams wrote:
> Linux maintains a coding-style and its own idiomatic set of terminology.
> Update the style guidelines to recommend replacements for the terms
> master/slave and blacklist/whitelist.
> 
> Link: http://lore.kernel.org/r/159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Dave Airlie <airlied@redhat.com>
> Acked-by: SeongJae Park <sjpark@amazon.de>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Chris Mason <clm@fb.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-By: Vinod Koul <vkoul@kernel.org>

Thanks for working on this

> ---
> Changes since v2 [1]:
> - Pick up missed sign-offs and acks from Jon, Shuah, and Christian
>   (sorry about missing those earlier).
> 
> - Reformat the replacement list to make it easier to read.
> 
> - Add 'controller' as a suggested replacement (Kees and Mark)
> 
> - Fix up the paired term for 'performer' to be 'director' (Kees)
> 
> - Collect some new acks, reviewed-by's, and sign-offs for v2.
> 
> - Fix up Chris's email
> 
> [1]: http://lore.kernel.org/r/159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com
> 
> 
>  Documentation/process/coding-style.rst |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 2657a55c6f12..1bee6f8affdb 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -319,6 +319,26 @@ If you are afraid to mix up your local variable names, you have another
>  problem, which is called the function-growth-hormone-imbalance syndrome.
>  See chapter 6 (Functions).
>  
> +For symbol names and documentation, avoid introducing new usage of
> +'master / slave' (or 'slave' independent of 'master') and 'blacklist /
> +whitelist'.
> +
> +Recommended replacements for 'master / slave' are:
> +    '{primary,main} / {secondary,replica,subordinate}'
> +    '{initiator,requester} / {target,responder}'
> +    '{controller,host} / {device,worker,proxy}'
> +    'leader / follower'
> +    'director / performer'
> +
> +Recommended replacements for 'blacklist/whitelist' are:
> +    'denylist / allowlist'
> +    'blocklist / passlist'
> +
> +Exceptions for introducing new usage is to maintain a userspace ABI/API,
> +or when updating code for an existing (as of 2020) hardware or protocol
> +specification that mandates those terms. For new specifications
> +translate specification usage of the terminology to the kernel coding
> +standard where possible.
>  
>  5) Typedefs
>  -----------
> 
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

-- 
~Vinod
