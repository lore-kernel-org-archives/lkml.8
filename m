Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53B0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7A920707
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgE2OSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgE2OSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:18:05 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60881C03E969;
        Fri, 29 May 2020 07:18:05 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jefpb-00Ha3Z-6v; Fri, 29 May 2020 14:17:55 +0000
Date:   Fri, 29 May 2020 15:17:55 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCHES] uaccess i915
Message-ID: <20200529141755.GD23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529004050.GY23230@ZenIV.linux.org.uk>
 <87ftbj1gah.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftbj1gah.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 08:06:14AM +0300, Jani Nikula wrote:
> On Fri, 29 May 2020, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > 	Low-hanging fruit in i915 uaccess-related stuff.
> > There's some subtler stuff remaining after that; these
> > are the simple ones.
> 
> Please Cc: intel-gfx@lists.freedesktop.org for i915 changes.

Will do.  Do you want me to resend those (or post them there separately, or...)?

> Also added Chris who I believe will be able to best review the changes.

FWIW, the branch is in

git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #uaccess.i915
