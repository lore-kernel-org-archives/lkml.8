Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E97C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26F820775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgFZEqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:46:14 -0400
Received: from ozlabs.org ([203.11.71.1]:42021 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbgFZEqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:46:07 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49tPTn068Jz9sTV; Fri, 26 Jun 2020 14:46:04 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200612142953.135408-1-sathnaga@linux.vnet.ibm.com>
References: <20200612142953.135408-1-sathnaga@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] powerpc/pseries/svm: Drop unused align argument in alloc_shared_lppaca() function
Message-Id: <159314672679.1150869.345529163412866656.b4-ty@ellerman.id.au>
Date:   Fri, 26 Jun 2020 14:46:04 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020 19:59:53 +0530, Satheesh Rajendran wrote:
> Argument "align" in alloc_shared_lppaca() was unused inside the
> function. Let's drop it and update code comment for page alignment.

Applied to powerpc/next.

[1/1] powerpc/pseries/svm: Drop unused align argument in alloc_shared_lppaca() function
      https://git.kernel.org/powerpc/c/178748b6d14946f080d49bc7dcc47b7cc4437e4d

cheers
