Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A71BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816D92065E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgGWUr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:47:26 -0400
Received: from ms.lwn.net ([45.79.88.28]:42632 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgGWUr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:47:26 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1ADFF2CD;
        Thu, 23 Jul 2020 20:47:26 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:47:25 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     tony.luck@intel.com, fenghua.yu@intel.com,
        linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ia64: Replace HTTP links with HTTPS ones
Message-ID: <20200723144725.17e369e0@lwn.net>
In-Reply-To: <20200713215506.44327-1-grandmaster@al2klimov.de>
References: <20200713083408.38154746@lwn.net>
        <20200713215506.44327-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 23:55:06 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

>  Documentation/ia64/xen.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ia64/xen.rst b/Documentation/ia64/xen.rst
> index 831339c74441..9da6abb02a2c 100644
> --- a/Documentation/ia64/xen.rst
> +++ b/Documentation/ia64/xen.rst
> @@ -28,7 +28,7 @@ Getting and Building Xen and Dom0
>  
>  	# hg clone http://xenbits.xensource.com/ext/ia64/xen-unstable.hg
>  	# cd xen-unstable.hg
> -	# hg clone http://xenbits.xensource.com/ext/ia64/linux-2.6.18-xen.hg
> +	# hg clone https://xenbits.xensource.com/ext/ia64/linux-2.6.18-xen.hg
>  
>   2. # make world

So ... this is a sequence of operations that clearly cannot work at all
since the repo link you didn't change is broken.  And if it were to
somehow work, we'd get ... a 2.6.18 version of ia64 xen?  I think that the
proper solution here is to simply delete this document...

jon
