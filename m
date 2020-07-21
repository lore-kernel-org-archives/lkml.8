Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EAFC433F7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7AB020729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595366322;
	bh=/nYarywAX7UNUN/53DtQdNHz6+8zh3ZomBd6Fnp5oAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FZ38xKkTTTJsndGsO9CZe8ZxRwS4D+p5N+d8Gk5FK1quQ+noWkj0ZqmdRzQEk5miR
	 D3NFyoh8lTpsQ8VXAq4ALbxS1SBsu5ds6xlKXeNEGIvIjrRDed9YoMcv/GfZNg0yu/
	 74/p0A2srscR6N6hdfihDa7sgVUdkstkVRnkoGv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbgGUVSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:18:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731204AbgGUVSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:18:39 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F394220720;
        Tue, 21 Jul 2020 21:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595366319;
        bh=/nYarywAX7UNUN/53DtQdNHz6+8zh3ZomBd6Fnp5oAE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mFEJTUe5xMfOSl50caGaOu0RXYLcHaSqYBOZTcdVVaD7VEAd9UP0LO25pyQJFrQa+
         JD1tz/c15PTmELr/co+JVxtFuKuEZgr2MZON7CuwUdJdg2ln5oKpGhspdciYX1SzeJ
         /zdayu98AGVgNG89ff3ttjLIFL8dk9xIWKuoZBSw=
Date:   Tue, 21 Jul 2020 14:18:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     mcgrof@kernel.org, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] kernel: add a kernel_wait helper
Message-Id: <20200721141838.12d19fce025c842138140324@linux-foundation.org>
In-Reply-To: <20200721130449.5008-1-hch@lst.de>
References: <20200721130449.5008-1-hch@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 15:04:49 +0200 Christoph Hellwig <hch@lst.de> wrote:

> Add a helper that waits for a pid and stores the status in the passed
> in kernel pointer.  Use it to fix the usage of kernel_wait4 in
> call_usermodehelper_exec_sync that only happens to work due to the
> implicit set_fs(KERNEL_DS) for kernel threads.

I guess it's cleaner, although it's a bit sad to be adding code to
address a non-problem.

Did you consider a simpler kernel_wait() which just wraps a
set_fs(KERNEL_DS) around a call to kernel_wait4()?

