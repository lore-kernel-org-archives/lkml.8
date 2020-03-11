Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18DBC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5362208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583916918;
	bh=0ig719qF57xMjabG6POD53mHZVoOUP1KuWNeaq573R0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yud4omtOzLHzH3QJ60hXm1pB+aJx6OIYpLFIxml3v7ymGzuO6XYCiwWXsoIplhQOn
	 GIyOv748fsHuzrImGm0VQoFuE8HglJ6YHXkDBjiq7ti0LHBky6pBEYLyJnrUjfJLjO
	 VfWZo/67Vm2+IDPyNj6ItFfYiGAZJjvAs7RUyBfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgCKIzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbgCKIzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:55:17 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7EE520873;
        Wed, 11 Mar 2020 08:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583916916;
        bh=0ig719qF57xMjabG6POD53mHZVoOUP1KuWNeaq573R0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V43tAO0ACoA3JdfRHjOn9zZn2Wb2Qp3Khnjp/rCGPSnjyZp97U+mNSohEFmytVHM7
         yscdk7an4Txq45MYWm2En70FFi4rHGTjxm/6ygSylt+2NkxNH8IEC5qkpQNwMNUI9d
         2bKo4PqWSNR8557NyaTX70Ta6ohHPUKDs1sUX7Fs=
Date:   Wed, 11 Mar 2020 16:55:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx25-pinfunc: add config for kpp rows 4 to 7
Message-ID: <20200311085511.GH29269@dragon>
References: <20200305212623.5601-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305212623.5601-1-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 10:26:24PM +0100, Martin Kaiser wrote:
> i.MX25's Keypad Port (KPP) can be used with a key pad matrix of up to
> 8 x 8 keys. Add pin configurations for rows 4 to 7.
> 
> The new defines have been tested on an out-of-tree board.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Applied, thanks.
