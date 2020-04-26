Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0FBC2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 03:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC7592071E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 03:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgDZDsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 23:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgDZDsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 23:48:37 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737CAC061A0C;
        Sat, 25 Apr 2020 20:48:37 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DDC49159FFC4A;
        Sat, 25 Apr 2020 20:48:36 -0700 (PDT)
Date:   Sat, 25 Apr 2020 20:48:36 -0700 (PDT)
Message-Id: <20200425.204836.2190122326484289412.davem@davemloft.net>
To:     xiangxia.m.yue@gmail.com
Cc:     eric.dumazet@gmail.com, geert@linux-m68k.org, pshelar@ovn.org,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: openvswitch: suitable access to the dp_meters
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1587785988-23517-1-git-send-email-xiangxia.m.yue@gmail.com>
References: <1587785988-23517-1-git-send-email-xiangxia.m.yue@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 25 Apr 2020 20:48:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xiangxia.m.yue@gmail.com
Date: Sat, 25 Apr 2020 11:39:47 +0800

> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> To fix the following sparse warning:
> | net/openvswitch/meter.c:109:38: sparse: sparse: incorrect type
> | in assignment (different address spaces) ...
> | net/openvswitch/meter.c:720:45: sparse: sparse: incorrect type
> | in argument 1 (different address spaces) ...
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>

Applied.
