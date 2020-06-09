Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD296C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C292078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591692036;
	bh=jh4pPeDllLIa0gzajHtaJgN8gFI5M1S9vMW6hQg+A4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S+s2xaF8m8M4lju7+lv/oPgYlxfs0S84T0nWdOrtsj8cc6gice2zGxntzjpd4xuoA
	 8T7IhXI5YhEwsYs2hpR/BPZnNhwYPF79v0+V7aYUHIgAmPcjoe2tDTVw52wu5pxsZi
	 XPD/you6oArsvt8HxUmvdb5VEaoPV6L+f1seD6iI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgFIIkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgFIIkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:40:35 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD8492078D;
        Tue,  9 Jun 2020 08:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591692034;
        bh=jh4pPeDllLIa0gzajHtaJgN8gFI5M1S9vMW6hQg+A4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ycVrdILeVIX9+DRAS1oTAQC8ICKIWRxGRSCCmnrPC114tgfiiRBqSBhoLfi2K7dCu
         O4cz9RTId2frkHAftqAxTLnk7WC59rZQ1VeSK35TFy0QUQGmA9qJ776Jlqpubv5HXk
         UqkWkQ4IkStyT13yu70eQOj24AqC78YVHxiXWeW8=
Received: by pali.im (Postfix)
        id 9C3F5884; Tue,  9 Jun 2020 10:40:31 +0200 (CEST)
