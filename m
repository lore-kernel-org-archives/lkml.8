Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B736C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA9A3207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592236044;
	bh=TvoTA2FuH6mLitI1jM5lsj1kplEHSv1NCisVfYWGIJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uOwPiqLo+nIr3HMMmIQdsMgiatTr+22mpcKFyFWBWerDkzLo/ejtWXFvf8QKZ2dgO
	 jKFNatcg02OqP93CaRTve4MEF9zEhT1f5vWu/E5iPJW1HnDprZggSeDsfQCyzm0+Y0
	 RH++HMyFej/Y23xSAjo/Dp3+ob4qods4oOIpgIw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbgFOPrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:47:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbgFOPrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:47:22 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99BE42078E;
        Mon, 15 Jun 2020 15:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592236041;
        bh=TvoTA2FuH6mLitI1jM5lsj1kplEHSv1NCisVfYWGIJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6yWGGNpB/VnrsNNFwvyCenz5ShS7q1GVlq2x9avR8n2fOp7C7XT9pDTD1pPXQHSQ
         znH/SSlpzF08xtLhUa8D8H3S4uxk4h116vgt3tjotR2fhxKfNUXzHLgjK4ZnvmVjm/
         8+T29Hcb2dR/5PeDFxD0MRz5/LuNA1kLgH8R8BzY=
Date:   Mon, 15 Jun 2020 08:47:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Satya Tangirala <satyat@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix use-after-free when accessing
 bio->bi_crypt_context
Message-ID: <20200615154720.GA902@sol.localdomain>
References: <1592193588-21701-1-git-send-email-stummala@codeaurora.org>
 <20200615050019.GA3100@sol.localdomain>
 <20200615061633.GA23467@google.com>
 <20200615095316.GB2916@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615095316.GB2916@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 03:23:16PM +0530, Sahitya Tummala wrote:
> > 
> > Should I fold this change into the original patch? Or keep it as a
> > separate patch when I send out the fscrypt/f2fs inline encryption
> > patches?
> 
> It may be good to keep it seperate as we already have the base FBE patches in
> several downstream kernels, so this fix can be applied easily. But I will
> leave it up to you to take a call on this.
> 

We should fold it in because the patch this fixes isn't applied upstream yet.

We'll need to submit this as a separate fix to the Android common kernels
because they already have a previous version of the inline encryption patchset.
(I assume that's where you have the code from.)  But that doesn't affect what we
do upstream.

- Eric
