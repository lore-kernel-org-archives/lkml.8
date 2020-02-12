Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1964C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844AE206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgBLLXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:23:45 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:35059 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgBLLXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:23:45 -0500
X-Originating-IP: 90.65.102.129
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 094DFC000A;
        Wed, 12 Feb 2020 11:23:42 +0000 (UTC)
Date:   Wed, 12 Feb 2020 12:23:42 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     a.zummo@towertech.it, michal.simek@xilinx.com, sgoud@xilinx.com,
        shubhraj@xilinx.com, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
Subject: Re: [PATCH v2] rtc: zynqmp: Clear alarm interrupt status before
 interrupt enable
Message-ID: <20200212112342.GC3326@piout.net>
References: <1581503079-387-1-git-send-email-srinivas.neeli@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581503079-387-1-git-send-email-srinivas.neeli@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2020 15:54:39+0530, Srinivas Neeli wrote:
> Fix multiple occurring interrupts for alarm interrupt. RTC module doesn't
> clear the alarm interrupt status bit immediately after the interrupt is
> triggered.This is due to the sticky nature of the alarm interrupt status
> register. The alarm interrupt status register can be cleared only after
> the second counter outruns the set alarm value. To fix multiple spurious
> interrupts, disable alarm interrupt in the handler and clear the status
> bit before enabling the alarm interrupt.
> 
> Fixes: 11143c19eb57 ("rtc: add xilinx zynqmp rtc driver")
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> ---
> Changes in V2:
> Addressed Michal Simek comments
>  - Removed new line in declartion part.
>  - Added new line before return.
> ---
>  drivers/rtc/rtc-zynqmp.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
