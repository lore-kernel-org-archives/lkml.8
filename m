Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E205C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F21AA20657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826646;
	bh=1kDKxjJeg1LfNC3E7RurznKrh41PNTnWt9redWavVb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DRJhGYBYdlOG6/HwnNVd7JulFKrOaHH+DSceRY/Xlfybzo4fxPg8buB/bCOY427Ez
	 HtsySQcL26Zy6WBIeL00wTBihMNlEpCDHE6xgd5yr154PDZ9v/mUvmM54JLLVh0pkh
	 UsYmknXwvFxjqoPpMnXtWgCHj1X6z/YFJGjimAAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbgERSap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbgERRkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:40:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17E33207C4;
        Mon, 18 May 2020 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823635;
        bh=1kDKxjJeg1LfNC3E7RurznKrh41PNTnWt9redWavVb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QU+qRjjni5MdeE74tabqBsoCwqH2Fj80tO/RcaOWt80PtojXwSqgvwZnSE/ZAvqPH
         2bNCnmjw/N4tfXKyNhzHmaCkqf5FfZvzFBPo4o4Lc91Lr4h8n7/4o81DYMkVjpD4Fu
         bNI1i6FgHk/kzaZgWbsqybjrbAsnzxlG0voJgsU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 62/86] gcc-10: disable restrict warning for now
Date:   Mon, 18 May 2020 19:36:33 +0200
Message-Id: <20200518173502.967629916@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.254571947@linuxfoundation.org>
References: <20200518173450.254571947@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit adc71920969870dfa54e8f40dac8616284832d02 upstream.

gcc-10 now warns about passing aliasing pointers to functions that take
restricted pointers.

That's actually a great warning, and if we ever start using 'restrict'
in the kernel, it might be quite useful.  But right now we don't, and it
turns out that the only thing this warns about is an idiom where we have
declared a few functions to be "printf-like" (which seems to make gcc
pick up the restricted pointer thing), and then we print to the same
buffer that we also use as an input.

And people do that as an odd concatenation pattern, with code like this:

    #define sysfs_show_gen_prop(buffer, fmt, ...) \
        snprintf(buffer, PAGE_SIZE, "%s"fmt, buffer, __VA_ARGS__)

where we have 'buffer' as both the destination of the final result, and
as the initial argument.

Yes, it's a bit questionable.  And outside of the kernel, people do have
standard declarations like

    int snprintf( char *restrict buffer, size_t bufsz,
                  const char *restrict format, ... );

where that output buffer is marked as a restrict pointer that cannot
alias with any other arguments.

But in the context of the kernel, that 'use snprintf() to concatenate to
the end result' does work, and the pattern shows up in multiple places.
And we have not marked our own version of snprintf() as taking restrict
pointers, so the warning is incorrect for now, and gcc picks it up on
its own.

If we do start using 'restrict' in the kernel (and it might be a good
idea if people find places where it matters), we'll need to figure out
how to avoid this issue for snprintf and friends.  But in the meantime,
this warning is not useful.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile |    3 +++
 1 file changed, 3 insertions(+)

--- a/Makefile
+++ b/Makefile
@@ -800,6 +800,9 @@ KBUILD_CFLAGS += $(call cc-disable-warni
 KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
 
+# Another good warning that we'll want to enable eventually
+KBUILD_CFLAGS += $(call cc-disable-warning, restrict)
+
 # Enabled with W=2, disabled by default as noisy
 KBUILD_CFLAGS += $(call cc-disable-warning, maybe-uninitialized)
 


