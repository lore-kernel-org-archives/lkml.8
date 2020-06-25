Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74B1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0012076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406922AbgFYTsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406844AbgFYTsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:48:35 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7BDC08C5C1;
        Thu, 25 Jun 2020 12:48:35 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 87DB913D602DE;
        Thu, 25 Jun 2020 12:48:34 -0700 (PDT)
Date:   Thu, 25 Jun 2020 12:48:33 -0700 (PDT)
Message-Id: <20200625.124833.893666125631041346.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     aelior@marvell.com, GR-everest-linux-l2@marvell.com,
        kuba@kernel.org, michal.kalderon@marvell.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, irusskikh@marvell.com
Subject: Re: [PATCH][V2] qed: add missing error test for
 DBG_STATUS_NO_MATCHING_FRAMING_MODE
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200625164505.115425-1-colin.king@canonical.com>
References: <20200625164505.115425-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 25 Jun 2020 12:48:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Thu, 25 Jun 2020 17:45:05 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> The error DBG_STATUS_NO_MATCHING_FRAMING_MODE was added to the enum
> enum dbg_status however there is a missing corresponding entry for
> this in the array s_status_str. This causes an out-of-bounds read when
> indexing into the last entry of s_status_str.  Fix this by adding in
> the missing entry.
> 
> Addresses-Coverity: ("Out-of-bounds read").
> Fixes: 2d22bc8354b1 ("qed: FW 8.42.2.0 debug features")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: use the error message as suggested by Igor Russkikh

I already applied your V1 so this patch no longer applies.
