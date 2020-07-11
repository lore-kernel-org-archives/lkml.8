Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34E2C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 15:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD54C207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 15:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594482036;
	bh=ewoDgPYPDXyDOaGtAvntNe+1VvnwMnpoRTvJx15pFkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ypDnrB2HmIX6f57CIsELfEDWySbxD+YlUkcQbL3PVP9uxhYRZmCbzoM1QgYkNUIQq
	 QsiPPP1n1X7yc2a7QIUtFuMNcXC/7VfXQwrD1pJnpoZvhLGF8IeaRDayC2BjVxSfEy
	 zvFaYmJzfGcDwkX7r45xt5c8Y/hyTtaR3iBOxHMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgGKPkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 11:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbgGKPkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 11:40:35 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F509207D4;
        Sat, 11 Jul 2020 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594482035;
        bh=ewoDgPYPDXyDOaGtAvntNe+1VvnwMnpoRTvJx15pFkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mj4slq3ErogTYDafaVANP2JV6/EYzSVx72lZ9KXDKiIHENHBRbO4e3umPnoyUj7iA
         2Xue1BaH6fCotvOYfPcDWnmaIapqbGLY/8pHj61c+Kde4my+naS1l5nAfSG0U5glOs
         pHP9lE0uRTMK/H3GIvhAUN0w1e0OL/JFvP1ibmNk=
Date:   Sat, 11 Jul 2020 23:40:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     ran.wang_1@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, Biwen Li <biwen.li@nxp.com>
Subject: Re: [v3 3/4] arm64: dts: ls1012a/ls1043a/ls1046a/ls1088a/ls208xa:
 add ftm_alarm0 node
Message-ID: <20200711154029.GN21277@dragon>
References: <20200624024501.15974-1-biwen.li@oss.nxp.com>
 <20200624024501.15974-3-biwen.li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624024501.15974-3-biwen.li@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:45:00AM +0800, Biwen Li wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> The patch adds ftm_alarm0 DT node
> 	- add new rcpm node
> 	- add ftm_alarm0 node
> 	- aliases ftm_alarm0 as rtc1
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>

Changed prefix to 'arm64: dts: layerscape: ' and applied patches.

Shawn
