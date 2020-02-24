Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9587CC11D27
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6327620714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582530910;
	bh=sLHq/C+ADYQPzbcKchD17zBFD/RAFeYaBYz25/Cd+iI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S+Bz/cgCs1eWCFSuo0SXOemB0fg3QoqupNOsuKQ97aM733BgAzYDqrOX6dLmfEI1n
	 2+Jqyc002fWaL4UtJ/O/XGospql+uvqD2rHMZtJPZfPmB7iBz08MDkmU8T0cSMAJbX
	 KNjziIlrIh46d/TUgOxVpuyXvzsSBHFHxgp/ERBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgBXHzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:55:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgBXHzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:55:09 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01ED0206E2;
        Mon, 24 Feb 2020 07:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582530908;
        bh=sLHq/C+ADYQPzbcKchD17zBFD/RAFeYaBYz25/Cd+iI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CBb8ieRWuiHplAg8mlEHhySrDPGXK4OxZ/1m+vKBXw94Ggqse8kQYdfySHAMvF249
         Gq9qGVa99ptUtPu7hgLEmpiHE6Xq3++U7intUb3XyRZDSvuYd+uEI/ffvBRQw4v8cF
         KrJ+ryPBhyzgbtEy/A0mjkGty3ZWelnSOISLmqO0=
Date:   Mon, 24 Feb 2020 15:55:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        devicetree@vger.kernel.org, kernel@puri.sm,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] arm64: dts: librem5-devkit: description updates
Message-ID: <20200224075500.GC27688@dragon>
References: <20200224062917.4895-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224062917.4895-1-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 07:29:09AM +0100, Martin Kepplinger wrote:
> These are additions to the imx8mq-librem5-devkit devicetree description
> we are running for quite some time. All users should have them:
> 
> revision history
> ----------------
> v3: review by Show: newline / hyphen issues; squashed related ones.
>     thanks a lot.
> v2: review by Shawn and Guido: remove a battery description
>     add SoB tags, coding style fixes, squash and reorder audio
>     descritions, remove redundant and unneeded changes.
>     https://lore.kernel.org/linux-arm-kernel/20200218084942.4884-1-martin.kepplinger@puri.sm/
> v1: https://lore.kernel.org/linux-arm-kernel/20200205143003.28408-1-martin.kepplinger@puri.sm/
> 
> 
> Angus Ainslie (Purism) (7):
>   arm64: dts: librem5-devkit: enable sai2 and sai6 audio interface
>   arm64: dts: librem5-devkit: add the simcom 7100 modem and sgtl5000
>     audio codec
>   arm64: dts: librem5-devkit: allow modem to wake the system from
>     suspend
>   arm64: dts: librem5-devkit: add a vbus supply to usb0
>   arm64: dts: librem5-devkit: add the regulators for DVFS
>   arm64: dts: librem5-devkit: allow the redpine card to be removed
>   arm64: dts: librem5-devkit: increase the VBUS current in the kernel

Applied all, thanks.
