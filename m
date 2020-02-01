Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B58C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 19:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417B220723
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 19:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580585425;
	bh=nu/AJbl37PympHlny43SrRpga+1Uh5lijiXfR2VivmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0cKZD9anvcE0+W7keNkL5wF0AUSzaHorjK+qF1l9A4X7YTz57d5h+oDYqAkpvDcRR
	 OtaWdXC7h3NJTUDshHjsYOX1Qnbp0cAUC7GPTydBjVs9HN5WANd3yNQTXwd/rHrbaz
	 dLkOFObWrTCVKMqvfqdON/nfKAxW0cVMkizeiaq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgBATaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 14:30:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgBATaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 14:30:23 -0500
Received: from cakuba.hsd1.ca.comcast.net (c-73-93-4-247.hsd1.ca.comcast.net [73.93.4.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3D0B20723;
        Sat,  1 Feb 2020 19:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580585423;
        bh=nu/AJbl37PympHlny43SrRpga+1Uh5lijiXfR2VivmI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2ajHIZ1ZWnLdPlIgya3iRwr+SvQIC8DDhgTTI+wdFVt+nIXm3QBsgPLTxCAymNaPZ
         jCsJj0g1qdmmXuKGjbFIK5PwQmdVRJak64SabqHdJVqWPaOYGUvhopcomp+I2kRzvF
         ZWCryZd6hy8mls1VwWjaE4uh0dbk3p+89w7Tf5TA=
Date:   Sat, 1 Feb 2020 11:30:22 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        claudiu.beznea@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        harinikatakamlinux@gmail.com
Subject: Re: [PATCH 0/2] TSO bug fixes
Message-ID: <20200201113022.47424f55@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <1580466455-27288-1-git-send-email-harini.katakam@xilinx.com>
References: <1580466455-27288-1-git-send-email-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 15:57:33 +0530, Harini Katakam wrote:
> orkaround the same by limiting this size to 0x3FC0 as recommended by
> Cadence. There was no performance impact on 1G system that I tested
> with.
> 
> Note on patch 1: The alignment code may be unused but leaving it there
> in case anyone is using UFO.

Hi Harini! Please provide Fixes tags when you post v2, thanks!
