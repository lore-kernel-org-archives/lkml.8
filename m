Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00355C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E63206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="qtxEzZCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgHDOtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbgHDOtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:49:00 -0400
Received: from forward500p.mail.yandex.net (forward500p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26891C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 07:48:59 -0700 (PDT)
Received: from mxback5g.mail.yandex.net (mxback5g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:166])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id 423E6940350;
        Tue,  4 Aug 2020 17:48:49 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback5g.mail.yandex.net (mxback/Yandex) with ESMTP id rSFBIL9Fqs-mmIW95H6;
        Tue, 04 Aug 2020 17:48:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1596552528;
        bh=rS/+6n/koFWKSBys6+6aWID9TEc0lcxKA4Nv1F6EDF0=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=qtxEzZCu0A7cbwJIUikJA3ukGT/DD5Px3H4fZVFvDGYFa8VIRw8V8Uv82F7AT3Tb8
         uydEkCvkihjV5Ll0vRHn5QdOKIcJtvHB4lUFHaJF9Sua/OLusutYPkHmi9HtFKcD+Z
         BJXwcB2Qm3vr4ZS6SYZDLdo6BVLJusYdGY6VJLQQ=
Authentication-Results: mxback5g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva5-64778ce1ba26.qloud-c.yandex.net with HTTP;
        Tue, 04 Aug 2020 17:48:48 +0300
From:   Evgeny Novikov <novikov@ispras.ru>
Envelope-From: eugenenovikov@yandex.ru
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ldv-project-org <ldv-project@linuxtesting.org>
In-Reply-To: <23dceaac-526d-4ee3-40de-cf354b0aeabd@roeck-us.net>
References: <856951596540762@mail.yandex.ru> <23dceaac-526d-4ee3-40de-cf354b0aeabd@roeck-us.net>
Subject: Re: hwmon: (sis5595) potential null pointer dereference in probe
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 04 Aug 2020 17:48:48 +0300
Message-Id: <4831596552157@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.08.2020, 17:33, "Guenter Roeck" <linux@roeck-us.net>:
> On 8/4/20 4:50 AM, Evgeny Novikov wrote:
>>  sis5595_pci_probe() registers platform driver callbacks and just then
>>  initializes global pointer variable s_bridge. sis5595_probe() may
>>  dereference it before this happens that can result in null pointer
>>  dereference.
>
> sis5595_probe() is only called after the device is registered,
> which happens in sis5595_device_add() after s_bridge is set. This is
> a southbridge, so there won't be any hot insertion/removal events.
>

Thank you for this hint. We need to tune our models appropriately.

>>  We can not swap registration of platform driver callbacks with
>>  initialization of s_bridge since sm_sis5595_exit() assumes the
>>  current order. Perhaps it has sense to implement a pci_driver.remove
>>  callback that will take care about deregistration of platform driver
>>  callbacks.
>
> Agreed regarding the remove function. However, given the age of the chip,
> I'd rather remove the driver than spending time on cleanup efforts.
> This looks like a perfect candidate for depreciation.
>

This is completely up to you. Anyway the driver does not have the bug.

Best regards,
Evgeny

> Guenter
