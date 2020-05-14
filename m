Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C18C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 03:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 950E5206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 03:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="eNimw/DJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgENDod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 23:44:33 -0400
Received: from ozlabs.org ([203.11.71.1]:60175 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENDod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 23:44:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49My8X5x7Yz9sSt;
        Thu, 14 May 2020 13:44:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1589427871;
        bh=iZBASLOaTvF7r2NjS49achKXlbcYsjxWGScH+UJN7+c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=eNimw/DJzlqPCeltJf3xFIieLSyobV5R/UR20i6h2twzzFo8SZnATUOyUVJNRd4Sj
         bOx7/itrphk/18brAttlArSb2bsqu52A4od21eqFboK2ExwoINE8XFMcSX5km6u998
         ACWq6ttN0FGsk7zcgk/Ycwx6VZhs7YyMEyW7bxPwTg+CZ7yAwWeU5vDxCDgqNcAJ56
         3dg8lt/whgnaxIphmtObIZnLqiT5Tjs1s/pn+Yrg1m804aZgiaqCBIJdgHFFCV2YmL
         MtFMU/iFH9CZ7CKkkT9u6k0kA3MI13OLKQhSmgX81tYlS4oqO4H3jE+ogItM5M0Q7Q
         wnz5sxcVkrguQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Emil Velikov <emil.l.velikov@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     emil.l.velikov@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 06/11] powerpc/xmon: constify sysrq_key_op
In-Reply-To: <20200513214351.2138580-6-emil.l.velikov@gmail.com>
References: <20200513214351.2138580-1-emil.l.velikov@gmail.com> <20200513214351.2138580-6-emil.l.velikov@gmail.com>
Date:   Thu, 14 May 2020 13:44:46 +1000
Message-ID: <875zczb2oh.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emil Velikov <emil.l.velikov@gmail.com> writes:
> With earlier commits, the API no longer discards the const-ness of the
> sysrq_key_op. As such we can add the notation.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> ---
> Please keep me in the CC list, as I'm not subscribed to the list.
>
> IMHO it would be better if this gets merged this via the tty tree.

Fine by me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 7af840c0fc93..0d8ca5c9f131 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -3842,7 +3842,7 @@ static void sysrq_handle_xmon(int key)
>  		xmon_init(0);
>  }
>  
> -static struct sysrq_key_op sysrq_xmon_op = {
> +static const struct sysrq_key_op sysrq_xmon_op = {
>  	.handler =	sysrq_handle_xmon,
>  	.help_msg =	"xmon(x)",
>  	.action_msg =	"Entering xmon",
> -- 
> 2.25.1
