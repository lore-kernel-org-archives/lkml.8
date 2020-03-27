Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C94C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1E720717
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgC0Juc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:50:32 -0400
Received: from 8bytes.org ([81.169.241.247]:56190 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgC0Juc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:50:32 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9B4532C8; Fri, 27 Mar 2020 10:50:31 +0100 (CET)
Date:   Fri, 27 Mar 2020 10:50:29 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     iommu@lists.linux-foundation.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Lower severity of add/remove device messages
Message-ID: <20200327095029.GB11538@8bytes.org>
References: <20200323214956.30165-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323214956.30165-1-ezequiel@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 06:49:56PM -0300, Ezequiel Garcia wrote:
> These user messages are not really informational,
> but mostly of debug nature. Lower their severity.

Like most other messages in the kernel log, that is not a reason to
lower the severity. These messages are the first thing to look at when
looking into IOMMU related issues.

Regards,

	Joerg

