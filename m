Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653EFC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362312073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iakLCct5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgAQP2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:28:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43070 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726942AbgAQP2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579274891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vX7MenyazFNxz1gceqizoJgoTU64O71K2UNBQUf1hrg=;
        b=iakLCct57UdaZhWX+dWDp5/pwmGcjXaOG+tHCa5NOakJeRTh5BNjPbAgroD1+H+bQtRGp0
        4q+iu4TEQdYjJG/1Z9P5mk4z9Dtc4yzYqU1KJuHUrcx4od2kZPsd36qGS+eJVr9ghk5U39
        6EKSDUTVAYA9qONzOI5NkXq1amvVYCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-UlEsAOqpPBecNTmYEIaVFQ-1; Fri, 17 Jan 2020 10:28:09 -0500
X-MC-Unique: UlEsAOqpPBecNTmYEIaVFQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A0D1100551A;
        Fri, 17 Jan 2020 15:28:08 +0000 (UTC)
Received: from treble (ovpn-123-54.rdu2.redhat.com [10.10.123.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1762484334;
        Fri, 17 Jan 2020 15:28:07 +0000 (UTC)
Date:   Fri, 17 Jan 2020 09:28:05 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Dec 6 (objtool, lots in btrfs)
Message-ID: <20200117152805.ncy3z34imzpchg7m@treble>
References: <20191211134929.GL3929@twin.jikos.cz>
 <c751bc1a-505c-5050-3c4c-c83be81b4e48@infradead.org>
 <20191212184725.db3ost7rcopotr5u@treble>
 <b9b0c81b-0ca8-dfb7-958f-cd58a449b6fb@infradead.org>
 <ba2a7a9b-933b-d4e4-8970-85b6c1291fca@infradead.org>
 <20191213235054.6k2lcnwa63r26zwi@treble>
 <c6a33c21-3e71-ac98-cc95-db008764917c@infradead.org>
 <20191214054515.ougsr5ykhl3vvy57@treble>
 <20191217152954.GH3929@suse.cz>
 <20200110194622.GS3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110194622.GS3929@twin.jikos.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 08:46:22PM +0100, David Sterba wrote:
> On Tue, Dec 17, 2019 at 04:29:54PM +0100, David Sterba wrote:
> > Separating the definitions by #ifdef looks ok, I'd rather do separate
> > definitions of ASSERT too, to avoid the ternary operator. I'll send the
> > patch.
> 
> Subject: [PATCH] btrfs: separate definition of assertion failure handlers
> 
> There's a report where objtool detects unreachable instructions, eg.:
> 
>   fs/btrfs/ctree.o: warning: objtool: btrfs_search_slot()+0x2d4: unreachable instruction
> 
> This seems to be a false positive due to compiler version. The cause is
> in the ASSERT macro implementation that does the conditional check as
> IS_DEFINED(CONFIG_BTRFS_ASSERT) and not an #ifdef.
> 
> To avoid that, use the ifdefs directly.
> 
> CC: Josh Poimboeuf <jpoimboe@redhat.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/ctree.h | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

This looks quite similar to my patch, would you mind giving me
attribution?

> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 569931dd0ce5..f90b82050d2d 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3157,17 +3157,21 @@ do {								\
>  	rcu_read_unlock();					\
>  } while (0)
>  
> -__cold
> -static inline void assfail(const char *expr, const char *file, int line)
> +#ifdef CONFIG_BTRFS_ASSERT
> +__cold __noreturn
> +static inline void assertfail(const char *expr, const char *file, int line)
>  {
> -	if (IS_ENABLED(CONFIG_BTRFS_ASSERT)) {
> -		pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
> -		BUG();
> -	}
> +	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
> +	BUG();

assertfail() is definitely better than "assfail", but shouldn't you
update the callers so it doesn't break the build?

-- 
Josh

