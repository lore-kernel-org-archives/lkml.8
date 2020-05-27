Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5C5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 04:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015DD20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 04:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="I3B2gb+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgE0EVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 00:21:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47563 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbgE0EVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 00:21:02 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 49WyLh3q1Kz9sSg; Wed, 27 May 2020 14:21:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1590553260; bh=Y21jN5y45Um4AYIa//KCJfpc5WBbHBo15ZjCSQkLVDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3B2gb+CqUvnQTciOQNbK+Nanl0aafykbtezdHL4nEHndD94WUy5NzD9feSxRyj49
         QsAoqdEtwRtAS8YCi93WAfbLMVvB2u67ufu53/SWaWwAfhLRaSO6XcMDVAXKpSEbi3
         2nhgX+lFSTNVaNijRZ+Lopo0iA+wnctLMQABLJZDyy8DXRlW0v+qY/763/ZZy1EujN
         UeYyAXI/IzV1D7lbTueJ5plZCHBnk9MrHForXAsPE/LBrl2Ip0AooCH6/mkwiczEgn
         8zvYmomsomo+Sh0iv8WMogEZTERJrj5XG7mnchJAoBaMlm2C5D4ruHw65MLKrLHbZz
         RPtepX0/K25jQ==
Date:   Wed, 27 May 2020 14:16:49 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, groug@kaod.org, mpe@ellerman.id.au,
        sukadev@linux.ibm.com, linuxram@us.ibm.com
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: relax check on H_SVM_INIT_ABORT
Message-ID: <20200527041649.GD293451@thinks.paulus.ozlabs.org>
References: <20200520193259.0b66db32@bahia.lan>
 <20200520174308.77820-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520174308.77820-1-ldufour@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 07:43:08PM +0200, Laurent Dufour wrote:
> The commit 8c47b6ff29e3 ("KVM: PPC: Book3S HV: Check caller of H_SVM_*
> Hcalls") added checks of secure bit of SRR1 to filter out the Hcall
> reserved to the Ultravisor.
> 
> However, the Hcall H_SVM_INIT_ABORT is made by the Ultravisor passing the
> context of the VM calling UV_ESM. This allows the Hypervisor to return to
> the guest without going through the Ultravisor. Thus the Secure bit of SRR1
> is not set in that particular case.
> 
> In the case a regular VM is calling H_SVM_INIT_ABORT, this hcall will be
> filtered out in kvmppc_h_svm_init_abort() because kvm->arch.secure_guest is
> not set in that case.
> 
> Fixes: 8c47b6ff29e3 ("KVM: PPC: Book3S HV: Check caller of H_SVM_* Hcalls")
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Thanks, applied to my kvm-ppc-next branch.  I expanded the comment in
the code a little.

Paul.
