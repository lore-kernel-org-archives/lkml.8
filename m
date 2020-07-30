Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA64DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A813820838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596117136;
	bh=r/gRPHhAPpag3PUKYG81HrzkMbvKm74zY6qgVadUZjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pul/FMZqWLzVar1GI13ctO6zfm+jJdHujJsyOkVEqrbYurQcbJ3vm5WM7PCE0Df6m
	 PBzrzIEjMafz/m5fPuZnPJbNhTyfyJLegZ29PSN+u5QdGI8mpf9QwcDgp5M2+vg8/7
	 WpHhOVWqYmFqZ+5COp1BKC/v5PQoPTR3HP96Huzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgG3NwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgG3NwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:52:14 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C41022074B;
        Thu, 30 Jul 2020 13:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596117133;
        bh=r/gRPHhAPpag3PUKYG81HrzkMbvKm74zY6qgVadUZjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lW33+vWwgbIQye4m0sYHmXGL3H7rTAzbHiJ1eDKwB8R1J09wLwKHSZ0LtxDlClk5Y
         +vzLimyF/jYeFL9cEY//YbEuC7jMhzmWJiHXFDoZVISyDlQggwd0lkJO5Nk/+rtAiI
         xmN+5VqQFXjPljqBGduHTpXq5qt33EcNlo7PfJQc=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k18yi-00GGvl-6w; Thu, 30 Jul 2020 14:52:12 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>, David Brazdil <dbrazdil@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@google.com, clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        android-kvm@google.com, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH] KVM: arm64: Ensure that all nVHE hyp code is in .hyp.text
Date:   Thu, 30 Jul 2020 14:52:09 +0100
Message-Id: <159611709973.1644456.15046238262603869142.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730132519.48787-1-dbrazdil@google.com>
References: <20200730132519.48787-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, dbrazdil@google.com, catalin.marinas@arm.com, kernel-team@google.com, clang-built-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020 14:25:19 +0100, David Brazdil wrote:
> Some compilers may put a subset of generated functions into '.text.*'
> ELF sections and the linker may leverage this division to optimize ELF
> layout. Unfortunately, the recently introduced HYPCOPY command assumes
> that all executable code (with the exception of specialized sections
> such as '.hyp.idmap.text') is in the '.text' section. If this
> assumption is broken, code in '.text.*' will be merged into kernel
> proper '.text' instead of the '.hyp.text' that is mapped in EL2.
> 
> [...]

Applied to kvm-arm64/el2-obj-v4.1, thanks!

[1/1] KVM: arm64: Ensure that all nVHE hyp code is in .hyp.text
      commit: bdbc0c7a070c0cbe3009cd271c6ec8d87d69cc7a

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


