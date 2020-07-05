Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0EEC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B88D2075B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593978965;
	bh=0XaEuH+GLlapI0stQ/0mKRUOfs8/FRPyAUniFCy7078=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AgzLwWGmvpnDly2gEPLy4LOmIERqQTFRnTw/Z5dHb85L9xumm1uX0i3cKeZbbYTVM
	 lR6eWOuhKNTrKOw5vcgfrVPiP6gkO9RUHt2rNfbEIwBf2NNtsZ4sGRMp1mrXo5tkPC
	 bSKjlsRok4zEgvMX7FWlPGMczf8EDjmOwPkag9mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgGET4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 15:56:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgGET4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 15:56:03 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A95220739;
        Sun,  5 Jul 2020 19:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593978963;
        bh=0XaEuH+GLlapI0stQ/0mKRUOfs8/FRPyAUniFCy7078=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mGbHWI3zGF7Fi5SSdTX0HRxPkIJb48ZauUVYL08M542oOApj0vgllL/+wtzBXtScj
         1+lI5Zj+aMR9Do53yLriGCRv28dayCfh1AYstj6P4hbe8P6Zx562FNdG5Pau8icAbu
         GsgFeFUMWkJNjiicb4//ipX1Dxj82vv9dyUQWDxU=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jsAk6-009F1o-1T; Sun, 05 Jul 2020 20:56:02 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Peng Hao <richard.peng@oppo.com>, catalin.marinas@arm.com
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kvm/arm64: Correct incorrect function parameter specification
Date:   Sun,  5 Jul 2020 20:55:58 +0100
Message-Id: <159397885409.255799.9755807740058338252.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701120709.388377-1-richard.peng@oppo.com>
References: <20200701120709.388377-1-richard.peng@oppo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: richard.peng@oppo.com, catalin.marinas@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 08:07:09 -0400, Peng Hao wrote:
> update_vmid() just has one parameter "vmid".The other parameter
> "kvm" is no longer used.

Applied to kvm-arm64/next-5.9, thanks!

[1/1] KVM: arm64: Drop long gone function parameter documentation
      commit: 95fa0ba83e66dea0d3af48ad69842ae8c1dd9af2

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


