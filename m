Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E624C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5A22168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581634704;
	bh=CNRzbDb4Aji2mJUUY0DDsLokrLB+Xakc1hZkxANG9Ow=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=mVF4E+IHpXW0LM6kLVfA2oVdzxV43ClJTNcm7t6MS4n5I1sUzy2w9vi7jIq1fucUo
	 kJv84kW57agyTw8WupLfOBiyNanUQegc6RnAQI643JVLzJmo3oSLccrcCxXnEZUScN
	 ZybrzUfcOhGIA8Y1Idh7CsYgr1C5bO+NNZrnOrL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgBMW6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:58:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:40242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbgBMW6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:58:23 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7C0820873;
        Thu, 13 Feb 2020 22:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581634702;
        bh=CNRzbDb4Aji2mJUUY0DDsLokrLB+Xakc1hZkxANG9Ow=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=YyI63IZS508ElwOzd4tPZixLh/yiABHrsRp55eQoMS7gOMUQa7Ss2Zc6SY0LwOt7R
         Ozea8uD9gOeULHNn8N2Dd80ITr65fIip2qXa1p+oIRUK/lBZXmr4hrhkO1c0LLyu4R
         ck0GDSBDMvaYeFBPw9dQp71bECSOFzELYFy1gcbY=
Date:   Thu, 13 Feb 2020 14:58:22 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dsterba@suse.cz, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.14 129/173] btrfs: flush write bio if we loop in
 extent_write_cache_pages
Message-ID: <20200213225822.GA3878275@kroah.com>
References: <20200213151931.677980430@linuxfoundation.org>
 <20200213152004.740147248@linuxfoundation.org>
 <20200213210216.GT2902@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213210216.GT2902@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 10:02:16PM +0100, David Sterba wrote:
> On Thu, Feb 13, 2020 at 07:20:32AM -0800, Greg Kroah-Hartman wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> > 
> > [ Upstream commit 96bf313ecb33567af4cb53928b0c951254a02759 ]
> 
> Same comment as for the 4.9 backport, correct commit id is
> 42ffb0bf584ae5b6b38f7.

Now fixed up for all 3 places (4.14, 4.9, and 4.4)

thanks,

greg k-h
