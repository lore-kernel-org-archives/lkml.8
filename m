Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293CEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EB62072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591605308;
	bh=N5ib0Cm5Mh23WKzqB7RWLOabR8awuIJp/+tSEEOt/Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DJ2Tjh+o99C6he9ddeL0t1haHNXpKG58ALYIoJRlQmj28AF1yXFnYt80QYXoSWxLg
	 pI7P3k7ZaH2nIMXhkU4NGIOKxs1zY2wov8cTx6nlyK7RZBYFAnTzVa0mVe+z8wjk+N
	 IP2NawzrkcazgUuAYzxMcRJ+Hg90IGMhvtKkB0Zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgFHIfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgFHIfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:35:06 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F55E206A4;
        Mon,  8 Jun 2020 08:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591605306;
        bh=N5ib0Cm5Mh23WKzqB7RWLOabR8awuIJp/+tSEEOt/Oo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vHjd5ca7g/KLxaGTYNJKrv1r68V84W3OjA1KZ5EYnWCtWRW/f+1UiMorNHilla6SV
         TzVfmx2G8osrcYmJztGw2xmy6eX2byeZLzfImZ1uH/CR+fqJrd22pH1Ys4PDPmm4Nn
         mkojNZUFIEQ5ABBJOaZRLUrTTwX1fZs8Xmlx1XZ0=
Received: by pali.im (Postfix)
        id 1ECD2FB6; Mon,  8 Jun 2020 10:35:04 +0200 (CEST)
Date:   Mon, 8 Jun 2020 10:35:03 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Y Paritcher <y.linux@paritcher.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/3] platform/x86: dell-wmi: add new backlight events
Message-ID: <20200608083503.l5g5iq52ezxkobvv@pali>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <7dbe4e9e5ed64e4704b1c4ae13ac84df644ccc13.1591584631.git.y.linux@paritcher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dbe4e9e5ed64e4704b1c4ae13ac84df644ccc13.1591584631.git.y.linux@paritcher.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 June 2020 00:22:24 Y Paritcher wrote:
> Ignore events with a type of 0x0010 and a code of 0x57 / 0x58,
> this silences the following messages being logged on a
> Dell Inspiron 5593:
> 
> dell_wmi: Unknown key with type 0x0010 and code 0x0057 pressed
> dell_wmi: Unknown key with type 0x0010 and code 0x0058 pressed
> 
> Signed-off-by: Y Paritcher <y.linux@paritcher.com>
> ---
>  drivers/platform/x86/dell-wmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
> index c25a4286d766..0b4f72f923cd 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -252,6 +252,10 @@ static const struct key_entry dell_wmi_keymap_type_0010[] = {
>  	/* Fn-lock switched to multimedia keys */
>  	{ KE_IGNORE, 0x1, { KEY_RESERVED } },
>  
> +	/* Backlight brightness level */
> +	{ KE_KEY,    0x57, { KEY_BRIGHTNESSDOWN } },
> +	{ KE_KEY,    0x58, { KEY_BRIGHTNESSUP } },
> +
>  	/* Keyboard backlight change notification */
>  	{ KE_IGNORE, 0x3f, { KEY_RESERVED } },

Please, keep codes sorted.

>  
> -- 
> 2.27.0
> 
