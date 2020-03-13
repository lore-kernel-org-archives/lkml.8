Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C947C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DC6206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WKO5oG44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgCMTO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:14:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgCMTO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=09yW9h+/nWoQmCEfqkkhObnUi342JHHlf0xuk0jzfN0=; b=WKO5oG44guoe4OsIum/ZbICYeb
        ScFpySEpmQmrVbg9RX2pJ8BUKtRtJIika4bwC5MsWOM4NMdXjnLK7uZ+Q1juBMU0uxhIytcqB6Bys
        pbE46Dn3zrwnNB2znw+ErZqqkaNPwNp9/pDzExevw4krky7BiHYgOff0zNEMpcwAG5p4WuG6pk+kd
        r12PV/l3Q9KqLyoM9Xw5E/poPtanAqSl4xn3dWppISmLlEezXI62MTz9+UfXE++tP88DebFlu3myF
        czvKMhatDsho48IDWLUoqH+UTRC1jn3xE1SuQj5ddjuxdMfQixeRgFGvhEcxQMTndUdGwcfKLN6eu
        Fc93+vkA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCplK-0006Cc-6S; Fri, 13 Mar 2020 19:14:26 +0000
Date:   Fri, 13 Mar 2020 12:14:26 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] radix-tree: fix kernel-doc for
 radix_tree_find_next_bit
Message-ID: <20200313191426.GO22433@bombadil.infradead.org>
References: <20200313184909.4560-1-hqjagain@gmail.com>
 <20200313184909.4560-2-hqjagain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313184909.4560-2-hqjagain@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 02:49:08AM +0800, Qiujun Huang wrote:
>   * radix_tree_find_next_bit - find the next set bit in a memory region
>   *
>   * @addr: The address to base the search on
> - * @size: The bitmap size in bits
> + * @tag: The tag index (< RADIX_TREE_MAX_TAGS)
>   * @offset: The bitnumber to start searching at
>   *
>   * Unrollable variant of find_next_bit() for constant size arrays.
> - * Tail bits starting from size to roundup(size, BITS_PER_LONG) must be zero.
> - * Returns next bit offset, or size if nothing found.
> + * Returns next bit offset, or RADIX_TREE_MAP_SIZE if nothing found.
>   */
>  static __always_inline unsigned long
>  radix_tree_find_next_bit(struct radix_tree_node *node, unsigned int tag,

Ugh, this is a static function with kernel-doc.  What a waste of time ;-(
