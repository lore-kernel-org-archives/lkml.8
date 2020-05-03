Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDE4C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 22:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E99B206F0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 22:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgECW6J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 18:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725844AbgECW6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 18:58:09 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CA7C061A0E;
        Sun,  3 May 2020 15:58:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8C4351211C987;
        Sun,  3 May 2020 15:58:08 -0700 (PDT)
Date:   Sun, 03 May 2020 15:58:07 -0700 (PDT)
Message-Id: <20200503.155807.975495147223194743.davem@davemloft.net>
To:     bjorn@mork.no
Cc:     Kangie@footclan.ninja, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: qmi_wwan: add support for DW5816e
From:   David Miller <davem@davemloft.net>
In-Reply-To: <87v9ldlccp.fsf@miraculix.mork.no>
References: <20200502155228.11535-1-Kangie@footclan.ninja>
        <87v9ldlccp.fsf@miraculix.mork.no>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 03 May 2020 15:58:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjørn Mork <bjorn@mork.no>
Date: Sun, 03 May 2020 09:13:58 +0200

> Matt Jolly <Kangie@footclan.ninja> writes:
> 
>> Add support for Dell Wireless 5816e to drivers/net/usb/qmi_wwan.c
>>
>> Signed-off-by: Matt Jolly <Kangie@footclan.ninja>
 ...
> Looks fine to me.  Please add to the stable queue as well,  Thanks.
> 
> Acked-by: Bjørn Mork <bjorn@mork.no>

Applied and queued up for -stable.
