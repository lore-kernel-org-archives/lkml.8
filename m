Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E47C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A2C2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597080568;
	bh=ireM7xLApekHQIqjELsBbT2kJiFJu4rDCIUy4AvUv8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oVU4GPvhuLlawCZ21lVMZClL/qdwbGUvln5pS1H1nkBWuqCmGPb39+09bchdVhdnU
	 ZrJUzQ1lHAJ50K7MxtfimTOUtXdEQC83I8fdOWToqe9K+H4MmKi+QjuJDJvKke4meF
	 VDre2k2sEJ4Gr20xczJq6bZhKgQriWMaSV3k9s9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgHJR31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 13:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgHJR30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:29:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E6520838;
        Mon, 10 Aug 2020 17:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597080566;
        bh=ireM7xLApekHQIqjELsBbT2kJiFJu4rDCIUy4AvUv8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1tDgPKQ8a48L6iXeXl2ZQ+CV+co/rlaBWrRB5CIyCCdJto7kYTEFdNv49K9N/9Y5
         rDuTX5EDazzaDQZWo494zj8Tk+rfGv8PkWAewnuz3/NtHw2HCOORQb1SpdmA8Xqp8n
         T9Dz72HdKHAoAsEM2uS2KfzOnSyOz07eKsKy3tjA=
Date:   Mon, 10 Aug 2020 19:29:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+1a54a94bd32716796edd@syzkaller.appspotmail.com,
        syzbot+9d2abfef257f3e2d4713@syzkaller.appspotmail.com,
        Hillf Danton <hdanton@sina.com>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 4.19 06/48] ALSA: seq: oss: Serialize ioctls
Message-ID: <20200810172936.GA82601@kroah.com>
References: <20200810151804.199494191@linuxfoundation.org>
 <20200810151804.528955642@linuxfoundation.org>
 <20200810163717.GA24408@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810163717.GA24408@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 06:37:17PM +0200, Pavel Machek wrote:
> Hi!
> 
> > commit 80982c7e834e5d4e325b6ce33757012ecafdf0bb upstream.
> > 
> > Some ioctls via OSS sequencer API may race and lead to UAF when the
> > port create and delete are performed concurrently, as spotted by a
> > couple of syzkaller cases.  This patch is an attempt to address it by
> > serializing the ioctls with the existing register_mutex.
> > 
> > Basically OSS sequencer API is an obsoleted interface and was designed
> > without much consideration of the concurrency.  There are very few
> > applications with it, and the concurrent performance isn't asked,
> > hence this "big hammer" approach should be good enough.
> 
> That really is a "big hammer". And I believe it is too big.

Please discuss code architecture decisions on the mailing list for the
subsystem/patch.  Doing it in random stable backports does not help out
as all of the developers involved are not copied here.

thanks,

greg k-h
