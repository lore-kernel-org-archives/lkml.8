Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB35C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BAC521D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U55S4Mjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgDQDYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 23:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726319AbgDQDYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 23:24:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F74C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4NwRdnd1tqHPknUqRG8dZUJNk1TYuEB6jMxKNZTYnKQ=; b=U55S4Mjk3H/DrgX1Nyk3DwecPx
        3RJmjnZtDd66aTMXfWjADMplV3gkjopia000iB+pHjew3iT1rNXZVQRbZYX/wv1l56w7iL2V9c6qV
        RYUOD5NdhycZ5NQco7Bk7Kxhry9iDWjfeKVlIfI27M9d7tnwIUmN9tfwTn5Dr2yxoV5ZH6FwmCPTf
        ezxvyAxZslVYOgzG+zDCxiAIMDQrmZM6H4ZMI3y3xaPLmqjUqqEj8PI8ELcj8PziQXA0lX0HgFrY8
        oOQF3pROJzkMuGePVojzUOJaSE3G/44BKEpWlh2FflNnAviNSZWvE1tWdlOm6RgwBkvEbA15YkeCq
        sP7+/9qA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPHbe-0005WU-5o; Fri, 17 Apr 2020 03:23:54 +0000
Date:   Thu, 16 Apr 2020 20:23:54 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: Re: [PATCH] kmalloc_index optimization(code size & runtime stable)
Message-ID: <20200417032354.GK5820@bombadil.infradead.org>
References: <1587089010-110083-1-git-send-email-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587089010-110083-1-git-send-email-bernard@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 07:03:30PM -0700, Bernard Zhao wrote:
> kmalloc_index inline function code size optimization and runtime
> performance stability optimization. After optimization, the function
> kmalloc_index is more stable, the size will never affecte the function`s
> execution efficiency.
> And follow test data shows that the performance of new optimization
> exceeds the original algorithm when applying for more than 512 Bytes
> (include 512B).And new optimization runtime is more stable than before.

That's all very well and good, but the vast majority of allocations
are less than 512 bytes in size!  Your numbers show that on average,
this patch makes the kernel slower!

>             size        time/Per 100 million times
>                         old fun		new fun with optimise
> 		8	203777		241934
> 		16	245611		409278
> 		32	236384		408419
> 		64	275499		447732
> 		128	354909		416439
> 		256	360472		406598
> 		512	431072		409168
> 		1024	463822		407401

