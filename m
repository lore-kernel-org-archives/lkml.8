Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C13DC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70312146E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583266838;
	bh=e6wE0Cu8UchbQPnOplEUCLjQTVHqtR0gUxUBtrSXDpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dRalXRI1UGm4BZOf7Y/X2v9KgR7fFm1hNGZjqXt3eZG9MZlQwIiPupqP4AD7MqJJA
	 xZBpMezKhgW24BO8AyXTE/CrpioTYtOrEKyVTJLqtc3n8rBICuwbiziFEJqJpLf9Hg
	 0qCTHKj2yiK43KxGweFMCPhsMbhAZ1cIb639yO30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbgCCUUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:20:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbgCCUUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:20:36 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D387620CC7;
        Tue,  3 Mar 2020 20:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583266835;
        bh=e6wE0Cu8UchbQPnOplEUCLjQTVHqtR0gUxUBtrSXDpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MoJhOzbFot297vSuM9Zh2gJ00wpQAbMr0JD/luMKW3YuNL74/ENj4lKXr7pA51hEm
         f1rWb0ObpNnkv6zaVXL+DcbDooHuR9D+KuXd0PvIl32BKIUJeZPEM6k8rMOphVoqlz
         rLDMWU6ARo1NjEyGMtl1/ccOJF8t/nISnjgBh6rw=
Date:   Wed, 4 Mar 2020 05:20:28 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Josh Triplett <josh@joshtriplett.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Check for readiness more quickly, to speed up boot
 time
Message-ID: <20200303202028.GA12836@redsun51.ssa.fujisawa.hgst.com>
References: <20200229025228.GA203607@localhost>
 <f97877d5-2cb5-426f-3117-0b439b00b88c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f97877d5-2cb5-426f-3117-0b439b00b88c@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, queued up for 5.7.
