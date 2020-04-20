Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE47C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F602145D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587376672;
	bh=I0h5ML7YIEwjeXZYjjpwj95iaSeLcBsR0LC61CGo8XY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ILL15sMsUXT44pDnpM3BX2k37/098cAqeIEgBPgiyjG24jJc6XAWEXLMDAmljt8V9
	 sLlolhED8CBKFp+wmpiVxE6CEEVGQYmhTHf36wVK+kEQuQWBpEcB3eaZAch50sty+X
	 D/h6Yvv4yt8m8HriFXwhHZXVzNNWXAmpdDJj4Tb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgDTJ5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 05:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTJ5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 05:57:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70CB120CC7;
        Mon, 20 Apr 2020 09:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587376669;
        bh=I0h5ML7YIEwjeXZYjjpwj95iaSeLcBsR0LC61CGo8XY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vu0MZxTXOTir/D2Dtst444gK/Cj1Y8cGedereW4ZkKwl8yd5Ic2xgaw/cVI1YCu5G
         FU4Pr99prB5uXPEZSuJ0kJll/tQpHOHRkcaU4713fUhQZcs9QJB24+euu026ubIgQr
         xS+M+In6BOjQbRHjk8xkmFRLLiNMhe8nJVntBieo=
Date:   Mon, 20 Apr 2020 11:57:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Evalds Iodzevics <evalds.iodzevics@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] x86/microcode/intel: replace sync_core() with
 native_cpuid_reg(eax)
Message-ID: <20200420095747.GA3737151@kroah.com>
References: <20200420120037.1537-1-evalds.iodzevics@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420120037.1537-1-evalds.iodzevics@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 03:00:37PM +0300, Evalds Iodzevics wrote:
> sync_core() always jums past cpuid instruction on 32 bit machines
> because data structure boot_cpu_data are not populated so early in boot.
> 
> It depends on commit 5dedade6dfa243c130b85d1e4daba6f027805033 for
> native_cpuid_reg(eax) definitions
> 
> This patch is for 4.4 but also should apply to 4.9
> 
> Signed-off-by: Evalds Iodzevics <evalds.iodzevics@gmail.com>
> ---
>  arch/x86/include/asm/microcode_intel.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
