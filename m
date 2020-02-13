Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026F2C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA85B217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FTr4ag9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgBMJLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:11:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40164 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbgBMJLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DxpiptL2pUZ6GLGMQaYrfBXAAODM92lCFecuBtl0f50=; b=FTr4ag9Qxwa1NG8zi/HRSHf9Hz
        O6V6wVy9IdVnkYJc43lq7Nh+uUCTGy1hXehEixF7g+CtmU+I1I6jlI0wbdj9ykzDI1wgLZaDBWdfG
        HLyRMd941f6JVZu6Y7e+O5xLqGHxRZXZ6maHOQeE+NtzsaKbQu9M51ltWJkdZ1nW0xwOZV/UYf1Kc
        5Sf3vrhkFO+1Q+pr3NFO6OqJlV/YwHQPSZTLh78ZWSo+aA4IYfkE367OMQrOr82XuWL6cM7Ou1t25
        kPT6w5ONGr91aEYwuDEm43vTrtH4AjeDjWY6yu2W0nD/hwneb8IzbUJ78ER9wF2EgsMMqYKaE53SO
        xq0Qlt7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2AWV-0006O1-3p; Thu, 13 Feb 2020 09:11:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A960C30066E;
        Thu, 13 Feb 2020 10:09:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3562D20206D69; Thu, 13 Feb 2020 10:11:01 +0100 (CET)
Date:   Thu, 13 Feb 2020 10:11:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stefan Asserhall <stefana@xilinx.com>
Cc:     Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>, git <git@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/7] microblaze: Define SMP safe bit operations
Message-ID: <20200213091101.GM14897@hirez.programming.kicks-ass.net>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <6a052c943197ed33db09ad42877e8a2b7dad6b96.1581522136.git.michal.simek@xilinx.com>
 <20200212155309.GA14973@hirez.programming.kicks-ass.net>
 <cd4c6117-bc61-620c-8477-44df6e51d7b8@xilinx.com>
 <BYAPR02MB499729CFF3B9FD7DDDCFBCD8DD1A0@BYAPR02MB4997.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR02MB499729CFF3B9FD7DDDCFBCD8DD1A0@BYAPR02MB4997.namprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 09:01:21AM +0000, Stefan Asserhall wrote:
> The comment in the generic bitops.h says "You should recode these in the
> native assembly language, if at all possible". I don't think using the generic
> implementation will be as efficient as the current arch specific one.

That is a very crusty old recommendation. Please look at the compiler
generated code.

We've extended the atomic_t operations the past few years and Will wrote
the generic atomic bitops for Arm64, we're looking to convert more LL/SC
archs to them.

There is currently one known issue with it, but Will has a patch-set
pending to solve that (IIRC that only matters if you have stack
protector on).

Also see this thread:

  https://lkml.kernel.org/r/875zimp0ay.fsf@mpe.ellerman.id.au

And these patches:

  https://lkml.kernel.org/r/20200123153341.19947-1-will@kernel.org
