Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2997EC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11997206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgD0G0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 02:26:35 -0400
Received: from mail1.bemta25.messagelabs.com ([46.226.52.115]:51656 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726339AbgD0G0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:26:34 -0400
Received: from [100.112.198.136] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-west-1.aws.symcld.net id F5/35-51957-61B76AE5; Mon, 27 Apr 2020 06:26:30 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRWlGSWpSXmKPExsVy8MN7XV2x6mV
  xBtOe8VrMOd/CYtG8eD2bxaqF19gsLu+aw2bx/lMnk8X/PTvYHdg8tqy8yeTRcuQtq8emVZ1s
  HvvnrmH3+LxJLoA1ijUzLym/IoE1Y+qXKWwFlzgrnlxVamA8ydHFyMUhJLCWUWLDoi2sXYycQ
  E6lxLKjTcwgNq9AhMSZe9fAbE4BM4kV614zQdSYSmy/tYEdxGYT0JF4NHM9WJxFQFWia9sqMF
  tYIFViw+NHbCALRAQuMko8efyHDSTBLBAnMathOSvEAkGJkzOfsEDEJSQOvnjBDLFAS+LcmlW
  MExh5ZyEpm4WkbAEj0ypGi6SizPSMktzEzBxdQwMDXUNDI11DS3NdQzMTvcQq3SS91FLd8tTi
  El1DvcTyYr3iytzknBS9vNSSTYzAsE0pOLpkB+O25e/1DjFKcjApifLqxS6LE+JLyk+pzEgsz
  ogvKs1JLT7EKMPBoSTB+7oSKCdYlJqeWpGWmQOMIZi0BAePkghvKUiat7ggMbc4Mx0idYpRl2
  Pn0XmLmIVY8vLzUqXEeZWrgIoEQIoySvPgRsDi+RKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkY
  lYd5JIKt4MvNK4Da9AjqCCeiIKvnFIEeUJCKkpBqYyhh7Hj49xCHw+OKLD98fiHAnuG6f4xX3
  0bb4wzLpEqY5mULiUvNcc3Y+NK563n02lfHTlbl3fsl/bUxf9839dFrF37de+iXb+/TU9JKS/
  qx7XHH+a9SFVDE/4d2Lb/z+fOxUebh8/uFnD6vsQl8ab7VrYj053b4s8V62osKfqNynSpMrzA
  WbZ2tH1zBtqHq3flPZilknF0x/K3RJL4010k6Xa9dV6T8PlZgcYm3vLvY92VddK6NovZPVlvN
  W82uVmF3nPr639PDTyme3PvHy7hqWF+VyHWv5M0Ndk/Y/Kcv1O3R7UoljwMtW1mDL3GnOPea3
  UnSX3E982ajifUL8qvVazpu+zs/q/j3fJZutxFKckWioxVxUnAgALgikj2IDAAA=
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-19.tower-292.messagelabs.com!1587968789!3549008!1
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23370 invoked from network); 27 Apr 2020 06:26:30 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-19.tower-292.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 27 Apr 2020 06:26:30 -0000
Received: from krsrvapps-03.diasemi.com (10.95.17.51) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 27 Apr 2020 08:26:29 +0200
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 DD0B413F670; Mon, 27 Apr 2020 15:26:27 +0900 (KST)
Message-ID: <3e4e181ae9b25b51298b90be43396f46c91e2ea9.1587949032.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1587949032.git.Roy.Im@diasemi.com>
References: <cover.1587949032.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Mon, 27 Apr 2020 09:57:11 +0900
Subject: [RESEND PATCH V11 1/3] MAINTAINERS: da7280 updates to the Dialog
 Semiconductor search terms
To:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the da7280 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
v11: No changes.
v10: No changes.
v9: No changes.
v8: No changes.
v7: No changes.
v6: No changes.
v5: No changes.
v4: No changes.
v3: No changes.
v2: No changes.


 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b816a45..e63e550 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4944,6 +4944,7 @@ S:	Supported
 W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
 F:	Documentation/devicetree/bindings/sound/da[79]*.txt
@@ -4954,6 +4955,7 @@ F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
 F:	drivers/input/misc/da90??_onkey.c
+F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
 F:	drivers/mfd/da903x.c
-- 
end-of-patch for RESEND PATCH V11

