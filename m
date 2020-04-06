Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B65FC2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C98124953
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgDFQXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:23:02 -0400
Received: from mail.itouring.de ([188.40.134.68]:39532 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728924AbgDFQXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:23:02 -0400
Received: from tux.applied-asynchrony.com (p5B07E2B3.dip0.t-ipconnect.de [91.7.226.179])
        by mail.itouring.de (Postfix) with ESMTPSA id 5C7D04161A57;
        Mon,  6 Apr 2020 18:23:01 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 18391F01600;
        Mon,  6 Apr 2020 18:23:01 +0200 (CEST)
To:     LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: hwmon: drivetemp: bogus values after wake up from suspend
Organization: Applied Asynchrony, Inc.
Message-ID: <1af049a1-63ae-ee55-05d5-0e55eb00bd0e@applied-asynchrony.com>
Date:   Mon, 6 Apr 2020 18:23:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I've been giving the drivetemp hwmon driver a try and am very happy
with it; works right away and - much to my surprise - doesn't wake up
HDDs that have gone to sleep. Nice!

I did notice one tiny thing though: after waking up from suspend, my SSD
(Samsung 850 Pro) reports a few initial bogus values - suspiciously -128°,
which is definitely not the temperature in my office. While this is more
a cosmetic problem, it cramps my monitoring setup and leads to wrong graphs.
Can't have that!

So I looked into the source and found that the values are (understandably)
passed on unfiltered/uncapped. Since it's unlikely any active device has
operating temperature below-zero, I figured the laziest way is to cap the
value to positive:

diff -rup a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
--- a/drivers/hwmon/drivetemp.c	2020-04-02 08:02:32.000000000 +0200
+++ b/drivers/hwmon/drivetemp.c	2020-04-06 18:13:04.892554087 +0200
@@ -147,7 +147,7 @@ static LIST_HEAD(drivetemp_devlist);
  #define INVALID_TEMP		0x80
  
  #define temp_is_valid(temp)	((temp) != INVALID_TEMP)
-#define temp_from_sct(temp)	(((s8)(temp)) * 1000)
+#define temp_from_sct(temp)	(max(0, ((s8)(temp)) * 1000))
  
  static inline bool ata_id_smart_supported(u16 *id)
  {

The assumption is of course *theoretically* wrong since some
equipment might indeed operate in negative C°. One way might be
to use the device's "low" operating point first, but then that
might not be available and we'd be back to capping to 0.
I'm open to other suggestions. :)

thanks,
Holger
