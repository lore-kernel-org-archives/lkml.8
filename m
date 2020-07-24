Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDD8C43465
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1452A20737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgGXSYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 14:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgGXSYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:24:51 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FC9C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 11:24:51 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jz2NF-001mjV-8S; Fri, 24 Jul 2020 18:24:49 +0000
Date:   Fri, 24 Jul 2020 19:24:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] xtensa csum regression fix
Message-ID: <20200724182449.GO2786714@ZenIV.linux.org.uk>
References: <20200724181644.GN2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724181644.GN2786714@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 07:16:44PM +0100, Al Viro wrote:

Argh...  Sorry, hit send too early; the missing summary would be

	Max Filippov has caught a breakage introduced in xtensa this
cycle by the csum_and_copy_..._user() series.  Cut'n'paste from the
wrong source - the check that belongs in csum_and_copy_to_user() has
ended up both there and in csum_and_copy_from_user().  Please, apply


> The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:
> 
>   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
> 
> for you to fetch changes up to 5fff09bc141570cd15c118b097b17dec832b517f:
> 
>   xtensa: fix access check in csum_and_copy_from_user (2020-07-21 19:08:25 -0400)
> 
> ----------------------------------------------------------------
> Max Filippov (1):
>       xtensa: fix access check in csum_and_copy_from_user
> 
>  arch/xtensa/include/asm/checksum.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
