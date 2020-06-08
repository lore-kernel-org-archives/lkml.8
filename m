Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A8DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3971420760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591648582;
	bh=SsNN8Hhx2UTYZvuOqt+V/PMVs5Ui77zf0F9Ls8ozYPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iNyNwdsrNUZhY/KHy/YdTs9rQV7pkE2nTx+yyNO1MEiYd4BiI/G0S3dDSLms/ygdO
	 KKhOLklCJb6G29/LKJlb+jJlxOksgk44TJeoI0htyPVlKkz0NIIJdLm7WBRHklCzIt
	 1qIwQx9os22jjxP25AAA/ifnf914+FlJtOAC1dds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgFHUgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:36:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgFHUgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:36:21 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B6EC206D5;
        Mon,  8 Jun 2020 20:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591648580;
        bh=SsNN8Hhx2UTYZvuOqt+V/PMVs5Ui77zf0F9Ls8ozYPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0EtFVyFHES8nk8c0TJYr+QHKnrBJVaOjN4CbOTWl+zc5ua5euONocGNxwKNtKRIwC
         EFiAuM7j3e+KhSJ7O5rf4BIbxpyc5wSUzSCFSGZ0EdohaQKe/3mWcUCowNFCI0lUFm
         lOCqAY1CQl1e3zzitAIeobI06+GyX4VRSNA0de+8=
Received: by pali.im (Postfix)
        id ACD2EFB6; Mon,  8 Jun 2020 22:36:18 +0200 (CEST)
Date:   Mon, 8 Jun 2020 22:36:18 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Mario.Limonciello@dell.com
Cc:     y.linux@paritcher.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, mjg59@srcf.ucam.org
Subject: Re: [PATCH 1/3] platform/x86: dell-wmi: add new backlight events
Message-ID: <20200608203618.dhpu6gsvigzdnecv@pali>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <7dbe4e9e5ed64e4704b1c4ae13ac84df644ccc13.1591584631.git.y.linux@paritcher.com>
 <20200608083503.l5g5iq52ezxkobvv@pali>
 <3e0d394545954ed79b8f883e1ac93338@AUSX13MPC105.AMER.DELL.COM>
 <e91bb21e-98fa-f469-cc24-abc9ae200e4d@paritcher.com>
 <14b9e7d3a3e842e991e4e5e271b447e7@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14b9e7d3a3e842e991e4e5e271b447e7@AUSX13MPC105.AMER.DELL.COM>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 June 2020 20:14:15 Mario.Limonciello@dell.com wrote:
> > >>> index c25a4286d766..0b4f72f923cd 100644
> > >>> --- a/drivers/platform/x86/dell-wmi.c
> > >>> +++ b/drivers/platform/x86/dell-wmi.c
> > >>> @@ -252,6 +252,10 @@ static const struct key_entry
> > >> dell_wmi_keymap_type_0010[] = {
> > >>>  	/* Fn-lock switched to multimedia keys */
> > >>>  	{ KE_IGNORE, 0x1, { KEY_RESERVED } },
> > >>>
> > >>> +	/* Backlight brightness level */
> > >>> +	{ KE_KEY,    0x57, { KEY_BRIGHTNESSDOWN } },
> > >>> +	{ KE_KEY,    0x58, { KEY_BRIGHTNESSUP } },
> > >>> +
> > >
> > > For these particular events are they emitted by another interface as well
> > in this
> > > platform?
> > >
> > > If so they should be KE_IGNORE so you don't end up with double
> > notifications to
> > > userspace.
> > Thank you both for the review,
> > This is my first patch so if i am doing something wrong please let me know.
> > 
> > Both before and after this change they are only emitted once (verified via
> > showkeys)
> > this is because `dell_wmi_process_key()` calls
> > `acpi_video_handles_brightness_key_presses()`
> > for brightness events, and `acpi_video_handles_brightness_key_presses()`
> > makes sure no duplicate acpi-video events are sent.
> 
> That's good to hear that it also filters it, but my opinion is that dell-wmi.c
> should also filter it.  So just change KE_KEY to KE_IGNORE like the other events.

IIRC for other existing KEY_BRIGHTNESS* lines, KE_KEY/KE_IGNORE decision
is there just because kernel can be configured if ACPI layer would
handle them or not. And based on acpi_video_handles_brightness_key_presses()
function we know if ACPI layer processed these keys or not.

So in my opinion we should handle these new KEY_BRIGHTNESS* events in
the same way. So dell-wmi should process these events, but only in case
when ACPI layer did not processed them.
