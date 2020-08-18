Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B778FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D4520786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597769964;
	bh=YAxfXVhRRyjsoOwe1xBQcE8TbImFIWnjUwrnAZb31Lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YcM6ng0Syunu9LmnIrjXSlwWQt2m/8NbeGxc6m7b08Jy151MQ78DcqFSwLpE37tyH
	 Seni6WFi8uP9KJ4jrrJkg7FLq+MmrmXGuJU3E94H9XA59CAL94HUNfsZk6kM+P7IyZ
	 GfC+MJZ6MN4B4Sr1tD89FiNgyEQaTWlbaaWgzkiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgHRQ7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbgHRQ6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:58:14 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4ED820786;
        Tue, 18 Aug 2020 16:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769894;
        bh=YAxfXVhRRyjsoOwe1xBQcE8TbImFIWnjUwrnAZb31Lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1iUF9fGWN0aHSMGoqUSaAjHfsDTcjYZVjy1XM6ZoRFmrtfQC2skiaGju3vBOHkRBa
         9RuixYt/WxpPJe14gR/l678gCwYGyxE9hthiA9Dl3CCk7RcniaRbXA58Qld2gdcEpg
         7/cA3WV5m3AXIhU26J4vJTXSRnED+4/afv5fAbz8=
Date:   Tue, 18 Aug 2020 09:58:11 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Javier Gonzalez <javier@javigon.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>, Damien.LeMoal@wdc.com,
        axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, johannes.thumshirn@wdc.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200818165811.GA2979311@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:50:33AM +0200, Javier Gonzalez wrote:
> a number of customers are requiring the use of normal writes, which we
> want to support.

A device that supports append is completely usable for those customers,
too. There's no need to create divergence in this driver.
