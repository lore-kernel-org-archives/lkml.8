Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8E0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEB4D20814
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591694399;
	bh=9FJwkfN1H2pieeAp+SCp/YPLUVWuwCDSFsBpYP7T0+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lGHB9GDRR7fCGEu/Fc1sYtAv+4VdDf+7+1fxfBD5cHFyzkEjQE4KhTwahNACoRKVE
	 OW3IJ4wwtcWJ4oXnNY+4kLqFf6E3LgUv2ihJKag6M/pjL4YxB2V+NWhyiet5Z+8dGY
	 t8JVDUTz9jARVWHW50PypQNeLQjwGg5b5LFS6mY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgFIJT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 05:19:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728366AbgFIJTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 05:19:55 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E787320814;
        Tue,  9 Jun 2020 09:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591694395;
        bh=9FJwkfN1H2pieeAp+SCp/YPLUVWuwCDSFsBpYP7T0+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GESDfcva2ACXfkbdnW4yixGI0Pb06AKK4+lYgJoyGMqGCyAbU0MrM5ittsz6C5see
         MwFiJLwJErLmLHwTj7q9nTv8kmycbfUnMREH0o9f5/feQWTtT88PdJmEODYHqxjUg+
         eCfL4rqaPE51tOJRMli3EevxAHd1UheW3MqSVQ2U=
Received: by pali.im (Postfix)
        id C0DF8884; Tue,  9 Jun 2020 11:19:52 +0200 (CEST)
Date:   Tue, 9 Jun 2020 11:19:52 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Y Paritcher <y.linux@paritcher.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mario.Limonciello@dell.com
Subject: Re: [PATCH v3 3/3] platform/x86: dell-wmi: add new dmi mapping for
 keycode 0xffff
Message-ID: <20200609091952.myqtorlp42aiqpup@pali>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <cover.1591673143.git.y.linux@paritcher.com>
 <e2f6b5ee27a3a6142a2f8806be8dfbce442548da.1591673143.git.y.linux@paritcher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2f6b5ee27a3a6142a2f8806be8dfbce442548da.1591673143.git.y.linux@paritcher.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Darren and Andy, please look at this issue as this is something
which should be decided how to handle in all platform/wmi drivers.

On Monday 08 June 2020 23:52:54 Y Paritcher wrote:
> This looks to be a special value for some sort of custom scancode.
> This code could not be triggered for any keypress and is included
> from the 0xB2 DMI table.
> 
> This prevents the following messages from being logged at startup on a
> Dell Inspiron 5593:
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
> Signed-off-by: Y Paritcher <y.linux@paritcher.com>
> ---
>  drivers/platform/x86/dell-wmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
> index e3bc2601e631..bbdb3e860892 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -506,7 +506,7 @@ static void handle_dmi_entry(const struct dmi_header *dm, void *opaque)
>  		u16 keycode = (bios_entry->keycode <
>  			       ARRAY_SIZE(bios_to_linux_keycode)) ?
>  			bios_to_linux_keycode[bios_entry->keycode] :
> -			KEY_RESERVED;
> +			(bios_entry->keycode == 0xffff ? KEY_UNKNOWN : KEY_RESERVED);

I really do not like this patch in this form as it is inconsistent with
how are these key codes processed. And also because it does not solve
any problem. It just hides existence of the problem. And this is
something which should be avoided as it makes debugging harder and
basically does not bring any value.

To explain it a bit more. We have mapping table bios_to_linux_keycode[]
from Dell BIOS key codes to Linux key codes. This mapping table is used
for processing Dell WMI buffer of type 0x0010.

You are not able to trigger these events and therefore you and nobody
else in this discussion does not know yet what real key triggers this
Dell BIOS key code.

So it means that you are proposing to add "bogus" value into
bios_to_linux_keycode[] table (just implicitly via check to reduce
memory usage, but it does not matter) just because to hide existence of
the problem.

This bogus value "KEY_UNKNOWN" is there just as a placeholder because
nobody know correct value and nobody was able to trigger it.

Also how it differs situation with unknown keycode "39" which is also
missing in the table from yours with keycode "65535" which is also
missing in the table?

I think there is no difference, for both values we do not know what is
correct mapping to Linux keycodes and therefore value is not present in
bios_to_linux_keycode[] table.

If I accept to take this bogus value for keycode "65535", tomorrow can
somebody send me a patch which adds bogus value "1000" for the same
reason as you as it makes precedense. But it also does not solve any
problem.

We would just end up with mess and garbage in bios_to_linux_keycode[]
mapping table together with some correct values in table.

So we should ask here two main questions:

1) Is dell-wmi able to process key presses (or events) with scancode
0x48 and keycode 0xffff?

2) If we are not able to process them, what should we do?

Answer for first question is definitely "no".

And answer for second question, I'm not sure, but I thought that
throwing warning or info message is the correct solution. Driver cannot
handle something, so it inform about it, instead of silently dropping
event. Same behavior I'm seeing in other kernel drivers.

But looks like that you and Mario have opposite opinion, that kernel
should not log unknown events and rather should drop them.

I would like to have behavior of dell-wmi same as in other drivers for
consistency, so the best would be to ask WMI/platform maintainers. They
could have opinion how to handle these problem globally.

...

Darren & Andy, could you please say something to this, what do you think
about silently dropping events/actions which are currently unknown for
dell-wmi driver? It is better to log them or not? Currently we are
logging them.

>  
>  		/*
>  		 * Log if we find an entry in the DMI table that we don't
> -- 
> 2.27.0
> 
