Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1491EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E278C206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5bcbiTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437313AbgE2Dk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:40:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20080 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436711AbgE2DkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590723622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LckFzfKpAYEdTFxchZpw4kb5NHTX4jw9/QaNtcrDL8Y=;
        b=Y5bcbiTdeobRtLIqyihRRr/0dwpCzlbHKIybjQ2egxlw2o/yuOyP7B5NUef03++aCZYC8Y
        8oNd6e9Uzza+aE6WBdCNq7aBzxjOuyubz/zeatrM2Ge7ipGwYMDsA6r3Q5ZtVUfKDMyuPL
        NpuWo6lbSqhufByVz6qUgw/WGvwoogs=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-C74EUX2HPsuBx50igarJsg-1; Thu, 28 May 2020 23:40:20 -0400
X-MC-Unique: C74EUX2HPsuBx50igarJsg-1
Received: by mail-pg1-f197.google.com with SMTP id k124so888108pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LckFzfKpAYEdTFxchZpw4kb5NHTX4jw9/QaNtcrDL8Y=;
        b=aUOJav0LhHcRgKFcq9hf0LzwzcNyMd48HcuYrZOw9kWizHkcdmUvIbxT0e+DFYlGn0
         cDzHyjd7p/qXBDoIblLrdomyYAMqlYxkAALmN6iWQsCQSr6XrxLBdyGIF/jaX6j4+wBQ
         cNIR8wFXHVj3XvZXkGL73EVpuLa5oWm+/3Fw3EHnQPTZU5g8BeDaAc+zcieeDEb3pmei
         b6wG5sg3ZxqZIh07woQ6ugryun5eIvUly5ibMa/RbZ2Llc6e2DA835sGvb6VkKxMpMpA
         DQVziYLfu/mqG8PH5PWCtHHMSPAvVPvndhkhRa4oxs5u1EaeOm2SPzJSMgA14aPYi7my
         5wzw==
X-Gm-Message-State: AOAM532NY07OUq8TVrnp6pSNiuFOFzrabS+deTRAS//rbaq944uJwF4G
        a3ZzLfghK+xfG00p0BzA1TUDQmJmK9czmCrk2iBCvecKsOsYQiptG/zlP3sweaLWNggnkhxoQeV
        UnFdHdGZ9B4Swo8KwFAFXLw7i
X-Received: by 2002:a17:90a:ce17:: with SMTP id f23mr7691955pju.51.1590723619359;
        Thu, 28 May 2020 20:40:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3IqpxYfBR2MgUo03XNoATGGGr0gmcEv4dZim1Qi47Q05fk1p6AaoZkla7LLY0mrteGxh8cA==
X-Received: by 2002:a17:90a:ce17:: with SMTP id f23mr7691933pju.51.1590723619100;
        Thu, 28 May 2020 20:40:19 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g65sm1947761pfb.61.2020.05.28.20.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 20:40:18 -0700 (PDT)
Date:   Fri, 29 May 2020 11:40:07 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Gao Xiang <xiang@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Chao Yu <yuchao0@huawei.com>
Subject: Re: linux-next: manual merge of the vfs tree with the erofs tree
Message-ID: <20200529034007.GA12648@xiangao.remote.csb>
References: <20200529114501.3e2ecc14@canb.auug.org.au>
 <20200529015111.GA23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529015111.GA23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

On Fri, May 29, 2020 at 02:51:11AM +0100, Al Viro wrote:
> On Fri, May 29, 2020 at 11:45:01AM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the vfs tree got a conflict in:
> > 
> >   fs/erofs/super.c
> > 
> > between commit:
> > 
> >   e7cda1ee94f4 ("erofs: code cleanup by removing ifdef macro surrounding")
> > 
> > from the erofs tree and commit:
> > 
> >   91a7c5e1d30e ("erofs: convert to use the new mount fs_context api")
> > 
> > from the vfs tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> > 
> > diff --cc fs/erofs/super.c
> > index 8e46d204a0c2,2c0bad903fa6..000000000000
> > --- a/fs/erofs/super.c
> > +++ b/fs/erofs/super.c
> > @@@ -408,16 -365,12 +365,9 @@@ static int erofs_fc_fill_super(struct s
> >   	sb->s_time_gran = 1;
> >   
> >   	sb->s_op = &erofs_sops;
> >  -
> >  -#ifdef CONFIG_EROFS_FS_XATTR
> >   	sb->s_xattr = erofs_xattr_handlers;
> >  -#endif
> >   
> > - 	/* set erofs default mount options */
> > - 	erofs_default_options(sbi);
> > - 
> > - 	err = erofs_parse_options(sb, data);
> > - 	if (err)
> > - 		return err;
> > - 
> > - 	if (test_opt(sbi, POSIX_ACL))
> > + 	if (test_opt(ctx, POSIX_ACL))
> >   		sb->s_flags |= SB_POSIXACL;
> >   	else
> >   		sb->s_flags &= ~SB_POSIXACL;
> 
> FWIW, I would be glad to have that old erofs commit moved over to
> erofs tree...  Folks?

I'm fine with that, although I think it's mainly with vfs changes
so could be better though with vfs tree. I will add this patch
tomorrow anyway... Thanks for reminder!

Thanks,
Gao Xiang


