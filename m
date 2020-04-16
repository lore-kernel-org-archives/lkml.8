Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F16C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92BC82076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="c1zv+sv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgDPUSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729120AbgDPUSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 16:18:21 -0400
X-Greylist: delayed 330 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Apr 2020 13:18:17 PDT
Received: from forward501j.mail.yandex.net (forward501j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADF7C03C1A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 13:18:17 -0700 (PDT)
Received: from mxback2q.mail.yandex.net (mxback2q.mail.yandex.net [IPv6:2a02:6b8:c0e:40:0:640:9c8c:4946])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id 47A43338071F;
        Thu, 16 Apr 2020 23:12:41 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback2q.mail.yandex.net (mxback/Yandex) with ESMTP id YUcaSHdlDb-Ceg4lJIF;
        Thu, 16 Apr 2020 23:12:40 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1587067960;
        bh=FjgtpRfNnNo3G5mZ6JF4NLtbDrsA/Hb5OCt/UqoNZkY=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=c1zv+sv3JOpzKhBNttUBmSNhIREG4HQQAtiqvDWoEjhdc5HF/QBcUzLodfyI1IuGu
         EV6r+WKIFaFX+lczdK6ABSSLhr+v75S5eNjVFzXv80TBjFNPdC9YjV4CXWLeu3Gr6i
         HPONBKoAp4517407xuyl6T0RXduxdWtbuLWDwpWc=
Authentication-Results: mxback2q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla5-dcf36e533bf7.qloud-c.yandex.net with HTTP;
        Thu, 16 Apr 2020 23:12:40 +0300
From:   Evgeniy Polyakov <zbr@ioremap.net>
Envelope-From: drustafa@yandex.ru
To:     Akira Shimahara <akira215corp@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <greg@kroah.com>
In-Reply-To: <20200414170248.299534-1-akira215corp@gmail.com>
References: <20200414170248.299534-1-akira215corp@gmail.com>
Subject: Re: [PATCH] Changes in w1_therm.c and adding w1_therm.h
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 16 Apr 2020 23:12:40 +0300
Message-Id: <20621587067856@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

14.04.2020, 20:03, "Akira Shimahara" <akira215corp@gmail.com>:
> From: Akira SHIMAHARA <akira215corp@gmail.com>
>
> Patch for enhacement of w1_therm module. Added features :
>  - Bulk read : send one command for all the slaves
>                  on the bus to trigger temperature conversion
>  - Optimized conversion time regarding to device resolution
>  - Dedicated sysfs entry for powering read,
>                  resolution set/get, eeprom save/restore
>  - Alarms settings and reading
>  - Code optimization to mitigate bus traffic
>                  (devices information are stored to avoid
>                 interrogating each device every-time)
>
> Following sysfs entry are added :
>  - temperature (RO) : return the temperature in 1/1000°
>  - ext_power (RO) : return the power status of the device
>  - resolution (RW) : get or set the device resolution (supported devices)
>  - eeprom (WO) :trigger a save or restore to/from device EEPROM
>  - alarms (RW) : read or write TH and TL in the device RAM
>  - therm_bulk_read (RW) : Attribute at master level to trigger
>                  bulk read and to survey the progress of devices conversions
>  - w1_slave has been kept for compatibility
>
> Main motivation was to improve temperature reading speed, which depend
> on resolution settings of devices. The module store the powwer status and
> the resolution of each device so that during reading operation, no
> transaction is required on the bus, which improve speed.
> The harware status is checked as soon as a new device is detected,
> when a user change occured, or when the corresponding sys file is
> accessed by user.
>
> The bulk read allow to trigger convserion of all devices on the bus at
> the same time. It will apply a strong pull up on the line if at least
> one device required it. The duration of the pull up is the max time
> required by a device on the line.
>
> Please let me know any feedback you have on this patch.
>
> Thanks ahead,
>
> Signed-off-by: Akira Shimahara <akira215corp@gmail.com>

Looks good to me, thank you!
These are really good changes.

Greg, please pull it into your tree, thank you.

Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
