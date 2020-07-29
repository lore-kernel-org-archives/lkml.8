Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A36C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7212082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596052173;
	bh=QNiv9n7PuSdxKRrJ6qT8RBFA2b9ZvLFMIst1Fg0eciU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CgQEsFwtrv9pgR0Nze3GEjc4dj3vm/Rxina4B2WPqLYB1+GbDtQQKJuj69dJULSq/
	 COy1l0PXgymsSF1TOET5m35gkDLLhYHDQ0tQXUzBjp6wOI3mWNsdhV7vAah+1zcvEs
	 HRfTe9jz8mcysn/nBWbGFmxfEk18vETfzyjCczHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgG2Ttc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:49:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgG2Ttc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:49:32 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10F9420809;
        Wed, 29 Jul 2020 19:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596052171;
        bh=QNiv9n7PuSdxKRrJ6qT8RBFA2b9ZvLFMIst1Fg0eciU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eky31ZE76gTUM2zR/ESSrpF2nD3tgUZJliHVJu1smF8kR6j5Capm3eHz3741QcX++
         dF3b3MfvmfVDVh5Ii0LK1KcfjFNa94ESjWOdJ4DrLwS9O/tGsxa5IuHJEVUXNVm6aD
         857fCb7f1J1wc/8q7ClbScXY20N9+au/q0l7QD2U=
Date:   Wed, 29 Jul 2020 12:49:29 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Lach <iam@lach.pw>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Regression in nvme driver
Message-ID: <20200729194929.GA3499289@dhcp-10-100-145-180.wdl.wdc.com>
References: <8aeb9192-df1b-979d-514d-025366f658e2@lach.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aeb9192-df1b-979d-514d-025366f658e2@lach.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 07:29:08PM +0000, Lach wrote:
> Hello
> 
> I caught a regression in the nvme driver, which shows itself on some
> controllers (In my case, at 126h:2263)

Fix is staged for the next 5.8 pull;

  https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.8&id=5bedd3afee8eb01ccd256f0cd2cc0fa6f841417a

