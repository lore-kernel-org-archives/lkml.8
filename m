Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE51C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F07120726
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kscYDLu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCFBO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 20:14:29 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:39548 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgCFBO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 20:14:28 -0500
Received: by mail-pf1-f181.google.com with SMTP id l7so248351pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 17:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Ho+0RD0p4M7tpfqm+yllGyejJF11Nk19HY5HGVNRLT4=;
        b=kscYDLu8ng4LZZyzX8XW4wfmSOKUcnyvKv1uimDLeFs/xUIiEnbqMJnVmjxigvzsnu
         M9UcYycE1mrgcRNWfral1hHUWqKIGg5QHValx0+8qnULO6vDrHXjjFnKrIdQpsNgnBBi
         waRZzWzEuprY/E1RfMlOYxj+IbMMehNmAGrtDi5wIhc5bPoPlhIbyW8mocHiGrENAC0g
         bnbpX8NEMMfb5YpuTx0s0de+49Qp1mNSHVQfOg2sz107QqQStTL4qhcUcwriPg5yEfxn
         afT4ga3xB7MnJzFzkV6ZNB67NtiA2ZXzNHDPc7dcfwNpXy2KjvGl9v8BmiSjqkuzzxUt
         LKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ho+0RD0p4M7tpfqm+yllGyejJF11Nk19HY5HGVNRLT4=;
        b=JfRaFwq++nKZa3uRO5eWSNlm3xlOor9tgJPCDfYM0ZqDL2Yg29FDQZ+RQtBMKVtkEi
         v/ep5dljL/LaHwbDxXibFEmdr6WprXKp/EALMR2RG8zqcvZNspDkhqY2+TkMjVqgvNkG
         Zg5hcwX/pTd7JuXU/1ngfItacsp1zyH7n83na3e9577KSKh6n2JpjXZ+lz9BXaisK5Mx
         zlN9rLsP5f8WS9ExIvpJlMmRGUt5xj5N1kpnWSii9BM+tMGOMaIdeQrLAzYcrfVuQRE3
         HIe7QsSgdj26hYrWvGI/XwnANWnbg+tP567K39FrlmKu8uDhPcM78MJnSAMGVEfn1+Gb
         JFtA==
X-Gm-Message-State: ANhLgQ139hVZZFWVzYFAtdMnWzjUh9lzobyJl7Dqno+3TKnAZ3hRN1IE
        kEiY6NJdxB4MPUbJAYTwdhU=
X-Google-Smtp-Source: ADFU+vtpFJLTWb+LOFK1Xu3CzXx+StCYZY1Eh+0qFG+EjzQmDnhqtk9hA4D/8gTdxON2wYNy4TU2hQ==
X-Received: by 2002:aa7:875a:: with SMTP id g26mr1156707pfo.193.1583457267331;
        Thu, 05 Mar 2020 17:14:27 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a22sm318870pfo.56.2020.03.05.17.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Mar 2020 17:14:26 -0800 (PST)
Date:   Thu, 5 Mar 2020 17:14:31 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     robin.murphy@arm.com, jroedel@suse.de
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Possible bugs in iommu_map_sg()/iommu_map_dma_sg()
Message-ID: <20200306011430.GA17529@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I recently ran a 4GB+ allocation test case with my downstream
older-version kernel, and found two possible bugs. I then saw
the mainline code, yet don't find them getting fixed.

However, I am not 100% sure that they are real practical bugs
because I later figured out that my use case was not entirely
correct. So I'd like to get some advice first, before sending
any patch.


First problem is accumulating the pad_len in iommu_map_dma_sg.
My use case was to map a size of 4GB+ sg while the device did
not set its segmentation boundary -- leaving it to the default
32-bit mask.

00 of 14: s_length    90000, s->length    90000, iova_len 0
01 of 14: s_length   100000, s->length   100000, iova_len 90000
02 of 14: s_length   100000, s->length   100000, iova_len 190000
03 of 14: s_length   200000, s->length   200000, iova_len 290000
04 of 14: s_length   200000, s->length   200000, iova_len 490000
05 of 14: s_length 39c00000, s->length 39c00000, iova_len 690000
06 of 14: s_length   400000, s->length   400000, iova_len 3a290000
07 of 14: s_length   400000, s->length   400000, iova_len 3a690000
08 of 14: s_length   400000, s->length   400000, iova_len 3aa90000
09 of 14: s_length   400000, s->length   400000, iova_len 3ae90000
10 of 14: s_length   400000, s->length   400000, iova_len 3b290000
11 of 14: s_length   400000, s->length   400000, iova_len 3b690000
12 of 14: s_length fffff000, s->length fffff000, iova_len 3ba90000
12 of 14: prev->length 400000 + pad_len c4570000 = c4970000
13 of 14: s_length 1df41000, s->length 1df41000, iova_len 1fffff000
13 of 14: prev->length fffff000 + pad_len 1000 = 100000000

So, the problem here is adding the last pad_len 0x1000 to the
prev->length 0xfffff000, and writing the result back:
880                 if (pad_len && pad_len < s_length - 1) {
881                         prev->length += pad_len;

This 0x100000000 overflows that "unsigned int" prev->length.


Second problem is in the iommu_map_sg function. When it maps
iova to phys for each list, it uses previously padded length
instead of the actual s->dma_length, which means it possibly
maps some of the iova space to a physical address space that
is out of the allocated region. For a large value of pad_len
0xc4570000, it might end up map iova to somewhere invalid:
iova [0xc3b690000, 0xd00000000] ==>
  pa [0x0000000262800000, 0x0000000327170000]
  // size 0xc4970000, dma_size 0x400000

This 0x327170000 is out of actual physical address space for
my platform. And even for the small 0x1000 pad_len, it still
maps out of the allocated region.


For my use case, I made it work by setting the segmentation
boundary to a larger size, which shouldn't be wrong because
I need a contiguous iova space with no paddings in-between.

Yet, since the code is designed to take care of a "mask size
< IOVA size" case, I feel that we probably need to fix these
two issues.

For problem 1, should we change the type of length to size_t?

For problem 2, should we map each iova<=>pa using dma_length?

Thanks
Nicolin
