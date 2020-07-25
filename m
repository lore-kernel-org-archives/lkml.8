Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2101AC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 00:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E32B320774
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 00:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgGYAWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 20:22:22 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:38216 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgGYAWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 20:22:22 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 9A7951A40314; Fri, 24 Jul 2020 17:22:21 -0700 (PDT)
Date:   Fri, 24 Jul 2020 17:22:21 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: [QUESTION] Sharing a `struct page` across multiple `struct
 address_space` instances
Message-ID: <20200725002221.dszdahfhqrbz43cz@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

I've been poking around the shmem/tmpfs code with an eye towards
adding reflink support to tmpfs.

Prior to looking at the code, conceptually I was envisioning the pages
in the reflink source inode's address_space would simply get their
refcounts bumped as they were added to the dest inode's address_space,
with some CoW flag set to prevent writes.

But there seems to be a fundamental assumption that a `struct page`
would only belong to a single `struct address_space` at a time, as it
has single `mapping` and `index` members for reverse mapping the page
to its address_space.

Am I completely lost here or does it really look like a rather
invasive modification to support this feature?

I have vague memories of Dave Chinner mentioning work towards sharing
pages across address spaces in the interests of getting reflink copies
more competitive with overlayfs in terms of page cache utilization.

Dave did you ever end up going down this path?

Regards,
Vito Caputo
