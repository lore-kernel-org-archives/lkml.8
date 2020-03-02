Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA54C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A2E22B48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583170736;
	bh=E8B3jpue7UHu45EE/SwSFmn12bB9ltxToTRi5uWnKlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Uw4maw6b+voH8VVTqxEzC1lPE4G3IUstExNiXCgrizYS+yEof2J8I3bmGQ4zS0LyH
	 sW9m6R5+4h90A6OhJRO0/Zuyl5O0nVECuQkaPmJLInWr+C/eU2c4Hy1T+SeUV8pCwT
	 Xffk6tqXtKcy8h9yMOJLJUKQb1H7Hm5nyoSjCLzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgCBRiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:38:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:33434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbgCBRiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:38:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54603222C4;
        Mon,  2 Mar 2020 17:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583170734;
        bh=E8B3jpue7UHu45EE/SwSFmn12bB9ltxToTRi5uWnKlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/9ULXogQDQQYKVRJCmyzpVxPcYYcMwtSdtUoZtzhGdb1MZ3n0P8PBz6qjj5ftoU9
         WFSvpR7dQ9klBJs1jPIM2NL57FMAKmtx4SjoeVPMkCnLCWgGp2R+8yUdn8dcHKgg0U
         kJMUopP2Q6riXnHGBbDpAkTypiTLvr7qOm3qbosI=
Date:   Mon, 2 Mar 2020 18:38:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     glider@google.com
Cc:     tkjos@google.com, keescook@chromium.org, arve@android.com,
        mingo@redhat.com, dvyukov@google.com, jannh@google.com,
        devel@driverdev.osuosl.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] binder: do not initialize locals passed to
 copy_from_user()
Message-ID: <20200302173852.GB109022@kroah.com>
References: <20200302130430.201037-1-glider@google.com>
 <20200302130430.201037-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302130430.201037-2-glider@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 02:04:29PM +0100, glider@google.com wrote:
> Certain copy_from_user() invocations in binder.c are known to
> unconditionally initialize locals before their first use, like e.g. in
> the following case:
> 
> 	struct binder_transaction_data tr;
> 	if (copy_from_user(&tr, ptr, sizeof(tr)))
> 		return -EFAULT;
> 
> In such cases enabling CONFIG_INIT_STACK_ALL leads to insertion of
> redundant locals initialization that the compiler fails to remove.
> To work around this problem till Clang can deal with it, we apply
> __no_initialize to local Binder structures.

I would like to see actual benchmark numbers showing this is
needed/useful otherwise it's going to just be random people adding this
marking to random places with no real reason.

thanks,

greg k-h
