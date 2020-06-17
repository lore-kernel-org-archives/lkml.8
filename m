Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A21C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44D220888
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hFDq8l+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgFQPKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgFQPK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:10:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50922C06174E;
        Wed, 17 Jun 2020 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=7Em4MC4EQzp9zY211Niwju/uTQx/PBZTsUAMP7BVAwg=; b=hFDq8l+moKpj4m4/2ZppXGE50e
        64sBKKvo6scapFrQwCZx7bOa3x09Wb3RNc+msxtiAafsymcob9Yilu70Y1qq9z9h9zCelgxb4UGp9
        PJ0c73dKBuo2csJ0yJzmkerptFRicrqvGgUIDueqNy4upZDIP5jY2qv5tEw6f3d+tdmHax51cHM6o
        wopQtSlbK3sPNaW8ciPRK3/aUaU+IG/nxRDKozBeQEKP1kaEvxrfvvGtRE7DW6ihm5QcCpZj9oMBE
        QGwrTeG3hLnVmlGG5+yLcSo8MqVHeXNTYScx641ztg9lGGnut+wM+EWJfTz8fxuG45/g0ZGTs+RqV
        oKgRyXHg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlZht-0005HH-1B; Wed, 17 Jun 2020 15:10:29 +0000
Subject: Re: [PATCH v3] debugfs: Add access restriction option
To:     Peter Enderborg <peter.enderborg@sony.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20200617133738.6631-1-peter.enderborg@sony.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d6f02bd5-e92d-017b-9ac2-ffdcb4381c97@infradead.org>
Date:   Wed, 17 Jun 2020 08:10:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617133738.6631-1-peter.enderborg@sony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/20 6:37 AM, Peter Enderborg wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb95fad81c79..249c86e53bb7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -827,6 +827,17 @@
>  			useful to also enable the page_owner functionality.
>  			on: enable the feature
>  
> +	debugfs=    	[KNL] When CONFIG_DEBUG_FS_RESTRICTED is set, this parameter
> +			enables what is exposed to userspace.
> +			Format: { on, no_fs, off }
> +			on: 	All functions are enabled.
> +			no_fs: 	Filesystem is not registered but kernel clients can
> +			        access APIs and a crashkernel can be used to read
> +				it's content. There its nothing to mount.

				its content. There is nothing to mount.


> +			off: 	(default) Filesystem is not registered and clients
> +			        get a -EPERM as result when trying to register files
> +				or directories within debugfs.
> +
>  	debugpat	[X86] Enable PAT debugging
>  
>  	decnet.addr=	[HW,NET]


-- 
~Randy

