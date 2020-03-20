Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C80BC43333
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BDD20782
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCTSZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:25:03 -0400
Received: from foss.arm.com ([217.140.110.172]:55454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgCTSZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:25:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 914D21FB;
        Fri, 20 Mar 2020 11:25:00 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4939B3F305;
        Fri, 20 Mar 2020 11:24:59 -0700 (PDT)
Date:   Fri, 20 Mar 2020 18:24:56 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu,
        will@kernel.org
Subject: Re: [PATCH] arm64: move kimage_vaddr to .rodata
Message-ID: <20200320182456.GF7448@mbp>
References: <20200312094002.153302-1-remi@remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200312094002.153302-1-remi@remlab.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 11:40:02AM +0200, Rémi Denis-Courmont wrote:
> From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> This datum is not referenced from .idmap.text: it does not need to be
> mapped in idmap. Lets move it to .rodata as it is never written to after
> early boot of the primary CPU.
> (Maybe .data.ro_after_init would be cleaner though?)
> 
> Signed-off-by: Rémi Denis-Courmont <remi@remlab.net>

Queued for 5.7. Thanks.

-- 
Catalin
