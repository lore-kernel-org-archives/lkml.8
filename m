Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5A3C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2C620705
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759458;
	bh=5MkXauhoehfgF1bchJUtFa+ktvr7TubTgXLAVcWSsPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O53r4Zb20ZKENhM/hznpyQwZ6NXIqZ9aQLms9cldCsMFK1lCWIQ+hqL9xSfIX+c9b
	 C/6dqrDxaThjlAiCrRPbUaMz8F3tjRmFRcboiFuiVTHxmKVYEzi28lc6VyIEmn2ZP9
	 Rv9J1gfU/WU9LNGG1ZqsDJ8d2dj04GPBubRf/4hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389703AbgDAQoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389546AbgDAQoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:44:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B6BC2063A;
        Wed,  1 Apr 2020 16:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759454;
        bh=5MkXauhoehfgF1bchJUtFa+ktvr7TubTgXLAVcWSsPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GMJZCm1PiJ7oGWgVSWFjIT0ICXL8mvjxojEUI2Zw5EQecmonSRVYIPeT929ddyqjE
         roVOCaErOSJzTeEin7AjOcQSUzoh6SXsIUYdgx6VFGvmXL28zwN62aKojPcmx8QO4F
         3ay91iZJDYIcL49P6DnD1n6PGunFFIr97tjTStVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 085/148] arm64: ptrace: map SPSR_ELx<->PSR for compat tasks
Date:   Wed,  1 Apr 2020 18:17:57 +0200
Message-Id: <20200401161601.264697375@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

commit 76fc52bd07d3e9cb708f1a50b60c825c96acd606 upstream.

The SPSR_ELx format for exceptions taken from AArch32 is slightly
different to the AArch32 PSR format.

Map between the two in the compat ptrace code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 7206dc93a58fb764 ("arm64: Expose Arm v8.4 features")
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/ptrace.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -833,6 +833,7 @@ static int compat_gpr_get(struct task_st
 			break;
 		case 16:
 			reg = task_pt_regs(target)->pstate;
+			reg = pstate_to_compat_psr(reg);
 			break;
 		case 17:
 			reg = task_pt_regs(target)->orig_x0;
@@ -900,6 +901,7 @@ static int compat_gpr_set(struct task_st
 			newregs.pc = reg;
 			break;
 		case 16:
+			reg = compat_psr_to_pstate(reg);
 			newregs.pstate = reg;
 			break;
 		case 17:


