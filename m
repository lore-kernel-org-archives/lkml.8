Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B279C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2235020866
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgCIUAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:00:32 -0400
Received: from smtprelay0027.hostedemail.com ([216.40.44.27]:55570 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725992AbgCIUAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:00:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E7891181D3030;
        Mon,  9 Mar 2020 20:00:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: angle62_44c5bace4011
X-Filterd-Recvd-Size: 1773
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Mar 2020 20:00:29 +0000 (UTC)
Message-ID: <84ef5548ee27e7150d0b7a5702ce50536cea975a.camel@perches.com>
Subject: Re: [PATCH v2 1/4] kernfs: kvmalloc xattr value instead of kmalloc
From:   Joe Perches <joe@perches.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, cgroups@vger.kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org, shakeelb@google.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        kernel-team@fb.com
Date:   Mon, 09 Mar 2020 12:58:49 -0700
In-Reply-To: <20200309195104.GA77841@mtj.thefacebook.com>
References: <C16IH7NEXW4J.440OGTNY7CWX@dlxu-fedora-R90QNFJV>
         <6bbfc8b8c9c206d80de43a64bfe4b8083cc2c02f.camel@perches.com>
         <20200309195104.GA77841@mtj.thefacebook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-09 at 15:51 -0400, Tejun Heo wrote:
> On Mon, Mar 09, 2020 at 12:41:05PM -0700, Joe Perches wrote:
> > If the need is to allocate from a single block of memory,
> > perhaps you need a submemory allocator like gen_pool.
> > (gennalloc.h)
> > 
> > Dunno.  Maybe i just don't quite understand your need.
> 
> vmalloc is the right thing to do here. vmalloc space isn't a scarce
> resource on any 64bit machines. On 32bits, which basically are tiny
> machines at this point, these allocations are both size and quantity
> limited by other factors (e.g. each cgroup consumes way more memory).

This feels like driving spikes into a living thing
more than into a
corpse.

I've still got more than a few 32-bit devices around.


