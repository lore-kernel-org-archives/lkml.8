Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D2AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B21262075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V5cw7BLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgE2IXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgE2IXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:23:22 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AE0C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:23:21 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fs4so917250pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AIdQINovPOSOTJO7LcbhlxJUhgtHjantuh4CQ+iWOIk=;
        b=V5cw7BLL23TyvF7XSXItctQqYMbZHnd3YzoANtt528V7qq7xu1e8i/d5BPhYuuzcJA
         S4SZfsMhz56qz6LHdqb9P3YxO98X4/nyW5suGrtljbQRKiFaxDCQddMjE6qySAsDecYm
         59mGjrKtcG0wLlb2EG+x0AmjGyZj6GcSpchSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AIdQINovPOSOTJO7LcbhlxJUhgtHjantuh4CQ+iWOIk=;
        b=a9c19waSG9UQOrAZ5Pd9xhB5/4s3bAKWtV0hkzIJozXmJua3zroH+fjPDM4gbtBMO/
         VV4wmi1Dw9QLH82JNU2vK76Sd7bKrpGWYc7bZemNTXxbk7yUWZ7Hortyys2IU+rvyG5W
         3dLYfkbHwexSfSh7Nxq3yFezH79qvOxxcS5VCBc7Cj4VN6KT757sQqGeOSfT7JQ4MWPT
         E/nG0W+laKe/gPVMbjJpWR2pbUlZ714qZVGPebqaDw3vEe4ytep/dW155nMJ9RzZCVO4
         YBjSEdrbkutbJ56k8f6JG+E2pfez69y1DOuF+JO0WPQqs1DeZfpXGYwW2XgtYkDF1Zzp
         4qOw==
X-Gm-Message-State: AOAM530V/thLK4C1Be7bNKpNBvw/dRJVst5wj0VAXjFaEMPNiUTfMb29
        UV97GaB5GMKsGhMSlNgkMGQdqQ==
X-Google-Smtp-Source: ABdhPJxhe+HLIcubMtL5eQGoTBqj0FU4LjvgWIjKqizFmhGngk4G6mh/yk/MZlVlYeZObWjd5EoKaQ==
X-Received: by 2002:a17:90a:2e8a:: with SMTP id r10mr8137536pjd.33.1590740601487;
        Fri, 29 May 2020 01:23:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gd1sm7532180pjb.14.2020.05.29.01.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 01:23:20 -0700 (PDT)
Date:   Fri, 29 May 2020 01:23:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        axboe@kernel.dk, clemens@ladisch.de, arnd@arndb.de,
        gregkh@linuxfoundation.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, benh@kernel.crashing.org,
        rdna@fb.com, viro@zeniv.linux.org.uk, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com, vbabka@suse.cz,
        sfr@canb.auug.org.au, jack@suse.cz, amir73il@gmail.com,
        rafael@kernel.org, tytso@mit.edu, julia.lawall@lip6.fr,
        akpm@linux-foundation.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] ocfs2: use new sysctl subdir helper
 register_sysctl_subdir()
Message-ID: <202005290121.C78B4AC@keescook>
References: <20200529074108.16928-1-mcgrof@kernel.org>
 <20200529074108.16928-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529074108.16928-7-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 07:41:01AM +0000, Luis Chamberlain wrote:
> This simplifies the code considerably. The following coccinelle
> SmPL grammar rule was used to transform this code.
> 
> // pycocci sysctl-subdir.cocci fs/ocfs2/stackglue.c
> 
> @c1@
> expression E1;
> identifier subdir, sysctls;
> @@
> 
> static struct ctl_table subdir[] = {
> 	{
> 		.procname = E1,
> 		.maxlen = 0,
> 		.mode = 0555,
> 		.child = sysctls,
> 	},
> 	{ }
> };
> 
> @c2@
> identifier c1.subdir;
> 
> expression E2;
> identifier base;
> @@
> 
> static struct ctl_table base[] = {
> 	{
> 		.procname = E2,
> 		.maxlen = 0,
> 		.mode = 0555,
> 		.child = subdir,
> 	},
> 	{ }
> };
> 
> @c3@
> identifier c2.base;
> identifier header;
> @@
> 
> header = register_sysctl_table(base);
> 
> @r1 depends on c1 && c2 && c3@
> expression c1.E1;
> identifier c1.subdir, c1.sysctls;
> @@
> 
> -static struct ctl_table subdir[] = {
> -	{
> -		.procname = E1,
> -		.maxlen = 0,
> -		.mode = 0555,
> -		.child = sysctls,
> -	},
> -	{ }
> -};
> 
> @r2 depends on c1 && c2 && c3@
> identifier c1.subdir;
> 
> expression c2.E2;
> identifier c2.base;
> @@
> -static struct ctl_table base[] = {
> -	{
> -		.procname = E2,
> -		.maxlen = 0,
> -		.mode = 0555,
> -		.child = subdir,
> -	},
> -	{ }
> -};
> 
> @r3 depends on c1 && c2 && c3@
> expression c1.E1;
> identifier c1.sysctls;
> expression c2.E2;
> identifier c2.base;
> identifier c3.header;
> @@
> 
> header =
> -register_sysctl_table(base);
> +register_sysctl_subdir(E2, E1, sysctls);
> 
> Generated-by: Coccinelle SmPL
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  fs/ocfs2/stackglue.c | 27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
> index a191094694c6..addafced7f59 100644
> --- a/fs/ocfs2/stackglue.c
> +++ b/fs/ocfs2/stackglue.c
> @@ -677,28 +677,8 @@ static struct ctl_table ocfs2_mod_table[] = {
>  	},
>  	{ }
>  };
> -
> -static struct ctl_table ocfs2_kern_table[] = {
> -	{
> -		.procname	= "ocfs2",
> -		.data		= NULL,
> -		.maxlen		= 0,
> -		.mode		= 0555,
> -		.child		= ocfs2_mod_table
> -	},
> -	{ }
> -};
> -
> -static struct ctl_table ocfs2_root_table[] = {
> -	{
> -		.procname	= "fs",
> -		.data		= NULL,
> -		.maxlen		= 0,
> -		.mode		= 0555,
> -		.child		= ocfs2_kern_table
> -	},
> -	{ }
> -};
> +	.data		= NULL,
> +	.data		= NULL,

The conversion script doesn't like the .data field assignments. ;)

Was this series built with allmodconfig? I would have expected this to
blow up very badly. :)

-- 
Kees Cook
