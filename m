Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3EBC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 12:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF34206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 12:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ZPIEzQuv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="01Z/YLlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgBPMWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 07:22:00 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42389 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726651AbgBPMWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 07:22:00 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4FB4F209E5;
        Sun, 16 Feb 2020 07:21:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 16 Feb 2020 07:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=lF+rSyZKJiYeyANTIn3y1BWmlmX
        5LAbtCdmLpPMIfwI=; b=ZPIEzQuv2qun+WylAry/5ceboYc2EAU5jqVHZEOYlAW
        k+dCjXvbu2DPDMiy4v5tonjKAmm62gkgJpo0yhKMvrY6szglUKZ1hdUQhAoFFQRu
        /7YIbtsKyKDYupGcuTlAwAzpw3pdWYfr+KQnK/nMoZdZmT+fRDUZ8s9aZQJe5IbL
        IPUk//KqpoEcbKjNGNzburL6Ot9Fh9rrDiRYjLcCoFBoxJ0u4ub0hLXg3fC4zrcf
        XqmS+ZC6y+vStEeeDFlUSB1L5zYm6txwrTu1XphFxBbd4Qjr10kOQ6udz6NbEgGG
        afzUHTg6Gt2yy7jPvxrhjn61i4m5at3YeYUtpbjtJZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=lF+rSy
        ZKJiYeyANTIn3y1BWmlmX5LAbtCdmLpPMIfwI=; b=01Z/YLlWOfnqidQHCb+5qW
        hp7Ly2NhfYy/NZrQtLFOgW5RnaKLC77DTETrLCAjQjWFCchwM3n/qO5wJoReMwL4
        YqjsQE2kE4VlGiyi+L/TBekn4Gzm11Rb/A1yqXk0OVW1gqpRD4cQVFXihWx5SCZv
        MdLohTOz1mnNIs1QAq/z+T/dbAOSny7DW/W3szt5NsLlS/1YG3YOuOCj2cfPVq/a
        MUglHCD7/B4u7RQxBoJuwhgPE3V7w8qVZ5czoXn2cNk0w91qway65wT8Y5f+JCk1
        Z/ToVvYkIwJyqNDb/iuil8sHfrnu9m+InXiK6OVFoUwykIWm3lLldLZjttVw600w
        ==
X-ME-Sender: <xms:5zNJXo1kB5BOEelu5IoQLqP5m6PvAhdMqvGYLOx8HP9TmDUMI3RzyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeeggdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucfkphepkeefrdekiedrkeelrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:5zNJXp_52VkvojFnZUWUfvQUXGu_ArAK5t9fH0_hLfZi-qMtZYvezA>
    <xmx:5zNJXt2jOSMrNv9z82yuqLLRyiPp4zDTMzQ3Iifk2r01EOF3oJLU7g>
    <xmx:5zNJXu9cUux3umO8CLdx0QpugQXuoysZK-YsDTc7vp-CrWk-p4u0Bg>
    <xmx:5zNJXmN_HAOQljUYt6E0qJWsZCz1u5X6jT5Eg3x1ifuN1xDOUBFobw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id C89DB328005D;
        Sun, 16 Feb 2020 07:21:58 -0500 (EST)
Date:   Sun, 16 Feb 2020 13:21:56 +0100
From:   Greg KH <greg@kroah.com>
To:     sunnypranay <mpranay2017@gmail.com>
Cc:     abbotti@mev.co.uk, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: comedi: drivers: fixed errors warning coding
 style issue
Message-ID: <20200216122156.GA21307@kroah.com>
References: <20200216081518.3516-1-mpranay2017@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216081518.3516-1-mpranay2017@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 01:45:18PM +0530, sunnypranay wrote:
> Fixed a coding style issue.

What issue?

> 
> Signed-off-by: sunnypranay <mpranay2017@gmail.com>

We need a "real" name here, one that you use for documents.

> ---
>  drivers/staging/comedi/drivers.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers.c b/drivers/staging/comedi/drivers.c
> index 750a6ff3c03c..76395de100a6 100644
> --- a/drivers/staging/comedi/drivers.c
> +++ b/drivers/staging/comedi/drivers.c
> @@ -133,7 +133,7 @@ EXPORT_SYMBOL_GPL(comedi_alloc_subdevices);
>   * On success, @s->readback points to the first element of the array, which
>   * is zero-filled.  The low-level driver is responsible for updating its
>   * contents.  @s->insn_read will be set to comedi_readback_insn_read()
> - * unless it is already non-NULL.
> + * Unless it is already non-NULL.
>   *
>   * Returns 0 on success, -EINVAL if the subdevice has no channels, or
>   * -ENOMEM on allocation failure.
> @@ -282,8 +282,20 @@ EXPORT_SYMBOL_GPL(comedi_readback_insn_read);
>   * continue waiting or some other value to stop waiting (generally 0 if the
>   * condition occurred, or some error value).
>   *
> - * Returns -ETIMEDOUT if timed out, otherwise the return value from the
> - * callback function.
> + * Redback_insn_read() - A generic (*insn_read) for subdevice readback.
> + * @dev: COMEDI device.
> + * @s: COMEDI subdevice.
> + * @insn: COMEDI instruction.
> + * @data: Pointer to return the readback data.
> + * Handles the %INSN_READ instruction for subdevices that use the readback
> + * array allocated by comedi_alloc_subdev_readback().  It may be used
> + * directly as the subdevice's handler (@s->insn_read) or called via a
> + * wrapper.
> + * @insn->n is normally 1, which will read a single value.  If higher, the
> + * same element of the readback array will be read multiple times.
> + * Returns @insn->n on success,
> + * or -EINVAL if @s->readback is NULL.turns -ETIMEDOUT if timed out,
> + * otherwise the return value from the callback function.

Where did all of that come from?

thanks,

greg k-h
