Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F87C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D522073B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590131361;
	bh=siqAKAhPdHB34ed/jqAQ/rPGKnZobfHSokZRD7WLHJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ou34+6L4K4wvXfVY1a/qROqUiFzNeTd4M4f14Usaj+pKHr2S06vfsVbsp9Kkpv7nX
	 uerfCPNF80QRCSJ7vx6Z+lj4JZzvdrVc+KxT2+h4Ven+WF1h/hkLvTW47anT3QfWJL
	 lhLgvYEsXzFk5MdVKEMrch6laBAvVX55uGgrTPgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgEVHJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 03:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728606AbgEVHJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:09:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F6E42072C;
        Fri, 22 May 2020 07:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590131359;
        bh=siqAKAhPdHB34ed/jqAQ/rPGKnZobfHSokZRD7WLHJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LDlpaqFUUO1Afmq5GmOSkpssdME79UKsrQCMEfIXF0LeLKRfQeXm5OLtdk+ry5R2z
         7PaMw7sctYkUsC0CqMv1NVGbMbRaQeOK1qGAOvRtdMzNNIZQ/XRwv48q4tuJWkWJ0C
         8MCiAZ4NlYwzJsxUPXxGaktlVkSUkgpqeN97cWnI=
Date:   Fri, 22 May 2020 09:09:17 +0200
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
Subject: Re: [PATCH v2 14/18] nitro_enclaves: Add Kconfig for the Nitro
 Enclaves driver
Message-ID: <20200522070917.GF771317@kroah.com>
References: <20200522062946.28973-1-andraprs@amazon.com>
 <20200522062946.28973-15-andraprs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522062946.28973-15-andraprs@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 09:29:42AM +0300, Andra Paraschiv wrote:
> Signed-off-by: Andra Paraschiv <andraprs@amazon.com>

changelog is needed.
