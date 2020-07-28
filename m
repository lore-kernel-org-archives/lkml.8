Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F21C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 330012064B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595934280;
	bh=DgU4yKbmp8OwurHB5DLCGWi9A01qQNe/KIyrPlNU668=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=17pPgtwdnkZe4bhXn5zDCQPXSlEtck8i7OgMCotu8Hztz2V6eomcY/05cwgUyOr0Q
	 QNHQnMLGb2df2t+ZdjJQSz9+jfH5+JPUTVVIR1RnIh4WKGKKPwvnCYLBOVfKE49X1W
	 6hFkflwLz1ww+W5DrvNRsNXFix7uaUfpSMGvBe+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgG1LEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728806AbgG1LEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:04:38 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A570204EA;
        Tue, 28 Jul 2020 11:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595934277;
        bh=DgU4yKbmp8OwurHB5DLCGWi9A01qQNe/KIyrPlNU668=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZVv5HUnMOVp2vHnZ9/jtVS2y/XyBACUo9eSxXbsVecuIY/cF0jYniuWzpdyF237jW
         bM6z0VJwVTsJBMSyi4czmL0gVP2+4XvXlcYnaRF2dC0KH1ocPws2APpXg/68W+2rE9
         DZ84dmgv9dkZZJLwx+eHIxFkWz332B+nJWqx/PVc=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k0NPQ-00FczY-4W; Tue, 28 Jul 2020 12:04:36 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, kernel-team@android.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] Unify non-VHE ASLR features behind CONFIG_RANDOMIZE_BASE
Date:   Tue, 28 Jul 2020 12:04:31 +0100
Message-Id: <159593423897.3960510.2442620106516348363.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721094445.82184-1-dbrazdil@google.com>
References: <20200721094445.82184-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, james.morse@arm.com, dbrazdil@google.com, catalin.marinas@arm.com, android-kvm@google.com, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu, kernel-team@android.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 10:44:43 +0100, David Brazdil wrote:
> There is currently no way to disable nVHE ASLR, e.g. for debugging, so the
> first patch in this series makes it conditional on RANDOMIZE_BASE, same as
> KASLR. Note that the 'nokaslr' command line flag has no effect here.
> 
> Second patch unifies the HARDEN_EL2_VECTORS errate for A57 and A72 behind
> the same Kconfig for simplicity. Happy to make it just depend on
> RANDOMIZE_BASE if having an option to keep randomization on but hardenning
> off is preferred.
> 
> [...]

Applied to kvm-arm64/misc-5.9, thanks!

[1/2] KVM: arm64: Make nVHE ASLR conditional on RANDOMIZE_BASE
      commit: 24f69c0fa4e252f706884114b7d6353aa07678b5
[2/2] KVM: arm64: Substitute RANDOMIZE_BASE for HARDEN_EL2_VECTORS
      commit: a59a2edbbba7397fede86e40a3da17e5beebf98b

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


