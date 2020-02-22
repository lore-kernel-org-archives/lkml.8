Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE097C35641
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1752071E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgBVAgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:36:11 -0500
Received: from smtprelay0146.hostedemail.com ([216.40.44.146]:60201 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726672AbgBVAgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:36:10 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 7A25A1801870D;
        Sat, 22 Feb 2020 00:36:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bun08_6fc9d6b00412a
X-Filterd-Recvd-Size: 3435
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat, 22 Feb 2020 00:36:08 +0000 (UTC)
Message-ID: <4a2a109b5b7c5ce5e62bba4d39270abb855b2052.camel@perches.com>
Subject: Re: [PATCH] staging: qlge: unify multi-line string
From:   Joe Perches <joe@perches.com>
To:     Kaaira Gupta <kgupta@es.iitr.ac.in>,
        Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Feb 2020 16:34:44 -0800
In-Reply-To: <20200221185012.GA16841@kaaira-HP-Pavilion-Notebook>
References: <20200221185012.GA16841@kaaira-HP-Pavilion-Notebook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-02-22 at 00:20 +0530, Kaaira Gupta wrote:
> Fix checkpatch.pl warning of 'quoted string split across lines' in
> qlge_dbg.c by merging the strings in one line. Fixing this warning is
> necessary to ease grep-ing the source for printk.
[]
> diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
[]
> @@ -1333,16 +1333,16 @@ void ql_mpi_core_to_log(struct work_struct *work)
>  		     "Core is dumping to log file!\n");
>  
>  	for (i = 0; i < count; i += 8) {
> -		pr_err("%.08x: %.08x %.08x %.08x %.08x %.08x "
> -			"%.08x %.08x %.08x\n", i,
> -			tmp[i + 0],
> -			tmp[i + 1],
> -			tmp[i + 2],
> -			tmp[i + 3],
> -			tmp[i + 4],
> -			tmp[i + 5],
> -			tmp[i + 6],
> -			tmp[i + 7]);
> +		pr_err("%.08x: %.08x %.08x %.08x %.08x %.08x %.08x %.08x %.08x\n",
> +		       i,
> +		       tmp[i + 0],
> +		       tmp[i + 1],
> +		       tmp[i + 2],
> +		       tmp[i + 3],
> +		       tmp[i + 4],
> +		       tmp[i + 5],
> +		       tmp[i + 6],
> +		       tmp[i + 7]);

This should probably instead use

	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 32, 4,
		       qdev->mpi_coredump, sizeof(*qdev->mpi_coredump), false);

So that the debug and the dump are emitted at the
same KERN_<LEVEL> and the code is simpler.

>  		msleep(5);

And the msleep seems unnecessary.

>  	}
>  }


Perhaps:
---
 drivers/staging/qlge/qlge_dbg.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
index 8cf3961..a4cd91 100644
--- a/drivers/staging/qlge/qlge_dbg.c
+++ b/drivers/staging/qlge/qlge_dbg.c
@@ -1324,27 +1324,12 @@ void ql_mpi_core_to_log(struct work_struct *work)
 {
 	struct ql_adapter *qdev =
 		container_of(work, struct ql_adapter, mpi_core_to_log.work);
-	u32 *tmp, count;
-	int i;
 
-	count = sizeof(struct ql_mpi_coredump) / sizeof(u32);
-	tmp = (u32 *)qdev->mpi_coredump;
 	netif_printk(qdev, drv, KERN_DEBUG, qdev->ndev,
 		     "Core is dumping to log file!\n");
 
-	for (i = 0; i < count; i += 8) {
-		pr_err("%.08x: %.08x %.08x %.08x %.08x %.08x "
-			"%.08x %.08x %.08x\n", i,
-			tmp[i + 0],
-			tmp[i + 1],
-			tmp[i + 2],
-			tmp[i + 3],
-			tmp[i + 4],
-			tmp[i + 5],
-			tmp[i + 6],
-			tmp[i + 7]);
-		msleep(5);
-	}
+	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 32, 4,
+		       qdev->mpi_coredump, sizeof(*qdev->mpi_coredump), false);
 }
 
 #ifdef QL_REG_DUMP

