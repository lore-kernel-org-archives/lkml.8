Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22936C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E111F207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588283694;
	bh=t9qnll8WvxQGsQph0bJHSahUHwx0V36v+7m8O+CgYVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cYbZ1q67ZWxeLP2mxMJ6vhJoVbQGI05GkjUyYknaPFgD6dNIwhH3MZ930UcLb5If+
	 g35/BQeRyVB58uRZ2hkLcGIIvQ6BiA2+qfHAg6aUuSEJLd5BDxOEFUoQVXpPxvBBvo
	 /OrUBw3OYoOZET3fEfh1tWATHMwwBlgFpwi/7obo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgD3Vyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgD3Vyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:54:53 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3354C20731;
        Thu, 30 Apr 2020 21:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588283693;
        bh=t9qnll8WvxQGsQph0bJHSahUHwx0V36v+7m8O+CgYVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TjnUd7P2z/2BEm/0Yz5xqXL2V6zK+jGMx7In+KwxIsoGspG0DqUCDJB21zdTjGfp2
         GgecJVXTpAbW2u6UnwoAn3OfURjtm+brB8CxDJmZXgBgZUVUSj2Y0vkpVabnz6VZZe
         0VncMoF5KTPqUtWfkBw0K6Hn1+W1A3ShkFL59I+g=
Received: by pali.im (Postfix)
        id 0D223850; Thu, 30 Apr 2020 23:54:51 +0200 (CEST)
Date:   Thu, 30 Apr 2020 23:54:50 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 09/15] udf: avoid gcc-10 zero-length-bounds warnings
Message-ID: <20200430215450.anfwm4zikvhy2bt5@pali>
References: <20200430213101.135134-1-arnd@arndb.de>
 <20200430213101.135134-10-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430213101.135134-10-arnd@arndb.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 April 2020 23:30:51 Arnd Bergmann wrote:
> gcc-10 warns about writes to the empty freeSpaceTable[] array, with
> many instances like:
> 
> fs/udf/balloc.c: In function 'udf_bitmap_new_block':
> fs/udf/balloc.c:101:36: error: array subscript 65535 is outside the bounds of an interior zero-length array '__le32[0]' {aka 'unsigned int[0]'} [-Werror=zero-length-bounds]
>   101 |  le32_add_cpu(&lvid->freeSpaceTable[partition], cnt);
>       |                ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> In file included from fs/udf/udfdecl.h:7,
>                  from fs/udf/balloc.c:22:
> fs/udf/ecma_167.h:363:11: note: while referencing 'freeSpaceTable'
>   363 |  __le32   freeSpaceTable[0];
>       |           ^~~~~~~~~~~~~~

Hi Arnd! This looks like a false-positive warning.

> These can all be avoided by using a flexible array member instead.
> 
> Another warning is a bit more obscure:
> 
> fs/udf/super.c: In function 'udf_count_free':
> fs/udf/super.c:2521:26: warning: array subscript '(<unknown>) + 4294967295' is outside the bounds of an interior zero-length array '__le32[0]' {aka 'unsigned int[0]'} [-Wzero-length-bounds]
>  2521 |      lvid->freeSpaceTable[part]);
> 
> Work around this one by changing the array access to equivalent
> pointer arithmetic, as there cannot be multiple flexible-array
> members in a single struct.

Well, this code uses GNU extension for zero-length arrays because it was
written in pre-C99 era when C99 flexible arrays did not exist yet.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/udf/ecma_167.h | 2 +-
>  fs/udf/super.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
> index 736ebc5dc441..14ffe27342bc 100644
> --- a/fs/udf/ecma_167.h
> +++ b/fs/udf/ecma_167.h
> @@ -360,9 +360,9 @@ struct logicalVolIntegrityDesc {
>  	uint8_t			logicalVolContentsUse[32];
>  	__le32			numOfPartitions;
>  	__le32			lengthOfImpUse;
> -	__le32			freeSpaceTable[0];
>  	__le32			sizeTable[0];
>  	uint8_t			impUse[0];
> +	__le32			freeSpaceTable[];

Please do not change order of members in these structures. Order is
strictly defined by ECMA 167 standard and changing them you would just
confuse reader. In LVID is free space table before size table.

If you do not like GNU C extension for zero-length arrays then just
replace it by standard C99 flexible arrays. I think that there is no
reason to not use standard C99 language constructions, just nobody had
motivation or time to change (working) code.

Also this file is semi-synchronized with udftools project in which I
already replaced all GNU C zero-length arrays by C99 flexible arrays.

You can take inspiration what I did with logicalVolIntegrityDesc:
https://github.com/pali/udftools/commit/f851d84478ce881d516a76018745fa163f803880#diff-1e1a5b89f620d380f22b973f9449aeaeL381-R384

Anyway, if you have a better idea what to do with such on-disk structure
and how to represent it in C struct syntax, let me know as it could be
updated also in udftools project.

>  } __packed;
>  
>  /* Integrity Type (ECMA 167r3 3/10.10.3) */
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index f747bf72edbe..379867888c36 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -117,7 +117,7 @@ struct logicalVolIntegrityDescImpUse *udf_sb_lvidiu(struct super_block *sb)
>  	}
>  	/* The offset is to skip freeSpaceTable and sizeTable arrays */
>  	offset = partnum * 2 * sizeof(uint32_t);
> -	return (struct logicalVolIntegrityDescImpUse *)&(lvid->impUse[offset]);
> +	return (struct logicalVolIntegrityDescImpUse *)(lvid->impUse + offset);
>  }
>  
>  /* UDF filesystem type */
> -- 
> 2.26.0
> 
