Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA222C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48B1207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593174477;
	bh=TUFytmxkb72+UFVWQN6IdqKF0CX2CD0Q+ltCz0dnsas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jjbahCXJlhcumvEfVe9KaNjEyY6so0tqmmeFK1OVz9Vjgp1gdUBNM4fjD+t9P8ja7
	 BavUQfaBlYzYlW2CsoZBLb5uVGP2U/OQ1rhfvFEChfGpxfLxE87DhV/RDf5GVK76sO
	 6ZTfk2BD+Rf9rhXap/Fq3t98Af2a80PZ+D7T35F8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgFZM14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:27:56 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54663 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgFZM1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:27:55 -0400
Received: by mail-pj1-f66.google.com with SMTP id u8so4647718pje.4;
        Fri, 26 Jun 2020 05:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QYO7rUOe6ZR76wbmsG+rFsvLUmMt19wB0njlIJ04IhI=;
        b=e8t0Ttj4dqC0O/NA9IxnLZaTvxfJHyQ61J4OuDU7GZsYkinA4nYokfYJj/8IGOqp29
         PufSdH2VgwSd8Cf47Tl/HF5TFmG3IxlQ1Nnn6zVrKohmc4TaB09Et9AmTQi+P1fWRTNB
         tAC8ZFo3HaKJ+OARzlMKRIksatNGg6isxsaqIqfUzVBQiww4+s2ImZVp6POSsWDQYtbc
         PkUI0oBvDM4b0nwznaTGcA6TD6GcVUsSGKFqBIE+6BvAltJEdj9qDVYW+W6CxCin74g1
         ij4u1HZdz3Tiq9FC1CG3cxHUBJDybpKz27kpFZqQL3WlubMj186tciQeZxTmMEleI5gI
         7knQ==
X-Gm-Message-State: AOAM531/alt8u2oiEoy2/+VZjjZictZbH1DNAOGVrBu/DNVfBcbS8C41
        eaDSpHtADHd+tBfmZ9WOx6kbKjROyrE=
X-Google-Smtp-Source: ABdhPJzrqHNjjhgRg9sX3AzqBOPU93O7CxkpRVP9q8ile5kLzFIH7E88Z+6STbaoNDQD3aWX6NXBQg==
X-Received: by 2002:a17:902:c3ca:: with SMTP id j10mr2520952plj.171.1593174474802;
        Fri, 26 Jun 2020 05:27:54 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id o1sm11599230pja.49.2020.06.26.05.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:27:53 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9A5EC40B24; Fri, 26 Jun 2020 12:27:52 +0000 (UTC)
Date:   Fri, 26 Jun 2020 12:27:52 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/9] fs: don't allow kernel reads and writes without iter
 ops
Message-ID: <20200626122752.GN4332@42.do-not-panic.com>
References: <20200626075836.1998185-1-hch@lst.de>
 <20200626075836.1998185-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626075836.1998185-9-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 09:58:35AM +0200, Christoph Hellwig wrote:
> diff --git a/fs/read_write.c b/fs/read_write.c
> index e765c95ff3440d..ae463bcadb6906 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -420,6 +420,18 @@ ssize_t iter_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos,
>  	return ret;
>  }
>  
> +static void warn_unsupported(struct file *file, const char *op)
> +{
> +	char pathname[128], *path;

Why 128? How about kstrdup_quotable_file()?

  Luis
