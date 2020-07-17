Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22F5C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC54A20684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594980226;
	bh=AjmrtslKmwX/6PMA4+8pzIsPlXZYlwjTJ2i/lkpv7EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nhfvfYDRsiJlf1nYvhIpkt/y1O7U4WFW+TZw+vOea6ZCzuGqOhgyXRv+kSBObW9Cf
	 HG6gTY/RUtX2B+waMXEd7ZTGUxia03cZdlhe/WkqQFkJ6VKV6+f/id3rzMoK5Znsrm
	 rkH487sGwnZKfmU42sPofixS3JvTUQUG+xeZ5qXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgGQKDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgGQKDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 06:03:44 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 847C12076A;
        Fri, 17 Jul 2020 10:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594980224;
        bh=AjmrtslKmwX/6PMA4+8pzIsPlXZYlwjTJ2i/lkpv7EI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0HOWqPq7Xb6a4IP4VN2D6+4wU2bfE7MkxqiblCPE/mlCsFKsb1nHocBy0S6ckTenx
         vjcn55OkAGmZtsR2bQgTQ8loJ3UMMFEBNzJglNPAzMuIwrGvp12AJiLpv2XOpkvd2A
         10Af/T/FlmIlYB+IMR60aNjx+i8kzW7XFA+Q/SmI=
Date:   Fri, 17 Jul 2020 11:03:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     joro@8bytes.org, robin.murphy@arm.com, robh+dt@kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, yhsu@nvidia.com, snikam@nvidia.com,
        praithatha@nvidia.com, talho@nvidia.com, bbiswas@nvidia.com,
        mperttunen@nvidia.com, nicolinc@nvidia.com, bhuntsman@nvidia.com,
        nicoleotsuka@gmail.com
Subject: Re: [PATCH v10 0/5] NVIDIA ARM SMMU Implementation
Message-ID: <20200717100337.GA8673@willie-the-truck>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200713135020.GD2739@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713135020.GD2739@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 02:50:20PM +0100, Will Deacon wrote:
> On Tue, Jul 07, 2020 at 10:00:12PM -0700, Krishna Reddy wrote:
> > Changes in v10:
> > Perform SMMU base ioremap before calling implementation init.
> > Check for Global faults across both ARM MMU-500s during global interrupt.
> > Check for context faults across all contexts of both ARM MMU-500s during context fault interrupt.
> > Add new DT binding nvidia,smmu-500 for NVIDIA implementation.
> 
> Please repost based on my SMMU queue, as this doesn't currently apply.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates

Any update on this, please? It would be a shame to miss 5.9 now that the
patches look alright.

Will
