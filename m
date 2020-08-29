Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9D0C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 22:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C462076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 22:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gd4Ih4+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgH2WMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 18:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbgH2WMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 18:12:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC577C061573;
        Sat, 29 Aug 2020 15:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lAxDZ0MhT9ew7DX+zcoqbskvUprSBZURJzrDB+UjpUI=; b=gd4Ih4+5BvHoBnQWIxzzJdi48a
        CUDo4RWg4E2rV1QtzU/80VEGKFbcXLWtsR39ALG4Gh7amaleBDcT8wyg25n2E91xSwirK3TwZEDy/
        38UCQCl+vThbM/f+oRKtwHgySnYmZzoe3aAhbHRAbS6JMSIQYnKTnxeKBQHPEqKJfS1xj6WWSGMKx
        PH/UG4rbzEWn64WJAvBTjDwwz7Dz9QzTQaeJuO5jnBfdF6ZxjTn7iXv+b1dfJlysKsAflxO7FikbG
        gfWOkYJguFquvupMqenkcVMHfSIw3+wS+ZK0Nvmipv4C9DEHLx9tMYIBGSB0xHcew2FAJ7sV8zBGg
        CR0tw/Ww==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kC94u-0003gh-BP; Sat, 29 Aug 2020 22:12:04 +0000
Date:   Sat, 29 Aug 2020 23:12:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Florian Margaine <florian@platform.sh>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: allow do_renameat2() over bind mounts of the same
 filesystem.
Message-ID: <20200829221204.GV14765@casper.infradead.org>
References: <871rjqh5bw.fsf@platform.sh>
 <20200828213445.GM1236603@ZenIV.linux.org.uk>
 <87wo1hf8o9.fsf@platform.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo1hf8o9.fsf@platform.sh>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 11:23:34PM +0200, Florian Margaine wrote:
> Al Viro <viro@zeniv.linux.org.uk> writes:
> 
> > On Fri, Aug 28, 2020 at 10:40:35PM +0200, Florian Margaine wrote:
> >> There's currently this seemingly unnecessary limitation that rename()
> >> cannot work over bind mounts of the same filesystem,
> >
> > ... is absolutely deliberate - that's how you set a boundary in the
> > tree, preventing both links and renames across it.
> 
> Sorry, I'm not not sure I understand what you're saying.

Al's saying this is the way an administrator can intentionally prevent
renames.

>     /*
>      * FICLONE/FICLONERANGE ioctls enforce that src and dest files are on
>      * the same mount. Practically, they only need to be on the same file
>      * system.
>      */
>     if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
>         return -EXDEV;

clone doesn't change the contents of a file, merely how they're laid out
on storage.  There's no particular reason for an administrator to
prohibit clone across mount points.


