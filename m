Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75992C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 06:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFB5215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 06:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583304587;
	bh=VK53u2VxkYUENGgHTPFGpT3Z/fpLjjPmXcKQ3gcUtws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P/VOC9U/QuazQVpieP0G1vkeZJ5xtbIIan3qn69/zbTaQtURLAOy8/+5pqge8wBAA
	 CLZ+50SvAWgyCW9cKCTaJHc95i2pB2m0yG4bVowH0UKJoA1hpU2MLsUHUI6pYf+O8p
	 XnBEy1CO9/smmhUAcBLHQvRRYFNyTFXrFxGXd3L4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgCDGtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 01:49:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725271AbgCDGtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 01:49:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBE3E2146E;
        Wed,  4 Mar 2020 06:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583304585;
        bh=VK53u2VxkYUENGgHTPFGpT3Z/fpLjjPmXcKQ3gcUtws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V+kwW6KvpMnnUi3CM3rOFD+6kThqvnEFjb1p+czVRydBv93/KSXzGe2IYFoW676Fv
         pH2x4cytTMjT9gRUPVeCMQ+P04yFBpP+CZWgtITnnRIko9PnsJXb6Tw5ZE2IyElK15
         1/ziS9d0t+rBiXatxi4PMTLBHTJDG2uW3BZ39/MI=
Date:   Wed, 4 Mar 2020 07:49:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kaaira Gupta <kgupta@es.iitr.ac.in>
Cc:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: qlge: emit debug and dump at same level
Message-ID: <20200304064943.GA1232764@kroah.com>
References: <20200224082448.GA6826@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224082448.GA6826@kaaira-HP-Pavilion-Notebook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:54:48PM +0530, Kaaira Gupta wrote:
> Simplify code in ql_mpi_core_to_log() by calling print_hex_dump()
> instead of existing functions so that the debug and dump are
> emitted at the same KERN_<LEVEL>
> 
> Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
> ---
> 
> changes since v1: make code of ql_mpi_core_to_log() simpler.
> changes since v2: directly call the function instead of defining a
> macro.
> changes since v3: Remove prefix string.
> 
> ----
> ---
>  drivers/staging/qlge/qlge_dbg.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)

Does not apply to my tree :(
