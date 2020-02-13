Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9786C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725802173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581588663;
	bh=DcTFDh6Btu9NlaDnpCgIMMBV4IDmzSgnefKuvO9pNK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L08R3AiRYQLAM4FitOC2aWgI9fcnV5ItQMHJFkskDnNI3dOX6Lm2++RUl5/jQasQh
	 oegLuUnOGTmdkV77O9tFEIaX87anLF8DAFMX5Q9nVEVc6FRuggQIvils0BOKXEFALB
	 fOGVWq5NEIm8S5tNDNC7qWgjx1B9UonfyT5UDhvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgBMKLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 05:11:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:51322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgBMKLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 05:11:02 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40FAF20873;
        Thu, 13 Feb 2020 10:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581588662;
        bh=DcTFDh6Btu9NlaDnpCgIMMBV4IDmzSgnefKuvO9pNK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjn/5040/9bpqrzAPIPY0NL05Icp8khNKqiWzTH8ehI9lZjKQY8M4aPda7PZocp9E
         /hHaRaM4IYarz/UZQa8TZE2dKpLxCeCCyXaJlN+Us6LOLCkKDRSWd79d6CpUJVrS2q
         XaLhsvSH3GdMGKQgNUYRSv0f57KBocrE/1T0jazk=
Date:   Thu, 13 Feb 2020 10:10:58 +0000
From:   Will Deacon <will@kernel.org>
To:     minyard@acm.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] arm64 kgdb fixes for single stepping
Message-ID: <20200213101057.GB1405@willie-the-truck>
References: <20200213031131.13255-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213031131.13255-1-minyard@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 09:11:29PM -0600, minyard@acm.org wrote:
> I got a bug report about using kgdb on arm64, and it turns out it was
> fairly broken.  Patch 2 has a description of what was going on.  I am
> using a Marvell 8100 board.
> 
> The following patches fix the problem, but probably not in the
> best way.  They are what I hacked out to show the problems.
> 
> I am not quite sure how this will interact with kprobes and hardware
> breakpoints which use the same code, but they would have been broken,
> too, so this is not making them any worse.

This should all be handled by kgdb itself, not by changing the low-level
debug exception handling. For example, the '&kgdb_step_hook' can take
care of re-arming the step state machine and kgdb can also simply disable
interrupts during the step if it doesn't want to step into the handler.

Will
