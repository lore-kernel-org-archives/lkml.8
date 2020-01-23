Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6406BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F23F21835
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgAWNer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:34:47 -0500
Received: from logand.com ([37.48.87.44]:33244 "EHLO logand.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgAWNer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:34:47 -0500
Received: by logand.com (Postfix, from userid 1001)
        id 84ECF19F8AB; Thu, 23 Jan 2020 14:34:45 +0100 (CET)
X-Mailer: emacs 26.3 (via feedmail 11-beta-1 Q)
From:   Tomas Hlavaty <tom@logand.com>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference at 00000000000000a8 in nilfs_segctor_do_construct
In-Reply-To: <87immckp07.fsf@logand.com>
References: <8736emquds.fsf@logand.com> <CAKFNMo=k1wVHOwXhTLEOJ+A-nwmvJ+sN_PPa8kY8fMxrQ4R+Jw@mail.gmail.com> <87immckp07.fsf@logand.com>
Date:   Thu, 23 Jan 2020 13:31:38 +0100
Message-ID: <87v9p2tkut.fsf@logand.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryusuke,

>> 2) Can you mount the corrupted(?) partition from a recent version of
>> kernel ?

this will take me some time to figure out

>> 3) Does read-only mount option (-r) work to avoid the crash ?

ro mount doesn't seem to crash

at least after mounting the partition read-only
- running lscp
- running sudo find . -type f inside the mounted partition
- cat <some random file on the nilfs partition>
does not crash

the crash i was seeing was during rsync (writing i guess)

Other info that might be relevant:

- the nilfs partition was on top of luks
- the corruption happened probably during shutdown
  the shutdown hanged for a long time waiting for nilfs
  disk (iirc it waits for 1m30s) and even after that it did
  not finish so i turned the computer off without waiting
  further.  after new start, i got the crash
- i got the same problem on another disk recently

Regards,

Tomas
