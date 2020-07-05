Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF08EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 17:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C00022073E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 17:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593971473;
	bh=GVp5NSk4PuRdXFzh3kuMmXeVppzx2y7naUIlRJ8dzYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UvfZa36guvYOTRfzHa0LZTbrdSQM8e9v40Cvb5DBu7Ra1V98d9thGZAjlIp0gC0BT
	 b5/g5EwFyhUY4LtqXPApOJVUx1c+Rq9gnAnOd+e4fbLy3lE9UB09nsski6UnOmJtzD
	 GtxoxgHn60mFj8dEaRBzhtSZPVrrqGeQDTydEzrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgGERvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 13:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbgGERvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 13:51:12 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 270B820708;
        Sun,  5 Jul 2020 17:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593971471;
        bh=GVp5NSk4PuRdXFzh3kuMmXeVppzx2y7naUIlRJ8dzYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1FJKHws9wZf4T2p3CTHeXao0YjtEZ7TjaQuvGUkRv3PLzsXlc0+VBStDj+gEfP8nl
         nIW0PsD2tp/6qA7c0Mmg368u+pnfhvnWlQysSmGSf7nC9uz1BC36aWvStLLzSBpBA9
         xYEIMcGuCV+Av74Ad9TGVp9fbVti56z7Mx5aYgDU=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1js8nF-009DUh-MH; Sun, 05 Jul 2020 18:51:09 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        David Brazdil <dbrazdil@google.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        android-kvm@google.com
Subject: Re: [PATCH v4 00/15] Split off nVHE hyp code
Date:   Sun,  5 Jul 2020 18:51:01 +0100
Message-Id: <159397135631.253877.13833853427852365865.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200625131420.71444-1-dbrazdil@google.com>
References: <20200625131420.71444-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: suzuki.poulose@arm.com, will@kernel.org, julien.thierry.kdev@gmail.com, dbrazdil@google.com, james.morse@arm.com, catalin.marinas@arm.com, kernel-team@android.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, android-kvm@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 14:14:05 +0100, David Brazdil wrote:
> Refactor files in arch/arm64/kvm/hyp to compile all code which runs in EL2
> under nVHE into separate object files from the rest of KVM. This is done in
> preparation for being able to unmap hyp code from EL1 and kernel code/data
> from EL2 but has other benefits too, notably:
>  * safe use of KASAN/UBSAN/GCOV instrumentation on VHE code,
>  * no need for __hyp_text annotations.
> 
> [...]

Applied to kvm-arm64/next-5.9, thanks!

[01/15] KVM: arm64: Fix symbol dependency in __hyp_call_panic_nvhe
        commit: b38b298aa4397e2dc74a89b4dd3eac9e59b64c96
[02/15] KVM: arm64: Move __smccc_workaround_1_smc to .rodata
        commit: 7b2399ea5640b2e5f576af08b91091a26f240ea4
[03/15] KVM: arm64: Add build rules for separate VHE/nVHE object files
        commit: 7621712918ad4f5e6356193d9058debf657a6254
[04/15] KVM: arm64: Use build-time defines in has_vhe()
        commit: 53b671128bd7f9ea41ae1a06106d88eb4cf66623
[05/15] KVM: arm64: Handle calls to prefixed hyp functions
        commit: f50b6f6ae131b6ee7d5dd738961eda0c00b7f027
[06/15] KVM: arm64: Build hyp-entry.S separately for VHE/nVHE
        commit: b877e9849d41e7d2100d2933e0a3971d0ddec011
[07/15] KVM: arm64: Move hyp-init.S to nVHE
        commit: 208243c752a7eeef4236f7b7d67e806ee356e3f8
[08/15] KVM: arm64: Duplicate hyp/tlb.c for VHE/nVHE
        commit: e03fa29164ec1db1a81dc0168d0017a9e0366c7c
[09/15] KVM: arm64: Split hyp/switch.c to VHE/nVHE
        commit: 09cf57eba304246141367b95c89801fd2047ac96
[10/15] KVM: arm64: Split hyp/debug-sr.c to VHE/nVHE
        commit: d400c5b2025c9aeca76213d6bd4138ec39da5cef
[11/15] KVM: arm64: Split hyp/sysreg-sr.c to VHE/nVHE
        commit: 13aeb9b400c5d7c5e979fdbbf994c787487f7889
[12/15] KVM: arm64: Duplicate hyp/timer-sr.c for VHE/nVHE
        commit: 9aebdea494b5d2d5fe0ba54d71e9d6c5acfe76b4
[13/15] KVM: arm64: Compile remaining hyp/ files for both VHE/nVHE
        commit: c04dd455eb311d2d289c9d81d080eaf11a06cebf
[14/15] KVM: arm64: Remove __hyp_text macro, use build rules instead
        commit: c50cb04303cb88c517715b078e3e010c024af1a5
[15/15] KVM: arm64: Lift instrumentation restrictions on VHE
        commit: f9a026e3d38ba81cd274725f1caaf64322a86aa5

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


