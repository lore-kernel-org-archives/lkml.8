Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E57C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6097D206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbgEVXUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 19:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731223AbgEVXUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 19:20:09 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAA0C061A0E;
        Fri, 22 May 2020 16:20:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E9D5A12751C31;
        Fri, 22 May 2020 16:20:07 -0700 (PDT)
Date:   Fri, 22 May 2020 16:20:07 -0700 (PDT)
Message-Id: <20200522.162007.703955779701480867.davem@davemloft.net>
To:     wu000273@umn.edu
Cc:     kuba@kernel.org, hkallweit1@gmail.com, jonathan.lemon@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kjlu@umn.edu
Subject: Re: [PATCH] net: sun: fix missing release regions in
 cas_init_one().
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200522215027.4217-1-wu000273@umn.edu>
References: <20200522215027.4217-1-wu000273@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 May 2020 16:20:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wu000273@umn.edu
Date: Fri, 22 May 2020 16:50:27 -0500

> From: Qiushi Wu <wu000273@umn.edu>
> 
> In cas_init_one(), "pdev" is requested by "pci_request_regions", but it
> was not released after a call of the function “pci_write_config_byte” 
> failed. Thus replace the jump target “err_write_cacheline” by 
> "err_out_free_res".
> 
> Fixes: 1f26dac32057 ("[NET]: Add Sun Cassini driver.")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>

Applied, thank you.
