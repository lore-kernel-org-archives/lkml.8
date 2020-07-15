Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A95C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED912067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgGOKbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:31:17 -0400
Received: from canopus.corp.1gb.ru ([81.177.167.38]:63235 "EHLO
        canopus.corp.1gb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgGOKbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:31:17 -0400
X-Greylist: delayed 1596 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jul 2020 06:31:16 EDT
Received: from canopus.corp.1gb.ru (canopus.corp.1gb.ru [81.177.167.38] (may be forged))
        by canopus.corp.1gb.ru (8.14.5/8.14.7) with ESMTP id 06FA4cv1062261
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 15 Jul 2020 13:04:38 +0300 (MSK)
        (envelope-from renton@renton.name)
Received: (from renton@localhost)
        by canopus.corp.1gb.ru (8.14.5/8.14.7/Submit) id 06FA4ckJ062260;
        Wed, 15 Jul 2020 13:04:38 +0300 (MSK)
        (envelope-from renton@renton.name)
X-Authentication-Warning: canopus.corp.1gb.ru: renton set sender to renton@renton.name using -f
Date:   Wed, 15 Jul 2020 13:04:38 +0300
From:   Alexey Vlasov <renton@renton.name>
To:     linux-kernel@vger.kernel.org
Cc:     kirill@shutemov.name
Subject: Re: [REGRESSION] [BISECTED] kswapd high CPU usage
Message-ID: <20200715100438.GL69039@canopus.corp.1gb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After upgrading from 3.14 to 4.14.173, I ran into exactly the same problem
that the starter topic described. Namely, sometimes kswapd starts to consume 100% 
of the CPU, and the system freezes for several minutes.

Below is an example of such an event (orange - system cpu, red - total cpu):
https://www.dropbox.com/s/5wr5su3p0fubq0a/kswapd_100.png?dl=0

Here is the top:

top - 23:44:16 up 9 days,  2:06, 14 users,  load average: 14.03, 12.32, 13.07
Tasks: 7108 total,  16 running, 6921 sleeping,   0 stopped,   9 zombie
%Cpu(s): 28.1 us, 18.1 sy,  0.0 ni, 51.7 id,  1.2 wa,  0.0 hi,  0.9 si,  0.0 st
KiB Mem : 19803248+total,   596160 free, 11094233+used, 86493992 buff/cache
KiB Swap: 62914556 total, 62302912 free,   611644 used. 71269504 avail Mem

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
  134 root      20   0       0      0      0 R  86.2  0.0 383:21.35 kswapd0
  135 root      20   0       0      0      0 R  84.9  0.0 344:00.17 kswapd1

this is a begin of the collapse, some minutes later the system has thousands of D
processes and does not answer:

top - 23:57:33 up 9 days,  2:19, 14 users,  load average: 1223.43, 1083.85, 662.
Tasks: 8356 total, 344 running, 7821 sleeping,   0 stopped,  44 zombie
%Cpu(s): 28.1 us, 18.2 sy,  0.0 ni, 51.6 id,  1.2 wa,  0.0 hi,  0.9 si,  0.0 st
KiB Mem : 19803248+total,   800516 free, 11587540+used, 81356560 buff/cache
KiB Swap: 62914556 total, 62130072 free,   784484 used. 62231208 avail Mem

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
10704 w_defau+  20   0  393476 117160  15160 D 100.0  0.1   0:00.16 httpd
16056 w_sti46+  20   0  599048  21528   9504 S 100.0  0.0   0:00.00 httpd
12649 w_divan+  20   0   41764   8064   3904 D 100.0  0.0   0:06.62 menu1.pl
13739 w_defau+  20   0  248696  24168  14132 S 100.0  0.0   0:00.01 httpd
 5172 mysql     20   0 6993508 2.310g   9660 D  38.9  1.2   3866:26 mysqld_aux3
 4683 mysql     20   0 9974.1m 4.366g   8268 D  38.7  2.3   2553:14 mysqld
 4791 mysql     20   0 10.359g 4.180g   9784 D  28.5  2.2   1659:40 mysqld_aux1
 5078 mysql     20   0  9.871g 3.774g   9888 D  25.4  2.0   2445:08 mysqld_aux2
    9 root      20   0       0      0      0 I   3.4  0.0  13:56.16 rcu_sched
  135 root      20   0       0      0      0 D   2.8  0.0 344:29.12 kswapd1
  134 root      20   0       0      0      0 D   2.6  0.0 383:49.86 kswapd0

Nevertheless there is not any I/O activity before after and during this collapse.

I tried to use your patch about "late_initcall(set_recommended_min_free_kbytes)",
unfortunately it did not help.

In my experience this could be solved by adding RAM but unfortunately this server
no longer has free slots. 188 GB RAM is the maximum for it.

Also I cannot go back to 3.14 kernel, since one of the partitions contains xfs with
the superblock of the new version v5, which is not supported by 3.14 kernel.

If you need more information, for example, vmstat, /proc/meminfo, I can send.

Is there any solution to this problem?

> On Fri, Jan 22, 2016 at 12:28:10AM +1000, Nalorokk wrote:
>> It appears that kernels newer than 4.1 have kswapd-related bug resulting in
>> high CPU usage. CPU 100% usage could last for several minutes or several
>> days, with CPU being busy entirely with serving kswapd. It happens usually
>> after server being mostly idle, sometimes after days, sometimes after weeks
>> of uptime. But the issue appears much sooner if the machine is loaded with
>> something like building a kernel.
>>
>> Here are the graphs of CPU load: first
>> <http://i.piccy.info/i9/9ee6c0620c9481a974908484b2a52a0f/1453384595/44012/994698/cpu_month.png>,
>> second
>> <http://i.piccy.info/i9/7c97c2f39620bb9d7ea93096312dbbb6/1453384649/41222/994698/cpu_year.png>.
>> Perf top output is here <http://pastebin.com/aRzTjb2x>as well.
>>
>> To find the cause of this problem I've started with the fact that the issue
>> appeared after 4.1 kernel update. Then I performed longterm test of 3.18,
>> and discovered that 3.18 is unaffected by this bug. Then I did some tests
>> of 4.0 to confirm that this version behaves well too.
>>
>> Then I performed git bisect from tag v4.0 to v4.1-rc1 and found exact
>> commits that seem to be reason of high CPU usage.
>>
>> The first really "bad" commit is 79553da293d38d63097278de13e28a3b371f43c1.
>> 2 previous commits cause weird behavior as well resulting in kswapd
>> consuming more CPU than unaffected kernels, but not that much as the commit
>> pointed above. I believe those commits are related to the same mm tree
>> merge.
>>
>> I tried to add transparent_hugepage=never to kernel boot parameters, but it
>> did not change anything. Changing allocator to SLAB from SLUB alters
>> behavior and makes CPU load lower, but don't solve a problem at all.
>>
>> Here <https://bugzilla.kernel.org/show_bug.cgi?id=110501>is kernel bugzilla
>> bugreport as well.
>>
>> Ideas? â
>
> Could you try to insert "late_initcall(set_recommended_min_free_kbytes);"
> back and check if makes any difference.
>
>-- 
>Kirill A. Shutemov
