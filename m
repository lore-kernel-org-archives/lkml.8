Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7954C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C8422B40
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596614154;
	bh=7UQJZZcTdJI13BKFL++btdNL+mH6JhjxG2J2M0fuJS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D2Ky/7PNZmlDHZakcbGyYRF03j6eVpc+VA5lK5G2RMb2JZdstRI6zyvAOq7lQcEaH
	 K0Jg6lNW0UcEQSBotAgvC9Zgn3vcrX5vsZjK6vhMUK3XFL9+bKQ4j/ctJftpTRUgGi
	 QZV1A5yHfZRWKpO99nSZYe85YhRC0CUwR7/n///M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHEHzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgHEHzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:55:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E571021744;
        Wed,  5 Aug 2020 07:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596614147;
        bh=7UQJZZcTdJI13BKFL++btdNL+mH6JhjxG2J2M0fuJS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KtTzy4t4SFk/N1hNFRYPbB+PGd85GSy2svPpor664q2lPfYpQYOLam8LE2sQjAhSI
         L/ClP2w6M7u4w8s5Qemo57xNdBpiyvfE/nFecweHsem60fE6wDRkooZMVL2pX52Pme
         bgloTAQwSdzlNsCiuTSCSNdAGheoIT5BF9qXa89c=
Date:   Wed, 5 Aug 2020 09:56:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongdong Yang <contribute.kernel@gmail.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        devel@driverdev.osuosl.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangdongdong@xiaomi.com,
        yanziily@xiaomi.com, rocking@linux.alibaba.com
Subject: Re: [PATCH v5] sched: Provide USF for the portable equipment.
Message-ID: <20200805075604.GA635696@kroah.com>
References: <cover.1596612536.git.yangdongdong@xiaomi.com>
 <3bbd9a487176a05588e33ff660d4e58efa1fdb10.1596612536.git.yangdongdong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bbd9a487176a05588e33ff660d4e58efa1fdb10.1596612536.git.yangdongdong@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 03:36:21PM +0800, Dongdong Yang wrote:
> --- /dev/null
> +++ b/kernel/sched/usf.c
> @@ -0,0 +1,314 @@
> +/*
> + * Copyright (C) 2020 XiaoMi Inc.
> + * Author: Yang Dongdong <yangdongdong@xiaomi.com>
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + * See http://www.gnu.org/licenses/gpl-2.0.html for more details.
> + */

You did not run checkpatch.pl on this patch, nor listen to my request to
drop the boilerplate license text and just use a SPDX line :(

greg k-h
