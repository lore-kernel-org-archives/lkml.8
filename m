Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDDFC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B212065E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgGWUtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:49:41 -0400
Received: from ms.lwn.net ([45.79.88.28]:42652 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgGWUtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:49:41 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0525D2BA;
        Thu, 23 Jul 2020 20:49:40 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:49:40 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     trix@redhat.com
Cc:     jacobhuisman@kernelthusiast.com, robh@kernel.org,
        grandmaster@al2klimov.de, mchehab+huawei@kernel.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: process: Add an example for creating a fixes tag
Message-ID: <20200723144940.38a9669b@lwn.net>
In-Reply-To: <20200710200115.21176-1-trix@redhat.com>
References: <20200710200115.21176-1-trix@redhat.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 13:01:15 -0700
trix@redhat.com wrote:

> To make it a little clearer how to create a fixes tag,
> add an example based on the preceeding gitconfig setup.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  Documentation/process/submitting-patches.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index e58b2c541d25..5219bf3cddfc 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -196,6 +196,11 @@ outputting the above style in the ``git log`` or ``git show`` commands::
>  	[pretty]
>  		fixes = Fixes: %h (\"%s\")
>  
> +An example call::
> +
> +	$ git log -1 --pretty=fixes 54a4f0239f2e
> +	Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
> +

Sure, why not?  Applied, thanks.

jon
