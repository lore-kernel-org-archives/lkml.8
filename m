Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043F4C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 21:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75912465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 21:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IDYVCYAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgAVVns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 16:43:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVVns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 16:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P6YIyQ6H1J0k+Mrn2boNE7EpN97Sppw4ebAkqT27uNM=; b=IDYVCYAur0v9GQiVU1k2QC4+/
        60NNV/9+0ms9oWTt3Ipheguyza66RVtsYZdx+8r+lZ3392jy/yGAEUVS/7lqy3+K6fYsjBOOjzSbO
        n4obXzw99QKagw8C5iTj4CH8Bad+At9QYnQ0mVrcNu3fgKmAHQmqqbfzcduZtHqTVZhsecjE6y4hA
        ujq9qIzusK9xiodEnOOQ64Eh7mh5HFfWMQyJzLKBsmp09FJyJODw6qfyXCkeLZgzWcen3V8IsAc4b
        HiGBzDcmrVEMFnPB8ir7Yq1p/Gr909/Au6aUSAe38rbZK1tgM07qRG7qjnyq+4EjetSpa8OBrwH54
        jAmo+Q0wA==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuNmt-0000Ns-7r; Wed, 22 Jan 2020 21:43:47 +0000
Subject: Re: [PATCH v3] dynamic_debug: allow to work if debugfs is disabled
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20200122074343.GA2099098@kroah.com>
 <20200122080352.GA15354@willie-the-truck>
 <20200122081205.GA2227985@kroah.com> <20200122135352.GA9458@kroah.com>
 <8d68b75c-05b8-b403-0a10-d17b94a73ba7@akamai.com>
 <20200122192940.GA88549@kroah.com> <20200122193118.GA88722@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ef1172ac-ea78-146e-575e-93e2d65b4606@infradead.org>
Date:   Wed, 22 Jan 2020 13:43:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200122193118.GA88722@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

If you make any more changes:

On 1/22/20 11:31 AM, Greg Kroah-Hartman wrote:
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index 252e5ef324e5..41f43a373a6a 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -54,6 +54,9 @@ If you make a mistake with the syntax, the write will fail thus::
>  				<debugfs>/dynamic_debug/control
>    -bash: echo: write error: Invalid argument
>  
> +Note, for systems without 'debugfs' enabled, the control file can be
> +also found in ``/proc/dynamic_debug/control``.

Mostly drop the "also".  How about:

> +Note, for systems without 'debugfs' enabled, the control file is located
> +in ``/proc/dynamic_debug/control``.


> +
>  Viewing Dynamic Debug Behaviour
>  ===============================
>  


-- 
~Randy

