Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EF9C2BC11
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E6A222204
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgIKQV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:21:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgIKPaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:30:03 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BCEA20770;
        Fri, 11 Sep 2020 15:30:02 +0000 (UTC)
Date:   Fri, 11 Sep 2020 16:30:00 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anshuman.khandual@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH v2 2/3] arm64/mm: Unitify CONT_PTE_SHIFT
Message-ID: <20200911152959.GI12835@gaia>
References: <20200910095936.20307-1-gshan@redhat.com>
 <20200910095936.20307-2-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910095936.20307-2-gshan@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 07:59:35PM +1000, Gavin Shan wrote:
> CONT_PTE_SHIFT actually depends on CONFIG_ARM64_CONT_SHIFT. It's
> reasonable to reflect the dependency:
> 
>    * This renames CONFIG_ARM64_CONT_SHIFT to CONFIG_ARM64_CONT_PTE_SHIFT,
>      so that we can introduce CONFIG_ARM64_CONT_PMD_SHIFT later.
> 
>    * CONT_{SHIFT, SIZE, MASK}, defined in page-def.h are removed as they
>      are not used by anyone.
> 
>    * CONT_PTE_SHIFT is determined by CONFIG_ARM64_CONT_PTE_SHIFT.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
