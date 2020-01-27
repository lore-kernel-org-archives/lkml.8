Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74575C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46472214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgA0J6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:58:46 -0500
Received: from us.icdsoft.com ([192.252.146.184]:60904 "EHLO us.icdsoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgA0J6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:58:46 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jan 2020 04:58:46 EST
Received: (qmail 4371 invoked by uid 1001); 27 Jan 2020 09:52:05 -0000
Received: from 45.98.145.213.in-addr.arpa (HELO ?213.145.98.45?) (gnikolov@icdsoft.com@213.145.98.45)
  by 192.252.159.165 with ESMTPA; 27 Jan 2020 09:52:05 -0000
To:     shli@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Georgi Nikolov <gnikolov@icdsoft.com>
Subject: Pausing md check hangs
Message-ID: <01ea67c2-244c-0427-0be7-c565fac97092@icdsoft.com>
Date:   Mon, 27 Jan 2020 11:52:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I posted a kernel bug about this a month ago but it did not receive any 
attention: https://bugzilla.kernel.org/show_bug.cgi?id=205929
Here is a copy of the bug report and I hope that this is the correct 
place to discuss this:

I have a Supermicro server with 10 md raid6 arrays each consisting of 8 SATA drives. SATA drives are Hitachi/HGST Ultrastar 7K4000 8T.
When i try to pause array check with "echo idle > "/sys/block/<md_dev>/md/sync_action" it randomly hangs at different md device.
Process "mdX_raid6" is at 100% cpu usage. cat /sys/block/mdX/md/journal_mode hungs forever.

Here is the state at the moment of crash for one of the md devices:

root@supermicro:/sys/block/mdX/md# find -mindepth 1 -maxdepth 1 -type f|sort|grep -v journal_mode|xargs -r egrep .
./array_size:default
./array_state:write-pending
grep: ./bitmap_set_bits: Permission denied
./chunk_size:524288
./component_size:7813895168
./consistency_policy:resync
./degraded:0
./group_thread_cnt:4
./last_sync_action:check
./layout:2
./level:raid6
./max_read_errors:20
./metadata_version:1.2
./mismatch_cnt:0
grep: ./new_dev: Permission denied
./preread_bypass_threshold:1
./raid_disks:8
./reshape_direction:forwards
./reshape_position:none
./resync_start:none
./rmw_level:1
./safe_mode_delay:0.204
./skip_copy:0
./stripe_cache_active:13173
./stripe_cache_size:8192
./suspend_hi:0
./suspend_lo:0
./sync_action:check
./sync_completed:3566405120 / 15627790336
./sync_force_parallel:0
./sync_max:max
./sync_min:1821385984
./sync_speed:126
./sync_speed_max:1000 (local)
./sync_speed_min:1000 (system)

root@supermicro:~# cat /proc/mdstat
Personalities : [raid1] [linear] [multipath] [raid0] [raid6] [raid5] [raid4] [raid10]
md4 : active raid6 sdaa[2] sdab[3] sdy[0] sdae[6] sdac[4] sdad[5] sdaf[7] sdz[1]
       46883371008 blocks super 1.2 level 6, 512k chunk, algorithm 2 [8/8] [UUUUUUUU]
       [====>................]  check = 22.8% (1784112640/7813895168) finish=20571.7min speed=4884K/sec


Regards,
Georgi Nikolov

