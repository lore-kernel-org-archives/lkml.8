Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CE5C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA5BF206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="RG2ZnBVr";
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="RG2ZnBVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgIAWBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgIAWBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:01:49 -0400
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Sep 2020 15:01:47 PDT
Received: from mail.sammserver.com (sammserver.com [IPv6:2001:470:5a5b:1::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D32C061244;
        Tue,  1 Sep 2020 15:01:46 -0700 (PDT)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id 3E106FCD560; Tue,  1 Sep 2020 23:55:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1598997337; bh=/RtFyWyJDIkCcWhBfGLKv/03qnf5PIZh/94SZpxGp1A=;
        h=Date:From:To:Cc:Subject:From;
        b=RG2ZnBVrBVVv2CWA6WDCwMa0eLBQ4d0jpslftDpLYIdld9Ytz6c6FqQo/V6fq132k
         Gf1EnDLFzYjiWhHNayqWJ65uit6t/XM/FMg5VOA3y9mYqx2KqAeYMwZJob4S3Xr2cQ
         BueooTfZ7LTmuewXAJ7msNBki0wFDjxbRTLUtCq8=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id F3187FCD55D;
        Tue,  1 Sep 2020 23:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1598997337; bh=/RtFyWyJDIkCcWhBfGLKv/03qnf5PIZh/94SZpxGp1A=;
        h=Date:From:To:Cc:Subject:From;
        b=RG2ZnBVrBVVv2CWA6WDCwMa0eLBQ4d0jpslftDpLYIdld9Ytz6c6FqQo/V6fq132k
         Gf1EnDLFzYjiWhHNayqWJ65uit6t/XM/FMg5VOA3y9mYqx2KqAeYMwZJob4S3Xr2cQ
         BueooTfZ7LTmuewXAJ7msNBki0wFDjxbRTLUtCq8=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id D67EC14210F4; Tue,  1 Sep 2020 23:55:36 +0200 (CEST)
Date:   Tue, 1 Sep 2020 23:55:36 +0200
From:   Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Corentin Chary <corentin.chary@gmail.com>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: platform/x86: asus-wmi: SW_TABLET_MODE is always 1 on some devices
Message-ID: <20200901215536.qcouepovmfxje4n5@fastboi.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

A bug was introduced with the following commit[1]:

    b0dbd97de: platform/x86: asus-wmi: Add support for SW_TABLET_MODE

The SW_TABLET_MODE switch seems to be always 1 on some devices,
including my UX360CA and a UX390UAK[2].

This can be seen in the output of evtest:

    # evtest /dev/input/by-path/platform-asus-nb-wmi-event
    Input driver version is 1.0.1
    Input device ID: bus 0x19 vendor 0x0 product 0x0 version 0x0
    Input device name: "Asus WMI hotkeys"
    Supported events:
      (...)
      Event type 5 (EV_SW)
        Event code 1 (SW_TABLET_MODE) state 1

And directly results in libinput disabling the trackpad and keyboard via
its tablet-mode mechanism, rendering X.org and Wayland unusable (not even
switching to VT works without sysrq+r):

    # libinput debug-events
    (...)
    -event8   DEVICE_ADDED     Asus WMI hotkeys     seat0 default group10 cap:kS
     event8   SWITCH_TOGGLE    +0.000s	switch tablet-mode state 1
    (...)

I have been using the following workaround to get my input working
again:

    # cat /usr/share/libinput/50-system-asus.quirks
    (...)
    [Asus WMI hotkeys]
    MatchName=*Asus WMI hotkeys*
    ModelTabletModeSwitchUnreliable=1

Another option would be to rmmod asus_nb_wmi and blacklist it for now.

I am not sure what the solution would be as I am not acquainted with the
WMI module. However, I can provide some information about my hardware:

The UX360CA fully disables the keyboard in hardware(firmware?) when the
lid is flipped beyond 180 degrees (tablet mode). The trackpad is not
disabled. A KEY_PROG2 event is generated by the same "Asus WMI hotkeys"
input device at this moment, it however does not carry the actual state
-- a 1 is sent and a 0 follows immediately[3]. The same KEY_PROG2
sequence is generated when the lid is returned back to laptop position.
The SW_TABLET_MODE switch does not change state at all during this.
Thank you.

Have a nice day,
Samuel

[1]: https://patchwork.kernel.org/patch/11539215/
[2]: https://bugzilla.kernel.org/show_bug.cgi?id=209011
[3]: https://lore.kernel.org/patchwork/patch/973647/
