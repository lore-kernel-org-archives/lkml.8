Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD77DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A5F204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbgF3JXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:23:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:59634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbgF3JXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:23:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4E92AEDF;
        Tue, 30 Jun 2020 09:23:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5BB65DA790; Tue, 30 Jun 2020 11:22:55 +0200 (CEST)
Date:   Tue, 30 Jun 2020 11:22:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sebastian Hyrwall <sh@keff.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: BTRFS/EXT4 Data Corruption
Message-ID: <20200630092254.GW27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sebastian Hyrwall <sh@keff.org>,
        linux-kernel@vger.kernel.org
References: <f87dcf1e-5a8a-36c2-a864-88099a66d220@keff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f87dcf1e-5a8a-36c2-a864-88099a66d220@keff.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 01:55:40AM +0700, Sebastian Hyrwall wrote:
> Sorry if this is not the right place for this email but I can't think of 
> another place (might be linux-fsdevel)

You can always CC the mailinglists of the filesystems.

> Someone here is ought to be an expert in this.
> 
> It all started as having file corruptions inside VMs that then led to 
> alot of testing that
> resulted in replicatable results on the backend NAS.
> 
> Tests where done by generating 100 1GB files from /dev/urandom to 
> "volume1" (both BTRFS and EXT4 tested).
> MD5 hashing the files and then copying the files to "volume2". 2-4% of 
> the files would fail the hash match every time
> the test was done.
> 
> After alot of fiddling around it turned out that the problem goes away 
> if doing "cp --sparse=never"
> when copying the files. This would to me exclude any hardware errors and 
> feels more like something
> deeper inside the kernel.

That the problem goes away when you use a completely different way to
write data maybe just hiding the fact that hardware is faulty.

Generating 100G of data will have different memory usage pattern and
likely spanning way more pages than the reflink approach that will be
metadata-only operation (adding the extent references).

> The box runs Kernel 3.10.105. Version >4 seems unaffected (not 100% 
> confirmed, too few testboxes).
> 
> Here is a diff between a hexdump of a failed file,
> 
> 43861581c43861581
> < 29d464c0: aca0 d68f 0ff4 0bad fa4M-5 1339 8148 30e8 .........E.9.H0.
> ---
>  > 29d464c0: aca0 d68f 0ff4 0bad fa45 1339 8148 30e8 .........E.9.H0.
> 55989446c55989446
> < 35654c50: 31f4 f7b5 40be 2188 c539 043b 35b4 abb5 1...@.!..9.;5...
> ---
>  > 35654c50: 3174 f7b5 40be 2188 c539 043b 35b4 abb5 1t..@.!..9.;5...
> 
> As you can see it's a single flipped bit (31f4, 3174). I'm not sure 
> about "fa4M-5". Never seen "M-" before.

If it's a bitflip, then it's faulty RAM. All other explanations like
random memory overwrites typically lead to whole byte or byte sequences.
The reasons for bad RAM could be a faulty module, but I've also seen
transient bitflips on a box without enough PSU power when the system was
under load. Which also makes it hard to make sure memtest will catch the
errors, as was in my case, because the disks were not active.

I'd recommend to stop using the machine for anything than testing.
