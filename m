Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C24C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665A420714
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbgGVNd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgGVNd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:33:27 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF9AC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 06:33:26 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 091402C8; Wed, 22 Jul 2020 15:33:24 +0200 (CEST)
Date:   Wed, 22 Jul 2020 15:33:23 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.9
Message-ID: <20200722133323.GG27672@8bytes.org>
References: <20200721080352.GA13023@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721080352.GA13023@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Tue, Jul 21, 2020 at 09:03:53AM +0100, Will Deacon wrote:
> Please pull these Arm SMMU driver updates for 5.9. Summary is in the tag,
> but the main thing is support for two new SoC integrations, one of which
> is considerably more brain-dead than the other (determining which one is
> left as an exercise to the reader although the diffstat is fairly revealing).

:)

> The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:
> 
>   Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

Pulled, thanks. Given the number of arm-smmu* files it probably makes
sense to create a drivers/iommu/arm-smmu/ directory and move it all
there. If you agree feel free to send this as an additional patch on-top
of this pull-request.

Regards,

	Joerg
