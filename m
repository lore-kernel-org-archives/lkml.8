Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC18C3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5254A24650
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgB0Wft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:35:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:49428 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbgB0Wft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:35:49 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7Rks-0025iX-U0; Thu, 27 Feb 2020 22:35:43 +0000
Date:   Thu, 27 Feb 2020 22:35:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: Minimize uaccess exposure in
 i915_gem_execbuffer2_ioctl()
Message-ID: <20200227223542.GE23230@ZenIV.linux.org.uk>
References: <ed52cfb852d2772bf20f48614d75f1d1b1451995.1582841072.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed52cfb852d2772bf20f48614d75f1d1b1451995.1582841072.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 04:08:26PM -0600, Josh Poimboeuf wrote:
> With CONFIG_CC_OPTIMIZE_FOR_SIZE, objtool reports:
> 
>   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: i915_gem_execbuffer2_ioctl()+0x5b7: call to gen8_canonical_addr() with UACCESS enabled
> 
> This means i915_gem_execbuffer2_ioctl() is calling gen8_canonical_addr()
> -- and indirectly, sign_extend64() -- from the user_access_begin/end
> critical region (i.e, with SMAP disabled).
> 
> While it's probably harmless in this case, in general we like to avoid
> extra function calls in SMAP-disabled regions because it can open up
> inadvertent security holes.
> 
> Fix it by moving the gen8_canonical_addr() conversion to a separate loop
> before user_access_begin() is called.
> 
> Note that gen8_canonical_addr() is now called *before* masking off the
> PIN_OFFSET_MASK bits.  That should be ok because it just does a sign
> extension and ignores the masked lower bits anyway.

How painful would it be to inline the damn thing?
<looks>
static inline u64 gen8_canonical_addr(u64 address)
{
        return sign_extend64(address, GEN8_HIGH_ADDRESS_BIT);
}
static inline __s64 sign_extend64(__u64 value, int index)
{
        __u8 shift = 63 - index;
        return (__s64)(value << shift) >> shift;
}

What the hell?  Josh, what kind of .config do you have that these are
_not_ inlined?  And why not mark gen8_canonical_addr() __always_inline?
