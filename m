Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B0DC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2519E206D6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgD3Vcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:32:42 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51025 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgD3Vcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:32:41 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MRmwM-1jaI7F1geQ-00T9PZ; Thu, 30 Apr 2020 23:32:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 08/15] usb: ehci: avoid gcc-10 zero-length-bounds warning
Date:   Thu, 30 Apr 2020 23:30:50 +0200
Message-Id: <20200430213101.135134-9-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200430213101.135134-1-arnd@arndb.de>
References: <20200430213101.135134-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9LwbzPiDVBTutPI7/SmbJcMbJzAjVunAx6lsoRTMq+jOauVlaC3
 MgKUiAe+HddGUKoavqOfiAsSpWnCH3KOmtqZqSCBvUZkoD9k1rj+PQ4AVhfvLLaMvdG9CX+
 7Y4+sJJK7i+mMhDuVBqNuXk9EhPc6KK6v5/xyT3y9wGWLHToM1tskvt271mkLVQOER9AXa0
 qJwyxkiW9dCsIY54jJz+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lguDXmXr0vo=:HF3x9q9yVSo8GfNZqml4nG
 Y1So3lZ/EU291ooBiltDFReKVfKroB8H0GqCweHIfHh6ZZf6T5OnasR3za5ZgEKMNPJOljE4a
 rWkbTcCbBgIhJhoqEWoe41PNI+jy4CTiEv0dQJqPzDkW8tMgWVqFNEPh0lS+VGUI7FvAZr8MA
 pofS+LpblAWAZaqFYgbVxEEwkjisO8qqt9+kX6Y5DtO90yomqQtzL1YRZ/UUH+HQ4TKRP6oM1
 5W1QWYCFiV5y3z/VGtB/va7j9vYN5YCGZFty33a+DKvGVQHTXL+H19tHgYZpzabzt2mmpwL2h
 DhQVJYKPM5s8dsNv6ho3RpA4FEpOhyvpUX09S/CtvXi61/rfEf/TSLZBytZDOUONU5h5HvV/S
 CJJR6hf6ytHn3MRgCJ/ASzMQCjsOVhVD1JdGu53rovZp++mR3j4SOCNpO9bnqXB89k6rUGuiQ
 s/FhHMGN8ra75zHUkqrTLKsz7+PYN04EYGegMNGOrs2EZUeQvHWdWBpqLCApu0pcbVLoh5hNh
 dAsXXYqkNqL82ettUCs/rW41TxPWItB/wdrvmowJ55Z6SvBDAHKzINaUA3dDfgrXO+VGpGeGT
 LbiHgKUPF23qbcBSa3hKkjDFs7i2BrTuAxWrkPJ+W85XBX+xuD0tBeFExInOrjz0306cCzMim
 p5B/m+taevaLNoTey3/geklfUu+bp9vOpBdLvQjcvjo00thdkxfYSTXnHATU3pkLpOc4SlCDH
 i2X+CjrNuhZomIKp6ZFwG5PTc5bt9MSl8wDWg33jP19lMpou6wQm5Eg5T/yjaziSMHK/nPASt
 z60ev2uT6xJm/Vhvywu0OrPttAQ8naeLtNyPkstQNrkLFzSFq8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building ehci drivers with gcc-10 results in a number of warnings like
when an zero-length array is accessed:

drivers/usb/host/ehci-hub.c: In function 'ehci_bus_suspend':
drivers/usb/host/ehci-hub.c:320:30: error: array subscript 14 is outside the bounds of an interior zero-length array 'u32[0]' {aka 'unsigned int[0]'} [-Werror=zero-length-bounds]
  320 |    u32 __iomem *hostpc_reg = &ehci->regs->hostpc[port];
      |                              ^~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/usb/host/ehci.h:273,
                 from drivers/usb/host/ehci-hcd.c:96:
include/linux/usb/ehci_def.h:186:7: note: while referencing 'hostpc'
  186 |  u32  hostpc[0]; /* HOSTPC extension */
      |       ^~~~~~
In file included from drivers/usb/host/ehci-hcd.c:305:
drivers/usb/host/ehci-hub.c: In function 'ehci_hub_control':
drivers/usb/host/ehci-hub.c:892:15: error: array subscript 256 is outside the bounds of an interior zero-length array 'u32[0]' {aka 'unsigned int[0]'} [-Werror=zero-length-bounds]
  892 |  hostpc_reg = &ehci->regs->hostpc[temp];
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/usb/host/ehci.h:273,
                 from drivers/usb/host/ehci-hcd.c:96:
include/linux/usb/ehci_def.h:186:7: note: while referencing 'hostpc'
  186 |  u32  hostpc[0]; /* HOSTPC extension */
      |       ^~~~~~

All these fields are colocated with reserved fields that I guess
refer to the correct field length.

Change the two struct definition to use an unnamed union to define
both of these fields at the same location as the corresponding
reserved fields.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/usb/ehci_def.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/usb/ehci_def.h b/include/linux/usb/ehci_def.h
index 78e006355557..8777d8e56ef2 100644
--- a/include/linux/usb/ehci_def.h
+++ b/include/linux/usb/ehci_def.h
@@ -127,7 +127,8 @@ struct ehci_regs {
 #define FLAG_CF		(1<<0)		/* true: we'll support "high speed" */
 
 	/* PORTSC: offset 0x44 */
-	u32		port_status[0];	/* up to N_PORTS */
+	union {
+		u32		port_status[9];	/* up to N_PORTS */
 /* EHCI 1.1 addendum */
 #define PORTSC_SUSPEND_STS_ACK 0
 #define PORTSC_SUSPEND_STS_NYET 1
@@ -165,7 +166,8 @@ struct ehci_regs {
 #define PORT_CONNECT	(1<<0)		/* device connected */
 #define PORT_RWC_BITS   (PORT_CSC | PORT_PEC | PORT_OCC)
 
-	u32		reserved3[9];
+		u32		reserved3[9];
+	};
 
 	/* USBMODE: offset 0x68 */
 	u32		usbmode;	/* USB Device mode */
@@ -181,11 +183,13 @@ struct ehci_regs {
  * PORTSCx
  */
 	/* HOSTPC: offset 0x84 */
-	u32		hostpc[0];	/* HOSTPC extension */
+	union {
+		u32		hostpc[17];	/* HOSTPC extension */
 #define HOSTPC_PHCD	(1<<22)		/* Phy clock disable */
 #define HOSTPC_PSPD	(3<<25)		/* Port speed detection */
 
-	u32		reserved5[17];
+		u32		reserved5[17];
+	};
 
 	/* USBMODE_EX: offset 0xc8 */
 	u32		usbmode_ex;	/* USB Device mode extension */
-- 
2.26.0

