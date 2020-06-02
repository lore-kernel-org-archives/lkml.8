Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAE4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C1672074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591134664;
	bh=OG5HRGyKV3zEjimah4a0c6gJZ7mOncwrp6JlgmZTJXU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=Hzqhn3LgPnFqo+kEWyAJ4wwPsu3koNNYl8eCzIL2S8H63ppokDtFHsSS8b35HCW+m
	 rmqPuwpZbioyELJBGv7Mg1ZCD3w6KOqBdeNIdy7tKG1Rou27DaORFO2M61AWGPQxk3
	 PKpJQtTqqhrMd2M2vF6Z80sZ1NPsJap7PH4QOZQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgFBVvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgFBVvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:51:03 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AA68206E2;
        Tue,  2 Jun 2020 21:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591134662;
        bh=OG5HRGyKV3zEjimah4a0c6gJZ7mOncwrp6JlgmZTJXU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=mDaApVbv13sLSvUPxDLg7qf18jrKrHmMzTnkjukv5eL/Ku5u0trpjQZW8FgRBbpE7
         uBfuTN+v5BZDdxYgO2H6sOcDNFN74Qf468AoUzW3+fytW0qRePC2BAmt9zbt8oMYoD
         zmqTdVRF9X0/E+gGvz8I7eQlQC2c74oIBtYkeX9k=
Date:   Tue, 2 Jun 2020 14:51:02 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        tamas@tklengyel.com, roman@zededa.com, sstabellini@kernel.org
Subject: Re: [PATCH 00/10] fix swiotlb-xen for RPi4
In-Reply-To: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
Message-ID: <alpine.DEB.2.21.2006021447340.6774@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to ask the maintainers, Juergen, Boris, Konrad, whether you
have any more feedback before I send v2 of the series.

Cheers,

Stefano


On Wed, 20 May 2020, Stefano Stabellini wrote:
> Hi all,
> 
> This series is a collection of fixes to get Linux running on the RPi4 as
> dom0.
> 
> Conceptually there are only two significant changes:
> 
> - make sure not to call virt_to_page on vmalloc virt addresses (patch
>   #1)
> - use phys_to_dma and dma_to_phys to translate phys to/from dma
>   addresses (all other patches)
> 
> In particular in regards to the second part, the RPi4 is the first
> board where Xen can run that has the property that dma addresses are
> different from physical addresses, and swiotlb-xen was written with the
> assumption that phys addr == dma addr.
> 
> This series adds the phys_to_dma and dma_to_phys calls to make it work.
> 
> 
> Cheers,
> 
> Stefano
> 
