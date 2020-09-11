Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A50C2BC11
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1BE221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599840469;
	bh=HMkToyAt+R5UW/0fJTeoIckq2g06NAPzV1gQYp89vEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NXMR5UbocdP30WKxmy/hkqtywhTxNR713z7vIxl6XzBRGGsnwkyGULEHb4Axqd6oN
	 Mo0Fn2h3IcHWYssgDzWUGQatj5itf+bjXF4vcax/ffYThZQxWmgQhT3u6t4pkja1t5
	 WgcBUkzxoS+JohAggIP2FcXM8qgFL7avQ7h8nhug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgIKQHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbgIKQHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:07:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AFC2206CA;
        Fri, 11 Sep 2020 16:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599840432;
        bh=HMkToyAt+R5UW/0fJTeoIckq2g06NAPzV1gQYp89vEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rW40pgimHDCBZ3vHXEgiusgmWmT7c33pKGm3eMIMIJHF2eAVYvAbQbBax0f1VzpZL
         7GRrVgdXVhGnr00ED/n/a2itqfP1aYXxYL8QXzDrhFZaI2IUqsJrt9zBMuVKFqYO6z
         OOd1Jf5FYqf9x4SCl57HVjpIsmhSc5NfoUhTu41w=
Date:   Fri, 11 Sep 2020 17:07:07 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        freedreno@lists.freedesktop.org,
        "Kristian H . Kristensen" <hoegsberg@google.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCHv4 6/6] iommu: arm-smmu-impl: Remove unwanted extra blank
 lines
Message-ID: <20200911160706.GA20802@willie-the-truck>
References: <cover.1599832685.git.saiprakash.ranjan@codeaurora.org>
 <010101747d912d9f-c8050b8d-1e81-4be0-ac35-b221f657b490-000000@us-west-2.amazonses.com>
 <c26b5317-f12d-8be9-be45-3307ce5efbfc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c26b5317-f12d-8be9-be45-3307ce5efbfc@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 05:03:06PM +0100, Robin Murphy wrote:
> BTW am I supposed to have received 3 copies of everything? Because I did...

Yeah, this seems to be happening for all of Sai's emails :/

Will
