Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C9CC7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 05:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F97206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 05:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581918789;
	bh=3XZW45+oxiEd21pjOWOS/xVC/P/jx/HU3Cb4pITE3fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iCn+Rg+vgye+29BBsTR1s4lEaxqZJf+Kz9DBDwFiRtBz3BX1mVlv1jUoqaXcg47Vc
	 rtTFPUqoyIZl09PBnjcn99Vn5rYdALZAUt9OEbZGys3OeuMZ9KA20Gp0F6pdMMoNeC
	 2lXVl3s1vLZ6krKJDo4wOja0N2UxLu5ulteYK2sE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgBQFwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 00:52:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:57492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgBQFwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 00:52:54 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCEAA206F4;
        Mon, 17 Feb 2020 05:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581918773;
        bh=3XZW45+oxiEd21pjOWOS/xVC/P/jx/HU3Cb4pITE3fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JqETqfL1YBqAvtHF2RyHkOTqG5cmAmPwE4k5mGeoZTCzh7dkTO64l6Ji1Vb7Vjgaw
         cW9NWvgHNKBqOABc7ypk7UGIeKFonKSY95I1ug/KaPQc/oyChxB559B3aAkqtzqXpi
         6fAWeyngRMt5SOm3kvRFJ9GXX5eepwXlmifhDhx0=
Date:   Mon, 17 Feb 2020 13:52:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: support external trigger timestamp
 fifo of PTP timer
Message-ID: <20200217055246.GD6042@dragon>
References: <20200211045758.8231-1-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211045758.8231-1-yangbo.lu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 12:57:58PM +0800, Yangbo Lu wrote:
> There is an external trigger timestamp fifo for PTP timer
> of LS1028A. Add property fsl,extts-fifo for that.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied, thanks.
