Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9529FC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 17:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72ACF20714
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 17:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgBIRYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 12:24:43 -0500
Received: from smtprelay0193.hostedemail.com ([216.40.44.193]:44675 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727397AbgBIRYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 12:24:43 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 941B9180A68BF;
        Sun,  9 Feb 2020 17:24:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hook20_bb392dfc3436
X-Filterd-Recvd-Size: 3915
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sun,  9 Feb 2020 17:24:40 +0000 (UTC)
Message-ID: <80495d71d156ed8bb44da5b46eac458b497af691.camel@perches.com>
Subject: Re: [PATCH v2] staging: qlge: remove spaces at the start of a line
From:   Joe Perches <joe@perches.com>
To:     Mohana Datta Yelugoti <ymdatta.work@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 09 Feb 2020 09:23:26 -0800
In-Reply-To: <20200209171431.19907-1-ymdatta.work@gmail.com>
References: <ymdatta.work@gmail.com>
         <20200209171431.19907-1-ymdatta.work@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-02-09 at 22:44 +0530, Mohana Datta Yelugoti wrote:
> This patch fixes "WARNING: please, no spaces at the start of a
> line" by checkpatch.pl by replacing spaces with the tab.

> Signed-off-by: Mohana Datta Yelugoti <ymdatta.work@gmail.com>
> ---

Hello Mohana.

What changed in the v2?

When you send a new revision of a patch, it's good form to describe
the differences between the patches below the --- line

So here you should write something like

V2: Improved patch description

Also, the form of the code could be rewritten using //
comments while aligning all the options, even those
commented out currently with /* ... */

Something like:

 drivers/staging/qlge/qlge_main.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/qlge/qlge_main.c b/drivers/staging/qlge/qlge_main.c
index ef8037..f25cd2 100644
--- a/drivers/staging/qlge/qlge_main.c
+++ b/drivers/staging/qlge/qlge_main.c
@@ -52,16 +52,22 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
 static const u32 default_msg =
-    NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_LINK |
-/* NETIF_MSG_TIMER |	*/
-    NETIF_MSG_IFDOWN |
-    NETIF_MSG_IFUP |
-    NETIF_MSG_RX_ERR |
-    NETIF_MSG_TX_ERR |
-/*  NETIF_MSG_TX_QUEUED | */
-/*  NETIF_MSG_INTR | NETIF_MSG_TX_DONE | NETIF_MSG_RX_STATUS | */
-/* NETIF_MSG_PKTDATA | */
-    NETIF_MSG_HW | NETIF_MSG_WOL | 0;
+	NETIF_MSG_DRV |
+	NETIF_MSG_PROBE |
+	NETIF_MSG_LINK |
+//	NETIF_MSG_TIMER |
+	NETIF_MSG_IFDOWN |
+	NETIF_MSG_IFUP |
+	NETIF_MSG_RX_ERR |
+	NETIF_MSG_TX_ERR |
+//	NETIF_MSG_TX_QUEUED |
+//	NETIF_MSG_INTR |
+//	NETIF_MSG_TX_DONE |
+//	NETIF_MSG_RX_STATUS |
+//	NETIF_MSG_PKTDATA |
+	NETIF_MSG_HW |
+	NETIF_MSG_WOL |
+	0;
 
 static int debug = -1;	/* defaults above */
 module_param(debug, int, 0664);

>  drivers/staging/qlge/qlge_main.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/qlge/qlge_main.c b/drivers/staging/qlge/qlge_main.c
> index ef8037d0b52e..86b9b7314a40 100644
> --- a/drivers/staging/qlge/qlge_main.c
> +++ b/drivers/staging/qlge/qlge_main.c
> @@ -52,16 +52,16 @@ MODULE_LICENSE("GPL");
>  MODULE_VERSION(DRV_VERSION);
>  
>  static const u32 default_msg =
> -    NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_LINK |
> +	NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_LINK |
>  /* NETIF_MSG_TIMER |	*/
> -    NETIF_MSG_IFDOWN |
> -    NETIF_MSG_IFUP |
> -    NETIF_MSG_RX_ERR |
> -    NETIF_MSG_TX_ERR |
> +	NETIF_MSG_IFDOWN |
> +	NETIF_MSG_IFUP |
> +	NETIF_MSG_RX_ERR |
> +	NETIF_MSG_TX_ERR |
>  /*  NETIF_MSG_TX_QUEUED | */
>  /*  NETIF_MSG_INTR | NETIF_MSG_TX_DONE | NETIF_MSG_RX_STATUS | */
>  /* NETIF_MSG_PKTDATA | */
> -    NETIF_MSG_HW | NETIF_MSG_WOL | 0;
> +	NETIF_MSG_HW | NETIF_MSG_WOL | 0;


>  
>  static int debug = -1;	/* defaults above */
>  module_param(debug, int, 0664);

