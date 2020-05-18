Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7103C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E6A520715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825378;
	bh=8QXeBMlGAUFl3D0rEqDXnBSX/SsHzNShv8lCkysrbfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g1t+gEBeJw7XDIH93zW4aTW6KoyaQAIZ/n9CJMg4DJPTkNso6j6E/f93heDARwXDm
	 CbaEKsShzKrax5PmCvyuvEDoy5nRy5jPZdkAGgHbWNhpZ1kz/Dwgq9XrUPyzV8PRjc
	 q8V3W1iODgz2J1b+BbfYhqilMERdZJIeVnotaoL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgERSJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731506AbgERSGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:06:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2293320715;
        Mon, 18 May 2020 18:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825192;
        bh=8QXeBMlGAUFl3D0rEqDXnBSX/SsHzNShv8lCkysrbfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vo/XXnQDvVoj8CjDPxEMJl1i1um86GKnpd0cNMTBwxaqhoiXHgN+hv/M6Rm6YxLPp
         ch6HHS2r3/Aaptyd9cDLQEhjF1raouQsipVG/LjNcCx7J1JK1/l0Vf9GxtdjXku9xS
         KrOWx2oRRHX47kd9eztc3+v0LpFqjCZ9UdTmkFZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.6 128/194] gcc-10: disable array-bounds warning for now
Date:   Mon, 18 May 2020 19:36:58 +0200
Message-Id: <20200518173542.156930968@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 44720996e2d79e47d508b0abe99b931a726a3197 upstream.

This is another fine warning, related to the 'zero-length-bounds' one,
but hitting the same historical code in the kernel.

Because C didn't historically support flexible array members, we have
code that instead uses a one-sized array, the same way we have cases of
zero-sized arrays.

The one-sized arrays come from either not wanting to use the gcc
zero-sized array extension, or from a slight convenience-feature, where
particularly for strings, the size of the structure now includes the
allocation for the final NUL character.

So with a "char name[1];" at the end of a structure, you can do things
like

       v = my_malloc(sizeof(struct vendor) + strlen(name));

and avoid the "+1" for the terminator.

Yes, the modern way to do that is with a flexible array, and using
'offsetof()' instead of 'sizeof()', and adding the "+1" by hand.  That
also technically gets the size "more correct" in that it avoids any
alignment (and thus padding) issues, but this is another long-term
cleanup thing that will not happen for 5.7.

So disable the warning for now, even though it's potentially quite
useful.  Having a slew of warnings that then hide more urgent new issues
is not an improvement.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/Makefile
+++ b/Makefile
@@ -859,6 +859,7 @@ KBUILD_CFLAGS += $(call cc-disable-warni
 
 # We'll want to enable this eventually, but it's not going away for 5.7 at least
 KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
+KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
 
 # Enabled with W=2, disabled by default as noisy
 KBUILD_CFLAGS += $(call cc-disable-warning, maybe-uninitialized)


