Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978D2C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B126206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uPEqZ7eo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgDULTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 07:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgDULTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:19:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFA1C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 04:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zTZk99AiK5OjEAUI30e4RyjGcOqu7o/1DlNaNqdP1sM=; b=uPEqZ7eoM9Nf+ex2VARi90OFMI
        BlgWj8s1VbeYfOJ5p6Cp7KjPB40VZvnmVQLet+CiB8Nd85t93MQto0tWtFqjJSdnVtcgBWvo/0syV
        cW62zgfDK1qOJ1cgJMsqmI0c3pup4O4wOEHKA2XM+fClfAaopNFuK37futYMRraFTtcRYUSZqBSYW
        zrFsPcgYUP5FNgGqooNzKEy5VK4ZyQOVubtQf0Y5y5mzMDLoBcjLeOz2K4cpCJx4RWqbAPG+4Td84
        ScZCQsQJk3CFQBKeXOg/2aF/d+gcP0Oy0PQ92biA8OJ3TGbPzi/4Tmbglq2hkdqFOW0bR5EtiKs8K
        JsChop9Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQqvR-00034i-FN; Tue, 21 Apr 2020 11:18:49 +0000
Date:   Tue, 21 Apr 2020 04:18:49 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     1587089010-110083-1-git-send-email-bernard@vivo.com
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
        Bernard Zhao <bernard@vivo.com>
Subject: Re: [PATCH V2] kmalloc_index optimization(code size & runtime stable)
Message-ID: <20200421111849.GL5820@bombadil.infradead.org>
References: <20200421032501.127370-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421032501.127370-1-bernard@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 08:25:01PM -0700, Bernard Zhao wrote:
> kmalloc_index inline function code size optimization and runtime
> performance stability optimization. After optimization, the function
> kmalloc_index is more stable, the size will never affecte the function`s
> execution efficiency.

Please stop posting this patch until it's faster *for small sizes*.
As I explained last time you posted it, it's not an optimisation.

>             size        time/Per 100 million times
>                         old fun		new fun with optimise
> 		8	203777		241934
> 		16	245611		409278
> 		32	236384		408419
> 		64	275499		447732
> 		128	354909		416439

^^^^ these are the important cases that need to be fast.

