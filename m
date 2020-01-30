Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA86C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63D620707
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgA3QLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 11:11:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:54442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgA3QLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:11:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 933D3B12D;
        Thu, 30 Jan 2020 16:11:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20200130134217.GA3713@lst.de>
Date:   Thu, 30 Jan 2020 17:11:25 +0100
Subject: Re: [PATCH] dma-contiguous: CMA: give precedence to cmdline
From:   "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     "Christoph Hellwig" <hch@lst.de>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        "Robin Murphy" <robin.murphy@arm.com>, <phil@raspberrypi.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Message-Id: <C099AC3SE9HX.1WYS04PKHJU2Q@linux-9qgx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jan 30, 2020 at 2:42 PM, Christoph Hellwig wrote:
> I've picked this up for Linux 5.6, sorry for the delay.

Thanks!
