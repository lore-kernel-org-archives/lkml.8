Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0C2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F63220825
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590068010;
	bh=clauzvaS2I/eE4iY/eataOze9EMas4dwqsR/r0HZ4cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WZUApVNy+yWMuZyhYebn4LvxKAMLBLleGtVf1R7eotq/aYZI6C2DaYkPvbpGCBY4l
	 /JRqRF5pfSZBShpOBlWO+zlzE3IszjWnDOM6ap8zIrxMuowJdAEy1VhhOrTNlj1F9r
	 ZaMu4k70KXsbyNyWDsj5XxYL2z9or8poC/mTyWEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgEUNd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729437AbgEUNd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:33:28 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1F3B206BE;
        Thu, 21 May 2020 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590068008;
        bh=clauzvaS2I/eE4iY/eataOze9EMas4dwqsR/r0HZ4cg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/t0vsj3wRKHgkz32oAUh4/Xt3Kmkc1nK29Q9FikpaNIVidXSt73cyUkcqGOMnIog
         IKWKG8zA6KLo1QWpxHl3IdpXpMgBq/pZdtmKPocB0x6ijhgBsaXPkoi+sTcdzFnLME
         jRI9+XvpODWZCbZNoOI98BcVnnf+UwnKl5JEp+dE=
Date:   Thu, 21 May 2020 14:33:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, clang-built-linux@googlegroups.com,
        bp@alien8.de
Subject: Re: [PATCH -tip v2 07/11] kcsan: Update Documentation to change
 supported compilers
Message-ID: <20200521133322.GC6608@willie-the-truck>
References: <20200521110854.114437-1-elver@google.com>
 <20200521110854.114437-8-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521110854.114437-8-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 01:08:50PM +0200, Marco Elver wrote:
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  Documentation/dev-tools/kcsan.rst | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

-ENOCOMMITMSG

Will
