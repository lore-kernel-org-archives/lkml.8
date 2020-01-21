Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2833EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041312467A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgAUQTR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:19:17 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:58591 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgAUQTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:19:16 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id CF07BCECE3;
        Tue, 21 Jan 2020 17:28:33 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] net/bluetooth: remove __get_channel/dir
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1579596583-258090-1-git-send-email-alex.shi@linux.alibaba.com>
Date:   Tue, 21 Jan 2020 17:19:14 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8CA3EF63-F688-48B2-A21D-16FDBC809EDE@holtmann.org>
References: <1579596583-258090-1-git-send-email-alex.shi@linux.alibaba.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> These 2 macros are never used from first git commit Linux-2.6.12-rc2. So
> better to remove them.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Marcel Holtmann <marcel@holtmann.org> 
> Cc: Johan Hedberg <johan.hedberg@gmail.com> 
> Cc: "David S. Miller" <davem@davemloft.net> 
> Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com> 
> Cc: linux-bluetooth@vger.kernel.org 
> Cc: netdev@vger.kernel.org 
> Cc: linux-kernel@vger.kernel.org 
> ---
> net/bluetooth/rfcomm/core.c | 2 --
> 1 file changed, 2 deletions(-)
> 
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 3a9e9d9670be..825adff79f13 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -73,8 +73,6 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
> 
> /* ---- RFCOMM frame parsing macros ---- */
> #define __get_dlci(b)     ((b & 0xfc) >> 2)
> -#define __get_channel(b)  ((b & 0xf8) >> 3)
> -#define __get_dir(b)      ((b & 0x04) >> 2)
> #define __get_type(b)     ((b & 0xef))
> 
> #define __test_ea(b)      ((b & 0x01))

it seems we are also not using __dir macro either.

Regards

Marcel

