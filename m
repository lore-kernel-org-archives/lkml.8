Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE90C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48EEF207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587415345;
	bh=SYmDL71+i0dxipydp4fzdeCa0qcgn3q6383QGXptJxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Evau+uIVX5nIwrrEinJgNSf61b0v6MVMr/d44ZG6Qerpw612hidmLv789o+I7qJg4
	 DPro7dU0xb5zT2bWdqpcRkrbFQYnnmw+/sSkYzq3qL3Or8dCZcv+5XcFW00nwrBS3p
	 y/aESz8cqpygMWBU4cdh5QR0wRUvzUtQI1HfwqR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgDTUmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbgDTUmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:42:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F259206E9;
        Mon, 20 Apr 2020 20:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587415343;
        bh=SYmDL71+i0dxipydp4fzdeCa0qcgn3q6383QGXptJxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xMeM05XEdBoL/1hRghTVBJkRL92JNBsc0vONEfPdXkSjSKxdOO+hwrPBHdB/Cr1Z9
         GOD/PkSOModeIzIKldikpS1QexS3bmWDjnQ1l890YR72ONrmjqRMU1CbRcBJio2bGZ
         DiXKGrl9oq/t5wptbUrKeawIy93SgtP0oDiVXJH0=
Date:   Mon, 20 Apr 2020 21:42:18 +0100
From:   Will Deacon <will@kernel.org>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     catalin.marinas@arm.com, alexios.zavras@intel.com,
        tglx@linutronix.de, akpm@linux-foundation.org,
        steven.price@arm.com, steve.capper@arm.com, mark.rutland@arm.com,
        broonie@kernel.org, keescook@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] arm64: add check_wx_pages debugfs for CHECK_WX
Message-ID: <20200420204217.GA29998@willie-the-truck>
References: <20200307093926.27145-1-tranmanphong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307093926.27145-1-tranmanphong@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 04:39:26PM +0700, Phong Tran wrote:
> follow the suggestion from
> https://github.com/KSPP/linux/issues/35
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  arch/arm64/Kconfig.debug        |  3 ++-
>  arch/arm64/include/asm/ptdump.h |  2 ++
>  arch/arm64/mm/dump.c            |  1 +
>  arch/arm64/mm/ptdump_debugfs.c  | 18 ++++++++++++++++++
>  4 files changed, 23 insertions(+), 1 deletion(-)

Any plans to spin an updated version of this? The review feedback all seemed
reasonable to me.

Thanks,

Will
