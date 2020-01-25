Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA766C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 16:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1D220704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 16:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgAYQdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 11:33:01 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33922 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYQdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 11:33:01 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivOMd-002TGu-VY; Sat, 25 Jan 2020 16:32:52 +0000
Date:   Sat, 25 Jan 2020 16:32:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/adfs: bigdir: Fix an error code in adfs_fplus_read()
Message-ID: <20200125163251.GL23230@ZenIV.linux.org.uk>
References: <20200124101537.z6n242eovocfbdha@kili.mountain>
 <20200125092930.GQ25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125092930.GQ25745@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 09:29:30AM +0000, Russell King - ARM Linux admin wrote:
> On Fri, Jan 24, 2020 at 01:15:37PM +0300, Dan Carpenter wrote:
> > This code accidentally returns success, but it should return the
> > -EIO error code from adfs_fplus_validate_header().
> > 
> > Fixes: d79288b4f61b ("fs/adfs: bigdir: calculate and validate directory checkbyte")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Good catch.
> 
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Al, please apply, thanks.

Applied and pushed out.
