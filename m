Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072C9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BC02072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgFBVhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:37:10 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:38240 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgFBVhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:37:09 -0400
Date:   Tue, 2 Jun 2020 17:37:05 -0400
From:   Rich Felker <dalias@libc.org>
To:     musl@lists.openwall.com
Cc:     libc-alpha@sourceware.org, linux-kernel@vger.kernel.org
Subject: sys/sysinfo.h clash with linux/kernel.h
Message-ID: <20200602213704.GF1079@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/kernel.h is a uapi header that does almost nothing but define
some internal-use alignment macros and -- oddly -- include
linux/sysinfo.h to provide a definition of struct sysinfo. It's
included only from 6 places in the kernel uapi headers:

include/uapi/linux/lightnvm.h
include/uapi/linux/ethtool.h
include/uapi/linux/sysctl.h
include/uapi/linux/netlink.h
include/uapi/linux/netfilter/x_tables.h
include/uapi/linux/mroute6.h

However, it's also included from glibc's sys/sysinfo.h to provide
struct sysinfo (glibc depends on the kernel for the definition). On
musl, this produces a conflicting definition if both sys/sysinfo.h and
any of the above 6 headers are included in the same file.

I think the underlying problem here is that the same header is used
for two very disjoint purposes: by glibc as the provider of struct
sysinfo, and by other kernel headers as provider of the alignment
macros.

The glibc use is effectively a permanent contract that can't be
changed, so what I'd like to do is move the macros out to a separate
header (maybe linux/something_macros.h?) and have linux/kernel.h and
the above 6 uapi headers all include that. Then nothing but
linux/kernel.h would pull in linux/sysinfo.h.

Note that in practice this is a rather hard issue to hit since almost
nothing needs sysinfo() at the same time as the above uapi interfaces.
However it did come up in toybox, which is how I first (just today)
learned about the conflict, so it seems like something that should be
fixed.

Rich
