Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F746C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26FC924959
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgEEOPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:15:38 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55717 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbgEEOPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:15:32 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MspyA-1jGeMH3jPU-00t97P; Tue, 05 May 2020 16:15:25 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: select USB_ROLE_SWITCH
Date:   Tue,  5 May 2020 16:15:09 +0200
Message-Id: <20200505141523.809858-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yrb9vkuiMmrbRMRwcScx3qJ0uzLosaMXqi/bdKr7h+PA1CusLZU
 KRReS9zXfZAxA4/I5Eta+f5I+FgMS/F4Bvtk2qzGnFmtQo0AZ3tHddZDf/vmzyAQGhkAzyv
 if7nUXs7NCdUuiRjIEJLVJ9bRs2h6Ue10IXBlv/1ikSUOeveGKV+j2pGKz8NyiSyjzMplIt
 FW8yDVW2OE+EYofp5mgzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2a99Z8iYXuk=:afVkxNbQWlu4TrQVHfCj+X
 xBGZdgbKpa3kUxXSc350jkH8vtLB7zTrevjfQ3J1vSCugnWfRvAU1WuGETxi0rk5i+dVJYuRS
 vCxHFcvR92Ua+gEcw3jrvGj9exUlzYdZp05JG0RnSCUDzu3w1x2z270AnbIbM0rnNvfspo0rV
 iM0XQo5HFkacIgBv1JpumOwCHwZk6fEDVnzE1DO80lvfqPWySSmf/hc49i/iK+9RHKMTTtgW8
 4hRzzGmf5UiXMFla/bfxbeMISHIb1QJjnd2B6FIFK7fxExI3KV8VjsQvr3lNeWD1RRTbwoCIc
 Hs1e3YJ7a3otrJk8EI7VULoGYufXtEEl7FENBs6y1rgFhyiup2b1Fe8DVJGqv83i/LXeVhD/c
 FPOYWIOgrTBjW0BeAxZH5a6PW1X5YjpYUGScluw3/rnGuWsu5sVqDqq5WUxHFeD5yuRrgwL3t
 NW+3dNC79fwuSw6fuWwzv0QkQzdTg3YW29ZI2UQXurDjcEOmtHsojshhW3v3iTGGYiRbMUnUj
 COLpP/pLUrOORRhIujA81qdy6dJvOKCK8eQcs90yjGKvBwOvW+pJHCrvjDcR4s5iVw1AfId9l
 xhcigPEdwtnnjYOsTC/aRwunIE5iMXsWIQZWW32qZhHSMnBeOKiOdS2V2FSmY+5cJqK/MelC/
 Qz1buQt8fdnuxWSux5KyrLjzKbrW9NK7QbfMB0wMRUgK8Gj+4mTflA6j084cr7QOAURLjG3+d
 70W7efn/otxKYUMCgaNN2fPhbKat5dGxR6zZLDVF1mEorkbd/yG0bOfiDxZUbqnjYl0lCTJQf
 YSrYStaId772DwTM13AjGHAuTnm7QWirD1b0gKGRM5Tr3kIOjg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling into the role switch API requires that these functions
are loaded, if they are in a loadable module and dwc3 itself
is built-in, this produces a link error:

drivers/usb/dwc3/drd.o: In function `dwc3_usb_role_switch_get':
drd.c:(.text+0x26): undefined reference to `usb_role_switch_get_drvdata'
drivers/usb/dwc3/drd.o: In function `dwc3_usb_role_switch_set':
drd.c:(.text+0x97): undefined reference to `usb_role_switch_get_drvdata'
drivers/usb/dwc3/drd.o: In function `dwc3_drd_init':
drd.c:(.text+0x1ca7): undefined reference to `usb_role_switch_register'
drivers/usb/dwc3/drd.o: In function `dwc3_drd_exit':
drd.c:(.text+0x1e92): undefined reference to `usb_role_switch_unregister'

Select the USB_ROLE_SWITCH symbol from dwc3 in that configuration.

Fixes: 0339f7fbc82e ("usb: dwc3: fix up for role switch API change")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/dwc3/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 206caa0ea1c6..7a2304565a73 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -4,6 +4,7 @@ config USB_DWC3
 	tristate "DesignWare USB3 DRD Core Support"
 	depends on (USB || USB_GADGET) && HAS_DMA
 	select USB_XHCI_PLATFORM if USB_XHCI_HCD
+	select USB_ROLE_SWITCH if USB_DWC3_DUAL_ROLE
 	help
 	  Say Y or M here if your system has a Dual Role SuperSpeed
 	  USB controller based on the DesignWare USB3 IP Core.
-- 
2.26.0

