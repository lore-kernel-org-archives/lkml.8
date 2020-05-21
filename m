Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378DCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 02:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A57620748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 02:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ifaeD5kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgEUC0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 22:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgEUC0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 22:26:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD19AC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 19:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AQAUQIhz6SqBbHGlDEdDO7YRyc583EZtNH+fi0JhOnE=; b=ifaeD5kroRd/pg4bLz7jN/XLLB
        24s4q/bsYF++8aYyezv8cokcKu+WD/hZrpLUbHTlKnTjD6hW74FM8TrnKUbeFGn4eFyM45w4IKXyx
        ezbJjWLew8N86eaP2nowALIAff5ceiTIWylAWtiW763IPK0l+62dxzIfbpgofkuiGe/xZ7BzR+ch2
        MA8+mG00jCMq8151XmnIzj+YKevgflB27ZShQL0Fw2HIU0kgJWg492JPECQmnRYdhFeA0JGNLzS8Y
        AM5hzNtriG8TRn1NwAxUdL2Ak7EI2CeDCA0mOGlRyBiKgRGjaZzuXmOWN4eIleMLAPAebHkmiiNrG
        xYzANe4A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbaui-0003R9-PO; Thu, 21 May 2020 02:26:28 +0000
Date:   Wed, 20 May 2020 19:26:28 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     gregkh@linuxfoundation.org, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] /dev/mem: Revoke mappings when a driver claims the
 region
Message-ID: <20200521022628.GE16070@bombadil.infradead.org>
References: <159002475918.686697.11844615159862491335.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159002475918.686697.11844615159862491335.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 06:35:25PM -0700, Dan Williams wrote:
> +static struct inode *devmem_inode;
> +
> +#ifdef CONFIG_IO_STRICT_DEVMEM
> +void revoke_devmem(struct resource *res)
> +{
> +	struct inode *inode = READ_ONCE(devmem_inode);
> +
> +	/*
> +	 * Check that the initialization has completed. Losing the race
> +	 * is ok because it means drivers are claiming resources before
> +	 * the fs_initcall level of init and prevent /dev/mem from
> +	 * establishing mappings.
> +	 */
> +	smp_rmb();
> +	if (!inode)
> +		return;

But we don't need the smp_rmb() here, right?  READ_ONCE and WRITE_ONCE
are a DATA DEPENDENCY barrier (in Documentation/memory-barriers.txt parlance)
so the smp_rmb() is superfluous ...

> +	/*
> +	 * Use a unified address space to have a single point to manage
> +	 * revocations when drivers want to take over a /dev/mem mapped
> +	 * range.
> +	 */
> +	inode->i_mapping = devmem_inode->i_mapping;
> +	inode->i_mapping->host = devmem_inode;

umm ... devmem_inode->i_mapping->host doesn't already point to devmem_inode?

> +
> +	/* publish /dev/mem initialized */
> +	smp_wmb();
> +	WRITE_ONCE(devmem_inode, inode);

As above, unnecessary barrier, I think.

