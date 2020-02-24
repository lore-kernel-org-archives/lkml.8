Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A667AC11D24
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0462072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582526082;
	bh=scMnjbtBunqZevYTG1XPhcnk0YyJ6eRchbrVNwNgZfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VORHH4DgpXglez7tWc0RKMGAg9beH3HwA0ZLwRxAkf2y15PoyQmRL7R1nYsKyctfE
	 yGenVGtimDAcDmlASpstCqEnCs+fnXkWmw5Ysrj+J4zrEEpf1VMGiI9hXDEfwG7XPz
	 lYt2wzP1raGkqNhQXAW3wUHuiirkxMzgf12iiRY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgBXGel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 01:34:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgBXGek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 01:34:40 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40C9320661;
        Mon, 24 Feb 2020 06:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582526080;
        bh=scMnjbtBunqZevYTG1XPhcnk0YyJ6eRchbrVNwNgZfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rIG/qhkX1Rz6PiKItjibFFQGMbGxvyGwTfGpUqkv8hvbhKnfwJM5Ah+29AEVXi7Zg
         rONEwmlO7901c+s2IScRo0tVyuAZrvJV6VynBkayDOQyku3s/9AGAcFIC1TIUmG/o4
         XncUd3/w+tEBSnMrK06QEtoiETW5+0NlaTbBHfPI=
Date:   Mon, 24 Feb 2020 14:34:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next/devicetree 1/5] arm64: dts: fsl: ls1028a:
 delete extraneous #interrupt-cells for ENETC RCIE
Message-ID: <20200224063432.GL27688@dragon>
References: <20200219151259.14273-1-olteanv@gmail.com>
 <20200219151259.14273-2-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219151259.14273-2-olteanv@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 05:12:55PM +0200, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> This specifier overrides the interrupt specifier with 3 cells from gic
> (/interrupt-controller@6000000), but in fact ENETC is not an interrupt
> controller, so the property is bogus.
> 
> Interrupts used by the children of the ENETC RCIE must use the full
> 3-cell specifier required by the GIC.
> 
> The issue has no functional consequence so there is no real reason to
> port the patch to stable trees.
> 
> Fixes: 927d7f857542 ("arm64: dts: fsl: ls1028a: Add PCI IERC node and ENETC endpoints")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Prefix 'arm64: dts: ls1028a: ...' should be already clear enough.

Shawn
