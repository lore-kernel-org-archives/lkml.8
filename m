Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9801C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8F720786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgCXLXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:23:21 -0400
Received: from foss.arm.com ([217.140.110.172]:60984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgCXLXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:23:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0C2231B;
        Tue, 24 Mar 2020 04:23:20 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB8793F792;
        Tue, 24 Mar 2020 04:23:19 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:23:17 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>,
        will@kernel.org, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: clean up trampoline vector loads
Message-ID: <20200324112316.GG4892@mbp>
References: <1938400.7m7sAWtiY1@basile.remlab.net>
 <20200323121437.GC2597@C02TD0UTHF1T.local>
 <20200323190408.GE4892@mbp>
 <2067644.cOvikPKVsA@basile.remlab.net>
 <20200324105217.GA20256@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200324105217.GA20256@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 10:52:17AM +0000, Mark Rutland wrote:
> On Mon, Mar 23, 2020 at 10:42:30PM +0200, Rémi Denis-Courmont wrote:
> > Le maanantaina 23. maaliskuuta 2020, 21.04.09 EET Catalin Marinas a écrit :
> > > Should we just use adrp on __entry_tramp_data_start? Anyway, the diff
> > > below doesn't solve the issue I'm seeing (only reverting patch 3).
> > 
> > AFAIU, the preexisting code uses the manual PAGE_SIZE offset because the offset 
> > in the main vmlinux does not match the architected offset inside the fixmap. If 
> > so, then using the symbol directly will not work at all.
> 
> Indeed. I can't see a neat way of avoiding this right now, so should we
> drop these patches and leave the code as-is (but with comments as to the
> special requirements that it has)?

I'm going to drop these three patches from -next for now but I can take
any updated comments (they are pretty much missing from this code).

Thanks.

-- 
Catalin
