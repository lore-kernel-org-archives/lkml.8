Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35DCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E41920884
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593785638;
	bh=PsIKumf3rYwghoEYKnSPlB30VQJPntaNJu+MX4yG8zU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zrd5AtKxsxgLTp5fAJl8ouP/Xn7HLyk2s1FkTl5el5LM4FNuElduAP+DMZO87U4hi
	 ejGLC14uAcztZ8AdKd8Ae2eL44jhxOj6imHT2QQx/tATvhIH56nRBJGXb6LPNHrfgH
	 n6VTa1l3tUxKsxJLsDdE12cVoGUVvb+Ghlii7mgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgGCON5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgGCON5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:13:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1D46206BE;
        Fri,  3 Jul 2020 14:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593785636;
        bh=PsIKumf3rYwghoEYKnSPlB30VQJPntaNJu+MX4yG8zU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wz2RQlj56qd9dwtqd+LeV7sedWyVH2ZPMf1HK2LvrTbdZ/TkJjSZboqSrWkT3CbsY
         M/j5gN40UqBhZTJdjMBXNnwzN+hZ6ZA3JraAyIADJHmIi8shJNlL5uXryraYIwSYKv
         kfDYLyjG0YPFnDAzP/3JXd/j7j2aSBwvyL0O26Hg=
Date:   Fri, 3 Jul 2020 16:13:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v3] f2fs: add symbolic link to kobject in sysfs
Message-ID: <20200703141359.GA2953162@kroah.com>
References: <20200703065420.3544269-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703065420.3544269-1-daeho43@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 03:54:20PM +0900, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added a symbolic link to directory of sysfs. It will
> create a symbolic link such as "mount_0" and "mount_1" to
> each f2fs mount in the order of mounting filesystem. But
> once one mount point was umounted, that sequential number
> @x in "mount_@x" could be reused by later newly mounted
> point. It will provide easy access to sysfs node even if
> not knowing the specific device node name like sda19 and
> dm-3.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  Documentation/filesystems/f2fs.rst | 13 ++++++++++++-

No Documentation/ABI/ entry for your new sysfs file/link?

And what does this help with?

If it's really needed, why don't we do this for all filesystem types?

thanks,

greg k-h
