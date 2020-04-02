Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927E1C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7305220737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388494AbgDBQsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:48:24 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:39007 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBQsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:48:24 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id BB914200011;
        Thu,  2 Apr 2020 16:48:21 +0000 (UTC)
Date:   Thu, 2 Apr 2020 18:48:21 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] rtc: class: remove redundant assignment to
 variable err
Message-ID: <20200402164821.GQ3683@piout.net>
References: <20200402110411.508534-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402110411.508534-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2020 12:04:11+0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable err is being initialized with a value that is never read
> and it is being updated later with a new value. The initialization
> is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/rtc/class.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
