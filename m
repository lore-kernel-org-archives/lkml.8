Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35436C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2882177B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596556396;
	bh=tDpIkWuSdpodqGPQDWIFOE7o7/wTSGZ0oJmR6Sz9Ia0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=oTJ83qjVQKCHXUjxEAl2W/yrCnnTMpJu5OpPSt1MO2FL1Lbb3lpGxs+aW9xCGGlkG
	 0PEmMQ37XWh+viugPMyuabjo+j7wkY54h0a/2by/XSGE5NI7GhKfoeba/mVvh/Bwa4
	 8RBwXFKzbt8zJr5iA9IvHKIb8ZQ05QhLwilbmWFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgHDPw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728631AbgHDPwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:52:55 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D16492177B;
        Tue,  4 Aug 2020 15:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596556375;
        bh=tDpIkWuSdpodqGPQDWIFOE7o7/wTSGZ0oJmR6Sz9Ia0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=OI3MDkvGqDpsgTM5w7jN/tiL+atoldmOEjEfCWS7pHTnC2Uy1MY0J813NPeuSI6rz
         xhvQyEAAalWPyUsZx6E0SeXw3RI4fmv3s0L+a9GjazjECiPEKRU1BLI8ztJSblepe0
         uakSz5POYLuNJqFDfji1qYcISOWDiO6oPuAcHGYI=
Date:   Tue, 4 Aug 2020 08:52:54 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     =?UTF-8?Q?J=C3=BCrgen_Gro=C3=9F?= <jgross@suse.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        tamas@tklengyel.com, roman@zededa.com, hch@infradead.org
Subject: Re: [PATCH v3 00/11] fix swiotlb-xen for RPi4
In-Reply-To: <8413f3e2-0bbf-efa3-1a8a-2ae05b1d07c8@suse.com>
Message-ID: <alpine.DEB.2.21.2008040852460.5748@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2007101521290.4124@sstabellini-ThinkPad-T480s> <8413f3e2-0bbf-efa3-1a8a-2ae05b1d07c8@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1376642103-1596556375=:5748"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1376642103-1596556375=:5748
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 4 Aug 2020, Jürgen Groß wrote:
> On 11.07.20 00:34, Stefano Stabellini wrote:
> > Hi all,
> > 
> > This series is a collection of fixes to get Linux running on the RPi4 as
> > dom0. Conceptually there are only two significant changes:
> > 
> > - make sure not to call virt_to_page on vmalloc virt addresses (patch
> >    #1)
> > - use phys_to_dma and dma_to_phys to translate phys to/from dma
> >    addresses (all other patches)
> > 
> > 
> > I addressed all comments by Christoph to v2 of the series except from
> > the one about merging the precursor "add struct device *" patches. I can
> > always merge them together at any time as needed.
> > 
> > 
> > Boris gave his Reviewed-by to the whole series v2. I added his
> > Reviewed-by to all patches, including the ones with small cosmetic
> > fixes, except for patch #8 #9 #10 because they are either new or changed
> > significantly in this version of the series.
> > 
> > I retained Roman and Corey's Tested-by.
> 
> Series pushed to: xen/tip.git for-linus-5.9

Fantastic, thank you!
--8323329-1376642103-1596556375=:5748--
