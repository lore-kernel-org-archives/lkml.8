Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D80C2D0E6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE9F2074D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585160773;
	bh=6Q+CrQ602tmxDcWOlZL6ufQEyLdb6veHata9Ej2DLPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wor767wehUFRD6vZoyP9vwAfotOT3Le7wh2gh6Dm212s9S1BHDPT7+DliKj1iypHN
	 9ubhIyfcCeN+J6jGU9CdM32+10Dm51IoSDcXOlbBuAhZM0D+r/pUxXpL+ivNetkV6D
	 1+FhaX5L/SynsYh3749kqQmfgYqiKB9Nb1YwCWRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgCYS0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbgCYS0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 14:26:11 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 472A320740;
        Wed, 25 Mar 2020 18:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585160771;
        bh=6Q+CrQ602tmxDcWOlZL6ufQEyLdb6veHata9Ej2DLPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s9nDuL/OQSVs9yDeSg0VIZhceIqy4WFDzhhjqt2M33MT1llbQOCI8Bh4gMbHb1+Xo
         A8ueEhVPB5veTp5WBrwa5NgoRml5vDRsubWCY3Onw1vw67uXe0w8RjUALavx98foGC
         e2ydlGazdYoSxj065nxyFm9UBTjnpDnhZTVlU2Qc=
Date:   Thu, 26 Mar 2020 03:26:07 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Nick Bowler <nbowler@draconx.ca>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix NVME_IOCTL_ADMIN_CMD compat address handling.
Message-ID: <20200325182607.GA5290@redsun51.ssa.fujisawa.hgst.com>
References: <20200325002847.2140-1-nbowler@draconx.ca>
 <3eed9434-d1af-b0d9-e972-ddd393d1ab4b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eed9434-d1af-b0d9-e972-ddd393d1ab4b@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued up for nvme-5.7, thanks.
