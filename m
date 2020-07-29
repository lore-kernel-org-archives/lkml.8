Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DF8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30432205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgG2MQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2MQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:16:32 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7A0C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 05:16:32 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D9BB83EC; Wed, 29 Jul 2020 14:16:28 +0200 (CEST)
Date:   Wed, 29 Jul 2020 14:16:20 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 0/2] iommu: Move AMD and Intel Kconfig + Makefile bits
 into their directories
Message-ID: <20200729121619.GA23653@8bytes.org>
References: <20200630200636.48600-1-jsnitsel@redhat.com>
 <87d04gshgh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d04gshgh.fsf@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 03:47:58PM -0700, Jerry Snitselaar wrote:
> Looks like I forgot to cc you on this cover letter for v2.
> Does this work for you now?

Got it, applied now, thanks Jerry.
