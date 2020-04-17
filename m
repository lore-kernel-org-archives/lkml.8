Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63540C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414EE20776
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgDQVL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:11:29 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46498 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgDQVL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:11:29 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jPYGk-0005yL-PC; Fri, 17 Apr 2020 15:11:26 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jPYGi-0003AY-UF; Fri, 17 Apr 2020 15:11:26 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20200414070142.288696-1-hch@lst.de>
        <20200414070142.288696-3-hch@lst.de>
Date:   Fri, 17 Apr 2020 16:08:23 -0500
In-Reply-To: <20200414070142.288696-3-hch@lst.de> (Christoph Hellwig's message
        of "Tue, 14 Apr 2020 09:01:36 +0200")
Message-ID: <87pnc5akhk.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jPYGi-0003AY-UF;;;mid=<87pnc5akhk.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/sMSqzlC3UCo8sLeQoBbXwuy1pdf5wSzo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 2/8] signal: clean up __copy_siginfo_to_user32
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Instead of an architecture specific calling convention in common code
> just pass a flags argument with architecture specific values.

This bothers me because it makes all architectures pay for the sins of
x32.  Further it starts burying the details of the what is happening in
architecture specific helpers.  Hiding the fact that there is only
one niche architecture that does anything weird.

I am very sensitive to hiding away signal handling details right now
because way to much of the signal handling code got hidden in
architecture specific files and was quite buggy because as a result.

My general sense is putting all of the weird details up front and center
in kernel/signal.c is the only way for this code will be looked at
and successfully maintained.

How about these patches to solve set_fs with binfmt_elf instead:

Eric W. Biederman (2):
      signal: Factor copy_siginfo_to_external32 from copy_siginfo_to_user32
      signal: Remove the set_fs in binfmt_elf.c:fill_siginfo_note

 fs/binfmt_elf.c        |   5 +----
 fs/compat_binfmt_elf.c |   2 +-
 include/linux/compat.h |   1 +
 include/linux/signal.h |   7 +++++++
 kernel/signal.c        | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------

Eric
