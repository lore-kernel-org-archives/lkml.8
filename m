Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F5EC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F33720672
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgDUNN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:13:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:47190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgDUNN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:13:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BC4F9ABE7;
        Tue, 21 Apr 2020 13:13:56 +0000 (UTC)
Subject: Re: [PATCH V2] kmalloc_index optimization(code size & runtime stable)
To:     1587089010-110083-1-git-send-email-bernard@vivo.com,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
References: <20200421032501.127370-1-bernard@vivo.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <339dbb54-b4bc-78e2-e3f0-986814e86d0e@suse.cz>
Date:   Tue, 21 Apr 2020 15:13:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421032501.127370-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/20 5:25 AM, Bernard Zhao wrote:
> kmalloc_index inline function code size optimization and runtime
> performance stability optimization. After optimization, the function
> kmalloc_index is more stable, the size will never affecte the function`s
> execution efficiency.
> And follow test data shows that the performance of new optimization
> exceeds the original algorithm when applying for more than 512 Bytes
> (include 512B).And new optimization runtime is more stable than before.
> Test platform:install vmware ubuntu 16.04, ram 2G, cpu 1, i5-8500 3.00GHz
> Compiler: gcc -O2 optimization, gcc version 5.4.0.
> Just test diff code part.
> Follow is detailed test data:
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
>         2 * 1024	548519		407710
>         4 * 1024	623378		422326
>         8 * 1024	655932		407457
>        16 * 1024	744673		417574
>        32 * 1024	824889		415316
>        64 * 1024	854374		408577
>       128 * 1024	968079		433582
>       256 * 1024	985527		412080
>       512 * 1024	1196877		448199
>      1024 * 1024	1310315		448969
> 2  * 1024 * 1024	1367441		513117
> 4  * 1024 * 1024	1264623		415019
> 8  * 1024 * 1024	1255727		417197
> 16 * 1024 * 1024	1401431		411087
> 32 * 1024 * 1024	1440415		416616
> 64 * 1024 * 1024	1428122		417459

No, the kernel will never see these time improvements (or non-improvements for
small sizes). See how kmalloc() and kmalloc_node() both call kmalloc_index()
only under "if (__builtin_constant_p(size))"
which means kmalloc is called with a (compile-time) constant size, so this code
is only evaluated at compile time, not while kernel is running. Otherwise it
really wouldn't be implemented as a stream of if's :)
The cases that are not compile time constant size end up in kmalloc_slab(), so
you can see how that one is implemented and what its performance is.
