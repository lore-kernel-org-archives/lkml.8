Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93C9C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6E820768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCRR7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:59:02 -0400
Received: from smtprelay0200.hostedemail.com ([216.40.44.200]:45808 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726506AbgCRR7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:59:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 7007F180295A5;
        Wed, 18 Mar 2020 17:59:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hate21_3184fa5e40703
X-Filterd-Recvd-Size: 4340
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed, 18 Mar 2020 17:59:00 +0000 (UTC)
Message-ID: <a421ed974d7c675a7d41405d483c7645004d4125.camel@perches.com>
Subject: Re: [PATCH 2/2] staging: rtl8192u: Corrects 'Avoid CamelCase' for
 variables
From:   Joe Perches <joe@perches.com>
To:     Camylla Cantanheide <c.cantanheide@gmail.com>,
        dan.carpenter@oracle.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        lkcamp@lists.libreplanetbr.org
Date:   Wed, 18 Mar 2020 10:57:11 -0700
In-Reply-To: <CAG3pEr+9tuSYw==qgp3J8r--SdAd8DBMNQqSHCZQc-mkVVuE6w@mail.gmail.com>
References: <20200317085130.21213-1-c.cantanheide@gmail.com>
         <20200317085130.21213-2-c.cantanheide@gmail.com>
         <20200317134329.GC4650@kadam>
         <ee182711405229e85b5b5a44c683d5a2609b5ba3.camel@perches.com>
         <CAG3pEr+9tuSYw==qgp3J8r--SdAd8DBMNQqSHCZQc-mkVVuE6w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-18 at 14:31 -0300, Camylla Cantanheide wrote:
> Dear Dan Carpenter and Joe Perches,
> 
> Thank you very much for the suggestions, I found the evaluation of both
> very significant. Now, I have another perspective on variables.
> 
> I solved the problem for the *setKey *function, however, when executing the
> checkpatch, more *Checks* of the same type appeared.
> 
> Should I send the second version of the patch, only to the *setKey*
> function or do I resolve all *Checks* for the entire file?

A single patch refactoring the function would be fine.

Also perhaps a name change as a separate patch later as
setKey is a relatively generic name and not obviously
specific to the rtl8192u..

Perhaps a first refactoring patch like the below
then a renaming one.

(untested)
---
 drivers/staging/rtl8192u/r8192U_core.c | 50 ++++++++++++++++------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 89dd1fb..0c0cb08 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -4880,7 +4880,7 @@ void EnableHWSecurityConfig8192(struct net_device *dev)
 void setKey(struct net_device *dev, u8 EntryNo, u8 KeyIndex, u16 KeyType,
 	    u8 *MacAddr, u8 DefaultKey, u32 *KeyContent)
 {
-	u32 TargetCommand = 0;
+	u32 TargetCommand = CAM_CONTENT_COUNT * EntryNo |  BIT(31) | BIT(16);
 	u32 TargetContent = 0;
 	u16 usConfig = 0;
 	u8 i;
@@ -4897,32 +4897,28 @@ void setKey(struct net_device *dev, u8 EntryNo, u8 KeyIndex, u16 KeyType,
 	else
 		usConfig |= BIT(15) | (KeyType << 2) | KeyIndex;
 
-	for (i = 0; i < CAM_CONTENT_COUNT; i++) {
-		TargetCommand  = i + CAM_CONTENT_COUNT * EntryNo;
-		TargetCommand |= BIT(31) | BIT(16);
-
-		if (i == 0) { /* MAC|Config */
-			TargetContent = (u32)(*(MacAddr + 0)) << 16 |
-					(u32)(*(MacAddr + 1)) << 24 |
-					(u32)usConfig;
-
-			write_nic_dword(dev, WCAMI, TargetContent);
-			write_nic_dword(dev, RWCAM, TargetCommand);
-		} else if (i == 1) { /* MAC */
-			TargetContent = (u32)(*(MacAddr + 2))	 |
-					(u32)(*(MacAddr + 3)) <<  8 |
-					(u32)(*(MacAddr + 4)) << 16 |
-					(u32)(*(MacAddr + 5)) << 24;
-			write_nic_dword(dev, WCAMI, TargetContent);
-			write_nic_dword(dev, RWCAM, TargetCommand);
-		} else {
-			/* Key Material */
-			if (KeyContent) {
-				write_nic_dword(dev, WCAMI,
-						*(KeyContent + i - 2));
-				write_nic_dword(dev, RWCAM, TargetCommand);
-			}
-		}
+	TargetContent = MacAddr[0] << 16 |
+			MacAddr[0] << 24 |
+			(u32)usConfig;
+
+	write_nic_dword(dev, WCAMI, TargetContent);
+	write_nic_dword(dev, RWCAM, TargetCommand++);
+
+	 /* MAC */
+	TargetContent = MacAddr[2]	 |
+			MacAddr[3] <<  8 |
+			MacAddr[4] << 16 |
+			MacAddr[5] << 24;
+	write_nic_dword(dev, WCAMI, TargetContent);
+	write_nic_dword(dev, RWCAM, TargetCommand++);
+
+	/* Key Material */
+	if (!KeyContent)
+		return;
+
+	for (i = 2; i < CAM_CONTENT_COUNT; i++) {
+		write_nic_dword(dev, WCAMI, *KeyContent++);
+		write_nic_dword(dev, RWCAM, TargetCommand++);
 	}
 }
 

