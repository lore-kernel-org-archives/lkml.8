Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31128C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E69F208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgBQO43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:56:29 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41344 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgBQO43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:56:29 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4B0BE28C227;
        Mon, 17 Feb 2020 14:56:26 +0000 (GMT)
Date:   Mon, 17 Feb 2020 15:56:23 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
        Joao.Pinto@synopsys.com, Jose.Abreu@synopsys.com,
        bbrezillon@kernel.org, gregkh@linuxfoundation.org,
        wsa@the-dreams.de, arnd@arndb.de, broonie@kernel.org
Subject: Re: [RFC v2 1/4] i3c: master: export i3c_masterdev_type
Message-ID: <20200217155623.13a94802@collabora.com>
In-Reply-To: <7c742fba6c488b29f6fb15a5b910e799d50c5051.1580299067.git.vitor.soares@synopsys.com>
References: <cover.1580299067.git.vitor.soares@synopsys.com>
        <7c742fba6c488b29f6fb15a5b910e799d50c5051.1580299067.git.vitor.soares@synopsys.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020 13:17:32 +0100
Vitor Soares <Vitor.Soares@synopsys.com> wrote:

> Exporte i3c_masterdev_type so i3cdev module can verify if an i3c device
> is a master.
> 
> Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> ---
>  drivers/i3c/internals.h | 1 +
>  drivers/i3c/master.c    | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> index 86b7b44..bc062e8 100644
> --- a/drivers/i3c/internals.h
> +++ b/drivers/i3c/internals.h
> @@ -11,6 +11,7 @@
>  #include <linux/i3c/master.h>
>  
>  extern struct bus_type i3c_bus_type;
> +extern const struct device_type i3c_masterdev_type;
>  
>  void i3c_bus_normaluse_lock(struct i3c_bus *bus);
>  void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 7f8f896..8a0ba34 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -523,9 +523,10 @@ static void i3c_masterdev_release(struct device *dev)
>  	of_node_put(dev->of_node);
>  }
>  
> -static const struct device_type i3c_masterdev_type = {
> +const struct device_type i3c_masterdev_type = {
>  	.groups	= i3c_masterdev_groups,
>  };
> +EXPORT_SYMBOL_GPL(i3c_masterdev_type);

No need to export the symbol, removing the static and adding the
definition to internal.h should work just fine (i3c.o contains
both master.o and device.o).

>  
>  static int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode,
>  			    unsigned long max_i2c_scl_rate)

