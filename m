Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC4FC33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C12D2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diV7txC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgAMJ21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:28:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28439 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725832AbgAMJ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578907706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R3C4Q941xE3AXEWBJErO7jF+8a/J+pt1q7fx5URkZDQ=;
        b=diV7txC3kSVcODqHrxTrWaaihAR0sDXlaUNVBONeKoQ7UL9xYBcQtzSBefXXkfM0e8GRJ4
        Z372scX1NTJDI+qygmTMdSIWINVy8mm09zzveLXM9sDl2jrxtQRNQ0w7ZQWR2qr+JMnIrS
        5v/MY/fLAKL1ExD0f8Doo9KslFdHDZk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-GxA1gvvaNvKksl9_A-soIA-1; Mon, 13 Jan 2020 04:28:20 -0500
X-MC-Unique: GxA1gvvaNvKksl9_A-soIA-1
Received: by mail-wm1-f69.google.com with SMTP id t4so2305610wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 01:28:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=R3C4Q941xE3AXEWBJErO7jF+8a/J+pt1q7fx5URkZDQ=;
        b=ss+qFmWKQlOcl7dO6W6fIXnVYtzRCys6AjYgqZZkCua0B+SWdanGnmX33kC261RM+y
         VUiMV7sRw5Ux35ysagKJJ2rqyNbnPdhDvmd1mWI+fLJXwa6X8KssaHEUD89THlxGjxFj
         enFhEnM8V5ZTDBO/cRI4uITWo6tMBYRkwVP50PJeGrtCplGRo6AumTEW8AtpunFc/gb/
         +KKsPj7L9inrxz39MC6SXJfylh5YhJbKUwEVE55OhTHVQlJmKVAhMMefPZW+sJaUasfl
         76IxJHtXQW5hsaWfsdNyb2L2hKtzqvNCEclNWCixN6BjC5Dgp5IrSs5i6vDlI53vnWaD
         Bwkw==
X-Gm-Message-State: APjAAAXamCphwPSuM/T+jF1ZfPu9NUWjl3pYnxjMQUOtH0q+lcbCY9H9
        YR8q1ytG+/xYWUks/frIk4IjOKLy8z+8YH9ieX/ju9oQVb4kXV8ayybFTmjIAYeBeXvmSuwPVq/
        KNxfh/Ic2oPabuu9VMF/aTMCl
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr16792090wrs.369.1578907698501;
        Mon, 13 Jan 2020 01:28:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqwssFIroUIb1buW5MykkVVj/TQlDVXxwPmj/97+2mYHumLWKoldzBD8ViDURwXYkubqia4XUw==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr16792071wrs.369.1578907698283;
        Mon, 13 Jan 2020 01:28:18 -0800 (PST)
Received: from orion (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id m7sm13200881wma.39.2020.01.13.01.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 01:28:17 -0800 (PST)
Date:   Mon, 13 Jan 2020 10:28:15 +0100
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs tree
Message-ID: <20200113092815.qwndd7oi5wglxh3c@orion>
Mail-Followup-To: Carlos Maiolino <cmaiolino@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200110175729.3b5d2338@canb.auug.org.au>
 <20200110110353.klnooeqv4b6ipxid@orion>
 <20200111094427.4c875a90@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200111094427.4c875a90@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 09:44:27AM +1100, Stephen Rothwell wrote:
> Hi Carlos,
> 
> On Fri, 10 Jan 2020 12:03:53 +0100 Carlos Maiolino <cmaiolino@redhat.com> wrote:
> >
> > Eitherway, I am not 100% sure this is the right fix for this case, I remember
> > some bmap() users who didn't need CONFIG_BLOCK, so we may still need to export
> > it without CONFIG_BLOCK.
> > Can you please send me your configuration?
> 
> It was a x86_64 allnoconfig build.

Thanks for the info Stephen.

I think the correct way to fix this though, is to wrap the whole bmap(){}
definition in a #ifdef block, not only the EXPORT symbol, as, by my patches, we
redefine bmap() as an inline symbol if CONFIG_BLOCK is not set. So, something
like this:


diff --git a/fs/inode.c b/fs/inode.c
index 9f894b25af2b..21e58542801b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1612,6 +1612,8 @@ EXPORT_SYMBOL(iput);
  *	Returns -EINVAL in case of error, 0 otherwise. If mapping falls into a
  *	hole, returns 0 and *block is also set to 0.
  */
+
+#ifdef CONFIG_BLOCK
 int bmap(struct inode *inode, sector_t *block)
 {
 	if (!inode->i_mapping->a_ops->bmap)
@@ -1621,6 +1623,7 @@ int bmap(struct inode *inode, sector_t *block)
 	return 0;
 }
 EXPORT_SYMBOL(bmap);
+#endif
 
 /*
  * With relative atime, only update atime if the previous atime is

So, we preserve the original inline definition in include/fs.h (making bmap()
just returning -EINVAL). What do you think?

Viro, mind to share your opinion? I can send a 'Fixes:' patch.

Cheers



-- 
Carlos

