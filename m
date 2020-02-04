Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB9AC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D598B2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgBDLoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:44:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42192 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgBDLoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:44:02 -0500
Received: from localhost (unknown [IPv6:2001:982:756:1:57a7:3bfd:5e85:defb])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A3892133E9065;
        Tue,  4 Feb 2020 03:44:00 -0800 (PST)
Date:   Tue, 04 Feb 2020 12:43:59 +0100 (CET)
Message-Id: <20200204.124359.1467998825171045884.davem@davemloft.net>
To:     harinik@xilinx.com
Cc:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        harini.katakam@xilinx.com, harinikatakamlinux@gmail.com
Subject: Re: [PATCH v2 1/2] net: macb: Remove unnecessary alignment check
 for TSO
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAFcVECKXp-s-vteTzmqSDCR0ajugiDK_tnBmacea5NA+Fu02Ng@mail.gmail.com>
References: <20200204.103718.1343105885567379294.davem@davemloft.net>
        <BN7PR02MB5121912B4AE8633C50D6DE98C9030@BN7PR02MB5121.namprd02.prod.outlook.com>
        <CAFcVECKXp-s-vteTzmqSDCR0ajugiDK_tnBmacea5NA+Fu02Ng@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 04 Feb 2020 03:44:02 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harinik@xilinx.com>
Date: Tue, 4 Feb 2020 15:52:55 +0530

>> > will never trigger this IPPROTO_TCP condition after your change.
> 
> Yes, this is dead code now. I'll remove it.
> 
>> >
>> > A lot of things about this patch do not add up.
> 
> Please let me know if you have any further concerns.

Looks good with the above correction and a rework of your commit message
to explain things more clearly.

Thank you.
