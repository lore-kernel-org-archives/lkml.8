Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B2DC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D262075B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597671916;
	bh=QGlbmATnskSVN/Nl3hxctYOP1POSW2fxxhMUaDEiKbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NmC0+/OsTF9GSk3IqJFmSCbwsm4X82zfBA8RdjQX9Pe0M5pLvpsLJ2M28c9lyxjkj
	 RbgOnxfuLIso4EBFabSvGHCy2S01nEdnxAU0TqxcYdcrfAyJlJNYvMbihJvPjvJ+oL
	 mWAgf/GLlxo0NmGsm6wIImWT0/D4EqvIXT0+JMRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgHQNpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728694AbgHQNpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:45:03 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB90020786;
        Mon, 17 Aug 2020 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597671903;
        bh=QGlbmATnskSVN/Nl3hxctYOP1POSW2fxxhMUaDEiKbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1wE6C9h6+40Ke+PXSG9ImorNqTPtT8gCx3JeKRCVBv7bleBFWEjxeGTCeTswWSIzE
         PuUn8RrRUfKCYArILfXZ319oZ8y7jWEEudFIUszfc0yHx12huTg2vhRu/4uAeEq6iM
         /u49JguaJRfyWe7NeUusJcSnO/92pjXzLIcBr4Ls=
Date:   Mon, 17 Aug 2020 21:44:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Vabhav Sharma <vabhav.sharma@oss.nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, V.Sethi@nxp.com,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: qds: enable lpuart1
Message-ID: <20200817134457.GJ16951@dragon>
References: <1595590482-26833-1-git-send-email-vabhav.sharma@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595590482-26833-1-git-send-email-vabhav.sharma@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 05:04:42PM +0530, Vabhav Sharma wrote:
> From: Vabhav Sharma <vabhav.sharma@nxp.com>
> 
> LPUART nodes by default are disabled in LS1028A device
> tree, Enabling LPUART1 node
> 
> Acked-by: Fugang Duan <fugang.duan@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>

Applied, thanks.
