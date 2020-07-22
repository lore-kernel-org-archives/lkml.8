Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29C7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F8620709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595426908;
	bh=pjNTVbwdgxFQZDF7qv3mMxYBJxoCH6x2dgwMIwR/L1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HUoV+ERx8jgzxrRVbOr8gTGO9wo9y6lY9m1SqNlc/O0z1DUvOqQPhFsA3R4OvId7J
	 UlHFOk4Zu+pdyJKKFT0YQh6bgFrWTvUuHaL1e3QCb8yrXYHqIBFrXNvIx+LHBZPRcV
	 pGkWtvmYPxeOrorV9YdNiIAkrmnpjobw6F/JHe28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbgGVOI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgGVOI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:08:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0140820709;
        Wed, 22 Jul 2020 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595426906;
        bh=pjNTVbwdgxFQZDF7qv3mMxYBJxoCH6x2dgwMIwR/L1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDbnqU8Id40wCO5ERaVYLy7iOhz2Bffa7XnXK85fH0QU0z2rypZaOd0IvJmqx9IIB
         gS50AUPB++vHmetTqXWYeGuKCGqVfhsYjdqXq8AlC2DkCEuT/HBA3dZZ0RQAQl+S7A
         Ij/BYdo1BfB4dnzGBKicqReYzSUWDovQ93Y9GSKo=
Date:   Wed, 22 Jul 2020 16:08:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     richard.gong@linux.intel.com
Cc:     mchehab+huawei@kernel.org, davem@davemloft.net, robh@kernel.org,
        thor.thayer@linux.intel.com, linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCH] MAINTAINERS: altera: change maintainer for Altera drivers
Message-ID: <20200722140831.GB3755463@kroah.com>
References: <1595426980-32062-1-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595426980-32062-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 09:09:40AM -0500, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Thor is moving to a new position and I will take over the maintainership.
> Add myself as maintainer for 3 Altera drivers below:
> 1. Altera I2C driver
> 2. Altera System Manager driver
> 3. Altera System Resource driver
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>

No ack from Thor?

:(

