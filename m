Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653BBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 346BD2067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHSRtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:49:42 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38683 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725804AbgHSRtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:49:42 -0400
Received: from callcc.thunk.org (pool-108-49-65-20.bstnma.fios.verizon.net [108.49.65.20])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07JHnPOv028075
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 13:49:25 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0505342010C; Wed, 19 Aug 2020 13:49:24 -0400 (EDT)
Date:   Wed, 19 Aug 2020 13:49:24 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        kernel test robot <rong.a.chen@intel.com>,
        kbuild test robot <lkp@intel.com>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [ext4] d3b6f23f71: stress-ng.fiemap.ops_per_sec -60.5%
 regression
Message-ID: <20200819174924.GB5561@mit.edu>
References: <20200407080036.GA8179@shao2-debian>
 <20200715110437.7D0A3AE051@d06av26.portsmouth.uk.ibm.com>
 <705b788f-aac3-f622-a286-ecd99deb5ca9@linux.intel.com>
 <b29f6c18-f9c7-7e43-5b13-b5724fbf8d1a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b29f6c18-f9c7-7e43-5b13-b5724fbf8d1a@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at what the stress-ng fiemap workload is doing, and
it's.... interesting.

It is running 4 processes which are calling FIEMAP on a particular
file in a loop, with a 25ms sleep every 64 times.  And then there is a
fifth process which is randomly writing to the file and calling
punch_hole to random offsets in the file.

So this is quite different from what Ritesh has been benchmarking
which is fiemap in isolation, as opposed to fiemap racing against a 3
other fiemap processes plus a process which is actively modifying the
file.

In the original code, if I remember correctly, we were using a shared
reader/writer lock to look at the extent tree blocks directly, but we
hold the i_data_sem rw_sempahore for the duration of the fiemap call.

In the new code, we're going through the extent_status cache, which is
grabbing the rw_spinlock each time we do a lookup in the extents
status tree.  So this is a much finer-grained locking and that is
probably the explanation for the increased time for running fiemap in
the contended case.

If this theory is correct, we would probably get back the performance
by wrapping the calls to iomap_fiemap() with {up,down}_read(&ei->i_data_sem)
in ext4_fiemap().

That being said, however ---- it's clear what real-life workload cares
about FIEMAP performance, especially with multiple threads all calling
FIEMAP racing against a file which is being actively modified.  Having
stress-ng do this to find potential kernel bugs is a great thing, so I
understand why stress-ng might be doing this as a QA tool.  Why we
should care about stress-ng as a performance benchmark, at least in
this case, is much less clear to me.

Cheers,

					- Ted
