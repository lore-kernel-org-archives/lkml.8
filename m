Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D785C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7158C2078B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OLIptj6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHLSgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 14:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgHLSgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 14:36:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DA5C061383;
        Wed, 12 Aug 2020 11:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hGDWRQALLjCheB38NbQiHR7a1j5xW20CZsXUayNpcok=; b=OLIptj6YsBcNR6j1pcJkA8ZhKL
        yfg7/ItMMMlyIqQRjjYLmzs/hUIjfbtCiv5fjcYgKPg8gIFmjeg/87g66tTYn4WAwUTeFslUAKdto
        UyoUXilayDWaOai1f6QuliLcrFvy2gcIRTQBXZBveYaQffQkQGG2weRLVwOBcDT5GiIynw4xjYAPO
        sW4v5/KP68ArJCf+k6LUznpy9gTF2pBtiGtkETMCmhtaQN1H4+qSB2k2UXe3IVidL46WIkupyc9ZU
        XolWPZC9/0O+9BJ+178QsEEH0UzYiXWUYf7GndvXmXzit8hpEM56IBcwGxoAOVwSimZH2zr6/DcuW
        VTui5j0w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5vbR-0001kf-Hg; Wed, 12 Aug 2020 18:35:57 +0000
Date:   Wed, 12 Aug 2020 19:35:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gordon <bmgordon@google.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-fsdevel@vger.kernel.org, Micah Morton <mortonm@google.com>,
        Raul Rangel <rrangel@google.com>,
        Ross Zwisler <zwisler@google.com>
Subject: Re: [PATCH v7] Add a "nosymfollow" mount option.
Message-ID: <20200812183557.GB17456@casper.infradead.org>
References: <20200811222803.3224434-1-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811222803.3224434-1-zwisler@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 04:28:03PM -0600, Ross Zwisler wrote:
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index 96a0240f23fed..dd8306ea336c1 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -16,6 +16,7 @@
>  #define MS_REMOUNT	32	/* Alter flags of a mounted FS */
>  #define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
>  #define MS_DIRSYNC	128	/* Directory modifications are synchronous */
> +#define MS_NOSYMFOLLOW	256	/* Do not follow symlinks */
>  #define MS_NOATIME	1024	/* Do not update access times. */
>  #define MS_NODIRATIME	2048	/* Do not update directory access times */
>  #define MS_BIND		4096

Does this need to be added to MS_RMT_MASK too?
