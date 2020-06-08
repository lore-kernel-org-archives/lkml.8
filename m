Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED1AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F39002067B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591606217;
	bh=/yre4sR37dtBBlbohMxTN26j1x6NmVSllEwBVqDc22Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OsbnTApReuDnhy9+XbXsA9P41Kpr2upz+NH8jEH5/2tY/rKelQE0zG0BYJ/cGaXpK
	 N9q+QqsHcNbsUyQH38/QKKLaWq3FR0M7hS/Bu+UqZkHYQPG3YCGHVxQLnE+dhBC4Wt
	 SDFkhgtwIK+9wNgHTt1nVXke75aS4RbMFLFhejXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgFHIuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729085AbgFHIuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:50:15 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A8972067B;
        Mon,  8 Jun 2020 08:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591606214;
        bh=/yre4sR37dtBBlbohMxTN26j1x6NmVSllEwBVqDc22Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AyEVAxVoLnEbLnbpBXbz5jB0r+cZaGiGDwvBAsJxUYfqU6zeb00ItZk+GyCMFpeME
         HTpECf9MiIyjXFXyA6C9ij/f0CcYtsS9drdMljiMKvQ36mZyu/tvdOy+x1+PZTI7Ie
         Q1D9KjWO9gzEjfrp0E/g2flenfIi7LNgJ46l4rp4=
Received: by pali.im (Postfix)
        id 8B7EDFB6; Mon,  8 Jun 2020 10:50:12 +0200 (CEST)
Date:   Mon, 8 Jun 2020 10:50:12 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Y Paritcher <y.linux@paritcher.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Message-ID: <20200608085012.ve2zefw26hisagso@pali>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Monday 08 June 2020 00:22:25 Y Paritcher wrote:
> Ignore events with a type of 0x0012 and a code of 0xe035,
> this silences the following messages being logged when
> pressing the Fn-lock key on a Dell Inspiron 5593:

Could you please explain why to ignore these events instead of sending
them to userspace via input layer? I think that userspace can be
interested in knowing when Fn lock key was pressed and I can imagine
that some it can use it for some purposes.

> dell_wmi: Unknown WMI event type 0x12
> dell_wmi: Unknown key with type 0x0012 and code 0xe035 pressed

These messages are printed to inform about fact that some events were
not processed. And they should not be silenced without reason. If for
some reasons it is needed to completely ignore some kind of events then
this reason should be documented (e.g. in commit message) so other
developers would know why that code is there. Not all Linux developers
have all those Dell machines for testing so they do not know all
hardware details.

> Signed-off-by: Y Paritcher <y.linux@paritcher.com>
> ---
>  drivers/platform/x86/dell-wmi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
> index 0b4f72f923cd..f37e7e9093c2 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -334,6 +334,14 @@ static const struct key_entry dell_wmi_keymap_type_0011[] = {
>  	{ KE_IGNORE, KBD_LED_AUTO_100_TOKEN, { KEY_RESERVED } },
>  };
>  
> +/*
> + * Keymap for WMI events of type 0x0012
> + */
> +static const struct key_entry dell_wmi_keymap_type_0012[] = {
> +	/* Fn-lock button pressed */
> +	{ KE_IGNORE, 0xe035, { KEY_RESERVED } },
> +};
> +
>  static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
>  {
>  	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> @@ -425,6 +433,7 @@ static void dell_wmi_notify(struct wmi_device *wdev,
>  			break;
>  		case 0x0010: /* Sequence of keys pressed */
>  		case 0x0011: /* Sequence of events occurred */
> +		case 0x0012: /* Sequence of events occurred */

It is really sequence of events? Because you wrote that Fn-lock key was
pressed (and not generic event). Also it is really sequence? And not
just one event/key-press (with possibility of some additional details in
buffer)? It would be nice to put documentation for this type of events
to check and review that implementation is correct.

>  			for (i = 2; i < len; ++i)
>  				dell_wmi_process_key(wdev, buffer_entry[1],
>  						     buffer_entry[i]);
> @@ -556,6 +565,7 @@ static int dell_wmi_input_setup(struct wmi_device *wdev)
>  			 ARRAY_SIZE(dell_wmi_keymap_type_0000) +
>  			 ARRAY_SIZE(dell_wmi_keymap_type_0010) +
>  			 ARRAY_SIZE(dell_wmi_keymap_type_0011) +
> +			 ARRAY_SIZE(dell_wmi_keymap_type_0012) +
>  			 1,
>  			 sizeof(struct key_entry), GFP_KERNEL);
>  	if (!keymap) {
> @@ -600,6 +610,13 @@ static int dell_wmi_input_setup(struct wmi_device *wdev)
>  		pos++;
>  	}
>  
> +	/* Append table with events of type 0x0012 */
> +	for (i = 0; i < ARRAY_SIZE(dell_wmi_keymap_type_0012); i++) {
> +		keymap[pos] = dell_wmi_keymap_type_0012[i];
> +		keymap[pos].code |= (0x0012 << 16);
> +		pos++;
> +	}
> +
>  	/*
>  	 * Now append also table with "legacy" events of type 0x0000. Some of
>  	 * them are reported also on laptops which have scancodes in DMI.
> -- 
> 2.27.0
> 
