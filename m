Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571D3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21F012068D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fii8ZR3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbgFHXmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732123AbgFHX1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:27:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14266C08C5C2;
        Mon,  8 Jun 2020 16:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=xyZktwFw/PfsepqoistGI2Zu+WjsJE4jBtC4bLVR/g8=; b=Fii8ZR3Zn1fZFppUKCqm/mn0Dq
        UBpNtB5T+cpC0wr3Jrs+s3i2idqfUkLdYq3lL1Hpk4JwBtRwFfaQAfSxvrpA+d48EU7sEc5DRYe6i
        grcj1T87C4EgzRG2XZOSpnd5ggrc6vqRoM2NSrS4v9EIxFPRPaPdYbry4SBd0XNPbQx0ioKUUDJbK
        B9l4Ib84cCkXQ5zeUEjxX0bugeeii4iwsxTAuswXTW4DTJL7Vf0Q9ZCAEcLESx9GqbxV001Dguhz1
        XafVgjFI/Uqab7m9UfW4kOIDyf2tJnQh9ATHNZf4X789rri0PyEipT/zjeWrXvQ8GSMIOPOsF5bLb
        3rXV9wNw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiRAe-000826-92; Mon, 08 Jun 2020 23:27:12 +0000
Subject: Re: [PATCH v2 3/3] platform/x86: dell-wmi: add new dmi keys to
 bios_to_linux_keycode
To:     Y Paritcher <y.linux@paritcher.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Mario.Limonciello@dell.com
References: <cover.1591584631.git.y.linux@paritcher.com>
 <cover.1591656154.git.y.linux@paritcher.com>
 <d585d2a0f01a6b9480352530b571dec2d1afd79f.1591656154.git.y.linux@paritcher.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8053252a-83ad-bcaa-2830-ccfbca1b4152@infradead.org>
Date:   Mon, 8 Jun 2020 16:27:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d585d2a0f01a6b9480352530b571dec2d1afd79f.1591656154.git.y.linux@paritcher.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/8/20 4:05 PM, Y Paritcher wrote:
> Increase length of bios_to_linux_keycode to 2 bytes (the true size of a
> keycode) to allow for a new keycode 0xffff, this silences the following
> messages being logged at startup on a Dell Inspiron 5593:
> 
>     dell_wmi: firmware scancode 0x48 maps to unrecognized keycode 0xffff
>     dell_wmi: firmware scancode 0x50 maps to unrecognized keycode 0xffff
> 
> as per this code comment:
> 
>    Log if we find an entry in the DMI table that we don't
>    understand.  If this happens, we should figure out what
>    the entry means and add it to bios_to_linux_keycode.
> 
> These are keycodes included in the 0xB2 DMI table, for which the
> corosponding keys are not known.

  corresponding

> 
> Now when a user will encounter this key, a proper message wil be printed:
> 
>     dell_wmi: Unknown key with type 0xXXXX and code 0xXXXX pressed
> 
> This will then allow the key to be identified properly.
> 
> Signed-off-by: Y Paritcher <y.linux@paritcher.com>
> ---
>  drivers/platform/x86/dell-wmi.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
> index 6b510f8431a3..dae1db96b5a0 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -196,7 +196,7 @@ struct dell_dmi_results {
>  };
>  
>  /* Uninitialized entries here are KEY_RESERVED == 0. */
> -static const u16 bios_to_linux_keycode[256] = {
> +static const u16 bios_to_linux_keycode[65536] = {

It surely seems odd to me to expand an array from 512 bytes to 128 Kbytes
just to handle one special case.  Can't it be handled in code as a
special case?

>  	[0]	= KEY_MEDIA,
>  	[1]	= KEY_NEXTSONG,
>  	[2]	= KEY_PLAYPAUSE,
> @@ -237,6 +237,7 @@ static const u16 bios_to_linux_keycode[256] = {
>  	[37]	= KEY_UNKNOWN,
>  	[38]	= KEY_MICMUTE,
>  	[255]	= KEY_PROG3,
> +	[65535]	= KEY_UNKNOWN,
>  };
>  
>  /*
> @@ -503,10 +504,7 @@ static void handle_dmi_entry(const struct dmi_header *dm, void *opaque)
>  					&table->keymap[i];
>  
>  		/* Uninitialized entries are 0 aka KEY_RESERVED. */
> -		u16 keycode = (bios_entry->keycode <
> -			       ARRAY_SIZE(bios_to_linux_keycode)) ?
> -			bios_to_linux_keycode[bios_entry->keycode] :
> -			KEY_RESERVED;
> +		u16 keycode = bios_to_linux_keycode[bios_entry->keycode];
>  
>  		/*
>  		 * Log if we find an entry in the DMI table that we don't
> 

Something like:

		u16 keycode;

		keycode = bios_entry->keycode == 0xffff ? KEY_UNKNOWN :
			(bios_entry->keycode <
			       ARRAY_SIZE(bios_to_linux_keycode)) ?
			bios_to_linux_keycode[bios_entry->keycode] :
			KEY_RESERVED;



Also please fix this:
(no To-header on input) <>

-- 
~Randy

