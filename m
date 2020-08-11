Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39074C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205FB2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgHKSeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:34:15 -0400
Received: from smtprelay0060.hostedemail.com ([216.40.44.60]:34422 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725901AbgHKSeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 14:34:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 5EE6A8378A85;
        Tue, 11 Aug 2020 18:34:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stamp43_0b0be8426fe5
X-Filterd-Recvd-Size: 2715
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 11 Aug 2020 18:34:10 +0000 (UTC)
Message-ID: <5dd3d10088dbc8a126bc788237f5206130a090ae.camel@perches.com>
Subject: Re: [PATCH 19/20] media: platform: vpdma.c: fix comparison to bool
From:   Joe Perches <joe@perches.com>
To:     Benoit Parrot <bparrot@ti.com>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     skhan@linuxfoundation.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 11 Aug 2020 11:34:09 -0700
In-Reply-To: <20200811125748.s3pdpwjmqmd5bffb@ti.com>
References: <20200807083548.204360-19-dwlsalmeida@gmail.com>
         <20200811125748.s3pdpwjmqmd5bffb@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-11 at 07:57 -0500, Benoit Parrot wrote:
> Daniel W. S. Almeida <dwlsalmeida@gmail.com> wrote on Fri [2020-Aug-07 05:35:46 -0300]:
> > From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> > 
> > Fix the following coccinelle report:
> > 
> > drivers/media/platform/ti-vpe/vpdma.c:946:5-26: WARNING:
> > Comparison to bool
> > 
> > Found using - Coccinelle (http://coccinelle.lip6.fr)
[]
> > diff --git a/drivers/media/platform/ti-vpe/vpdma.c b/drivers/media/platform/ti-vpe/vpdma.c
[]
> > @@ -943,7 +943,7 @@ int vpdma_hwlist_alloc(struct vpdma_data *vpdma, void *priv)
> >  
> >  	spin_lock_irqsave(&vpdma->lock, flags);
> >  	for (i = 0; i < VPDMA_MAX_NUM_LIST &&
> > -	    vpdma->hwlist_used[i] == true; i++)
> > +	    vpdma->hwlist_used[i]; i++)
> >  		;


A more typical way to write this loop is
not testing i < VPDMA_MAX_NUM_LIST multiple
times like the below:
---
 drivers/media/platform/ti-vpe/vpdma.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/vpdma.c b/drivers/media/platform/ti-vpe/vpdma.c
index 2e5148ae7a0f..5893917ce50d 100644
--- a/drivers/media/platform/ti-vpe/vpdma.c
+++ b/drivers/media/platform/ti-vpe/vpdma.c
@@ -942,14 +942,13 @@ int vpdma_hwlist_alloc(struct vpdma_data *vpdma, void *priv)
 	unsigned long flags;
 
 	spin_lock_irqsave(&vpdma->lock, flags);
-	for (i = 0; i < VPDMA_MAX_NUM_LIST &&
-	    vpdma->hwlist_used[i] == true; i++)
-		;
-
-	if (i < VPDMA_MAX_NUM_LIST) {
+	for (i = 0; i < VPDMA_MAX_NUM_LIST; i++) {
+		if (vpdma->hwlist_used[i])
+			continue;
 		list_num = i;
 		vpdma->hwlist_used[i] = true;
 		vpdma->hwlist_priv[i] = priv;
+		break;
 	}
 	spin_unlock_irqrestore(&vpdma->lock, flags);
 


