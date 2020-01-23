Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24DFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDFB21835
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgAWNex convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:34:53 -0500
Received: from logand.com ([37.48.87.44]:33250 "EHLO logand.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgAWNex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:34:53 -0500
Received: by logand.com (Postfix, from userid 1001)
        id 2C76619F8AB; Thu, 23 Jan 2020 14:34:51 +0100 (CET)
X-Mailer: emacs 26.3 (via feedmail 11-beta-1 Q)
From:   Tomas Hlavaty <tom@logand.com>
To:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference at 00000000000000a8 in nilfs_segctor_do_construct
In-Reply-To: <76887BD9-D6C4-4A89-8F55-4BEAF2828FD3@dubeyko.com>
References: <8736emquds.fsf@logand.com> <CAKFNMo=k1wVHOwXhTLEOJ+A-nwmvJ+sN_PPa8kY8fMxrQ4R+Jw@mail.gmail.com> <76887BD9-D6C4-4A89-8F55-4BEAF2828FD3@dubeyko.com>
Date:   Thu, 23 Jan 2020 14:00:21 +0100
Message-ID: <87sgk6tjiy.fsf@logand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viacheslav,

Viacheslav Dubeyko <slava@dubeyko.com> writes:
> (1) the partition size?

the first disk with crash was 1TB

the second disk with crash, which i have by me, is 2TB:

$ lsblk /dev/sdb
NAME      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sdb         8:16   0  1.8T  0 disk  
└─extdisk 254:2    0  1.8T  0 crypt /mnt/b

> (2) the logical block size?
> (3) the segment size?

how can i find (2) and (3) out?

here is the output of nilfs-tune:

$ sudo nilfs-tune -l /dev/mapper/extdisk
nilfs-tune 2.2.7
Filesystem volume name:	  backup1_nilfs2
Filesystem UUID:	  7d9708f9-464f-41b7-a0c6-eda18741012f
Filesystem magic number:  0x3434
Filesystem revision #:	  2.0
Filesystem features:      (none)
Filesystem state:	  valid
Filesystem OS type:	  Linux
Block size:		  4096
Filesystem created:	  Thu Dec 27 14:14:14 2018
Last mount time:	  Fri Dec 20 13:06:15 2019
Last write time:	  Thu Jan 23 13:04:30 2020
Mount count:		  15
Maximum mount count:	  50
Reserve blocks uid:	  0 (user root)
Reserve blocks gid:	  0 (group root)
First inode:		  11
Inode size:		  128
DAT entry size:		  32
Checkpoint size:	  192
Segment usage size:	  16
Number of segments:	  238465
Device size:		  2000396834816
First data block:	  1
# of blocks per segment:  2048
Reserved segments %:	  5
Last checkpoint #:	  9884
Last block address:	  280841435
Last sequence #:	  137120
Free blocks count:	  207591424
Commit interval:	  0
# of blks to create seg:  0
CRC seed:		  0x5172270a
CRC check sum:		  0x2ef767d2
CRC check data size:	  0x00000118

it seems strange that the last write time is today, even though i
mounted the partition read-only

/dev/mapper/extdisk on /mnt/b type nilfs2 (ro,relatime)

> (4) how the partition was created?

using parted
then cryptsetup luksFormat
then cryptsetup luksOpen
then mkfs.nilfs2

> (5) the version of tools that created the partition?

how can i find this out?  is it saved somewhere?

> (6) the amount of free space on the partition?

/dev/mapper/extdisk  1.9T  1.1T  699G  61% /mnt/b

Regards,

Tomas
