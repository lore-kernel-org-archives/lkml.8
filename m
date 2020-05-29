Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4374C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 826842077D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590754157;
	bh=ePj9rbQ0Sk2NuJf9ZsB+VxMkuuhjLMWxfQxMQiI/sc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BGHnu0fXC/IMx3iwMtjLfEX2H/yKasVe8XStu8W6xO9Jrljf5TN0ALimZVDlJl0DW
	 tAF2HQ4mVWwotJKPbrvGLc08E985GL4W6oGCtEIe5pvSuYJoxBw14QOOMmz3JO3Xtv
	 Q+NKdsXaISrt+k/8Jeca0Npr9iFR50ymoLczsO7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgE2MJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:09:16 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39077 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2MJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:09:15 -0400
Received: by mail-pj1-f68.google.com with SMTP id h95so374791pje.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 05:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6vvgKHZv01UUvGrvhAsOqf6+UpVrlcy+OwWplQqQmoA=;
        b=AEXCCEFXfWm5zZ114b0KWuB6nfRF8NMepHdNcqkFDCVJtmmHI1BeyolNi4xvRZT4c9
         6MaHrXdsGgJAQqbbYvybIKPu8jZ2aDqjoEQAOrnMpvD0sy7QSvbJoJt1Bx51vWwoeU/o
         t7s2VJabJcG21+DMEluiYflda2X4xUA3iTo4xO0drxQlg7K0CEOh601kBFfpbggZbqkA
         124w+0DTNnwsW5icBVhp4I5N6H94iwqNT7Fj8Jl3mXew7b0FXJXE7BRCJIwkZCG1P/Oe
         VrgKmBQiO0ixSovohDli8cniqmhMIyY3x9b16mWfOBAXHrs0J9PyWG+82sEQyBH1HXbD
         jUZA==
X-Gm-Message-State: AOAM533Cxd3p00nIgp1fV6beFZ1R3CFwqELbsjge3w0L8Bz7yfy1j8Jh
        6MWShLwvuBeWYkfXQkGwDow=
X-Google-Smtp-Source: ABdhPJwH0ItHfFV94FqIi+i7pGGCJoHNOMavuCMZwaTSNJ24JRmSNe+lTFt06Kawbit8Fif5KqcKXw==
X-Received: by 2002:a17:90a:ce11:: with SMTP id f17mr2283340pju.123.1590754154418;
        Fri, 29 May 2020 05:09:14 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id l187sm7199102pfl.218.2020.05.29.05.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 05:09:13 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id AE8314046C; Fri, 29 May 2020 12:09:12 +0000 (UTC)
Date:   Fri, 29 May 2020 12:09:12 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, axboe@kernel.dk, clemens@ladisch.de,
        arnd@arndb.de, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, benh@kernel.crashing.org,
        rdna@fb.com, viro@zeniv.linux.org.uk, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com, vbabka@suse.cz,
        sfr@canb.auug.org.au, jack@suse.cz, amir73il@gmail.com,
        rafael@kernel.org, tytso@mit.edu, julia.lawall@lip6.fr,
        akpm@linux-foundation.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] firmware_loader: simplify sysctl declaration with
 register_sysctl_subdir()
Message-ID: <20200529120912.GD11244@42.do-not-panic.com>
References: <20200529074108.16928-1-mcgrof@kernel.org>
 <20200529074108.16928-10-mcgrof@kernel.org>
 <20200529102613.GA1345939@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529102613.GA1345939@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 12:26:13PM +0200, Greg KH wrote:
> On Fri, May 29, 2020 at 07:41:04AM +0000, Luis Chamberlain wrote:
> > From: Xiaoming Ni <nixiaoming@huawei.com>
> > 
> > Move the firmware config sysctl table to fallback_table.c and use the
> > new register_sysctl_subdir() helper. This removes the clutter from
> > kernel/sysctl.c.
> > 
> > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  drivers/base/firmware_loader/fallback.c       |  4 ++++
> >  drivers/base/firmware_loader/fallback.h       | 11 ++++++++++
> >  drivers/base/firmware_loader/fallback_table.c | 22 +++++++++++++++++--
> >  include/linux/sysctl.h                        |  1 -
> >  kernel/sysctl.c                               |  7 ------
> >  5 files changed, 35 insertions(+), 10 deletions(-)
> 
> So it now takes more lines than the old stuff?  :(

Pretty much agreed with the other changes, thanks for the review!

But this diff-stat change, indeed, it is unfortunate that we end up
with more code here than before. We'll try to reduce it instead
somehow, however in some cases during this spring-cleaning, since
the goal is to move code from one file to another, it *may* require
more code. So it won't always be negative. But we'll try!

  Luis
