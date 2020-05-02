Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6F2C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 23:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A9F20757
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 23:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgEBXcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 19:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726375AbgEBXcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 19:32:05 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA571C061A0C;
        Sat,  2 May 2020 16:32:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0DD051513DD3F;
        Sat,  2 May 2020 16:32:02 -0700 (PDT)
Date:   Sat, 02 May 2020 16:31:59 -0700 (PDT)
Message-Id: <20200502.163159.1994318394817516336.davem@davemloft.net>
To:     vincent.cheng.xh@renesas.com
Cc:     richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/3] ptp: Add adjust phase to support phase
 offset.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1588390538-24589-1-git-send-email-vincent.cheng.xh@renesas.com>
References: <1588390538-24589-1-git-send-email-vincent.cheng.xh@renesas.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 02 May 2020 16:32:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <vincent.cheng.xh@renesas.com>
Date: Fri, 1 May 2020 23:35:35 -0400

> From: Vincent Cheng <vincent.cheng.xh@renesas.com>
> 
> This series adds adjust phase to the PTP Hardware Clock device interface.
> 
> Some PTP hardware clocks have a write phase mode that has
> a built-in hardware filtering capability.  The write phase mode
> utilizes a phase offset control word instead of a frequency offset 
> control word.  Add adjust phase function to take advantage of this
> capability.
> 
> Changes since v1:
> - As suggested by Richard Cochran:
>   1. ops->adjphase is new so need to check for non-null function pointer.
>   2. Kernel coding style uses lower_case_underscores.
>   3. Use existing PTP clock API for delayed worker.

Series applied.
