Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FF7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62BE9206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594606531;
	bh=E3+c5kljqoqNsRLxsFojcCBmSVCwAZ2wSSbGAjIGrms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PhpRYb4zdtSeMLTyiEPI8wLd1QwRG8L7wlKBJrDpnt44jvICKHPRYuMil/xOxxNc5
	 ahpQxMmxLNJjCuZk31EvTAZJTozaxfI5gvZzd6Gch0LCvRfW11wU7lym3JoI2u7Ps9
	 /YbxcevcXVBFqhP1Tzbk+Mz9uhxe0l4JinOZfa0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgGMCPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMCPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:15:23 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F306206D9;
        Mon, 13 Jul 2020 02:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594606523;
        bh=E3+c5kljqoqNsRLxsFojcCBmSVCwAZ2wSSbGAjIGrms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iomCkNnga4XFvjJcetTdijdrsrIDdqExtCg+NkgA7pUjYCWcicQ0t5ioW3x/pcVrL
         QexDACviCGeSPNinUyBxc4ZGSn92Z1T6Zq6rPfoRqjk39+1Oht1Yk5JMVFl3GICI34
         o9jyWXzmX1rBGoCofqI/Lvwjd7IiwZU+43x/z2nM=
Date:   Mon, 13 Jul 2020 10:15:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        leoyang.li@nxp.com, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [Patch V2] arm64: dts: ls1028a: Add DSPI flash nodes for
 LS1028a-qds
Message-ID: <20200713021518.GU21277@dragon>
References: <20200629024634.14582-1-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629024634.14582-1-qiang.zhao@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 10:46:34AM +0800, Qiang Zhao wrote:
> From: Xiaowei Bao <xiaowei.bao@nxp.com>
> 
> Add the DSPI flash nodes into fsl-ls1028a-qds.dts
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>

Updated subject as 'arm64: dts: ls1028a-qds: Add DSPI flash nodes' and
applied the patch.

Shawn
