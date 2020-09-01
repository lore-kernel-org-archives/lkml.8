Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF034C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FFA7206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="brOl6QMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgIAN1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgIANSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:18:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A004AC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9uW7HqUpxdzqV40dT/tamC4W2czgW8JE3IFLKMzq3Eo=; b=brOl6QMQuceus0POSkNwRKBOPc
        a4W5E4fFl7mLou9iwqiW83OOIPD5tloQdE1hL+3dHtn3KeDWt1WiK/amSqHISq0Ms6iR6KD+ijhX1
        9pD/BauzyKChN3tT8YoEAhpVb3nFR1j1Xdj247X9Jk8/yn+AlnpZ+6CGwTAR4yUSM6qXC2Uh7KuFx
        0jSgoTqBKhEA1eCqArL9i2lvKkEx6/NcG6KBFZZ6HvoaHI0oy+GXHXokOG0RopsEGzAzz7N3jz57I
        3+HG3RbBSp9JJ9QZLfwWv95iRlJhKcuZrEEIAmLPBos5B/+SSld/kA0mMpTtIQmbe7o2hkcq3QQi8
        1UYGo03w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kD6AX-0000v5-Gv; Tue, 01 Sep 2020 13:17:49 +0000
Date:   Tue, 1 Sep 2020 14:17:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Russell King <linux@armlinux.org.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/3] mm/armv6: work around armv6 cmpxchg support issue
Message-ID: <20200901131749.GL14765@casper.infradead.org>
References: <1598928612-68996-1-git-send-email-alex.shi@linux.alibaba.com>
 <1598928612-68996-3-git-send-email-alex.shi@linux.alibaba.com>
 <ffa89b09-995a-77d8-03c6-2c1234a5474a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffa89b09-995a-77d8-03c6-2c1234a5474a@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 02:30:51PM +0800, Alex Shi wrote:
> seems there are couples archs can not do cmpxchg1
> So update the patch here. And it's easy to fix if more arch issue find here.

> +/*
> + * cmpxchg only support 32-bits operands on the following archs ARMv6, SPARC32
> + * sh2, XTENSA.
> + */
> +#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_SH2) || \
> +	defined(CONFIG_SPARC32) || defined(CONFIG_XTENSA)

Looks like we need a HAVE_CMPXCHG_BYTE in Kconfig to parallel
HAVE_CMPXCHG_DOUBLE.
