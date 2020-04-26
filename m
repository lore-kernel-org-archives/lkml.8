Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486D3C5519A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F412080C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587925519;
	bh=sli8dVbN68bnOFLVHNcyPfdvedBo83Oh3UfcDoEfYiM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JdOBfSiLZiEZDEXy+v4taJox+4sGE3qH2j31fbUZOBXMMIcHzZx+nqdWC1uIoqWls
	 moMwDsVXSHFdSoGTZyT7onvwDwVxlhQoppiAIXjmqGjDcetfw5kSvQ4vm0cHlo1BWG
	 RvCHBSPJ2wiVnQS7g/JSAMHgiC2lIxhKU+fdC9SU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgDZSZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgDZSZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:25:16 -0400
Subject: Re: [GIT PULL] USB driver fixes for 5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587925516;
        bh=sli8dVbN68bnOFLVHNcyPfdvedBo83Oh3UfcDoEfYiM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XTySH/CqeBkS2MptkQcZ90yApsATGJQzTf0oBVVblHZ0yEJLOe3gKVGz0h3y/AT1/
         ySsEQf+B+4TniOk8+3YSDenjCbJHVTywGuaTpogFQ87qr8b9trFLTnBT6+afH8iCMq
         vWleH5OVXlmym4SNdeizcv7pHxStcItpPw3wUfao=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200426104915.GA2121124@kroah.com>
References: <20200426104915.GA2121124@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200426104915.GA2121124@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.7-rc3
X-PR-Tracked-Commit-Id: 2df7405f79ce1674d73c2786fe1a8727c905d65b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9a61afb69f07b1c5880984d45e5cc232ec1bf6f
Message-Id: <158792551633.16875.15747508956804022723.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Apr 2020 18:25:16 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Apr 2020 12:49:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9a61afb69f07b1c5880984d45e5cc232ec1bf6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
