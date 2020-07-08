Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A56FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1E12067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbgGHQYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:24:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59193 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbgGHQYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:24:03 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jtCrU-0003RS-Or; Wed, 08 Jul 2020 16:23:56 +0000
Date:   Wed, 8 Jul 2020 18:23:56 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     corbet@lwn.net, ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>, Dave Airlie <airlied@redhat.com>
Subject: Re: [Ksummit-discuss] [PATCH v2] CodingStyle: Inclusive Terminology
Message-ID: <20200708162356.nrdv7n3dkasjiyfu@wittgenstein>
References: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 12:23:59AM -0700, Dan Williams wrote:
> Linux maintains a coding-style and its own idiomatic set of terminology.
> Update the style guidelines to recommend replacements for the terms
> master/slave and blacklist/whitelist.
> 
> Link: http://lore.kernel.org/r/159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com
> Cc: Jonathan Corbet <corbet@lwn.net>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Dave Airlie <airlied@redhat.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Acked-by: SeongJae Park <sjpark@amazon.de>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Chris Mason <clm@fb.clm>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

Probably got lost somewhere:
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

> Changes since v1 [1]
> - Drop inclusive-terminology.rst, it is in the lore archives if the
>   arguments are needed for future debates, but otherwise no pressing
>   need to carry it in the tree (Linus, James)
> 
> - Update the recommended terms to include replacement for 'master' and
>   'whitelist' (Kees, Andy)
> 
> - Add 'target' as a replacement (Andy)
> 
> - Add 'device' as a replacement (Mark)
> 
> - Collect acks and signed-off-bys. Yes, the sign-offs are not reflective
>   of a submission chain, but I kept "Signed-off-by" if people offered
>   it.
> 
> - Non-change: I did not add explicit language as to what to do with
>   existing usages. My personal inclination is to prioritize this
>   coding-style cleanup higher than others, but the coding-style document
>   has typically not indicated policy on how cleanups are handled by
>   subsystems. It will be a case by case effort and consideration.
> 
> [1]: http://lore.kernel.org/r/159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com
> 
>  Documentation/process/coding-style.rst |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 2657a55c6f12..a5b61e9005ac 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -319,6 +319,19 @@ If you are afraid to mix up your local variable names, you have another
>  problem, which is called the function-growth-hormone-imbalance syndrome.
>  See chapter 6 (Functions).
>  
> +For symbol names, avoid introducing new usage of 'master/slave' (or
> +'slave' independent of 'master') and 'blacklist/whitelist'. Recommended
> +replacements for 'master/slave' are: 'main/{secondary,subordinate}',
> +'primary/replica', '{initiator,requester}/{target,responder}',
> +'host/{device,proxy}', or 'leader/{performer,follower}'. Recommended
> +replacements for 'blacklist/whitelist' are: 'denylist/allowlist' or
> +'blocklist/passlist'.
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
