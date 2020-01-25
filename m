Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BA7C35242
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 09:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA0D2071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 09:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="p3C6FxXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgAYJ3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 04:29:42 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58276 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgAYJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 04:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FM1ml58BnLPMt++FhjzKuymIzy/MJ0kmkbkQBC0K5l4=; b=p3C6FxXIw/6mxvVo3KJoxPDvP
        YzzW7Z6CpE6unb99dez7aLsVkDyqwD/SKMeoaG8G3lKFbRGH7/w+jKALybZX14NpU1YJ1S2Xizfje
        aC+gbCwScgLeyIPFJZevwms5BMe4JcEio+uGUwblGRPDlKuJw5oP3DMOH2nlN/UpksFpsu2KZGZHO
        Rd5RygId/VRYD61cJ3D3QXlkChf9NegronU4w5G5h+eQjSp94ojN+Cs6KzKEtSpIvYXrI2SDiHjPu
        cQG26pzHPM1k3DbQCRITZx87t/UjTjOhf4NL6tyVFCcLd+ilfczxvNz9AxTU0vXND5ir/gjPMAKdI
        XF+6IRs4A==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:38930)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ivHkz-0004fT-D1; Sat, 25 Jan 2020 09:29:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ivHkw-0007mU-Ss; Sat, 25 Jan 2020 09:29:30 +0000
Date:   Sat, 25 Jan 2020 09:29:30 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/adfs: bigdir: Fix an error code in adfs_fplus_read()
Message-ID: <20200125092930.GQ25745@shell.armlinux.org.uk>
References: <20200124101537.z6n242eovocfbdha@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124101537.z6n242eovocfbdha@kili.mountain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 01:15:37PM +0300, Dan Carpenter wrote:
> This code accidentally returns success, but it should return the
> -EIO error code from adfs_fplus_validate_header().
> 
> Fixes: d79288b4f61b ("fs/adfs: bigdir: calculate and validate directory checkbyte")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Good catch.

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Al, please apply, thanks.

> ---
>  fs/adfs/dir_fplus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
> index 48ea299b6ece..4a15924014da 100644
> --- a/fs/adfs/dir_fplus.c
> +++ b/fs/adfs/dir_fplus.c
> @@ -114,7 +114,8 @@ static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
>  		return ret;
>  
>  	dir->bighead = h = (void *)dir->bhs[0]->b_data;
> -	if (adfs_fplus_validate_header(h)) {
> +	ret = adfs_fplus_validate_header(h);
> +	if (ret) {
>  		adfs_error(sb, "dir %06x has malformed header", indaddr);
>  		goto out;
>  	}
> -- 
> 2.11.0
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
