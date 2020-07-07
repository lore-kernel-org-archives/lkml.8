Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D9CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2F320708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YYvyv11O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgGGChQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 22:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgGGChQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 22:37:16 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5ADC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 19:37:16 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t15so3455994pjq.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 19:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HHdH3pxc6/1OWdiQ0FLNq8tld/3JYfOlJ1zd1DWvXxE=;
        b=YYvyv11OhAGE++Y19t/3AOlEmefMaGpenbchC0U1ko+Rz7bK4xMx1lRWXGKPWf7m69
         Tdnqd51W987csbOwrk//zANgFBaayT7cLz5wEMdRUQucTigjm/JL5op9uVN5DXvzb7U1
         fRQ5T8jDiN+UTHrTrfQSXIGx5izB2T5kF8GcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HHdH3pxc6/1OWdiQ0FLNq8tld/3JYfOlJ1zd1DWvXxE=;
        b=DR9ZJVGhmfGhP7Z14iaMdoniF0TCCDYDkhGdVcznj+ALuJvj+FJj4cv/tI0bDZw9Ee
         F0WZx8htBbaGB1HuGxio2UpNCrgvYkXk/OBicwXgxnCtq1Q+R2mH5yb1yP0TPHrSGZh2
         UiIHwf9YwX4r3bvD9O/jnMzz3JOo4Ul0gHlzZjWHb5PDmXc1Z8aA+iceu7boVn8JiYJe
         zPNyU/HvMM2cWzI299UAHip9uOvOvAMX7RQqKjOIpqxEGZq/hlQ1LNPWkvIMFm/bBqhw
         k3EbzCduWaqfGik3cB4ixsPr1pohX2sqWH7I6MQyRV51h7ggm+HnMGHK0O1Sqzyr+6it
         OQYQ==
X-Gm-Message-State: AOAM532EuVymDobmaEYE87dIZqPz+ruTFzMJYxdhKKXFpPigC0dg7XEj
        kRTdjueCfmBeT512p1FLRH8AsX4iJ9c=
X-Google-Smtp-Source: ABdhPJzXGXWo6BaBPsc65IAhDuQF0Km5xLLZpA7PkCz3ErWEQlWg+yVa5og4xutUAjns58+bKNXrDw==
X-Received: by 2002:a17:90b:3684:: with SMTP id mj4mr2123524pjb.66.1594089435628;
        Mon, 06 Jul 2020 19:37:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d190sm19730669pfd.199.2020.07.06.19.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 19:37:14 -0700 (PDT)
Date:   Mon, 6 Jul 2020 19:37:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/platform: build fix when crypto API are disabled
Message-ID: <202007061852.5B9A0F9ED@keescook>
References: <20200706234045.9516-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706234045.9516-1-mcroce@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:40:45AM +0200, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> When building a kernel with CONFIG_PSTORE=y and CONFIG_CRYPTO not set,
> a build error happens:
> 
>     ld: fs/pstore/platform.o: in function `pstore_dump':
>     platform.c:(.text+0x3f9): undefined reference to `crypto_comp_compress'
>     ld: fs/pstore/platform.o: in function `pstore_get_backend_records':
>     platform.c:(.text+0x784): undefined reference to `crypto_comp_decompress'
> 
> This because some pstore code uses crypto_comp_(de)compress
> regardless of the CONFIG_CRYPTO status.
> Fix it by wrapping the (de)compress usage by IS_ENABLED(CONFIG_PSTORE_COMPRESS)

I'm surprised this hasn't come up before in a randconfig! But I guess
it'd require a very lucky config: picking CONFIG_PSTORE but not
CONFIG_CRYPTO _and_ 0 of the many compression options in pstore. :P

But yes, I can reproduce this with:

# CONFIG_CRYPTO is not set
CONFIG_PSTORE=y
# CONFIG_PSTORE_DEFLATE_COMPRESS is not set
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set

> 
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---
>  fs/pstore/platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index a9e297eefdff..6022d8359f96 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -436,7 +436,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
>  					  dst_size, &dump_size))
>  			break;
>  
> -		if (big_oops_buf) {
> +		if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && big_oops_buf) {
>  			zipped_len = pstore_compress(dst, psinfo->buf,
>  						header_size + dump_size,
>  						psinfo->bufsize);
> @@ -668,7 +668,7 @@ static void decompress_record(struct pstore_record *record)
>  	int unzipped_len;
>  	char *unzipped, *workspace;
>  
> -	if (!record->compressed)
> +	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !record->compressed)
>  		return;
>  
>  	/* Only PSTORE_TYPE_DMESG support compression. */
> -- 
> 2.26.2

This report also reminds me that I want to stop hard-coding the possible
compressors[1].

Regardless, for now, I'd like a slightly different patch, which pokes
pstore_compress() instead of doing it inline in pstore_dump():


diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index a9e297eefdff..36714df37d5d 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -269,6 +269,9 @@ static int pstore_compress(const void *in, void *out,
 {
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESSION))
+		return -EINVAL;
+
 	ret = crypto_comp_compress(tfm, in, inlen, out, &outlen);
 	if (ret) {
 		pr_err("crypto_comp_compress failed, ret = %d!\n", ret);
@@ -668,7 +671,7 @@ static void decompress_record(struct pstore_record *record)
 	int unzipped_len;
 	char *unzipped, *workspace;
 
-	if (!record->compressed)
+	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESSION) || !record->compressed)
 		return;
 
 	/* Only PSTORE_TYPE_DMESG support compression. */



Let me know if that works for you (it fixes it on my end).

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20180802215118.17752-1-keescook@chromium.org/

-- 
Kees Cook
