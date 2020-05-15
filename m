Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB13C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C8420758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=embedjournal.com header.i=siddharth@embedjournal.com header.b="IbnNVfB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgEONaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:30:02 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21369 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgEONaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:30:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589549390; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=mthFjg5pIaPTOiYVHLAQL4I7wuCFuFTnnt3pCEtfIm0fqNzy3Dc/XYfFzk9hEmnb0sdAU59B/vo/NNIx3BSYMGbN4mQzAVHmgoq/20q0EyGQcolH2uCQHeWjvijZUwBCXmfEYdGaKmz3+JD+9PJTbaAaxo6jjE77xIqznRCorhs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1589549390; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=tFYxYwnB4fcfztIGAf4NeU68AEc97Y1dhPbj/7sR+iY=; 
        b=WukZAVeR+U09SJXD+gL3sZYLrut6ZUFjhfaLoRZejXBs20/uvi0vnim+aHMYdbXJQqUD6kBprFVxHoK5D5ssmUWMzVcfm0hXVtwgkbGZeoC2Usro4DWlJipf2/l+R45ZyRceqckYVcna6TxZcs48IaRApL07+vThHfstccqXi5w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=embedjournal.com;
        spf=pass  smtp.mailfrom=siddharth@embedjournal.com;
        dmarc=pass header.from=<siddharth@embedjournal.com> header.from=<siddharth@embedjournal.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1589549390;
        s=zoho; d=embedjournal.com; i=siddharth@embedjournal.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=tFYxYwnB4fcfztIGAf4NeU68AEc97Y1dhPbj/7sR+iY=;
        b=IbnNVfB4GcQGCho0SlcM7xwg72CV4dvLs77OI8JkcVQYjYcGTZlB1tAoxfsbHxIa
        C0K2YAv0/PSlHeDENrkFL8g8tiSFnbnQNysiu3BXUM171RIieo1bj6ecxw5A9d72Vm8
        sjgo3264lJ5BkgB6APXPFaGCdsMtxD+MDgUCUDrk=
Received: from csiddharth-a01.vmware.com (115.97.41.221 [115.97.41.221]) by mx.zohomail.com
        with SMTPS id 1589549389648876.3212680013104; Fri, 15 May 2020 06:29:49 -0700 (PDT)
Date:   Fri, 15 May 2020 18:59:43 +0530
From:   Siddharth Chandrasekaran <siddharth@embedjournal.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Siddharth Chandrasekaran <csiddharth@vmware.com>,
        srostedt@vmware.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, srivatsab@vmware.com, dchinner@redhat.com,
        darrick.wong@oracle.com
Subject: Re: [PATCH] Backport security fixe to 4.9 and 4.4 stable trees
Message-ID: <20200515132943.GA97579@csiddharth-a01.vmware.com>
References: <cover.1589486724.git.csiddharth@vmware.com>
 <20200515124945.GA93755@csiddharth-a01.vmware.com>
 <20200515125701.GA1934886@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515125701.GA1934886@kroah.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 02:57:01PM +0200, Greg KH wrote:
> On Fri, May 15, 2020 at 06:19:45PM +0530, Siddharth Chandrasekaran wrote:
> > Please ignore this patch set, I accidentally added another patch I was
> > working on. Will send v2 with the right patches.
> 
> What patch set?  I see nothing in this email, so I have no idea what you
> are referring to :(

Apologies! Looks like my email thread was broken. I was referring to
the thread here: https://lkml.org/lkml/2020/5/14/1326 with subject:
  
  "[PATCH] Backport security fixe to 4.9 and 4.4 stable trees"

The corrected version (v2) of this patch should have reached you
(hopefully) with the subject:

  "[PATCH v2] Backport xfs security fix to 4.9 and 4.4 stable trees"

Thanks!

-- Sid.
