Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44080C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB6324656
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgCITmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:42:49 -0400
Received: from smtprelay0204.hostedemail.com ([216.40.44.204]:45016 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725992AbgCITms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:42:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4FE3118224D82;
        Mon,  9 Mar 2020 19:42:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: steel13_8c8a845334d15
X-Filterd-Recvd-Size: 2076
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Mar 2020 19:42:45 +0000 (UTC)
Message-ID: <6bbfc8b8c9c206d80de43a64bfe4b8083cc2c02f.camel@perches.com>
Subject: Re: [PATCH v2 1/4] kernfs: kvmalloc xattr value instead of kmalloc
From:   Joe Perches <joe@perches.com>
To:     Daniel Xu <dxu@dxuuu.xyz>, cgroups@vger.kernel.org, tj@kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org
Cc:     shakeelb@google.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@fb.com
Date:   Mon, 09 Mar 2020 12:41:05 -0700
In-Reply-To: <C16IH7NEXW4J.440OGTNY7CWX@dlxu-fedora-R90QNFJV>
References: <C16IH7NEXW4J.440OGTNY7CWX@dlxu-fedora-R90QNFJV>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-09 at 11:21 -0700, Daniel Xu wrote:
> Hi Joe,

Hello Daniel.

> On Fri Mar 6, 2020 at 12:49 AM, Joe Perches wrote:
> > On Thu, 2020-03-05 at 13:16 -0800, Daniel Xu wrote:
> > > It's not really necessary to have contiguous physical memory for xattr
> > > values. We no longer need to worry about higher order allocations
> > > failing with kvmalloc, especially because the xattr size limit is at
> > > 64K.
> > 
> > So why use vmalloc memory at all?
> > 
> > 
> > > diff --git a/fs/xattr.c b/fs/xattr.c
> > ']
> > > @@ -817,7 +817,7 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
> > >  	if (len < sizeof(*new_xattr))
> > >  		return NULL;
> > >  
> > > -	new_xattr = kmalloc(len, GFP_KERNEL);
> > > +	new_xattr = kvmalloc(len, GFP_KERNEL);
> > 
> > Why is this sensible?
> > vmalloc memory is a much more limited resource.
> 
> What would be the alternative? As Greg said, contiguous memory should be
> more scarce.

If the need is to allocate from a single block of memory,
perhaps you need a submemory allocator like gen_pool.
(gennalloc.h)

Dunno.  Maybe i just don't quite understand your need.

