Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1E2C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A05120771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586937717;
	bh=9ywgSYygOB+/Z9gWyANO2qKl2bCr6RfkfGZP7sjsuTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vLxssrxxBn/2Vwvt5NKbxKJ72KVQf8GkbmbHHcvHytUJTkCl5lUJMGMDpNCIxnDA2
	 4ZGcBC2tRVxHenQyjagfuxLYHel6aCIrkgatW5SMI8ZNmd5FF6z1XfYMSJEL+TrD7/
	 SwbT2TsRDGhEqjK9KFgnpRLsUd6dU+xAXIzpCUnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393783AbgDOIBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:01:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390632AbgDOIBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:01:41 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 049C920771;
        Wed, 15 Apr 2020 08:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586937701;
        bh=9ywgSYygOB+/Z9gWyANO2qKl2bCr6RfkfGZP7sjsuTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=goc1oNo7GGOHWZ/W3isuoJ865lkdjnq4UOaKhVyXXV/Xt6JAnvPBol9c4w/iTR6MQ
         hrOd3wRy/dyxTh3k8w3u7s1MH4dKPUVYwI/OPr1jVMVTHjKK84jSQH4vb9aDlW2QZN
         c7SoZsfA+pmy2+Poa1O/PFlBJo9nhaMDpo0JmsFQ=
Received: by pali.im (Postfix)
        id B30A7589; Wed, 15 Apr 2020 10:01:38 +0200 (CEST)
Date:   Wed, 15 Apr 2020 10:01:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sungjong Seo <sj1557.seo@samsung.com>
Subject: Re: [PATCH 0/4] Fixes for exfat driver
Message-ID: <20200415080138.fvmviqavjtyqyi65@pali>
References: <CGME20200317222604epcas1p1559308b0199c5320a9c77f5ad9f033a2@epcas1p1.samsung.com>
 <20200317222555.29974-1-pali@kernel.org>
 <000101d5fcb2$96ec6270$c4c52750$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000101d5fcb2$96ec6270$c4c52750$@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 March 2020 08:20:04 Namjae Jeon wrote:
> > This patch series contains small fixes for exfat driver. It removes
> > conversion from UTF-16 to UTF-16 at two places where it is not needed and
> > fixes discard support.
> Looks good to me.
> Acked-by: Namjae Jeon <namjae.jeon@samsung.com>
> 
> Hi Al,
> 
> Could you please push these patches into your #for-next ?
> Thanks!

Al, could you please take this patch series? Based on feedback current
hashing code is good enough. And we do not want to have broken discard
support in upcoming Linux kernel version.

> > 
> > Patches are also in my exfat branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=exfa
> > t
> > 
> > Pali Rohár (4):
> >   exfat: Simplify exfat_utf8_d_hash() for code points above U+FFFF
> >   exfat: Simplify exfat_utf8_d_cmp() for code points above U+FFFF
> >   exfat: Remove unused functions exfat_high_surrogate() and
> >     exfat_low_surrogate()
> >   exfat: Fix discard support
> > 
> >  fs/exfat/exfat_fs.h |  2 --
> >  fs/exfat/namei.c    | 19 ++++---------------
> >  fs/exfat/nls.c      | 13 -------------
> >  fs/exfat/super.c    |  5 +++--
> >  4 files changed, 7 insertions(+), 32 deletions(-)
> > 
> > --
> > 2.20.1
> 
> 
> 
