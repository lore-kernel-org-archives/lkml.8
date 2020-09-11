Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D47C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A71221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgIKGVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 02:21:38 -0400
Received: from verein.lst.de ([213.95.11.211]:35626 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgIKGVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 02:21:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E676E67373; Fri, 11 Sep 2020 08:21:34 +0200 (CEST)
Date:   Fri, 11 Sep 2020 08:21:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Harald Freudenberger <freude@linux.ibm.com>
Cc:     linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, hch@lst.de,
        borntraeger@de.ibm.com
Subject: Re: [PATCH] s390/zcrypt: remove set_fs() invocation in zcrypt
 device driver
Message-ID: <20200911062134.GB21597@lst.de>
References: <20200910102838.28887-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910102838.28887-1-freude@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 12:28:38PM +0200, Harald Freudenberger wrote:
> +static inline unsigned long z_copy_from_user(bool userspace,
> +					     void *to, const void __user *from, unsigned long n)

Can you avoid the pointless long lines in the function declaration?

> +{
> +	if (likely(userspace))
> +		return copy_from_user(to, from, n);
> +	memcpy(to, (void __force *) from, n);
> +	return 0;
> +}
> +
> +static inline unsigned long z_copy_to_user(bool userspace,
> +					   void __user *to, const void *from, unsigned long n)
> +{
> +	if (likely(userspace))
> +		return copy_to_user(to, from, n);
> +	memcpy((void __force *) to, from, n);
> +	return 0;

Otherwise this doesn't look great, but also not horrible and gets rid
of the set_fs while reducing the lines of code, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
