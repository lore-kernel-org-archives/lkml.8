Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A550C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A352075B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHRHLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:11:45 -0400
Received: from verein.lst.de ([213.95.11.211]:60474 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgHRHLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:11:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 807DD68B02; Tue, 18 Aug 2020 09:11:41 +0200 (CEST)
Date:   Tue, 18 Aug 2020 09:11:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     kbusch@kernel.org, hch@lst.de, Damien.LeMoal@wdc.com,
        axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, johannes.thumshirn@wdc.com
Subject: Re: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
Message-ID: <20200818071141.GA2544@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com> <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com> <20200818052936.10995-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818052936.10995-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 10:59:35AM +0530, Kanchan Joshi wrote:
> Set elevator feature ELEVATOR_F_ZBD_SEQ_WRITE required for ZNS.

No, it is not.
