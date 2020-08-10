Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73520C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 03:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF8120658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 03:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgHJDU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 23:20:27 -0400
Received: from smtprelay0113.hostedemail.com ([216.40.44.113]:59298 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726338AbgHJDU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 23:20:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 58A8D182244EC;
        Mon, 10 Aug 2020 03:20:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dogs95_06140a126fd6
X-Filterd-Recvd-Size: 2141
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Aug 2020 03:20:24 +0000 (UTC)
Message-ID: <4265227298e8d0a943ca4468a4f32222317df197.camel@perches.com>
Subject: Re: [PATCH] ionic_lif: Use devm_kcalloc() in ionic_qcq_alloc()
From:   Joe Perches <joe@perches.com>
To:     Xu Wang <vulab@iscas.ac.cn>, snelson@pensando.io,
        drivers@pensando.io, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Sun, 09 Aug 2020 20:20:22 -0700
In-Reply-To: <20200810023807.9260-1-vulab@iscas.ac.cn>
References: <20200810023807.9260-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-10 at 02:38 +0000, Xu Wang wrote:
> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus use the corresponding function "devm_kcalloc".
[]
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
[]
> @@ -412,7 +412,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
>  
>  	new->flags = flags;
>  
> -	new->q.info = devm_kzalloc(dev, sizeof(*new->q.info) * num_descs,
> +	new->q.info = devm_kcalloc(dev, num_descs, sizeof(*new->q.info),
>  				   GFP_KERNEL);
>  	if (!new->q.info) {
>  		netdev_err(lif->netdev, "Cannot allocate queue info\n");

You could also remove these unnecessary allocation error messages.
There is an existing dump_stack() on allocation failure.

> @@ -462,7 +462,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
>  		new->intr.index = IONIC_INTR_INDEX_NOT_ASSIGNED;
>  	}
>  
> -	new->cq.info = devm_kzalloc(dev, sizeof(*new->cq.info) * num_descs,
> +	new->cq.info = devm_kcalloc(dev, num_descs, sizeof(*new->cq.info),
>  				    GFP_KERNEL);
>  	if (!new->cq.info) {
>  		netdev_err(lif->netdev, "Cannot allocate completion queue info\n");

