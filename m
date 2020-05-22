Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B34C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3907A2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590131339;
	bh=bLTj+TE+SFykZ74lS1PNXvizkkVR2Ygc9vlMQGEgTo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xTRyHHiBkfbS3ZTZV03SjOD12M3pht/56yq4I5aPjOoWf9PzobTX6qllzdROc25PW
	 sUuDV6Fnf5JCuZmFBlzo9tRv9YxTr7oHwJlvCpigUw5nCc+kKpchpAJHEHEuP/4Qgp
	 UAzoIkqFNRoq2lKKmDi+IquhC72CIWb1ET4gCrDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgEVHI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 03:08:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728434AbgEVHIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:08:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1C7B2072C;
        Fri, 22 May 2020 07:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590131335;
        bh=bLTj+TE+SFykZ74lS1PNXvizkkVR2Ygc9vlMQGEgTo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mcL+gNNarKMT58WU27ixmdyuXSVCovRhza7LsxsNlv3AroxG/bCHuwiO5ZPkEcJyW
         2dUyUwDnz1sTse3Jj5HcFo5d/h8kNCp6BKcLd5+QjQNB8yCtkFI4DiIdy1Gr/ic9Y3
         mborzCl9tNkwVjvGw7p+oyT+lSXz03xs+5IbClUI=
Date:   Fri, 22 May 2020 09:08:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andra Paraschiv <andraprs@amazon.com>
Cc:     linux-kernel@vger.kernel.org,
        Anthony Liguori <aliguori@amazon.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Alexander Graf <graf@amazon.de>,
        Martin Pohlack <mpohlack@amazon.de>,
        Matt Wilson <msw@amazon.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Balbir Singh <sblbir@amazon.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stewart Smith <trawets@amazon.com>,
        Uwe Dannowski <uwed@amazon.de>, kvm@vger.kernel.org,
        ne-devel-upstream@amazon.com
Subject: Re: [PATCH v2 16/18] nitro_enclaves: Add sample for ioctl interface
 usage
Message-ID: <20200522070853.GE771317@kroah.com>
References: <20200522062946.28973-1-andraprs@amazon.com>
 <20200522062946.28973-17-andraprs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522062946.28973-17-andraprs@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 09:29:44AM +0300, Andra Paraschiv wrote:
> Signed-off-by: Alexandru Vasile <lexnv@amazon.com>
> Signed-off-by: Andra Paraschiv <andraprs@amazon.com>

I know I don't take commits with no changelog text :(

