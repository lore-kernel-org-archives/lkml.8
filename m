Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CB3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 130B02072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="uH4FX2c6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgEUKdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 06:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgEUKdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 06:33:47 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3EEC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 03:33:46 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id z3so5102975otp.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 03:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BOAM0G0ep685BfrMMBrzsYRUAH+LriI/QnKS9UMVwNk=;
        b=uH4FX2c6naImNpjF1yQheOyvouai08mR4fONjux3LXSwa3atWtvcysuGNlXmbrb2pN
         wRJ1on7y169STLPyifgebGjBJUp4EubM6NTntvwVHxEBoXDUL0fj2fzTWI+cl7JkmyjK
         IJys+HFLx2Q67txxqeDno/tSCHQOokbC3WZOHjoaptNlXp6rDVji/5NZfPTiTY1MNW08
         fS2BDjYIqJTkHLfRTVVF7HzzbLiXNGUfSPX9s4FisYDCQUOV0beVy1YvZa/HukO+DX/u
         9W0HyWNLnI9NAyu+QV/QDl1/qiCK7ZcHFpfJx5EiOT1O0M4qSVauCMeTgNH6Ad+FbxZz
         l4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BOAM0G0ep685BfrMMBrzsYRUAH+LriI/QnKS9UMVwNk=;
        b=rpMKaGrscPqFIEOYpXTPI0/2PM59jiX3CfqyTdpG8+GTpQ1ugvQ6XfOcSi/2ViTcbz
         /0DQIwza/saKvIm+B9XAKn3VfwAstyMTZKWIOwBNFZXCTaFQ6lpLxnaddsDP54t3NLL6
         kyD+QQ0KA6j+WTUQRSesGEHSYM05UphLs0llZfK9VrGIgD+ByVDkDo9mAXcaoMvUdJrM
         O11LGeMfUCnSL+ybOdEYF8+heHiQJnSJERjam2UpnFo1Iw93pFm82/IYQPB9nmz5EgYA
         iNivE4Xw1rA0MSk+acKHzD6dWD4CDzv5LThAft/VjASW4gjauJCrNgBfGHvGfg1G9+55
         FYjw==
X-Gm-Message-State: AOAM532ZoZ/TYensB6p70woO8QQBnZYxyM3c+XpifphgRW82wc6yS2L1
        PwA10/dDtu5gpLR2nxILRBy/TcJw01BglCiz3pwRdQ==
X-Google-Smtp-Source: ABdhPJwwl/pmo34XMx/bgS2GIn2MGs3NQHbfZ5KuMsiWv3SazK0fO1syIUSWbDavZ8iyAhFZ0WAU2t/9+eYeCvS63uM=
X-Received: by 2002:a9d:6ac9:: with SMTP id m9mr6583072otq.33.1590057225584;
 Thu, 21 May 2020 03:33:45 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 21 May 2020 18:33:34 +0800
Message-ID: <CAB4CAweJ6Zi2DqQ5qgQq-apAMzSSk3uzoohEJ443F5T=LohAAA@mail.gmail.com>
Subject: asus-wmi fails to load on new ASUS laptop UX325JA
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        gregkh@linuxfoundation.org, gayatri.kammela@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I have the ASUS new laptop UX325JA and most of the media keys are
not working even with the latest kernel (5.7.0-rc5+). Looking into the
dmesg log, the ASUS WMI driver fails to load because of
[    7.827241] asus-nb-wmi: probe of asus-nb-wmi failed with error -5.

    Before this message, the following message repeat 5 times, please
check the full dmesg log here
https://gist.github.com/mschiu77/9a53cd8ff17029e949210dfb3ec1213f
[    7.825975] ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT, Field
[IIA3] at bit offset/length 96/32 exceeds size of target Buffer (96
bits) (20200326/dsopcode-203)
[    7.825985] No Local Variables are initialized for Method [WMNB]
[    7.826005] ACPI Error: Aborting method \_SB.ATKD.WMNB due to
previous error (AE_AML_BUFFER_LIMIT) (20200326/psparse-531)

    It fails the \_SB.ATKD.WMNB because the local variable IIA3
exceeds the buffer limit. The WMNB is the function to deal with all
ASUS WMI functions, such as ASUS_WMI_METHODID_INIT...etc. The related
code in DSDT is as follows. The full DSDT is here
https://gist.github.com/mschiu77/849c6cb89a8d8cadd015fa75465882dd

Method (WMNB, 3, Serialized)
{
    P8XH (Zero, 0x11)
    CreateDWordField (Arg2, Zero, IIA0)
    CreateDWordField (Arg2, 0x04, IIA1)
    CreateDWordField (Arg2, 0x08, IIA2)
    CreateDWordField (Arg2, 0x0C, IIA3)
    CreateDWordField (Arg2, 0x10, IIA4)
    Local0 = (Arg1 & 0xFFFFFFFF)
    If ((Local0 == 0x54494E49))

    Just as the error messages indicated,  the IIA3 is out of boundary
for the target Buffer. The limit 96bits (12 bytes) is determined by
the input acpi_buffer size, which refers to internally defined struct
bios_args, in asus_wmi_evaluate_method3. Because all ASUS WMI
evaluations will invoke  asus_wmi_evaluate_method3 at last, so all
ASUS WMI functions fail to work. I can simply fix this by extending
the bios_args from 3 args to 5 u32 args as follows, but I don't think
it's generic enough and may have to change if there're more local
variables declared in ACPI method on the future ASUS machines. Any
suggestions for this?

--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -116,6 +116,8 @@ struct bios_args {
        u32 arg0;
        u32 arg1;
        u32 arg2; /* At least TUF Gaming series uses 3 dword input buffer. */
+       u32 arg3;
+       u32 arg4;
 } __packed;


Chris
