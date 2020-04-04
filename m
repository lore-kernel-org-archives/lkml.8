Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE1DC2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 15:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B9620644
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 15:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CGC/HTf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDDPhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 11:37:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgDDPhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 11:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zcRkBT5Lx26AnwXGSavWEqx/Dkt2w9NWgy6n1+Vs4bQ=; b=CGC/HTf2Yop1kREHsLdbohVZNL
        ux63WTXZkxwqv/G7Ic/O9L5+oCDjHk8ijNg13FiktXYfOPVR5gt0G9aAmGWolMn8SxEfs8ZOwmXKE
        Y6Uirr3DpQwFoeKaPWGGr/ONmPbAtr1Pvb3kNSAK+meFmJLXcAw2AoVONGZOd8+DmzBbWFvrdDE96
        WELUDDbWwTGPtAAjad0KWGgEmWc9rf5UOceAAwsmxGb48cjISIp6GKBT0Zy5jkdT6hl6ITdY3Y+42
        Rcks0QWnFmKNhG3tCpTUW9kb/ih1t5VyUhRQkADH8s6oevjYr2RcRTDPfld3y1u4+uhrFHDAdhia8
        SDjgGK7g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKkrG-0004Dy-O2; Sat, 04 Apr 2020 15:37:18 +0000
Date:   Sat, 4 Apr 2020 08:37:18 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200404153718.GS21484@bombadil.infradead.org>
References: <20200330124842.GY22483@bombadil.infradead.org>
 <20200330141558.soeqhstone2liqud@master>
 <20200330142821.GD22483@bombadil.infradead.org>
 <20200331134208.gfkyym6n3gpgk3x3@master>
 <20200331164212.GC21484@bombadil.infradead.org>
 <20200331220440.roq4pv6wk7tq23gx@master>
 <20200331235912.GD21484@bombadil.infradead.org>
 <20200401221021.v6igvcpqyeuo2cws@master>
 <20200401222000.GK21484@bombadil.infradead.org>
 <20200403223933.vkwfwatu572entz4@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403223933.vkwfwatu572entz4@master>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 10:39:33PM +0000, Wei Yang wrote:
> Did a run on 5.6 without my change. The output is
> 
> [root@debug010000002015 radix-tree]# ./main
> random seed 1585904186
> running tests
> XArray: 21151201 of 21151201 tests passed
> vvv Ignore these warnings
> assertion failed at idr.c:269
> assertion failed at idr.c:206
> ^^^ Warnings over
> IDA: 34980531 of 34980531 tests passed
> tests completed
> 
> Is these two assertion expected?

That's the meaning of the vvv and ^^^ lines.  Feel free to improve the
output here if you can figure out a way to do it.
