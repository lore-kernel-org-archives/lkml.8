Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EB3C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D29208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583913599;
	bh=01KKvpVC8TI7EECmHnPs6+Z8JXYVklG4uQqeeSbTFPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xwbhVSmckAs+eBREZCk+Yxsu2Gk1mKNRtUY+Ee9lbV1LUNV9GNToEFkVSSEyYk5fd
	 5+FVl7s62Vgx26sLJNRX5AJPE8ibZd/Njta9xG7tVunqa3FQfY/JHpAKxcSD8NOm5o
	 BAlAjAWOz2LycQ5A5lgJ7L/MY+z5tAGx0W7MkTdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgCKH76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:59:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgCKH76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:59:58 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B394220873;
        Wed, 11 Mar 2020 07:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583913597;
        bh=01KKvpVC8TI7EECmHnPs6+Z8JXYVklG4uQqeeSbTFPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJEiS1V+nVRZfPXZ+9M+aONnNVs9hc4PWRH5p31hmWWFYzxOZhxePFOufX7n3Gqgo
         m+YkY6FnufHVSj2Y18GoEHaMPay6tUgkPnDpq1EyAUM9+yiejiX6TKWiK36N4kfVtu
         kscH7MGAXTVp6LGEKUG1nKDzW1n9TUIlTsD2CVUk=
Date:   Wed, 11 Mar 2020 15:59:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, devicetree@vger.kernel.org, kernel@puri.sm,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] arm64: dts: librem5-devkit: description updates
Message-ID: <20200311075949.GV29269@dragon>
References: <20200227131733.4228-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227131733.4228-1-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 02:17:25PM +0100, Martin Kepplinger wrote:
> 
> Shawn, I included Fabio's feedback despite you've taken the changes already.
> I don't know how "far out there" they are already, but in case you want to
> rebase / force-push this again, here is v4: It basically only adds one Fixes
> tag.
> 
> 
> These are additions to the imx8mq-librem5-devkit devicetree description
> we are running for quite some time. All users should have them:
> 
> revision history
> ----------------
> v4: review by Fabio: add Fixes tag and reorder a bit. thanks.
> v3: review by Shawn: newline / hyphen issues; squashed related ones.
>     thanks a lot.
>     https://lore.kernel.org/linux-arm-kernel/20200224062917.4895-1-martin.kepplinger@puri.sm/
> v2: review by Shawn and Guido: remove a battery description
>     add SoB tags, coding style fixes, squash and reorder audio
>     descritions, remove redundant and unneeded changes.
>     https://lore.kernel.org/linux-arm-kernel/20200218084942.4884-1-martin.kepplinger@puri.sm/
> v1: https://lore.kernel.org/linux-arm-kernel/20200205143003.28408-1-martin.kepplinger@puri.sm/
> 
> 
> Angus Ainslie (Purism) (7):
>   arm64: dts: librem5-devkit: add a vbus supply to usb0
>   arm64: dts: librem5-devkit: add the sgtl5000 i2c audio codec
>   arm64: dts: librem5-devkit: add the simcom 7100 modem and audio
>   arm64: dts: librem5-devkit: allow modem to wake the system from
>     suspend
>   arm64: dts: librem5-devkit: add the regulators for DVFS
>   arm64: dts: librem5-devkit: allow the redpine card to be removed
>   arm64: dts: librem5-devkit: increase the VBUS current in the kernel

Replace v3 with this version, thanks.
