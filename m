Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68FDC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C06472073E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593973093;
	bh=ZcyrfoWN8MHHgOfd7nwKxw3dttJq6mqbG1jYnjHLddQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IUmw25bfeZE/ZYtG+B9KLpvfPL8t8ur6jtJD7uXeQcwbNzs975Dv4nwGLUlDH39ap
	 rwz+sjxQAUQaSU6BtfcY+wR3IS77IHPtUQnSsqe7qLy1VyWCHMyDiZgiUm6yyugqas
	 WcYUDzmqIvKHrB5++hvuEqs/ni10hoBhbZ+cDrLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgGESSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 14:18:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgGESSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 14:18:11 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5521B20720;
        Sun,  5 Jul 2020 18:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593973091;
        bh=ZcyrfoWN8MHHgOfd7nwKxw3dttJq6mqbG1jYnjHLddQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fMwO1tF7X+Qe3aFk1yGRRfk0zU6kFp6AxXSN2NRPvaP6MYjEbP4+y2WQaKMRfXVFh
         Hw7lWfl8t5bqOFxXCYUhdI4/glZ8TV0VMcoZ70b3tW+XqWGw1kikGQzDNVBXc/8WwE
         c3Gn0NIzBL2kYtDE+MSTmycyMkPOKbFj2+9ssHiY=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1js9DN-009Dpy-Rr; Sun, 05 Jul 2020 19:18:09 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Alexander Graf <graf@amazon.com>, kvmarm@lists.cs.columbia.edu
Cc:     kernel-team@android.com, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Change default caching mode for {PEND, PROP}BASER.outer
Date:   Sun,  5 Jul 2020 19:18:03 +0100
Message-Id: <159397301833.254690.3043556347352831821.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701140206.8664-1-graf@amazon.com>
References: <20200701140206.8664-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: graf@amazon.com, kvmarm@lists.cs.columbia.edu, kernel-team@android.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 16:02:06 +0200, Alexander Graf wrote:
> PENDBASER and PROPBASER define the outer caching mode for LPI tables.
> The memory backing them may not be outer sharable, so we mark them as nC
> by default. This however, breaks Windows on ARM which only accepts
> SameAsInner or RaWaWb as values for outer cachability.
> 
> We do today already allow the outer mode to be set to SameAsInner
> explicitly, so the easy fix is to default to that instead of nC for
> situations when an OS asks for a not fulfillable cachability request.
> 
> [...]

Applied to kvm-arm64/next-5.9, thanks!

[1/1] KVM: arm64: vgic-its: Change default outer cacheability for {PEND, PROP}BASER
      commit: 731532176716e2775a5d21115bb9c5c61e0cb704

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


