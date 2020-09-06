Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C651FC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86BD7208B3
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599419093;
	bh=71s+qTNIy0+SO4zmvuLbRsznOf8Yc7KstwtffWt6R6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZlRKQSw1MfHDGaFqTusdr0D3fq9XGznefdhG/dlsDt5r86golks16/JApSvwG/Z/9
	 4Ng/8HwumO9AYnWRBPIvF1bA2nQeHIxzG7O/28pVt+5H95pmecO0ZIVs+3y+nhDeWL
	 ikKNBfuEZ9t4kJ87NYsG6EBgjx8lm2tPmLcw6yfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgIFTEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 15:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgIFTEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 15:04:52 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AE732080A;
        Sun,  6 Sep 2020 19:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599419091;
        bh=71s+qTNIy0+SO4zmvuLbRsznOf8Yc7KstwtffWt6R6o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eBmZhdJMp+1qfEkL7KoIoMZxy3dhbYz7GaAAc6Q3O2TTLdn6VkvE49nlda+l1yTup
         CIGo8SfzEKeWIaF50OwJX/ag6SRoJ8TGZ2X1FdQi9tUbH0l+iV2AWQaWJTYg5UuYH1
         Geg4FMM4Mh8SwsDqBGpStTyGAMshYe1k1hMgiI+M=
Date:   Sun, 6 Sep 2020 12:04:49 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <antoine.tenart@bootlin.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <f.fainelli@gmail.com>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>
Subject: Re: [PATCH net] net: macb: fix for pause frame receive enable bit
Message-ID: <20200906120449.1af17a4c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1599294093-30758-1-git-send-email-pthombar@cadence.com>
References: <1599294093-30758-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Sep 2020 10:21:33 +0200 Parshuram Thombare wrote:
> PAE bit of NCFGR register, when set, pauses transmission
> if a non-zero 802.3 classic pause frame is received.
> 
> Fixes: 7897b071ac3b ("net: macb: convert to phylink")
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>

Applied, thank you!
