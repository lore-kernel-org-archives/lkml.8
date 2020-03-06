Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5CBC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696E820658
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WtrH3QX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCFRXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:23:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFRXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GvTsR9s3jXoUcl9oo/kaM6V16Gt1kBE/IYMf0oeTJtg=; b=WtrH3QX/fwn951ZI666/wSzz90
        TCBE1I8foHqrEBXgJCaj6n+ctyOYPepIGbbgm/l075STq55HL5NVLgqqSvcN3s6jQWUQ/t8hDHUS+
        Q2W7IFTL2b9/Ldh3MjBCUISyBtmR9M/6DyeV7bdxFR6Dw3p3LFEOyxk+xr2VmfWpi8NMrZzI5uUog
        XVmmjBYzISjWQ+GOnf1LP9v9BixccLxrgMghmuyGA6JKfCWNkxn+xG64CTZz76H9CgfiGUH8IpkC/
        3GFU+0dmaUSZdSm5hYry0X0ddi8/PBQN724+HXifxXwY0ewFNZvKYqhx4W6AzthVxTEZMhCi95FDj
        iOfJO2Eg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jAGgn-0001RV-EB; Fri, 06 Mar 2020 17:23:09 +0000
Date:   Fri, 6 Mar 2020 09:23:09 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document genhd capability flags
Message-ID: <20200306172309.GD25710@bombadil.infradead.org>
References: <20200306171621.24134-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306171621.24134-1-steve@sk2.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 06:16:21PM +0100, Stephen Kitt wrote:
> The kernel documentation includes a brief section about genhd
> capabilities, but it turns out that the only documented
> capability (GENHD_FL_MEDIA_CHANGE_NOTIFY) isn't used any more.
> 
> This patch removes that flag, and documents the rest, based on my
> understanding of the current uses of these flags in the kernel. The
> documentation is kept in the header file, alongside the declarations,
> in the hope that it will be kept up-to-date in future; the kernel
> documentation is changed to include the documentation generated from
> the header file.
> 
> Because the ultimate goal is to provide some end-user
> documentation (or end-administrator documentation), the comments are
> perhaps more user-oriented than might be expected.

Thank you!  I have some suggestions for further improvement ...

> -capability is a hex word indicating which capabilities a specific disk
> -supports.  For more information on bits not listed here, see
> -include/linux/genhd.h
> +``capability`` is a hex word indicating which capabilities a specific
> +disk supports:

``capability`` is a bitfield, printed in hexadecimal, indicating ...

> + * ``GENHD_FL_UP`` (16): indicates that the block device is "up", with
> + * a similar meaning to network interfaces.

Since we're printing it in hex, the value here should be displayed in hex
to help the end-user.  So ``GENHD_FL_UP`` (0x10), etc.

>  #define GENHD_FL_REMOVABLE			1
> -/* 2 is unused */
> -#define GENHD_FL_MEDIA_CHANGE_NOTIFY		4
> +/* 2 is unused (used to be GENHD_FL_DRIVERFS) */
> +/* 4 is unused (used to be GENHD_FL_MEDIA_CHANGE_NOTIFY) */
>  #define GENHD_FL_CD				8
>  #define GENHD_FL_UP				16
>  #define GENHD_FL_SUPPRESS_PARTITION_INFO	32
> -#define GENHD_FL_EXT_DEVT			64 /* allow extended devt */
> +#define GENHD_FL_EXT_DEVT			64
>  #define GENHD_FL_NATIVE_CAPACITY		128
>  #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	256
>  #define GENHD_FL_NO_PART_SCAN			512

Maybe these should also be converted to hex to match?
