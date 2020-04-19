Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1CFC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2818421974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587315279;
	bh=WZSePG8U/5BIrwAdO2ElbI/x0bCWWO/i26WU+s6NSHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tSpjeN4eWgjQi9zjuKBj66xpoFiAKnzFDTiM7Nhk4Q6vC3U/019IHRxdzYa8cZqXu
	 bgAMTXFbndUxEnFWRW5gdkPww5tmxfCTwhSbe7tVfPovw0SPS85lLyDUSAkSfKf7UU
	 74/BSqQyeO/4b1Ov7+jrgMJK0cJH2hqdBlk82UXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDSQyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 12:54:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDSQyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 12:54:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D1C0214D8;
        Sun, 19 Apr 2020 16:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587315277;
        bh=WZSePG8U/5BIrwAdO2ElbI/x0bCWWO/i26WU+s6NSHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cMip79hJDppcJ+upOiP/hYTwdoQ7QfBQjuav6/z2fP298GVTqDdBTKs8r1O2Renj1
         m0n9M3aMLcqpiQjbJmVjvTXF9NbkITAe5pMVAbSUGaFIGTxmyGsHlI1ISLCCOjGx50
         PV9u67rK4bhgV8bDcJ07N3/8PteYBw9nzCXh/SBQ=
Date:   Sun, 19 Apr 2020 18:54:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Evalds Iodzevics <evalds.iodzevics@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] x86/CPU: Add native CPUID variants returning a
 single datum
Message-ID: <20200419165434.GA3697654@kroah.com>
References: <20200419162943.3704-1-evalds.iodzevics@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419162943.3704-1-evalds.iodzevics@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 07:29:42PM +0300, Evalds Iodzevics wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> ... similarly to the cpuid_<reg>() variants.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: http://lkml.kernel.org/r/20170109114147.5082-2-bp@alien8.de
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/processor.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Why are you resending patches from someone else?
