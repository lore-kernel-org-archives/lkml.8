Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F89C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 19:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17BAC206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 19:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgF1TCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 15:02:23 -0400
Received: from mail.keff.org ([45.154.255.110]:56868 "EHLO mail.keff.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgF1TCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 15:02:21 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Jun 2020 15:02:20 EDT
Received: from [172.17.2.124] (unknown [45.154.255.254])
        by mail.keff.org (Postfix) with ESMTPSA id 645003E3CABC
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 20:55:44 +0200 (CEST)
To:     linux-kernel@vger.kernel.org
From:   Sebastian Hyrwall <sh@keff.org>
Subject: BTRFS/EXT4 Data Corruption
Message-ID: <f87dcf1e-5a8a-36c2-a864-88099a66d220@keff.org>
Date:   Mon, 29 Jun 2020 01:55:40 +0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X--MailScanner-Information: Please contact the ISP for more information
X--MailScanner-ID: 645003E3CABC.AF4E3
X--MailScanner: Found to be clean
X--MailScanner-From: sh@keff.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Sorry if this is not the right place for this email but I can't think of 
another place (might be linux-fsdevel)
Someone here is ought to be an expert in this.

It all started as having file corruptions inside VMs that then led to 
alot of testing that
resulted in replicatable results on the backend NAS.

Tests where done by generating 100 1GB files from /dev/urandom to 
"volume1" (both BTRFS and EXT4 tested).
MD5 hashing the files and then copying the files to "volume2". 2-4% of 
the files would fail the hash match every time
the test was done.

After alot of fiddling around it turned out that the problem goes away 
if doing "cp --sparse=never"
when copying the files. This would to me exclude any hardware errors and 
feels more like something
deeper inside the kernel.

The box runs Kernel 3.10.105. Version >4 seems unaffected (not 100% 
confirmed, too few testboxes).

Here is a diff between a hexdump of a failed file,

43861581c43861581
< 29d464c0: aca0 d68f 0ff4 0bad fa4M-5 1339 8148 30e8 .........E.9.H0.
---
 > 29d464c0: aca0 d68f 0ff4 0bad fa45 1339 8148 30e8 .........E.9.H0.
55989446c55989446
< 35654c50: 31f4 f7b5 40be 2188 c539 043b 35b4 abb5 1...@.!..9.;5...
---
 > 35654c50: 3174 f7b5 40be 2188 c539 043b 35b4 abb5 1t..@.!..9.;5...

As you can see it's a single flipped bit (31f4, 3174). I'm not sure 
about "fa4M-5". Never seen "M-" before.


Details,

Linux 3.10.105,
Intel(R) Xeon(R) CPU E3-1230 V2 @ 3.30GHz,
Volume ontop of lvm and md-raid,
md2 : active raid5 sda3[0] sdj3[5] sdi3[4] sdf3[3] sde3[2] sdb3[1]
       39046022720 blocks super 1.2 level 5, 64k chunk, algorithm 2 
[6/6] [UUUUUU],
cp (GNU coreutils) 8.24

BTRFS and EXT4 default mount options.



// Sebastian H

