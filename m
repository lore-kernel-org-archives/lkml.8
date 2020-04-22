Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FC3C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A42820776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgDVRLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:11:33 -0400
Received: from foss.arm.com ([217.140.110.172]:52966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgDVRLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:11:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7CFA1FB;
        Wed, 22 Apr 2020 10:11:32 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4581F3F6CF;
        Wed, 22 Apr 2020 10:11:31 -0700 (PDT)
Date:   Wed, 22 Apr 2020 18:11:22 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Phong Tran <tranmanphong@gmail.com>, steve.capper@arm.com,
        steven.price@arm.com, keescook@chromium.org, greg@kroah.com,
        akpm@linux-foundation.org, alexios.zavras@intel.com,
        broonie@kernel.org, kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH v2] arm64: add check_wx_pages debugfs for CHECK_WX
Message-ID: <20200422171122.GA40812@lakrids.cambridge.arm.com>
References: <20200307093926.27145-1-tranmanphong@gmail.com>
 <20200421173557.10817-1-tranmanphong@gmail.com>
 <20200422143526.GD54796@lakrids.cambridge.arm.com>
 <20200422152656.GF676@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422152656.GF676@willie-the-truck>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 04:26:56PM +0100, Will Deacon wrote:
> On Wed, Apr 22, 2020 at 03:35:27PM +0100, Mark Rutland wrote:
> > Thanks,
> > Marm.
> 
> Wow, employee of the month!

Muscle-memory has finally defeated me...

Marm.
