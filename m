Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52568C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D402073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgEDTF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726469AbgEDTF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:05:29 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49780C061A0E;
        Mon,  4 May 2020 12:05:28 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AA29211F5F61A;
        Mon,  4 May 2020 12:05:27 -0700 (PDT)
Date:   Mon, 04 May 2020 12:05:26 -0700 (PDT)
Message-Id: <20200504.120526.935588639172781549.davem@davemloft.net>
To:     wu000273@umn.edu
Cc:     kuba@kernel.org, oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kjlu@umn.edu
Subject: Re: [PATCH] nfp: abm: fix a memory leak bug
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200502224259.1477-1-wu000273@umn.edu>
References: <20200502224259.1477-1-wu000273@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 04 May 2020 12:05:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wu000273@umn.edu
Date: Sat,  2 May 2020 17:42:59 -0500

> From: Qiushi Wu <wu000273@umn.edu>
> 
> In function nfp_abm_vnic_set_mac, pointer nsp is allocated by nfp_nsp_open.
> But when nfp_nsp_has_hwinfo_lookup fail, the pointer is not released,
> which can lead to a memory leak bug. Fix this issue by adding
> nfp_nsp_close(nsp) in the error path.
> 
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>

Applied and queued up for -stable, thanks.
