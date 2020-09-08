Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5C0C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A612067C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbgIHStb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgIHStG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:49:06 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7024FC061573;
        Tue,  8 Sep 2020 11:49:05 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFifp-00CnK8-Ad; Tue, 08 Sep 2020 18:48:57 +0000
Date:   Tue, 8 Sep 2020 19:48:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Eliminate a local variable to make the code more
 clear
Message-ID: <20200908184857.GT1236603@ZenIV.linux.org.uk>
References: <20200729151740.GA3430@haolee.github.io>
 <20200908130656.GC22780@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908130656.GC22780@haolee.github.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 01:06:56PM +0000, Hao Lee wrote:
> ping
> 
> On Wed, Jul 29, 2020 at 03:21:28PM +0000, Hao Lee wrote:
> > The dentry local variable is introduced in 'commit 84d17192d2afd ("get
> > rid of full-hash scan on detaching vfsmounts")' to reduce the length of
> > some long statements for example
> > mutex_lock(&path->dentry->d_inode->i_mutex). We have already used
> > inode_lock(dentry->d_inode) to do the same thing now, and its length is
> > acceptable. Furthermore, it seems not concise that assign path->dentry
> > to local variable dentry in the statement before goto. So, this function
> > would be more clear if we eliminate the local variable dentry.

How does it make the function more clear?  More specifically, what
analysis of behaviour is simplified by that?
