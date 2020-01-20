Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C059C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 22:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0A324125
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 22:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZiQHmQJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgATWvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 17:51:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgATWvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 17:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R+VrryagXkN1KRM7i07YKJs/dp8y4Bt7arACVyux37U=; b=ZiQHmQJBi4ArefPvCRYtb4/0m
        5hQpyNNkqEd7ydwxryLvG0+E6I3dHphlRkeGDC6Yxi0gnJgjknN8XxMSF0NyVAQIYpil4oyHclHs5
        ZKpl5IlgfwFfSccgqu9VmkZY8/fxENAiACs/Jo3uKP6UQ84QvACPb06kr1MIHHwpwEtfGt32kxXRP
        dUkga1YUC8jun/vVqCrKm/IWOWgvWCItJFoFgYjM0w2UquLJ54V88ehQjoDwZIFe1jOGQw7x3zaXp
        hNWYl4hoCrPM6VDsJhrk6eB0wxrtoHG+vtV2JdL0OjQ7DKHL4QSZ46FfGlh98rVX2IVM2SEk9YJV7
        cP+YYOkcw==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itftV-0007Hu-R7; Mon, 20 Jan 2020 22:51:41 +0000
To:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: zram: various fixes in zram.rst
Message-ID: <77000e12-677a-62f6-9f78-343be5bd6630@infradead.org>
Date:   Mon, 20 Jan 2020 14:51:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix various items in zram.rst:
- typos/spellos
- punctuation
- grammar
- shell syntax
- indentation
- sysfs file names

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 Documentation/admin-guide/blockdev/zram.rst |   61 +++++++++---------
 1 file changed, 31 insertions(+), 30 deletions(-)

--- linux-next-20200120.orig/Documentation/admin-guide/blockdev/zram.rst
+++ linux-next-20200120/Documentation/admin-guide/blockdev/zram.rst
@@ -1,15 +1,15 @@
 ========================================
-zram: Compressed RAM based block devices
+zram: Compressed RAM-based block devices
 ========================================
 
 Introduction
 ============
 
-The zram module creates RAM based block devices named /dev/zram<id>
+The zram module creates RAM-based block devices named /dev/zram<id>
 (<id> = 0, 1, ...). Pages written to these disks are compressed and stored
 in memory itself. These disks allow very fast I/O and compression provides
-good amounts of memory savings. Some of the usecases include /tmp storage,
-use as swap disks, various caches under /var and maybe many more :)
+good amounts of memory savings. Some of the use cases include /tmp storage,
+use as swap disks, various caches under /var and maybe many more. :)
 
 Statistics for individual zram devices are exported through sysfs nodes at
 /sys/block/zram<id>/
@@ -43,17 +43,17 @@ The list of possible return codes:
 
 ========  =============================================================
 -EBUSY	  an attempt to modify an attribute that cannot be changed once
-	  the device has been initialised. Please reset device first;
+	  the device has been initialised. Please reset device first.
 -ENOMEM	  zram was not able to allocate enough memory to fulfil your
-	  needs;
+	  needs.
 -EINVAL	  invalid input has been provided.
 ========  =============================================================
 
-If you use 'echo', the returned value that is changed by 'echo' utility,
+If you use 'echo', the returned value is set by the 'echo' utility,
 and, in general case, something like::
 
 	echo 3 > /sys/block/zram0/max_comp_streams
-	if [ $? -ne 0 ];
+	if [ $? -ne 0 ]; then
 		handle_error
 	fi
 
@@ -65,7 +65,8 @@ should suffice.
 ::
 
 	modprobe zram num_devices=4
-	This creates 4 devices: /dev/zram{0,1,2,3}
+
+This creates 4 devices: /dev/zram{0,1,2,3}
 
 num_devices parameter is optional and tells zram how many devices should be
 pre-created. Default: 1.
@@ -73,12 +74,12 @@ pre-created. Default: 1.
 2) Set max number of compression streams
 ========================================
 
-Regardless the value passed to this attribute, ZRAM will always
-allocate multiple compression streams - one per online CPUs - thus
+Regardless of the value passed to this attribute, ZRAM will always
+allocate multiple compression streams - one per online CPU - thus
 allowing several concurrent compression operations. The number of
 allocated compression streams goes down when some of the CPUs
 become offline. There is no single-compression-stream mode anymore,
-unless you are running a UP system or has only 1 CPU online.
+unless you are running a UP system or have only 1 CPU online.
 
 To find out how many streams are currently available::
 
@@ -89,7 +90,7 @@ To find out how many streams are current
 
 Using comp_algorithm device attribute one can see available and
 currently selected (shown in square brackets) compression algorithms,
