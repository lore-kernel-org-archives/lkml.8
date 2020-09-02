Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30549C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F052D2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NrzrFjUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgIBMRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 08:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgIBMQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 08:16:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356C9C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 05:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RNU3BkQu16lOQlYGQKQxt8zBm/7aT5lbKoI0zD9sSfE=; b=NrzrFjUve86ObeH80hRi+UY4Ia
        wcC4oHLPwHYm4kLDoNvqCdyBnBJAT6S2GSuMEysHk6JFY1Tmr+YmyPNYJKNC1wU2ci3VG7Xz02YrD
        It41EeiD7l/VWwhhQF4ZPHW+kQ8y81L+Dkc9zcyN+rO8f5Nje1ft6qDa5953BdrqTRKhPemmV7QC7
        QlwtE6vOgxCosBy1wqdllKQrgpzQk0sClXB73Tp75rUW/y3lMNtEoJv2rysLLcaL1jU92cwjsJkO6
        6VrJQXKkOhxVtgTsb36VILMkDllECEBh/VMRz/ko4ySbYLSwZKz1kpK+If5Vmzu/+Pq7tLdIpkjUZ
        s5RAGxXw==;
Received: from amit by merlin.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDRh6-0001C3-Th; Wed, 02 Sep 2020 12:16:52 +0000
Date:   Wed, 2 Sep 2020 08:16:52 -0400
From:   Amit Shah <amit@infradead.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Amit Shah <amit@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: virtio: Select VIRTIO from VIRTIO_CONSOLE.
Message-ID: <20200902121652.GA4173@merlin.infradead.org>
References: <20200831165850.26163-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831165850.26163-1-msuchanek@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 06:58:50PM +0200, Michal Suchanek wrote:
> Make it possible to have virtio console built-in when
> other virtio drivers are modular.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Reviewed-by: Amit Shah <amit@kernel.org>

> ---
>  drivers/char/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 3a144c000a38..9bd9917ca9af 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -93,8 +93,9 @@ config PPDEV
>  
>  config VIRTIO_CONSOLE
>  	tristate "Virtio console"
> -	depends on VIRTIO && TTY
> +	depends on TTY
>  	select HVC_DRIVER
> +	select VIRTIO
>  	help
>  	  Virtio console for use with hypervisors.
>  
> -- 
> 2.28.0
> 
