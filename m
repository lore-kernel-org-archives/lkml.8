Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA416C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923D02063A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="A+PJJH1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgFPBgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 21:36:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22558 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgFPBgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 21:36:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592271402; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=xMh92ChtsXia9yszVbB8XBW80SKYdVIfI1TvNqZjeKY=; b=A+PJJH1Xt1qKJdsdjwC/2GiQVbYTTb6JyPvP1WUxrbzo9IHtNKwUkUmxRUycqoD26ln1bRjI
 yUH0UQqYXhPA2Y9ZWYl8Lc8mU/okoI8xJNYbrPcB4JdS1iqei+KljWZgldEbdR+Yg1okie1n
 nMhjxQB6KiU6LjUFnCbaRC+QRkg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ee8221d8fe116ddd9ecd3e4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 01:36:29
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 694AEC43391; Tue, 16 Jun 2020 01:36:28 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B682C433C8;
        Tue, 16 Jun 2020 01:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B682C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Tue, 16 Jun 2020 07:06:22 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Satya Tangirala <satyat@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stummala@codeaurora.org
Subject: Re: [PATCH] f2fs: fix use-after-free when accessing
 bio->bi_crypt_context
Message-ID: <20200616013622.GC2916@codeaurora.org>
References: <1592193588-21701-1-git-send-email-stummala@codeaurora.org>
 <20200615050019.GA3100@sol.localdomain>
 <20200615061633.GA23467@google.com>
 <20200615095316.GB2916@codeaurora.org>
 <20200615154720.GA902@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615154720.GA902@sol.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 08:47:20AM -0700, Eric Biggers wrote:
> On Mon, Jun 15, 2020 at 03:23:16PM +0530, Sahitya Tummala wrote:
> > > 
> > > Should I fold this change into the original patch? Or keep it as a
> > > separate patch when I send out the fscrypt/f2fs inline encryption
> > > patches?
> > 
> > It may be good to keep it seperate as we already have the base FBE patches in
> > several downstream kernels, so this fix can be applied easily. But I will
> > leave it up to you to take a call on this.
> > 
> 
> We should fold it in because the patch this fixes isn't applied upstream yet.
> 
> We'll need to submit this as a separate fix to the Android common kernels
> because they already have a previous version of the inline encryption patchset.
> (I assume that's where you have the code from.)  But that doesn't affect what we
> do upstream.

Sure, no concerns from my side. It can be merged into the original series.

Thanks,

> 
> - Eric

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
