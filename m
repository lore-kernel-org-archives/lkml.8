Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47037C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165402071B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Lp+85cge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgIBCYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 22:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBCYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 22:24:20 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5451BC061244;
        Tue,  1 Sep 2020 19:24:19 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1003)
        id 4Bh76p1Lpdz9sV8; Wed,  2 Sep 2020 12:24:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1599013458; bh=EVixgcCRwMWQEliFU3rC3kvQfdu2zUDN7I19538RUFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lp+85cgesSbN4lHlJc86ML29C4qx3hCTYUlwbUvtWndDtjTon38aXbhOL4a+gPzEf
         zR/1jLvj6BaAqrcvn9oTJDo3SpVnGxm1Oxvy153U5wDdOXSRkHESwkIh0fxAx5yzL8
         TNp0lEUzgCSR2pDRI+HFIfIGMv5MNYu8I4XdKL7rahf+F7ba3rU8h5wpa2dyjlOuKi
         XkdDBiyKjDWvSo0Ov+pX1oIWfz9hMw3fbvLeZ02D8Nc22Z3vwv/v6g4uqLKb3QgpLh
         IshWK5zmMDEuDL249XkM5xtdy279iAHHIM79WHP0HERuIc2a9p2i6U2RoHP/KFyuhp
         WPQ4Qlv/ifY6A==
Date:   Wed, 2 Sep 2020 12:01:24 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, npiggin@gmail.com,
        pbonzini@redhat.com, christophe.leroy@c-s.fr, jniethe5@gmail.com,
        pedromfc@br.ibm.com, rogealve@br.ibm.com, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/7] powerpc/watchpoint/kvm: Add infrastructure to
 support 2nd DAWR
Message-ID: <20200902020124.GB272502@thinks.paulus.ozlabs.org>
References: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
 <20200723102058.312282-3-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723102058.312282-3-ravi.bangoria@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 03:50:53PM +0530, Ravi Bangoria wrote:
> kvm code assumes single DAWR everywhere. Add code to support 2nd DAWR.
> DAWR is a hypervisor resource and thus H_SET_MODE hcall is used to set/
> unset it. Introduce new case H_SET_MODE_RESOURCE_SET_DAWR1 for 2nd DAWR.

Is this the same interface as will be defined in PAPR and available
under PowerVM, or is it a new/different interface for KVM?

> Also, kvm will support 2nd DAWR only if CPU_FTR_DAWR1 is set.

In general QEMU wants to be able to control all aspects of the virtual
machine presented to the guest, meaning that just because a host has a
particular hardware capability does not mean we should automatically
present that capability to the guest.

In this case, QEMU will want a way to control whether the guest sees
the availability of the second DAWR/X registers or not, i.e. whether a
H_SET_MODE to set DAWR[X]1 will succeed or fail.

Paul.
