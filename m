Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49EEC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF86208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598610631;
	bh=qUyXu/QgAcL7RoKIuJi1Rk2Gdv32baS0vRRKmUqfES0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hxll9Tzx1q8tNLRqMdtGe55RnLNLSloGuf0K0DL9OR3SjqhgyUIMd4XyuYEyWmoQA
	 RsotD5fjhKYsaEESqbTux2iACBcH7YY8F5AqHacOLaOWiHvzZbyWol5pDjOU7jP/iy
	 E8Kw4WUSSqTLsTsdHa4HDGX6zOxR7SwN/EsUZ1y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgH1Ka3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbgH1KaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:30:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08FD42080C;
        Fri, 28 Aug 2020 10:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598610610;
        bh=qUyXu/QgAcL7RoKIuJi1Rk2Gdv32baS0vRRKmUqfES0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOFV1ZhI5R86XUZTDEos/7uLHsM78gjWSdWMc20Mnxsx0Qm36kw/+eMQyS0G25dOA
         wb9cFtEjdaHJEoczG5Dc47v3I47423uAxKH0kWsvJnsvruWxm3l62QwK1D59oOdb7q
         yLhwt3qwucteM/x1PbKXMd0rUoL3e9TLK7eLINQA=
Date:   Fri, 28 Aug 2020 12:30:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dyndbg: refine export, rename to
 dynamic_debug_exec_queries()
Message-ID: <20200828103022.GD1470435@kroah.com>
References: <20200825173339.2082585-1-jim.cromie@gmail.com>
 <20200825173339.2082585-3-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825173339.2082585-3-jim.cromie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 11:33:38AM -0600, Jim Cromie wrote:
> commit 59cf47e7df31 dyndbg: export ddebug_exec_queries
> left a few configs broken, fix them with ifdef stub-fns.

Please use the standard way of printing commit ids, it's in the
submitting patches document.

> 
> Rename the export to dynamic_debug_exec_queries().  This is a more
> canonical function name, instead of exposing the 'ddebug' internal
> name prefix.  Do this now, before export hits v5.9.0
> 
> Implement as new function wrapping ddebug_exec_queries(now static
> again), which copies the query-string, preserving ddebug_exec_queries'
> in-place parsing, while allowing users to pass const strings.
> 
> --
> v2- fixes per Joe Perches

Shouldn't that go below the --- line?

> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Can you put a "Fixes:" tag in here?

thanks,

greg k-h
