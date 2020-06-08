Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4688BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA5C2072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591606821;
	bh=KZWJxpYWOgiCYRu055opqAsK07kORzJUVrnD2CXM7wI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jfKCg5Se0TTInfb5jHjDYDx5poF6TjF0c92vRL+MXzOZueauy/DNVJNVM7p4hdP8U
	 4YBWl6tvuqT8Y2pAwbu4jaVEqvbUO67WS8Z0UUZNrJh+0nocqhvuCiNa1o6lBZLiAV
	 uPRUERKv0k+BnunV1dzZd9RNrnxR1E73HOky+Wfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgFHJAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 05:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgFHJAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:00:19 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27870206D5;
        Mon,  8 Jun 2020 09:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591606819;
        bh=KZWJxpYWOgiCYRu055opqAsK07kORzJUVrnD2CXM7wI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OBZt8c8y44pjfeidoX1yK2NB5mz4FKIJrOX0a1S5O1SxtdfRcYKXgkd40r3GwfKyk
         Y7hVN9OSw7sXCZDVaZiHXYQ2opPFsnQYp/ujFVZ/W5eHIW0lrnlTvo9XSixRrTTOHy
         6novshpBVZMGAtnZjLP9GhhR1ux1LglEvVH/d0mM=
Received: by pali.im (Postfix)
        id 689EAFB6; Mon,  8 Jun 2020 11:00:17 +0200 (CEST)
Date:   Mon, 8 Jun 2020 11:00:17 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Y Paritcher <y.linux@paritcher.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 3/3] platform/x86: dell-wmi: add keys to
 bios_to_linux_keycode
Message-ID: <20200608090017.4qgtbosz7oullex2@pali>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <13951508596a3f654c6d47f5380ddb4f38e2f6b5.1591584631.git.y.linux@paritcher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13951508596a3f654c6d47f5380ddb4f38e2f6b5.1591584631.git.y.linux@paritcher.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Monday 08 June 2020 00:22:26 Y Paritcher wrote:
> Increase length of bios_to_linux_keycode to 2 bytes to allow for a new
> keycode 0xffff, this silences the following messages being logged at
> startup on a Dell Inspiron 5593
> 
> dell_wmi: firmware scancode 0x48 maps to unrecognized keycode 0xffff
> dell_wmi: firmware scancode 0x50 maps to unrecognized keycode 0xffff
> 
> Signed-off-by: Y Paritcher <y.linux@paritcher.com>
> ---
>  drivers/platform/x86/dell-wmi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
> index f37e7e9093c2..5ef716e3034f 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -196,7 +196,7 @@ struct dell_dmi_results {
>  };
>  
>  /* Uninitialized entries here are KEY_RESERVED == 0. */
> -static const u16 bios_to_linux_keycode[256] = {
> +static const u16 bios_to_linux_keycode[65536] = {

This change dramatically increase memory usage. I guess other that
maintainers would not like such change.

>  	[0]	= KEY_MEDIA,
>  	[1]	= KEY_NEXTSONG,
>  	[2]	= KEY_PLAYPAUSE,
> @@ -237,6 +237,7 @@ static const u16 bios_to_linux_keycode[256] = {
>  	[37]	= KEY_UNKNOWN,
>  	[38]	= KEY_MICMUTE,
>  	[255]	= KEY_PROG3,
> +	[65535]	= KEY_UNKNOWN,

Also it seems that this change is not complete. It looks like that you
map two different scancodes (0x48 and 0x50) to same keycodes, moreover
both are unknown.

Could you please describe which key presses (or events) generate
delivering these WMI scancode events?

Note that purpose of printing unknown/unrecognized keys messages is to
inform that current pressed key was not processed or that it was
ignored.

For me it looks like this just just hide information that key was not
processed correctly as this change does not implement correct processing
of this key.

Also, could you share documentation about these 0x48/0x50 events? Or it
is under NDA?

>  };
>  
>  /*
> -- 
> 2.27.0
> 
