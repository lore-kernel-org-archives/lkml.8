Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25C7C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07CA20848
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgCIKoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:44:16 -0400
Received: from foss.arm.com ([217.140.110.172]:50374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgCIKoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:44:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3D6B1FB;
        Mon,  9 Mar 2020 03:44:15 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E52E3F67D;
        Mon,  9 Mar 2020 03:44:14 -0700 (PDT)
Date:   Mon, 9 Mar 2020 10:44:12 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     =?utf-8?B?546L56iL5Yia?= <wangchenggang@vivo.com>
Cc:     'Catalin Marinas' <catalin.marinas@arm.com>,
        'Will Deacon' <will@kernel.org>,
        'Marc Zyngier' <maz@kernel.org>,
        'Allison Randal' <allison@lohutok.net>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Andrew Murray' <amurray@thegoodpenguin.co.uk>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, wenhu.wang@vivo.com
Subject: Re: [PATCH] arch/arm64: fix typo in a comment
Message-ID: <20200309104411.GB25261@lakrids.cambridge.arm.com>
References: <000401d5f5e3$622aefa0$2680cee0$@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000401d5f5e3$622aefa0$2680cee0$@vivo.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 03:21:42PM +0800, 王程刚 wrote:
> Fix typo in a comment in arch/arm64/include/asm/esr.h
> 
> "Unallocted" -> "Unallocated"
> 
> Signed-off-by: Chenggang Wang <wangchenggang@vivo.com>

My bad, it seems.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/esr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index cb29253ae86b..6a395a7e6707 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -60,7 +60,7 @@
>  #define ESR_ELx_EC_BKPT32	(0x38)
>  /* Unallocated EC: 0x39 */
>  #define ESR_ELx_EC_VECTOR32	(0x3A)	/* EL2 only */
> -/* Unallocted EC: 0x3B */
> +/* Unallocated EC: 0x3B */
>  #define ESR_ELx_EC_BRK64	(0x3C)
>  /* Unallocated EC: 0x3D - 0x3F */
>  #define ESR_ELx_EC_MAX		(0x3F)
> --
> 2.20.1
> 
