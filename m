Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FCCC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F02620650
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583938454;
	bh=FTqUtXYIF4iIuJ+yTfQiXiyt2Svw9cpfJ6cRAAT55kk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=t/MJcah+V4JPih+nc42rLf+xExlGKLbDUpmrfFAwv7TtTIKue5hYyUAk4NQ7YdrVN
	 XrtbUFqslMhUydO60EDPA3nUpzTa1rYRxIY4RRWwdoqNyjbtI2qU8y4M+XD8y1BrFZ
	 s0TYFWJHil0J7XyHySNIw7jUmDdy7w8UBXcSz26o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgCKOyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:54:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729584AbgCKOyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Mime-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=V5VwQ3DE+z7Gin8QWO2wlhFBBFKjYu8MYUyeDZvDjTA=; b=s7mN0sk0ngR79fsppXGLXlZ25a
        BbEbycKQ6SlQpPxENYqRwMB3Ui4KjmHwO8VuX+i/7Gcp6xhg07dPwX2TQDU9gfA6O9DbWuUWrx9oN
        5voV9t1b+QRgSacgBtgO/BSXQaOZJILYXddD+l6j1yh6WN3NHXhuh2UkkLcnWjJ0GJ2BaMrjS0Vyk
        mogt6hgkeMc3gs+2RlX7SpqbSZeij2R1crYr/BrNDaR4LT18Ej5OBoP0h6/SlRDYye4ylj4gsLNmN
        vlJkiVIPrWRgf0kUpoSf8/2npEwkHMNJ6bYx/OA78Kbc3tRTcIKYjClnz09vNknffTV/2d2U/amsp
        RicCxsqQ==;
Received: from [54.239.6.186] (helo=u0c626add9cce5a.drs10.amazon.com)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jC2kC-0000sD-0Z; Wed, 11 Mar 2020 14:54:00 +0000
Message-ID: <f09bacf3029edfc7f90097f7fc6e41176ddd4873.camel@kernel.org>
Subject: Re: [PATCH] virtio: virtio_console: add missing
 MODULE_DEVICE_TABLE() for rproc serial
From:   Amit Shah <amit@kernel.org>
To:     Alexander Lobakin <alobakin@dlink.ru>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sjur Brandeland <sjur.brandeland@stericsson.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 11 Mar 2020 15:53:56 +0100
In-Reply-To: <20200310110538.19254-1-alobakin@dlink.ru>
References: <20200310110538.19254-1-alobakin@dlink.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-10 at 14:05 +0300, Alexander Lobakin wrote:
> rproc_serial_id_table lacks an exposure to module devicetable, so
> when remoteproc firmware requests VIRTIO_ID_RPROC_SERIAL, no uevent
> is generated and no module autoloading occurs.
> Add missing MODULE_DEVICE_TABLE() annotation and move the existing
> one for VIRTIO_ID_CONSOLE right to the table itself.
> 
> Fixes: 1b6370463e88 ("virtio_console: Add support for remoteproc
> serial")
> Cc: <stable@vger.kernel.org> # v3.8+
> Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>

Reviewed-by: Amit Shah <amit@kernel.org>

Thanks,

> ---
>  drivers/char/virtio_console.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/virtio_console.c
> b/drivers/char/virtio_console.c
> index 4df9b40d6342..7e1bc0f580a2 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -2116,6 +2116,7 @@ static struct virtio_device_id id_table[] = {
>  	{ VIRTIO_ID_CONSOLE, VIRTIO_DEV_ANY_ID },
>  	{ 0 },
>  };
> +MODULE_DEVICE_TABLE(virtio, id_table);
>  
>  static unsigned int features[] = {
>  	VIRTIO_CONSOLE_F_SIZE,
> @@ -2128,6 +2129,7 @@ static struct virtio_device_id
> rproc_serial_id_table[] = {
>  #endif
>  	{ 0 },
>  };
> +MODULE_DEVICE_TABLE(virtio, rproc_serial_id_table);
>  
>  static unsigned int rproc_serial_features[] = {
>  };
> @@ -2280,6 +2282,5 @@ static void __exit fini(void)
>  module_init(init);
>  module_exit(fini);
>  
> -MODULE_DEVICE_TABLE(virtio, id_table);
>  MODULE_DESCRIPTION("Virtio console driver");
>  MODULE_LICENSE("GPL");

