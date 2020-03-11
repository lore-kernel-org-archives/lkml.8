Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB9BC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629E9208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583928354;
	bh=BPHaWjg6587a5T0Mvx0zEB0ljqLxgY6uyCgYbogdwXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xraEpncnfQAkMhCp7s5k4gFnn91J4wP/Y0NDiA8CtMqY2c4SzR7a/c0oNqjozM/He
	 +rz22Pccr9IshGauM+ySBUwN/K8BC7eK+L0jhbCjQTeA66ulFrTf+ZbCvnYITmgCPY
	 4ziJjWSzpxcYygSv5U2OPF+PYqzL/seFLC/MHxOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgCKMFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728996AbgCKMFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:05:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 785F421655;
        Wed, 11 Mar 2020 12:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583928352;
        bh=BPHaWjg6587a5T0Mvx0zEB0ljqLxgY6uyCgYbogdwXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dOzItMQyR9PScuscKHGb1Bmz4d3c4WWbrd81LPFhy6i32RGNUfU2APundDziWZIl/
         Zg8AVeqFxDSuCQC0eF6PFckXvP6MbLfwl/6aBo8zO2cE3F8R42XmG3PPD/e3zYg+jK
         GN2xvKoPwggOfV+QTe8BuIcbkktHzdPPXsIysGgo=
Date:   Wed, 11 Mar 2020 13:05:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
Cc:     devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        linux-kernel@vger.kernel.org,
        Mori.Takahiro@ab.mitsubishielectric.co.jp,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] staging: exfat: conform 'pbr_sector_t' definition to
 exFAT specification
Message-ID: <20200311120547.GA3757838@kroah.com>
References: <20200311105245.125564-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311105245.125564-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 07:52:41PM +0900, Tetsuhiro Kohada wrote:
> Redefine 'pbr_sector_t' as 'boot_sector_t' to comply with exFAT specification.
>  - Redefine 'pbr_sector_t' as 'boot_sector_t'.
>  - Rename variable names including 'pbr'.
>  - Replace GET**()/SET**() macro with cpu_to_le**()/le**_ to_cpu().
>  - Remove fs_info_t.PBR_sector (always 0).
>  - Remove unused definitions.
> 
> Reviewed-by: Takahiro Mori <Mori.Takahiro@ab.MitsubishiElectric.co.jp>
> Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
> ---
>  drivers/staging/exfat/exfat.h       | 139 +++++++---------------------
>  drivers/staging/exfat/exfat_core.c  |  62 ++++++-------
>  drivers/staging/exfat/exfat_super.c |  14 ++-
>  3 files changed, 65 insertions(+), 150 deletions(-)

The drivers/staging/exfat/ tree is now gone from my staging-next branch
as there is a "real" version of exfat now in linux-next from the vfs
tree.

I suggest you start working on the fs/extfat/ code.

thanks,


greg k-h
