Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CDFC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424BF20771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNqd/rx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDIMvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:51:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55922 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725971AbgDIMvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586436697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TZmA4pg3k+dyxdTvM3mLXWLto6f/ClFLBXh8mPitEPY=;
        b=XNqd/rx4YHhvsg8MElpjXixeAA22IWfeWEU2ihOLAJS9TYalgca9HPGExqkoCodeqpUqqA
        3kgIMlVPIuPcticglP6/ijNBQdhAt9gtjNgZtXUxHvpjpXrKbtYJqBwttRbNjU/oyOCbZm
        zpwx0iO4Pps9d+dgz8Z7bUoAjmDdJgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-3C-E88M4NfWluUW743yx3A-1; Thu, 09 Apr 2020 08:51:33 -0400
X-MC-Unique: 3C-E88M4NfWluUW743yx3A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5899119067E4;
        Thu,  9 Apr 2020 12:51:32 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73F2A9DD87;
        Thu,  9 Apr 2020 12:51:27 +0000 (UTC)
Date:   Thu, 9 Apr 2020 08:51:25 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: stop CONFIG_XFS_DEBUG from changing compiler flags
Message-ID: <20200409125125.GA38767@bfoster>
References: <20200409080909.3646059-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409080909.3646059-1-arnd@arndb.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 10:08:56AM +0200, Arnd Bergmann wrote:
> I ran into a linker warning in XFS that originates from a mismatch
> between libelf, binutils and objtool when certain files in the kernel
> are built with "gcc -g":
> 
> x86_64-linux-ld: fs/xfs/xfs_trace.o: unable to initialize decompress status for section .debug_info
> 
> After some discussion, nobody could identify why xfs sets this flag
> here. CONFIG_XFS_DEBUG used to enable lots of unrelated settings, but
> now its main purpose is to enable extra consistency checks and assertions
> that are unrelated to the debug info.
> 
> Remove the Makefile logic to set the flag here. If anyone relies
> on the debug info, this can simply be enabled again with the global
> CONFIG_DEBUG_INFO option.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Link: https://lore.kernel.org/lkml/20200409074130.GD21033@infradead.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Seems reasonable.

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/Makefile | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
> index 4f95df476181..ff94fb90a2ee 100644
> --- a/fs/xfs/Makefile
> +++ b/fs/xfs/Makefile
> @@ -7,8 +7,6 @@
>  ccflags-y += -I $(srctree)/$(src)		# needed for trace events
>  ccflags-y += -I $(srctree)/$(src)/libxfs
>  
> -ccflags-$(CONFIG_XFS_DEBUG) += -g
> -
>  obj-$(CONFIG_XFS_FS)		+= xfs.o
>  
>  # this one should be compiled first, as the tracing macros can easily blow up
> -- 
> 2.26.0
> 

