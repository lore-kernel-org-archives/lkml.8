Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99789C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E01206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zblpzcwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgFKP03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFKP03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:26:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619EFC08C5C1;
        Thu, 11 Jun 2020 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=XDs14OB/JNhBYdApCavGCHVKsnCM55SNO8niNyOpAvA=; b=ZblpzcweR/XrTv5cLLbJ1tDKo/
        xr6xxQN9japafOB7kZZlD6cW9ORszJ8zw37Va5VMQH4eNJnNHmTKOlGs3RgYVghuwaKrotF134oAA
        aURS7wm48BW18diCGGCEh4arZ4CidehLy7gCcUCNFa3fE+ProMTGGOEBvedIP0/GQdbEPnS6LPIvv
        dIuKkka7LbAPxfCFkUWYZovp+W1vPiSU08D3Ra3AZEIqj82XSey5UT1mgRDrlu619ktdBIu94vvj9
        WyOQL1o7WkXWLvFIqlMoPU2/Jb2XRXF/FYuYDxhy2/plPhBvENlm7kjv18YJqe1mmCzUklaeprEot
        mrwq0X5g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjP63-0003Tr-VV; Thu, 11 Jun 2020 15:26:28 +0000
Subject: Re: [PATCH v2] debugfs: Add access restriction option
To:     Peter Enderborg <peter.enderborg@sony.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20200611152155.2194-1-peter.enderborg@sony.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <91856f40-c44f-6600-b933-f994143c6934@infradead.org>
Date:   Thu, 11 Jun 2020 08:26:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611152155.2194-1-peter.enderborg@sony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Please fix typos:

On 6/11/20 8:21 AM, Peter Enderborg wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 4379c6ac3265..b1c1446aa90d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -827,6 +827,17 @@
>  			useful to also enable the page_owner functionality.
>  			on: enable the feature
>  
> +	debugfs=    	[KNL] When CONFIG_DEBUG_FS_RESTRICTED is set, this parameter
> +			enable what is exposed to userspace.

			enables

> +			Format: { on, no_fs, off }
> +			on: 	All functions are enabled.
> +			no_fs: 	Filesystem is not registered but kernel clients can
> +			        access apis and a crashkernel can be used to read

				       APIs

> +				it's content. There is noting to mount.

				its                    nothing


> +			off: 	(default) Filesystem is not registered and clients
> +			        get a -EPERM as result when trying to register files
> +				or directory’s within debugfs.

				or directories

> +
>  	debugpat	[X86] Enable PAT debugging
>  
>  	decnet.addr=	[HW,NET]


thanks.
-- 
~Randy

