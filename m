Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D411C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08254207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589983539;
	bh=HfBCWFfRpM5VyyK+IDlm6yuZbOJ44nnW86i2oO6kM+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UheO30JarCjLzVCOOHd7aMcCmtkNMEFY2FagQau1p+a+J/1xQHTYjjg9Xls3lcY2W
	 q+wN7qIqKgudR/rqyB47QSla6m8HqJ97r2VRBaMEI5d9b7v8MduEXctLVEJ3j1fRxv
	 8J95v1HriVo91/Z7mxI9BeDzkbV4hZSL4chxZ+e0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgETOFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETOFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:05:38 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DDE020756;
        Wed, 20 May 2020 14:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589983537;
        bh=HfBCWFfRpM5VyyK+IDlm6yuZbOJ44nnW86i2oO6kM+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=km2IocK4xKMy0nzEBce/dnj+q4vAZie6wkUiAQLo5+2Wn5Rrg6O7bxDwfsIduhi9C
         HSFO01WSisjf1RqyFbhMAhcLuglhBwrRC3NynA8W57NnQFzM5fKpHtljmC/7SRpvxS
         jpJe+ok0CKW6OEMrbEy6akwapZMWCo1zcZnzhqYM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jbPLj-00Dx1Q-UT; Wed, 20 May 2020 15:05:36 +0100
Date:   Wed, 20 May 2020 15:05:33 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/cpufeature: Drop open encodings while
 extracting parange
Message-ID: <20200520150533.3034fe90@why>
In-Reply-To: <1589360614-1164-1-git-send-email-anshuman.khandual@arm.com>
References: <1589360614-1164-1-git-send-email-anshuman.khandual@arm.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 14:33:34 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> Currently there are multiple instances of parange feature width mask open
> encodings while fetching it's value. Even the width mask value (0x7) itself
> is not accurate. It should be (0xf) per ID_AA64MMFR0_EL1.PARange[3:0] as in
> ARM ARM (0487F.a). Replace them with cpuid_feature_extract_unsigned_field()
> which can extract given standard feature (4 bits width i.e 0xf mask) field.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Marc Zyngier <maz@kernel.org>

	M.
-- 
Jazz is not dead. It just smells funny...
