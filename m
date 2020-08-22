Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37456C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 12:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F210207CD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 12:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598100131;
	bh=PcEbuY1tMJFLuQznEtfgM3cYcbdw9Klc6NZA+4mCA0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nc31qHhX8a0BQ2wpHXYXjy4cNiIE/HXubrQKbIxESHriqvTFkHrybIADegyVlPoSz
	 E7mmx3JG1KcTHTntka0wLmgCugEBQEnBQZ9/5fL0s2bloR+ZSoQQGOQGgAGzULbOYI
	 myi9Axt9d90cNun7+gEb/53yHI032R94xKc91naM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgHVMmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 08:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbgHVMmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 08:42:09 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5881020720;
        Sat, 22 Aug 2020 12:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598100129;
        bh=PcEbuY1tMJFLuQznEtfgM3cYcbdw9Klc6NZA+4mCA0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ii6BpWdJyzx+67QqHjvAgA7F+Nsy2r603EcPHYaQ84JipcKvdWYh4JQUDLzihHWlV
         zmlVMY2oTpPZEeMIdWBc0l9RVCU/kZOv7qKa/3Lix7SuKJb0GxqBCPsiAX/dfe4knK
         UYzkOrzHIWfKb2xnr8g48jZSPGZTSAQd0y/MXB4Y=
Date:   Sat, 22 Aug 2020 20:42:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabresd: Support headphone and
 microphone detection
Message-ID: <20200822124203.GL27575@dragon>
References: <1596623944-3104-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596623944-3104-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 06:39:04PM +0800, Shengjiu Wang wrote:
> Add "DMIC" rounting, headphone and microphone detect gpio for sound
> card, then output sound can switch between headphone and speaker.
> input sound can switch between DMIC and AMIC.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Applied, thanks.
