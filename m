Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90584C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68AF82073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbgG0QQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:16:55 -0400
Received: from smtprelay0217.hostedemail.com ([216.40.44.217]:47636 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731340AbgG0QQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:16:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 8A1278384373;
        Mon, 27 Jul 2020 16:16:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hour99_2915f0526f62
X-Filterd-Recvd-Size: 3083
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Jul 2020 16:16:45 +0000 (UTC)
Message-ID: <30618c986727e5f8a9806f663b4e6f4aa80065ae.camel@perches.com>
Subject: Re: [PATCH 2/2] media: bt8xx: avoid a useless memset
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        mchehab@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Mon, 27 Jul 2020 09:16:43 -0700
In-Reply-To: <0897d9bec8865859694c917f3f72ab8fd12321ff.camel@perches.com>
References: <20200727135151.54757-1-christophe.jaillet@wanadoo.fr>
         <0897d9bec8865859694c917f3f72ab8fd12321ff.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-27 at 09:09 -0700, Joe Perches wrote:
> On Mon, 2020-07-27 at 15:51 +0200, Christophe JAILLET wrote:
> > Avoid a memset after a call to 'dma_alloc_coherent()'.
> > This is useless since
> > commit 518a2f1925c3 ("dma-mapping: zero memory returned from dma_alloc_*")
> []
> > diff --git a/drivers/media/pci/bt8xx/btcx-risc.c b/drivers/media/pci/bt8xx/btcx-risc.c
> []
> > @@ -73,7 +73,6 @@ int btcx_riscmem_alloc(struct pci_dev *pci,
> >  		dprintk("btcx: riscmem alloc [%d] dma=%lx cpu=%p size=%d\n",
> >  			memcnt, (unsigned long)dma, cpu, size);
> >  	}
> > -	memset(risc->cpu,0,risc->size);
> >  	return 0;
> >  }
> 
> Likely NAK.
> 
> This is not useless as risc->cpu may be reused
> and the alloc may not have been done.

Perhaps a little rewrite for clarity:
---
 drivers/media/pci/bt8xx/btcx-risc.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/media/pci/bt8xx/btcx-risc.c b/drivers/media/pci/bt8xx/btcx-risc.c
index 51257980f539..311f4ca2a108 100644
--- a/drivers/media/pci/bt8xx/btcx-risc.c
+++ b/drivers/media/pci/bt8xx/btcx-risc.c
@@ -56,24 +56,26 @@ int btcx_riscmem_alloc(struct pci_dev *pci,
 		       struct btcx_riscmem *risc,
 		       unsigned int size)
 {
-	__le32 *cpu;
-	dma_addr_t dma = 0;
-
-	if (NULL != risc->cpu && risc->size < size)
-		btcx_riscmem_free(pci,risc);
-	if (NULL == risc->cpu) {
-		cpu = pci_alloc_consistent(pci, size, &dma);
-		if (NULL == cpu)
+	if (risc->cpu && risc->size < size)
+		btcx_riscmem_free(pci, risc);
+
+	if (risc->cpu) {
+		memset(risc->cpu, 0, risc->size);
+	} else {
+		dma_addr_t dma = 0;
+
+		risc->cpu = pci_alloc_consistent(pci, size, &dma);
+		if (!risc->cpu)
 			return -ENOMEM;
-		risc->cpu  = cpu;
+
 		risc->dma  = dma;
 		risc->size = size;
 
 		memcnt++;
 		dprintk("btcx: riscmem alloc [%d] dma=%lx cpu=%p size=%d\n",
-			memcnt, (unsigned long)dma, cpu, size);
+			memcnt, (unsigned long)dma, risc->cpu, size);
 	}
-	memset(risc->cpu,0,risc->size);
+
 	return 0;
 }
 

