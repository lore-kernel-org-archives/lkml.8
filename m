Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD8EC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 19:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7B02086A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 19:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581623476;
	bh=Xqbq2haBuZFkDYjZmsV4yATrit/Qz2AEyZkfCyM1khw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YHE8NLOkE+KJqrcYXB7S82NDeLZZ+rPujw8niybwORs0YRkpA1JDElWXehgRi8nyQ
	 PmRqrPGfavcd15wn648zemcedyYNZ7pkMFI9ZhuZSe0j2peYqAYzefnlnYlIebNhgQ
	 q5nXQA0ifHVHs//OO7h8anFBqesraD7O8nJcYNZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgBMTvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 14:51:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgBMTvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:51:15 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1489206DB;
        Thu, 13 Feb 2020 19:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581623474;
        bh=Xqbq2haBuZFkDYjZmsV4yATrit/Qz2AEyZkfCyM1khw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iCiUv1cEhk9VwBol7PtJap7ex5wIeg5ldTR+g0vDrDf4ZXUVibPHJxmw8z0OsPtP4
         3sDi51kklI4zP5HGQ5GjBfBHOb/TbuhsXDlniCFor44vp8ZUureEQ/Ir07YM2O7TyV
         sSG00Eyn9qbz3BCSD2kSR7827Jm6gkeT/WqVN19E=
Date:   Fri, 14 Feb 2020 04:51:06 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: fix uninitialized-variable warning
Message-ID: <20200213195106.GA8256@redsun51.ssa.fujisawa.hgst.com>
References: <20200107214215.935781-1-arnd@arndb.de>
 <20200130150451.GA25427@infradead.org>
 <CAK8P3a0EgfQkrSr77jE12Wm_NKemEZ1rFZLMcVhkAuu1cwOOWQ@mail.gmail.com>
 <20200130154815.GA2463@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130154815.GA2463@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 07:48:15AM -0800, Christoph Hellwig wrote:
> On Thu, Jan 30, 2020 at 04:36:48PM +0100, Arnd Bergmann wrote:
> > > This one is just gross.  I think we'll need to find some other fix
> > > that doesn't obsfucate the code as much.
> > 
> > Initializing the nvme_result in nvme_features() would do it, as would
> > setting it in the error path in __nvme_submit_sync_cmd() -- either
> > way the compiler cannot be confused about whether it is initialized
> > later on.
> 
> Given that this is outside the hot path we can just zero the whole
> structure before submitting the I/O.

I think this should be okay:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7f05deada7f4..4aeed750dab2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1165,8 +1165,8 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl,
 static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 		unsigned int dword11, void *buffer, size_t buflen, u32 *result)
 {
+	union nvme_result res = { 0 };
 	struct nvme_command c;
-	union nvme_result res;
 	int ret;
 
 	memset(&c, 0, sizeof(c));
--
