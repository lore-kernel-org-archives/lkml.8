Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9676BC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DF1208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgIKPx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:53:26 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42353 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgIKPnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:43:37 -0400
Received: from methusalix.internal.home.lespocky.de ([109.250.103.56]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1My3Ef-1kRwV22uGl-00zVsj; Fri, 11 Sep 2020 17:40:59 +0200
Received: from lemmy.internal.home.lespocky.de ([192.168.243.176] helo=lemmy.home.lespocky.de)
        by methusalix.internal.home.lespocky.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <alex@home.lespocky.de>)
        id 1kGlAW-00012l-Dq; Fri, 11 Sep 2020 17:40:57 +0200
Received: (nullmailer pid 28446 invoked by uid 2001);
        Fri, 11 Sep 2020 15:40:55 -0000
From:   Alexander Dahl <post@lespocky.de>
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Alexander Dahl <ada@thorsis.com>,
        Alexander Dahl <post@lespocky.de>
Subject: [PATCH v4 0/3] leds: pwm: Make automatic labels work
Date:   Fri, 11 Sep 2020 17:40:01 +0200
Message-Id: <20200911154004.28354-1-post@lespocky.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scan-Signature: 770cd104049592bdf1705ca88dc38dfa
X-Provags-ID: V03:K1:e4FvXaQWDj87KwD0kEbtAGIU3u5VS+b8RpwJ8Fxy+7ih3wJ005A
 dC03taXs1FPmBoQuk4ab6GKiSV4FkUwZWKiod2sLL/htRdqmxD3y5vdUgfkknuYJLaSDD1B
 kI6GShk76+2S4ls/wX1LLXWySYA2UdZL1m+00mhsvQhWfN0CpQCRSxQYQn9Kkuix26Jvtna
 NqNUEGcsCyjK6txldsrUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lQ7HEH7Aius=:Isg2qlduxH4oFRIzMuqf/y
 PTLMUjZyz1N4tki5cd+GSBmBii2zrZGs2Tpt2uMjVq9ACNPoyXdo0UxEjzqkf+HyzjHlDwHJK
 quORKXN4pT2SZ+bHf1/uhXxWZCvqayhtqO2LJEOaKK7NQ4GTDNRLayLpSUqrNww8A88NF0XrH
 Wm1qwrM/kQd05rIG+Sp9XszcgNSmIPf48IALqG2WdTzjnRlW9Wzg8HDAaDKd+3dhbJmpkihTY
 JkcYbG4k2M69tkgeu39J+dsAiq1s3I0tD7JxRvxzens+3AwrW0dDvnup57jS95iE4l+FrDKvo
 8myWL6V9G8fYSDhf6MwIj4iCMUf4iUL45LxMSddEytWjRmdtmmIgNu8BhCB8HVuP+udQI1ENO
 ve+rKjWJkUUfNLrAtrqxOe66f0l6c4MwJmApHZLHjMW39FtgzUJ0zcrgZW8keAkXVGTo5SQHO
 zMWUnO0l6nGOrytQl7yTvd5YS9pOKjEqxQEp9g41ZzwhEcz0mL2oNEFARVvg5+39vsWudCTcU
 C7ekLQI1uJA+TcrkSzq78/Zm5giMBAiISj/xaF6IkkS6a1L5vTVvucOkH8Eo/JUnfOTiksmaz
 T7kC5TlnpTc45PhdeApC2l5Sg9AxBQJQvj37atvBkjCIIeUshXg2C+xoL+L4EgeZLOldTND0k
 OGFGWFSZt+zjzl4sUzZfQzrxh3ux+0moP1DyEmtLPdfI2RAkDr+trS9slk1S/e7Y/wKQaqrmn
 v8ERLp5phHbAOQgjyOQ6t24P0fKz7GYidjKxtOnujli+lj3L0i04MxyK7PX0pSZlcVt28YM5v
 k3Jh3r9t82UQg9s37WuB1iP3b0c7C7JIVX+tr5Bp2VRL4YDMH5DyFQqI2n9LZ5QBuMbNZWI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hei hei,

for leds-gpio you can use the properties 'function' and 'color' in the
devicetree node and omit 'label', the label is constructed
automatically.  This is a common feature supposed to be working for all
LED drivers.  However it did not yet work for the 'leds-pwm' driver.

This series changes led-core a bit to add a non-ugly fix for the
leds-pwm driver and takes the opportunity to update the leds-pwm
dt-bindings accordingly.

v4 was tested on a at91 sama5d2 based platform with LEDs connected to
GPIO and PWM.

Greets
Alex

v4:
- added led-class patch handling fwnode passing differently (patch 1/3)
- adapted leds-pwm patch to new led-class (patch 2/3)
- contacted original author of leds-pwm dt binding on license issue
  (patch 3/3)

v3:
- series rebased on v5.9-rc4
- changed license of .yaml file to recommended one (patch 2/2)
- added Acked-by to both patches

v2:
- series rebased on v5.9-rc3
- added the dt-bindings update patch (2/2)

v1:
- based on v5.9-rc2
- backport on v5.4.59 tested and working

Alexander Dahl (3):
  leds: Require valid fwnode pointer for composing name
  leds: pwm: Allow automatic labels for DT based devices
  dt-bindings: leds: Convert pwm to yaml

 .../devicetree/bindings/leds/leds-pwm.txt     | 50 -----------
 .../devicetree/bindings/leds/leds-pwm.yaml    | 85 +++++++++++++++++++
 drivers/leds/led-class.c                      |  2 +-
 drivers/leds/leds-pwm.c                       |  3 +-
 4 files changed, 88 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm.yaml

-- 
2.20.1

