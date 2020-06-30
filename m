Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48457C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A8DA20702
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733265AbgF3L7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:59:06 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:57291 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732517AbgF3L7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:59:05 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MQuwR-1jUbpB2phn-00O0Fd; Tue, 30 Jun 2020 13:58:38 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] udc: lpc32xx: mark local function static
Date:   Tue, 30 Jun 2020 13:58:15 +0200
Message-Id: <20200630115836.1283978-1-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:veseWBWr1h5vpkppXNC/0CmWqCIFH50Srfs8LPsw5xH/JdVmkgX
 sejJf0abhmbrS9AYLMm/Sj5uVMzCbA4TtKcgK1Unm6zyyDZzCz5wkeySLEDQA8DmnHMeamE
 hF5MvVdhAXWySGe1eBjylbtP/fYK70Ua/aAp+cCqFh6TasJvTjA0FnncHPzkc86tXVz6YXq
 VP/TGHYu23YysT8LVNHAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7T6V5aSeTAs=:yJ8wghqXSVPKlr7tAlROEt
 rmI8tWkpNOImq4me4JBuv3h/w5RoAidkAuFxaO0YhclkFqg53dcd7rEj9IyVUpOi9P1gGkfMl
 Iu52sA7n75Jk8w1dA8BIugJ0XK6kpVwro+lIb3sa9pbFGNDdnhjqbA16ZV+S1ZK4zf9KJ7uI5
 tP8djaRtyV/00QsQwjRD6bcnnenifrkflKYgUmJ2GolntzrOAxisySifXcYb1l5ayVQvF+w3p
 M60Pa5A5XWJwbeF5hL8O6ePVUAmJe9uSjZzTC9Y5GstwoCUltovKdvpwwtWFJoKDOiWJu3Tql
 pbB9CYn5T4RjN5nSXGElEJ+pvyop9a2zCskD3wiK37CSj+FwMpSiNUNmFOalOEQ32RdO2mXps
 btMvhvk/r9Fy3K2PBvfcCfHWELIg5tUlztTFaFAQcXyJ347IaOZUufKG2C6yVeXgzoVvHsHg2
 CHIKRJS0kroSlZclNQNPbpg+wq04O+/fmC3sPDd7u96/YLon9oDt9dFqLX/xLxbxh9A4t6UDj
 TxskZ/bhg3kNaZh8UZvJuJgk02ODW1LJfgxktnDQbRfLIl7EpMdLKXGkW7LSMwLYIWcjb72vp
 YcgSq8qFdzOgujt76GhE1QFk7VeGlbl2dWouO0mi8hNgJqczSm87TSgjYRhkR2avU+izyfyF4
 nMmvg7GoqQg04covHnIzI9GM7dvUXiZHcpBJ0EmPi+8v84MysYrhUSgLeg0i3CfPwX/EniiVc
 bScdziPooi9MX1v3Y8ipQf3zXnQJsmVtxXTyPkcWyYqxArC2h0qwoJFc30JQXlcuewNGzhLUa
 Ll0SLMtCZ1Xr7dlLy3Mx7gzpg2KDLNAK3eswA7mpRGI3XYv204=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel test robot reports two functions that should be marked
static:

>> drivers/usb/gadget/udc/lpc32xx_udc.c:1928:6: warning: no previous prototype for 'udc_send_in_zlp' [-Wmissing-prototypes]
    1928 | void udc_send_in_zlp(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
>> drivers/usb/gadget/udc/lpc32xx_udc.c:1942:6: warning: no previous prototype for 'udc_handle_eps' [-Wmissing-prototypes]
    1942 | void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)

This showed up after my commit 792e559e94bc ("udc: lpc32xx: fix 64-bit
compiler warning") made it possible to build the driver on x86-64.

Fix the warning as suggested.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 465d0b7c6522..4a112670cc6c 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -1926,7 +1926,7 @@ static const struct usb_ep_ops lpc32xx_ep_ops = {
 };
 
 /* Send a ZLP on a non-0 IN EP */
-void udc_send_in_zlp(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
+static void udc_send_in_zlp(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
 {
 	/* Clear EP status */
 	udc_clearep_getsts(udc, ep->hwep_num);
@@ -1940,7 +1940,7 @@ void udc_send_in_zlp(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
  * This function will only be called when a delayed ZLP needs to be sent out
  * after a DMA transfer has filled both buffers.
  */
-void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
+static void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
 {
 	u32 epstatus;
 	struct lpc32xx_request *req;
-- 
2.27.0

