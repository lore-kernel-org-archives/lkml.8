Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA59DC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9547120719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPq/FWj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbgDAWK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:10:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50998 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732687AbgDAWK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:10:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id t128so1410926wma.0;
        Wed, 01 Apr 2020 15:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/KipLt+yI4hk4j/cdZ9DjitutZWqDp00pMlHvjB1TpM=;
        b=HPq/FWj3IdXUZh3MzvrXtferZKJdvTA+AuOD60PC+xEQ9NoDRmW6Ftyx8Ie3v2kFON
         uSAuACjwsUnL1Csmg25SsZZRzOIxs0JomyoYfebnXkSscZ5or3o5BH3K3P9yD5uTfBqj
         qpf13Wg+RZ1/jZgIRgd/RIf25eJtxefwO7kLYq55mejjaTMXO6D0ekPxAwrrGp7f8YmQ
         OiPILd4+Ty3hto7SRanL4SJho8EXi2tPqDMefOOCulXKfac4JEFf8ABNp6XbEFYWSa/5
         gSLenMqtaj+FUSWuIYEUsgOOvf+tQhzGtbp5N04M60UsrREjSeARTZl0OWvrYNVLBSRg
         UF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/KipLt+yI4hk4j/cdZ9DjitutZWqDp00pMlHvjB1TpM=;
        b=HL7NVGH8vaCoLOT2zw0uRO9Tm8y5BbnLOdHaYi5Swp2YdGeySgD5hWN7D4fneqRmRj
         i7v7LZh/9T+0F7I6KQ2GF19AcNFaEzI9HxfqT3GleXhqe8EmwaewyyKaSECUj5aEBmml
         ZXhFaO8X5RHOu6KUPE1mUgbS3wlnEod6FQ7EIpOdrPOK++TXYElwlEKrcZc7Mm3UK1Ni
         4Ws+o4dyn1zfDDvBft7zhfcdfTZebArdEAnVZN1zA/CwsMqzBxwYQJY7Q3LcLxLn9Ix9
         5ErBDH9sdaLV1/koXc+Ze7vQSlx2Ycm+oa1Hl1pSG820QxYGnmQ9Q+vQ0tjr71mmg1/B
         NF2w==
X-Gm-Message-State: AGi0PuatdTY8OYNkiZWwmoLoPMKLv1GYkp/kBIanrEkZBT64Lr0Z04KN
        1xUL/c4W7/9f4+qcBQGj/oxJAmJp
X-Google-Smtp-Source: APiQypLaU4z3yEt8m02m4ZBvHwDsHPORzy2HQwNxRVQLk7wEkQF2kmj0g7SHTTuKTOuRn7VFQ+oDhA==
X-Received: by 2002:a1c:2007:: with SMTP id g7mr161947wmg.70.1585779022908;
        Wed, 01 Apr 2020 15:10:22 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 71sm4922515wrc.53.2020.04.01.15.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Apr 2020 15:10:21 -0700 (PDT)
Date:   Wed, 1 Apr 2020 22:10:21 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200401221021.v6igvcpqyeuo2cws@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-6-richard.weiyang@gmail.com>
 <20200330124842.GY22483@bombadil.infradead.org>
 <20200330141558.soeqhstone2liqud@master>
 <20200330142821.GD22483@bombadil.infradead.org>
 <20200331134208.gfkyym6n3gpgk3x3@master>
 <20200331164212.GC21484@bombadil.infradead.org>
 <20200331220440.roq4pv6wk7tq23gx@master>
 <20200331235912.GD21484@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331235912.GD21484@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 04:59:12PM -0700, Matthew Wilcox wrote:
>On Tue, Mar 31, 2020 at 10:04:40PM +0000, Wei Yang wrote:
>> cc -I. -I../../include -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined   -c -o main.o main.c
>> In file included from ./linux/../../../../include/linux/radix-tree.h:15,
>>                  from ./linux/radix-tree.h:5,
>>                  from main.c:10:
>> ./linux/rcupdate.h:5:10: fatal error: urcu.h: No such file or directory
>>     5 | #include <urcu.h>
>>       |          ^~~~~~~~
>> compilation terminated.
>> make: *** [<builtin>: main.o] Error 1
>
>Oh, you need liburcu installed.  On Debian, that's liburcu-dev ... probably
>liburcu-devel on Red Hat style distros.

The bad news is I didn't find the package on Fedora.

I am trying to build it from source. Is this git repo the correct one?

git clone git://git.liburcu.org/userspace-rcu.git

-- 
Wei Yang
Help you, Help me
