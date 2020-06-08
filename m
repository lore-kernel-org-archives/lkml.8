Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3528CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E46207C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659404;
	bh=4kZSus6Sp1gMeKhcgP8+VZ03/LLAoT9JPsTdmVO+bag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TsvgJ4N3Gk7N/H+tZWkN4esOeq+lkLhEQPof8fVUZQ9+OimH6OWrxF23kThjT82j1
	 Qkzy+RaqqzbCV3VaQlRwRKNCi8WZcWbBSBTzPDb4aNtgtENT5/DR3h/ETrGJkVKmPF
	 pbpIZYKpniSu0SuIAarJH9ZB6dUJsAy6cDgYhFTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387754AbgFHXap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731655AbgFHXYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:24:43 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D06F2208A9;
        Mon,  8 Jun 2020 23:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658683;
        bh=4kZSus6Sp1gMeKhcgP8+VZ03/LLAoT9JPsTdmVO+bag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Si2oLuBzf22ZCtuQ/7ujy1Gsrnw7uAhdsofc8wTvlN5ux/Qe1UzJV3ejO+gdmuyqh
         SsXc5n/B4AXNj0ON3HARHcBv0+weApetNfcUcTqh6wB9apGb1MnJxBsv53rEK1PxbN
         mC2So5KaiR/J2h/WoEedcoZssGEaocdAGCVJEXZQ=
Received: by pali.im (Postfix)
        id A9332263E; Tue,  9 Jun 2020 01:24:40 +0200 (CEST)
Date:   Tue, 9 Jun 2020 01:24:40 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Y Paritcher <y.linux@paritcher.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mario.Limonciello@dell.com
Subject: Re: [PATCH v2 1/3] platform/x86: dell-wmi: add new backlight events
Message-ID: <20200608232440.a5tpxvf4mami563m@pali>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <cover.1591656154.git.y.linux@paritcher.com>
 <1ddd0496403199130532923e4ccb30481ff167b6.1591656154.git.y.linux@paritcher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ddd0496403199130532923e4ccb30481ff167b6.1591656154.git.y.linux@paritcher.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 June 2020 19:05:28 Y Paritcher wrote:
> Add events with a type of 0x0010 and a code of 0x57 / 0x58,
> this silences the following messages being logged on a
> Dell Inspiron 5593:
> 
> dell_wmi: Unknown key with type 0x0010 and code 0x0057 pressed
> dell_wmi: Unknown key with type 0x0010 and code 0x0058 pressed
> 
> These are brightness events and will be handled by acpi-video
> 
> Signed-off-by: Y Paritcher <y.linux@paritcher.com>

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/platform/x86/dell-wmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
> index c25a4286d766..0b2edfe2767d 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -255,6 +255,10 @@ static const struct key_entry dell_wmi_keymap_type_0010[] = {
>  	/* Keyboard backlight change notification */
>  	{ KE_IGNORE, 0x3f, { KEY_RESERVED } },
>  
> +	/* Backlight brightness level */
> +	{ KE_KEY,    0x57, { KEY_BRIGHTNESSDOWN } },
> +	{ KE_KEY,    0x58, { KEY_BRIGHTNESSUP } },
> +
>  	/* Mic mute */
>  	{ KE_KEY, 0x150, { KEY_MICMUTE } },
>  
> -- 
> 2.27.0
> 
