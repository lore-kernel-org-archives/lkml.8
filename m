Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D30C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949AD24673
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vr6SxS8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgBLVgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:36:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLVgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=/O4SAh4DehJhEI3V66WwmmKNKSXbvZl4XVQ7/dH/7wI=; b=Vr6SxS8tSPBOeGSFhTc1LJkekZ
        Ck24Hcyo8FtXYZ0rrJU2rytadHZtksyZnCGUtaqrW60JwLWACmyVwk1eBpW31iGmXiwLU0XN0ozLz
        qnYS5qrcQvvlO/IejUbd+vy49cF3aReZeQ2pb6V0z+3mM6wRk5ecTjnl9SWkdyQv8DIxMCKFwLH4g
        URNTc4ESZgkrQzdrgozOx0MjkbZr8woVAAKL3jasV9bXoEs71oSp6p1nVO/GriuDky4aKxgfEx8ZB
        hGE28mArnoiiVzeEE4f1DqHmPJUbra/p/hObKpgzlUJjZhaiLJRTV59DbEOK/IP+r7v4/L/Fx/yWm
        esiNEB5Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1zfv-0001GX-6O; Wed, 12 Feb 2020 21:36:03 +0000
Subject: Re: [PATCH] linux/pipe_fs_i.h: fix kernel-doc warnings after @wait
 was split
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
References: <0956ab21-9b9a-4d1e-fe43-b853d1602781@infradead.org>
 <CAHk-=wjU6YdzhdhevAJ8od96RWvvqtV+h3TWvJ3QcSNrQJbMMg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0ce3caf2-9209-0968-e78a-f8e067a78ca0@infradead.org>
Date:   Wed, 12 Feb 2020 13:36:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjU6YdzhdhevAJ8od96RWvvqtV+h3TWvJ3QcSNrQJbMMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/20 11:57 AM, Linus Torvalds wrote:
> On Sun, Feb 9, 2020 at 7:36 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Fix kernel-doc warnings in struct pipe_inode_info after @wait was
>> split into @rd_wait and @wr_wait.
> 
> Thanks, applied.
> 
> I've considered adding some doc building to my basic tests, but it is
> (a) somewhat slow and (b) has always been very noisy.
> 
> And that (b) is why I really don't do it. The reason I require the
> basic build to be warning-free is that because that way any new
> warnings stand out. But that's just not the case for docs.
> 
> What do you use to notice new errors? Or is there some trick to make
> it less noisy?

It's awfully noisy.  I just do lots of "grep -v" to ignore some messages
that are always there and then I manually ignore lots of others that are
not new.  Very little automation.  No magic tricks.

-- 
~Randy

