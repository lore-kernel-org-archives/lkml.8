Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F27C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E443B2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579619912;
	bh=CtK3JLf0Ca51+J8hJt7LWVIKavo/FjuD+bA7WxkQPnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r5eejnIVxiJ9dh1VPeCMN88byMj0m//Uck+5CZWEJUmhxUD1CjDJTWCy8zkLi4DwN
	 SgFQejU8FWBTgZFHmnjbaeGpQVexJft1m98p1+nuRynmGTQWBGlDD82e8UV4GVbalD
	 UG+AdofRBNrCxJLe5dyv+kXQonYexPddDzl9cQOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgAUPSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:18:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbgAUPSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:18:30 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7C3921569;
        Tue, 21 Jan 2020 15:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579619910;
        bh=CtK3JLf0Ca51+J8hJt7LWVIKavo/FjuD+bA7WxkQPnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f+U0QlGv/bdGpsxGtHX1GaxiJvKWSpeobAKeO03bfnKHEAbFOkkRQKadJqUtcPmBR
         /6WJ2ikdWHpJmjl+WJ4ot+roUJiQo6RWpMQygypOZGHASvlgpP6GW+Qi0nfKc4L6VU
         k8qJBdBdmJyshGMhVQZG6jcP19F0rzd0ruFm9qCk=
Date:   Tue, 21 Jan 2020 15:18:23 +0000
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, david@redhat.com,
        cai@lca.pw, logang@deltatee.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com,
        mgorman@techsingularity.net, osalvador@suse.de,
        ard.biesheuvel@arm.com, steve.capper@arm.com, broonie@kernel.org,
        valentin.schneider@arm.com, Robin.Murphy@arm.com,
        steven.price@arm.com, suzuki.poulose@arm.com, ira.weiny@intel.com
Subject: Re: [PATCH V12 0/2] arm64/mm: Enable memory hot remove
Message-ID: <20200121151822.GA13306@willie-the-truck>
References: <1579157135-10360-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579157135-10360-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 12:15:33PM +0530, Anshuman Khandual wrote:
> This series enables memory hot remove functionality on arm64 platform. This
> is based on Linux 5.5-rc6 and particularly deals with a problem caused when
> boot memory is attempted to be removed.

Unfortunately, this results in a conflict with mainline since the arm64
-next branches are based on -rc3 and there was a fix merged after that
(feee6b298916 ("mm/memory_hotplug: shrink zones when offlining memory"))
which changes the type of __remove_pages().

So I think I'll leave this for 5.7.

Will
