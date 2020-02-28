Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07924C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D988E246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgB1ExF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 23:53:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:53784 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1ExE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:53:04 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7Xdv-002EAr-AO; Fri, 28 Feb 2020 04:52:55 +0000
Date:   Fri, 28 Feb 2020 04:52:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
Message-ID: <20200228045255.GJ23230@ZenIV.linux.org.uk>
References: <20200226161404.14136-1-longman@redhat.com>
 <20200226162954.GC24185@bombadil.infradead.org>
 <2EDB6FFC-C649-4C80-999B-945678F5CE87@dilger.ca>
 <9d7b76c32d09492137a253e692624856388693db.camel@themaw.net>
 <20200228033412.GD29971@bombadil.infradead.org>
 <769be2c66746ff199bf6be1db9101c60b372948d.camel@themaw.net>
 <5598cd24defe490016479518c7344201f6dfa0eb.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5598cd24defe490016479518c7344201f6dfa0eb.camel@themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 12:36:09PM +0800, Ian Kent wrote:

> And let's not forget that file systems are the primary
> source of these and not all create them on lookups.
> I may be mistaken, but I think ext4 does not while xfs
> definitely does.

Both ext4 and xfs bloody well *DO* create hashed negative
dentries on lookups.  There is a pathological case when
they are trying to be case-insensitive (and in that situation
we are SOL - if somebody insists upon mounting with
-o make-it-suck, that's what they bloody well get).

Casefondling idiocy aside, negative lookups are hashed.
On all normal filesystems.  Look for d_splice_alias()
getting passed NULL inode - that's where ->lookup()
instances normally create those.
