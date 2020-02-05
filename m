Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEB6C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F53020702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgBENto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:49:44 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47314 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgBENto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:49:44 -0500
Received: from localhost (unknown [IPv6:2001:982:756:1:57a7:3bfd:5e85:defb])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2B97D158EDDC9;
        Wed,  5 Feb 2020 05:49:42 -0800 (PST)
Date:   Wed, 05 Feb 2020 14:49:40 +0100 (CET)
Message-Id: <20200205.144940.712557491994145617.davem@davemloft.net>
To:     harini.katakam@xilinx.com
Cc:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        harinikatakamlinux@gmail.com
Subject: Re: [PATCH v3 0/2] TSO bug fixes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1580906292-19445-1-git-send-email-harini.katakam@xilinx.com>
References: <1580906292-19445-1-git-send-email-harini.katakam@xilinx.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 05 Feb 2020 05:49:43 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harini.katakam@xilinx.com>
Date: Wed,  5 Feb 2020 18:08:10 +0530

> An IP errata was recently discovered when testing TSO enabled versions
> with perf test tools where a false amba error is reported by the IP.
> Some ways to reproduce would be to use iperf or applications with payload
> descriptor sizes very close to 16K. Once the error is observed TXERR (or
> bit 6 of ISR) will be constantly triggered leading to a series of tx path
> error handling and clean up. Workaround the same by limiting this size to
> 0x3FC0 as recommended by Cadence. There was no performance impact on 1G
> system that I tested with.
> 
> Note on patch 1: The alignment code may be unused but leaving it there
> in case anyone is using UFO.
> 
> Added Fixes tag to patch 1.

Series applied and queued up for -stable, thank you.
