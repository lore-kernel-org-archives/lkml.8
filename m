Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F4BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716282071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594871440;
	bh=0bDASk0781jq/cji5sUbOq/NcKI50JUK8aOvo76NM1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AyigAqbpncrcs9ShJLrfSpD0ZX+D8PUuLVXn6MzWJGGoBNJT0PxKeOQs8KktFzTr0
	 6qC8OeuO6tEbPATz+1TTzGm+zC2lMEOf/q68c5H3fzEstQ7OjdnotoapaWA8nqgFYm
	 OPl0qbvx4cfxzsHqDYzJpyUsJ/oDuFSH6Q4rw1Mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgGPDui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 23:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgGPDui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:50:38 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E64692071B;
        Thu, 16 Jul 2020 03:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594871438;
        bh=0bDASk0781jq/cji5sUbOq/NcKI50JUK8aOvo76NM1A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oogYGLGg0wKaXDpiEPMy1C41qPf1XwXf75ZyM6sPozBFOEfZLOmH1H3ACsugiBw4D
         xQmkE5O0d+/WUca5QU/EybTHyZ2vzR8gomP1mVuR2rWfVW4rg1PEi8y49sXdFPqxO9
         lNFpbIavUtYET351S/KiGjPIo8O5wj5qv5X6mchI=
Date:   Wed, 15 Jul 2020 20:50:36 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 3/9 v2 net-next] net: wimax: fix duplicate words in
 comments
Message-ID: <20200715205036.551e0486@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <50300854-3b28-3bab-dcf8-4dd49efebf86@infradead.org>
References: <20200715164246.9054-1-rdunlap@infradead.org>
        <20200715164246.9054-3-rdunlap@infradead.org>
        <20200715203453.4781ddee@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <50300854-3b28-3bab-dcf8-4dd49efebf86@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 20:35:34 -0700 Randy Dunlap wrote:
> On 7/15/20 8:34 PM, Jakub Kicinski wrote:
> > On Wed, 15 Jul 2020 09:42:40 -0700 Randy Dunlap wrote:  
> >>  /*
> >> - * CPP sintatic sugar to generate A_B like symbol names when one of
> >> - * the arguments is a a preprocessor #define.
> >> + * CPP syntatic sugar to generate A_B like symbol names when one of  
> > 
> > synta*c*tic
> > 
> > Let me fix that up before applying.  
> 
> eww. Thanks.

Applied, pushed. Thanks!
