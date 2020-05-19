Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D701DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF0A820758
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589910702;
	bh=qO414KmS7DC9vV6JVgPfD94wbq+HHVcUHYLT24PVLi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=StzII+Pwv/wb2tvpldcKQXH0/P1w49uXZhWZ351b+yfak31Q2kT5rc5aTDbOBqsK9
	 Lfmr0t3wTDVwDU0JN7s0pGp9HsCf7b5BUhMS3ojBIqVpmnRAhd6Jx+uDMvzsEa1zs9
	 5oY76mNviI3OxzYSufHB3YBG7xXI9e7f3itYKPSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgESRvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 13:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgESRvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:51:41 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D8A120674;
        Tue, 19 May 2020 17:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589910701;
        bh=qO414KmS7DC9vV6JVgPfD94wbq+HHVcUHYLT24PVLi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pqiFlhxX8oinm7AVG1bzCGFtft9PrwLRVxBchE7Kyf7wFvpUQMws8j57PI2yZyuMV
         0AX1gUUJDc9MIkchZYqXtmh4YmnIYkVPzZpN9VngSWu6ib/JmCoJe2hCXcMyOzOt6X
         N/wpsyauyJERxQRtDD/Umh1UqoJjVkDCjGo6extI=
Received: by pali.im (Postfix)
        id CCCE46B8; Tue, 19 May 2020 19:51:38 +0200 (CEST)
Date:   Tue, 19 May 2020 19:51:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-wmi: Ignore keyboard attached /
 detached events
Message-ID: <20200519175138.xu7pquxyku6mwjwt@pali>
References: <20200513130544.90243-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200513130544.90243-1-hdegoede@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 May 2020 15:05:44 Hans de Goede wrote:
> Ignore events with a type of 0x0011 and a code of 0xfff2 / 0xfff3,
> this silences the following messages being logged when the keyboard is
> detached / attached on a Dell Venue 11 Pro 7130:
> 
> [   63.621953] dell_wmi: Unknown key with type 0x0011 and code 0xfff2 pressed
> [   70.240558] dell_wmi: Unknown key with type 0x0011 and code 0xfff3 pressed
> 
> Note SW_TABLET_MODE is already reported through the intel_vbtn driver on
> this and other Dell devices, so dell_wmi should not report this too,
> to avoid duplicate events.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Looks good, you can add my:

Acked-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/platform/x86/dell-wmi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
> index 86e8dd6a8b33..c25a4286d766 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -310,6 +310,16 @@ static const struct key_entry dell_wmi_keymap_type_0011[] = {
>  	/* Battery inserted */
>  	{ KE_IGNORE, 0xfff1, { KEY_RESERVED } },
>  
> +	/*
> +	 * Detachable keyboard detached / undocked
> +	 * Note SW_TABLET_MODE is already reported through the intel_vbtn
> +	 * driver for this, so we ignore it.
> +	 */
> +	{ KE_IGNORE, 0xfff2, { KEY_RESERVED } },
> +
> +	/* Detachable keyboard attached / docked */
> +	{ KE_IGNORE, 0xfff3, { KEY_RESERVED } },
> +
>  	/* Keyboard backlight level changed */
>  	{ KE_IGNORE, KBD_LED_OFF_TOKEN,      { KEY_RESERVED } },
>  	{ KE_IGNORE, KBD_LED_ON_TOKEN,       { KEY_RESERVED } },
> -- 
> 2.26.0
> 
