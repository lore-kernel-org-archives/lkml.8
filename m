Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23BDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2CF20739
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592833298;
	bh=V9HgnMaqIzfFVCisajzYw6xWtn5XxqoVR2LehnRXRg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VTbfx7LGeHzldbNFd2tW49fwqpqunE1gwU4KnRGI3bq3R8CEJdRHeaKTEsGLBwTAo
	 JokEbktNdU9loji3dDNmCVS81dGJk79o0Fdb8juvyZVDkL7w/tjBN0a1USnOe+1Jlo
	 dBrjmz3nviwmTOesqs5CCnfXjhw1F/LzBU3RBW5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgFVNlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:41:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728256AbgFVNlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 09:41:36 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D43B20738;
        Mon, 22 Jun 2020 13:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592833295;
        bh=V9HgnMaqIzfFVCisajzYw6xWtn5XxqoVR2LehnRXRg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4RisWB7QV2GO23Tl7QI1mDr/l9CJX+DVFPZO57ChOd9oQ9QaL6+YrWKKgy1QaFXn
         kDrD3y/0+JAIVAR7cuLsE1odFdmY3lyiLJf6H3OyKGpK+QN7KZhh+2bBFA/g4z98Qg
         Xs63zL52x8we+eOuG92QoHkQPMym2xH0ZhQHh9AQ=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jnMha-005KkL-2W; Mon, 22 Jun 2020 14:41:34 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     james.morse@arm.com, suzuki.poulose@arm.com,
        julien.thierry.kdev@gmail.com, linux-kernel@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v2] KVM: arm64: kvm_reset_vcpu() return code incorrect with SVE
Date:   Mon, 22 Jun 2020 14:41:27 +0100
Message-Id: <159283326373.239821.12024358556490900113.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617105456.28245-1-steven.price@arm.com>
References: <20200617105456.28245-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, steven.price@arm.com, will@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com, julien.thierry.kdev@gmail.com, linux-kernel@vger.kernel.org, Dave.Martin@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 11:54:56 +0100, Steven Price wrote:
> If SVE is enabled then 'ret' can be assigned the return value of
> kvm_vcpu_enable_sve() which may be 0 causing future "goto out" sites to
> erroneously return 0 on failure rather than -EINVAL as expected.
> 
> Remove the initialisation of 'ret' and make setting the return value
> explicit to avoid this situation in the future.

Applied to next, thanks!

[1/1] KVM: arm64: Fix kvm_reset_vcpu() return code being incorrect with SVE
      commit: 66b7e05dc0239c5817859f261098ba9cc2efbd2b

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


