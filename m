Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEE7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DAD6207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="qKvFKOr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbgEZH7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:59:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35505 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgEZH7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:59:14 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 49WRDv3x0gz9sSs; Tue, 26 May 2020 17:59:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1590479951; bh=y9Dh8QD2sldowdau5z37SlPA9CE0uXq3c+Lcs+yQous=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKvFKOr4bi6PBmH5CPpjSHqLaLsfjMJlHFldlHQBVeS+7XcOjYOfYTH4di0pdc7Hi
         FVViWy67aZlWPBRAQGPlYeSxhJYnxAMg6tUrxM7ujmP2xoQhgf6Mx0UN0vM1hJeY7t
         JvM8uJJGbFh2/CAEX/ygfnuoL2sIBrm+X2QAxmHRutXk9tH3mjlx6udhTPxaPT9II6
         VPTxAVMeS3Kg+Ml9CWLC5I2cKQR8ZvZT9IzeTqwbN1e+m7RnnK2SqRIwmruJYzVQ3a
         qOnWFZnPedUSiv7IL6wWd3+Wx1GF6WRLG0IndceBboMAoFmwEvQbSFUs7V1n+5okLr
         6ncWU8VKADeHA==
Date:   Tue, 26 May 2020 17:59:04 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, pbonzini@redhat.com, sfr@canb.auug.org.au,
        rppt@linux.ibm.com, aneesh.kumar@linux.ibm.com, msuchanek@suse.de,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kvm@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [linux-next PATCH] mm/gup.c: Convert to use
 get_user_{page|pages}_fast_only()
Message-ID: <20200526075904.GE282305@thinks.paulus.ozlabs.org>
References: <1590396812-31277-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590396812-31277-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 02:23:32PM +0530, Souptick Joarder wrote:
> API __get_user_pages_fast() renamed to get_user_pages_fast_only()
> to align with pin_user_pages_fast_only().
> 
> As part of this we will get rid of write parameter.
> Instead caller will pass FOLL_WRITE to get_user_pages_fast_only().
> This will not change any existing functionality of the API.
> 
> All the callers are changed to pass FOLL_WRITE.
> 
> Also introduce get_user_page_fast_only(), and use it in a few
> places that hard-code nr_pages to 1.
> 
> Updated the documentation of the API.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

The arch/powerpc/kvm bits look reasonable.

Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
