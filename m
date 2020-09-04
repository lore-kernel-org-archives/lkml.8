Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC36C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1746E2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbgIDJx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:53:59 -0400
Received: from 8bytes.org ([81.169.241.247]:41058 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729872AbgIDJxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:53:55 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6962C9CE; Fri,  4 Sep 2020 11:53:54 +0200 (CEST)
Date:   Fri, 4 Sep 2020 11:53:53 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        sean.m.osborne@oracle.com, james.puthukattukaran@oracle.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        jon.grimm@amd.com
Subject: Re: [PATCH 0/2 v2] iommu: amd: Fix intremap IO_PAGE_FAULT for VMs
Message-ID: <20200904095352.GR6714@8bytes.org>
References: <20200903093822.52012-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903093822.52012-1-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 09:38:20AM +0000, Suravee Suthikulpanit wrote:
> Suravee Suthikulpanit (2):
>   iommu: amd: Restore IRTE.RemapEn bit after programming IRTE
>   iommu: amd: Use cmpxchg_double() when updating 128-bit IRTE

Applied both for v5.9, thanks Suravee.

