Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1C7C3404C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AA42176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582078688;
	bh=JA4nav9WNgI9FlwXSrYprZ3MJTcNklbbd74cAeesTao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M+iodPlXEFQxMx03a34822c7UFNWj0PW+VMg5zCTtXABXzX4UzwOjyzd4P5dTljAA
	 fy6Jo9BlJ2Bbc9wgkyM68f3j2qbbRb3hwIJCh9KJB0rA/LmxTZ6y2mfKUlEnwwbCk2
	 A9BBX0VCPq7Mvm1LptBk0aJls8c03EmZqGSwjNi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBSCSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:18:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgBSCSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:18:06 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EB64207FD;
        Wed, 19 Feb 2020 02:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582078686;
        bh=JA4nav9WNgI9FlwXSrYprZ3MJTcNklbbd74cAeesTao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QjLa7jpibMwkMEZ6dsZGF21NFvuYGCVjsrB8PBrCOAj/dDBYiyaWwGdW6gBOMIq5x
         ktRpjjgUdQLoHyt1Y8sRZQpMYc+U4CXlMJvGxb/nDV7qojG/5MuI/hovXfnabCdEud
         DfCG106ea/qZCPjks7o7iuyUq4uad3EiNrszs87Y=
Date:   Wed, 19 Feb 2020 10:17:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: ls1028a: add missing SPI nodes
Message-ID: <20200219021758.GJ6075@dragon>
References: <20200218171418.18297-1-michael@walle.cc>
 <20200218171418.18297-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218171418.18297-2-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 06:14:18PM +0100, Michael Walle wrote:
> The LS1028A has three (dual) SPI controller. These are compatible with
> the ones from the LS1021A. Add the nodes.
> 
> The third controller was tested on a custom board.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied this version, instead.

Shawn
