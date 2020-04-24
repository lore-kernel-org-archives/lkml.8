Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB001C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 984CB2074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587719081;
	bh=jCahtMZDkUSZ892I9UBU1wHBjYA6nRaxDDRtlKaup54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gzm+fIT5cSmygOExlkVyE1YDRd90n1BncgLRTaMWUXibiYdY2BPNN5YUqrnJP6tZ+
	 mmReYwvAULFKklc/U7LlFegGqCh2IXfXo9M3iChSmjlFf20Dgc/gDQnU95ARgRTtXs
	 oUPsFkKRvcGBukzd6B9scDZbFG1GDMiB0K9ZFsIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgDXJEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 05:04:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgDXJEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 05:04:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54B9220724;
        Fri, 24 Apr 2020 09:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587719078;
        bh=jCahtMZDkUSZ892I9UBU1wHBjYA6nRaxDDRtlKaup54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cFul12WGq9cotU8aEAKhwmbXTsYrIt2Z2j9dESoqn/jQEafOAHy5bW3MV3OzBE9WV
         HgKQezXniJM1e1bI0bPxYrejPgbnSSdvcMlrmBWzW+RwdxK8lB04V0POfb61Tgmb+X
         YpjB7moGqdvONMjDs0WFIWfNnZdPPEpxQ5kWWeYc=
Date:   Fri, 24 Apr 2020 11:04:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paolo Pisati <paolo.pisati@canonical.com>
Cc:     Jiri Slaby <jslaby@suse.com>, Dmitry Safonov <dima@arista.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysrq: export sysrq_mask symbol
Message-ID: <20200424090436.GA358113@kroah.com>
References: <20200424085347.40185-1-paolo.pisati@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424085347.40185-1-paolo.pisati@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 10:53:46AM +0200, Paolo Pisati wrote:
> Commit "68af431 serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE" breaks
> the build if CONFIG_SERIAL_CORE=m:
> 
> ...
> ERROR: modpost: "sysrq_mask" [drivers/tty/serial/serial_core.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
> make: *** [Makefile:1331: modules] Error 2
> 
> Signed-off-by: Paolo Pisati <paolo.pisati@canonical.com>
> ---
>  drivers/tty/sysrq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 5e0d0813da55..cf49010335fd 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -74,6 +74,7 @@ int sysrq_mask(void)
>  		return 1;
>  	return sysrq_enabled;
>  }
> +EXPORT_SYMBOL(sysrq_mask);
>  
>  /*
>   * A value of 1 means 'all', other nonzero values are an op mask:

Already in my tty tree, will go to Linus tomorrow, thanks!

greg k-h