Date:   Tue, 9 Jun 2020 10:40:31 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Y Paritcher <y.linux@paritcher.com>
Cc:     Mario.Limonciello@dell.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, mjg59@srcf.ucam.org
Subject: Re: [PATCH v2 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Message-ID: <20200609084031.3hibhhygpgns4s73@pali>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <cover.1591656154.git.y.linux@paritcher.com>
 <74fdb288757cf5970a558f920f531b3bd1c51b47.1591656154.git.y.linux@paritcher.com>
 <20200608233303.57ubv4rxo4tnaaxa@pali>
 <295ad85ecc464a57bffd5b783d4170a1@AUSX13MPC105.AMER.DELL.COM>
 <2d4b308d-ce03-b13b-0140-4bbe669878c4@paritcher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d4b308d-ce03-b13b-0140-4bbe669878c4@paritcher.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 June 2020 20:57:38 Y Paritcher wrote:
> On 6/8/20 8:26 PM, Mario.Limonciello@dell.com wrote:
> >> -----Original Message-----
> >> From: Pali Rohár <pali@kernel.org>
> >> Sent: Monday, June 8, 2020 6:33 PM
> >> To: Y Paritcher
> >> Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
> >> Matthew Garrett; Limonciello, Mario
> >> Subject: Re: [PATCH v2 2/3] platform/x86: dell-wmi: add new keymap type
> >> 0x0012
> >>
> >>
> >> [EXTERNAL EMAIL]
> >>
> >> On Monday 08 June 2020 19:05:29 Y Paritcher wrote:
> >>> These are events with extended data. The extended data is
> >>> currently ignored as userspace does not have a way to deal
> >>> it.
> >>>
> >>> Ignore event with a type of 0x0012 and a code of 0xe035, as
> >>> the keyboard controller takes care of Fn lock events by itself.
> >>
> >> Nice! This is information which is really important and need to have it
> >> documented.
> >>
> >>> This silences the following messages being logged when
> >>> pressing the Fn-lock key on a Dell Inspiron 5593:
> >>>
> >>> dell_wmi: Unknown WMI event type 0x12
> >>> dell_wmi: Unknown key with type 0x0012 and code 0xe035 pressed
> >>>
> >>> This is consistent with the behavior for the Fn-lock key
> >>> elsewhere in this file.
> >>>
> >>> Signed-off-by: Y Paritcher <y.linux@paritcher.com>
> >>
> >> I'm fine with this patch now.
> >>
> >> Reviewed-by: Pali Rohár <pali@kernel.org>
> >>
> >>> ---
> >>>  drivers/platform/x86/dell-wmi.c | 20 +++++++++++++++++++-
> >>>  1 file changed, 19 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-
> >> wmi.c
> >>> index 0b2edfe2767d..6b510f8431a3 100644
> >>> --- a/drivers/platform/x86/dell-wmi.c
> >>> +++ b/drivers/platform/x86/dell-wmi.c
> >>> @@ -334,6 +334,15 @@ static const struct key_entry
> >> dell_wmi_keymap_type_0011[] = {
> >>>  	{ KE_IGNORE, KBD_LED_AUTO_100_TOKEN, { KEY_RESERVED } },
> >>>  };
> >>>
> >>> +/*
> >>> + * Keymap for WMI events of type 0x0012
> >>> + * They are events with extended data
> >>> + */
> >>> +static const struct key_entry dell_wmi_keymap_type_0012[] = {
> >>> +	/* Fn-lock button pressed */
> >>> +	{ KE_IGNORE, 0xe035, { KEY_RESERVED } },
> >>> +};
> >>> +
> >>>  static void dell_wmi_process_key(struct wmi_device *wdev, int type, int
> >> code)
> >>>  {
> >>>  	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> >>> @@ -418,10 +427,11 @@ static void dell_wmi_notify(struct wmi_device
> >> *wdev,
> >>>
> >>>  		switch (buffer_entry[1]) {
> >>>  		case 0x0000: /* One key pressed or event occurred */
> >>> +		case 0x0012: /* Event with extended data occurred */
> > 
> > I don't really like this being handled as a key as it's just discarding all
> > that extended data.

It is not ideal. But currently we handle all events as key press. And
non-key events are marked as ignored.

I agree, it should be handled in better way. But that needs to extend
driver. But it is something which should be done in next patches, not in
this one (if somebody has time to do it, etc...).

> >>
> >> Mario, are you able to get some official documentation for these 0x0012
> >> event types? I think it could be really useful for community so they can
> >> understand and add easily new type of code and events. Because currently
> >> we are just guessing what it could be. (It is sequence? Or single event?
> >> Or single event with extended data? It is generic event? Or it is real
> >> keypress? etc...)
> > 
> > It's a single event with more data in the subsequent words.  It is definitely
> > not a real keypress.  It's supposed to be data that a user application would show.
> > 
> > Remember the way WMI works on Linux and Windows is different.  On Windows
> > userland applications get the events directly.  On Linux kernel drivers get the
> > events and either use it internally, pass to another kernel driver or pass to
> > userland in the form of a translated event.
> > 
> > So on Windows the whole buffer gets looked at directly by the application and the
> > application will decode it to show a translated string.
> > 
> > I can certainly discuss internally about our team releasing a patch to export
> > all these other events.  I would like to know what interface to recommend it pass
> > to userspace though, because as I said this is more than just a keycode that
> > comes through in the event.  It's not useful to just do dev_info, it really should
> > be something that userspace can act on and show a translated message.
> > I don't think we want to add another 15 Dell specific keycodes to the kernel for the
> > various events and add another 4 more when a laptop introduces another set of keys.
> > 
> 
> We can treat this as a key for now. This gets rid of the unnecessary log messages.
> 
> When adecision is made about how to handle extended events it will be very easy
> just to make this its own case statement and handle with it separately.

I agree. Handle it in the same way like we handle all other events. That
would make it easier to migrate to the new way, once it is there.

> However if you want to pass Fn lock event to userspace there are keys from older
> models of type 0010:
>     /* Fn-lock switched to function keys */
>     { KE_IGNORE, 0x0, { KEY_RESERVED } },
> 
>     /* Fn-lock switched to multimedia keys */
>     { KE_IGNORE, 0x1, { KEY_RESERVED } },
> 
> They should also be changed to be passed to userspace and they don't signify status
> with extended data rather by which event is called.
> 
> This means that passing these types of events to userspace is a separate task, that
> might require rethinking the entire design of how all event types are treated.
> 
> The current patch will be necessary regardless of what is decided in regards to
> passing the events on, and continues the status quo.
> >>
> >>>  			if (len > 2)
> >>>  				dell_wmi_process_key(wdev, 0x0000,
> >>>  						     buffer_entry[2]);
> >>> -			/* Other entries could contain additional information */
> >>> +			/* Extended data is currently ignored */
> >>>  			break;
> >>>  		case 0x0010: /* Sequence of keys pressed */
> >>>  		case 0x0011: /* Sequence of events occurred */
> >>> @@ -556,6 +566,7 @@ static int dell_wmi_input_setup(struct wmi_device
> >> *wdev)
> >>>  			 ARRAY_SIZE(dell_wmi_keymap_type_0000) +
> >>>  			 ARRAY_SIZE(dell_wmi_keymap_type_0010) +
> >>>  			 ARRAY_SIZE(dell_wmi_keymap_type_0011) +
> >>> +			 ARRAY_SIZE(dell_wmi_keymap_type_0012) +
> >>>  			 1,
> >>>  			 sizeof(struct key_entry), GFP_KERNEL);
> >>>  	if (!keymap) {
> >>> @@ -600,6 +611,13 @@ static int dell_wmi_input_setup(struct wmi_device
> >> *wdev)
> >>>  		pos++;
> >>>  	}
> >>>
> >>> +	/* Append table with events of type 0x0012 */
> >>> +	for (i = 0; i < ARRAY_SIZE(dell_wmi_keymap_type_0012); i++) {
> >>> +		keymap[pos] = dell_wmi_keymap_type_0012[i];
> >>> +		keymap[pos].code |= (0x0012 << 16);
> >>> +		pos++;
> >>> +	}
> >>> +
> >>>  	/*
> >>>  	 * Now append also table with "legacy" events of type 0x0000. Some of
> >>>  	 * them are reported also on laptops which have scancodes in DMI.
> >>> --
> >>> 2.27.0
> >>>