-change selected compression algorithm (once the device is initialised
+or change the selected compression algorithm (once the device is initialised
 there is no way to change compression algorithm).
 
 Examples::
@@ -167,9 +168,9 @@ Examples::
 zram provides a control interface, which enables dynamic (on-demand) device
 addition and removal.
 
-In order to add a new /dev/zramX device, perform read operation on hot_add
-attribute. This will return either new device's device id (meaning that you
-can use /dev/zram<id>) or error code.
+In order to add a new /dev/zramX device, perform a read operation on the hot_add
+attribute. This will return either the new device's device id (meaning that you
+can use /dev/zram<id>) or an error code.
 
 Example::
 
@@ -186,8 +187,8 @@ execute::
 
 Per-device statistics are exported as various nodes under /sys/block/zram<id>/
 
-A brief description of exported device attributes. For more details please
-read Documentation/ABI/testing/sysfs-block-zram.
+A brief description of exported device attributes follows. For more details
+please read Documentation/ABI/testing/sysfs-block-zram.
 
 ======================  ======  ===============================================
 Name            	access            description
@@ -245,7 +246,7 @@ whitespace:
 
 File /sys/block/zram<id>/mm_stat
 
-The stat file represents device's mm statistics. It consists of a single
+The mm_stat file represents the device's mm statistics. It consists of a single
 line of text and contains the following stats separated by whitespace:
 
  ================ =============================================================
@@ -261,7 +262,7 @@ line of text and contains the following
                   Unit: bytes
  mem_limit        the maximum amount of memory ZRAM can use to store
                   the compressed data
- mem_used_max     the maximum amount of memory zram have consumed to
+ mem_used_max     the maximum amount of memory zram has consumed to
                   store the data
  same_pages       the number of same element filled pages written to this disk.
                   No memory is allocated for such pages.
@@ -271,7 +272,7 @@ line of text and contains the following
 
 File /sys/block/zram<id>/bd_stat
 
-The stat file represents device's backing device statistics. It consists of
+The bd_stat file represents a device's backing device statistics. It consists of
 a single line of text and contains the following stats separated by whitespace:
 
  ============== =============================================================
@@ -316,7 +317,7 @@ To use the feature, admin should set up
 	echo /dev/sda5 > /sys/block/zramX/backing_dev
 
 before disksize setting. It supports only partition at this moment.
-If admin want to use incompressible page writeback, they could do via::
+If admin wants to use incompressible page writeback, they could do via::
 
 	echo huge > /sys/block/zramX/write
 
@@ -326,7 +327,7 @@ as idle::
 	echo all > /sys/block/zramX/idle
 
 From now on, any pages on zram are idle pages. The idle mark
-will be removed until someone request access of the block.
+will be removed until someone requests access of the block.
 IOW, unless there is access request, those pages are still idle pages.
 
 Admin can request writeback of those idle pages at right timing via::
@@ -341,16 +342,16 @@ to guarantee storage health for entire p
 
 To overcome the concern, zram supports "writeback_limit" feature.
 The "writeback_limit_enable"'s default value is 0 so that it doesn't limit
-any writeback. IOW, if admin want to apply writeback budget, he should
+any writeback. IOW, if admin wants to apply writeback budget, he should
 enable writeback_limit_enable via::
 
 	$ echo 1 > /sys/block/zramX/writeback_limit_enable
 
 Once writeback_limit_enable is set, zram doesn't allow any writeback
-until admin set the budget via /sys/block/zramX/writeback_limit.
+until admin sets the budget via /sys/block/zramX/writeback_limit.
 
 (If admin doesn't enable writeback_limit_enable, writeback_limit's value
-assigned via /sys/block/zramX/writeback_limit is meaninless.)
+assigned via /sys/block/zramX/writeback_limit is meaningless.)
 
 If admin want to limit writeback as per-day 400M, he could do it
 like below::
@@ -361,13 +362,13 @@ like below::
 		/sys/block/zram0/writeback_limit.
 	$ echo 1 > /sys/block/zram0/writeback_limit_enable
 
-If admin want to allow further write again once the bugdet is exausted,
+If admins want to allow further write again once the bugdet is exhausted,
 he could do it like below::
 
 	$ echo $((400<<MB_SHIFT>>4K_SHIFT)) > \
 		/sys/block/zram0/writeback_limit
 
-If admin want to see remaining writeback budget since he set::
+If admin wants to see remaining writeback budget since last set::
 
 	$ cat /sys/block/zramX/writeback_limit
 
@@ -375,12 +376,12 @@ If admin want to disable writeback limit
 
 	$ echo 0 > /sys/block/zramX/writeback_limit_enable
 
-The writeback_limit count will reset whenever you reset zram(e.g.,
+The writeback_limit count will reset whenever you reset zram (e.g.,
 system reboot, echo 1 > /sys/block/zramX/reset) so keeping how many of
 writeback happened until you reset the zram to allocate extra writeback
 budget in next setting is user's job.
 
-If admin want to measure writeback count in a certain period, he could
+If admin wants to measure writeback count in a certain period, he could
 know it via /sys/block/zram0/bd_stat's 3rd column.
 
 memory tracking


