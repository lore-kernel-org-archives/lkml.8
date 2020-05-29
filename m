Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FE7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D2E20814
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590752957;
	bh=9xQnbSRA4p8fwbkgB2zUKlTJHTtcFIyTjp/UVhOIUHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m58EybybgJX/NmLSOo/hDF6Pe9d1Y4XSNRzVugZVX+J8vNQaiGHRP/OB+WQwMYwiQ
	 lOVWvDr1bWzNpJi6jMWOw4EzLMVIh1cxJWAbFW3fUQu0HHCDOr7CiwG4LdDBiQIK+5
	 Ehqyp7/Po2NIY2hONyhu+jVS2TeeDwp2KCS11Py0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgE2LtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:49:16 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37946 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgE2LtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:49:16 -0400
Received: by mail-pj1-f68.google.com with SMTP id t8so1243197pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 04:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tKgvLnMoVN03KmyidTRu63JbswSykU0phmRWaMSE1pQ=;
        b=ME5ieocNPvRp8bvbv7Q1H/BLTSdEFEB91ZVaFh1v6bmtnyDI9KRI6N5WQz8D3zer5o
         MfPNi9LaaCR29/Ar3iHlH0G5LkUZwCPG27mM0XYg/8dW5ZbcZCmwcDS5djFjHuLSaJdt
         CDrsMMhDBJPdKgQjBaLf2Mxhj4S8RkCn195mIiQ1xHUiIEFMCRPZe4Svl6kxvR5rh7wP
         gAlK/jecEzPypUda9Zux2pMSDX//0nNiYt/LBK6ebeZ0mtrgW37OcHEQN/vurifBBQu2
         bcYoqHUdUOrFAKJ6cDSZz96gGUkuaAZKZJCahhOs9EuRFTd/pqdEOpdWCPXAZN6Q0hT0
         E72Q==
X-Gm-Message-State: AOAM533VjQnmUAIbCvMEc4Dqk65+wfK4pb+SwlUj+onFafqTheOhwfnK
        S0R4IJ3nQTqsrV3IvUFSYF0=
X-Google-Smtp-Source: ABdhPJxrT0WKEXd0Z0T8tqO8BKoAs/7a7rNPvktegNOfLVWuhUKQCRCyfP/hkaSF2EJJ+Sxqdt5Lrw==
X-Received: by 2002:a17:90a:c7d8:: with SMTP id gf24mr8959455pjb.218.1590752955275;
        Fri, 29 May 2020 04:49:15 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id go1sm7188741pjb.26.2020.05.29.04.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 04:49:13 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D2F254046C; Fri, 29 May 2020 11:49:12 +0000 (UTC)
Date:   Fri, 29 May 2020 11:49:12 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     jack@suse.cz, rafael@kernel.org, airlied@linux.ie,
        benh@kernel.crashing.org, amir73il@gmail.com, clemens@ladisch.de,
        dri-devel@lists.freedesktop.org, joseph.qi@linux.alibaba.com,
        sfr@canb.auug.org.au, mark@fasheh.com, rdna@fb.com,
        yzaikin@google.com, arnd@arndb.de, intel-gfx@lists.freedesktop.org,
        julia.lawall@lip6.fr, jlbec@evilplan.org, nixiaoming@huawei.com,
        vbabka@suse.cz, axboe@kernel.dk, tytso@mit.edu,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
        viro@zeniv.linux.org.uk
Subject: Re: [Intel-gfx] [PATCH 06/13] ocfs2: use new sysctl subdir helper
 register_sysctl_subdir()
Message-ID: <20200529114912.GC11244@42.do-not-panic.com>
References: <20200529074108.16928-1-mcgrof@kernel.org>
 <20200529074108.16928-7-mcgrof@kernel.org>
 <202005290121.C78B4AC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005290121.C78B4AC@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 01:23:19AM -0700, Kees Cook wrote:
> On Fri, May 29, 2020 at 07:41:01AM +0000, Luis Chamberlain wrote:
> > This simplifies the code considerably. The following coccinelle
> > SmPL grammar rule was used to transform this code.
> > 
> > // pycocci sysctl-subdir.cocci fs/ocfs2/stackglue.c
> > 
> > @c1@
> > expression E1;
> > identifier subdir, sysctls;
> > @@
> > 
> > static struct ctl_table subdir[] = {
> > 	{
> > 		.procname = E1,
> > 		.maxlen = 0,
> > 		.mode = 0555,
> > 		.child = sysctls,
> > 	},
> > 	{ }
> > };
> > 
> > @c2@
> > identifier c1.subdir;
> > 
> > expression E2;
> > identifier base;
> > @@
> > 
> > static struct ctl_table base[] = {
> > 	{
> > 		.procname = E2,
> > 		.maxlen = 0,
> > 		.mode = 0555,
> > 		.child = subdir,
> > 	},
> > 	{ }
> > };
> > 
> > @c3@
> > identifier c2.base;
> > identifier header;
> > @@
> > 
> > header = register_sysctl_table(base);
> > 
> > @r1 depends on c1 && c2 && c3@
> > expression c1.E1;
> > identifier c1.subdir, c1.sysctls;
> > @@
> > 
> > -static struct ctl_table subdir[] = {
> > -	{
> > -		.procname = E1,
> > -		.maxlen = 0,
> > -		.mode = 0555,
> > -		.child = sysctls,
> > -	},
> > -	{ }
> > -};
> > 
> > @r2 depends on c1 && c2 && c3@
> > identifier c1.subdir;
> > 
> > expression c2.E2;
> > identifier c2.base;
> > @@
> > -static struct ctl_table base[] = {
> > -	{
> > -		.procname = E2,
> > -		.maxlen = 0,
> > -		.mode = 0555,
> > -		.child = subdir,
> > -	},
> > -	{ }
> > -};
> > 
> > @r3 depends on c1 && c2 && c3@
> > expression c1.E1;
> > identifier c1.sysctls;
> > expression c2.E2;
> > identifier c2.base;
> > identifier c3.header;
> > @@
> > 
> > header =
> > -register_sysctl_table(base);
> > +register_sysctl_subdir(E2, E1, sysctls);
> > 
> > Generated-by: Coccinelle SmPL
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  fs/ocfs2/stackglue.c | 27 ++++-----------------------
> >  1 file changed, 4 insertions(+), 23 deletions(-)
> > 
> > diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
> > index a191094694c6..addafced7f59 100644
> > --- a/fs/ocfs2/stackglue.c
> > +++ b/fs/ocfs2/stackglue.c
> > @@ -677,28 +677,8 @@ static struct ctl_table ocfs2_mod_table[] = {
> >  	},
> >  	{ }
> >  };
> > -
> > -static struct ctl_table ocfs2_kern_table[] = {
> > -	{
> > -		.procname	= "ocfs2",
> > -		.data		= NULL,
> > -		.maxlen		= 0,
> > -		.mode		= 0555,
> > -		.child		= ocfs2_mod_table
> > -	},
> > -	{ }
> > -};
> > -
> > -static struct ctl_table ocfs2_root_table[] = {
> > -	{
> > -		.procname	= "fs",
> > -		.data		= NULL,
> > -		.maxlen		= 0,
> > -		.mode		= 0555,
> > -		.child		= ocfs2_kern_table
> > -	},
> > -	{ }
> > -};
> > +	.data		= NULL,
> > +	.data		= NULL,
> 
> The conversion script doesn't like the .data field assignments. ;)
> 
> Was this series built with allmodconfig? I would have expected this to
> blow up very badly. :)

Yikes, sense, you're right. Nope, I left the random config tests to
0day. Will fix, thanks!

  Luis
