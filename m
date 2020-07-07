Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B312EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8099C2074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CLCHUjmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGGGuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgGGGuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:50:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB53DC061755;
        Mon,  6 Jul 2020 23:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3d6PKXGgRzXyn8D7Pt5GMdB7zEVxXEF9N6HS6Hc10PA=; b=CLCHUjmf6Ch3VsWTX4HmRyFobR
        mPUjtxHnmpdeYbrwjrAuvZPmaoyC+Sfd5yZgd7d/7r0szOJkzGu8lHC+MInDW86htfG2zrvi+24Hg
        riujYoKye0kB9F1sgIoaTwe9BnwsSwwmggTiwdtCbv4TGC+Vh4BGtsR4aqUel/RM+hyrqvBEftfls
        sSlZ+0IuqY7eyRsVazYg9Fdbss2bOnI72ozHpaPrh7DV5eQt3tA3Lfy0jb74eeWvtr4eCuUj2oK2j
        9x9B+5BKvwEM1JZFaS4awOFPzUlY3UWoJ4K01sNHEtFJDw2GnsUw4sVP8rc7FNqV19GW3R4WIdiHL
        TgEN7FBQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jshQW-00056n-9w; Tue, 07 Jul 2020 06:50:01 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation/filesystems/proc.rst: copy-editing cleanup
Message-ID: <a5f126e6-d67a-154a-1c87-d8f07542a21c@infradead.org>
Date:   Mon, 6 Jul 2020 23:49:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Clean up Documentation/filesystems/proc.rst.

This is basically fixing lots of spelling, grammar, punctuation,
typos, spacing, consistency, section numbering, and headings.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/filesystems/proc.rst |  111 +++++++++++++--------------
 1 file changed, 55 insertions(+), 56 deletions(-)

--- linux-next-20200703.orig/Documentation/filesystems/proc.rst
+++ linux-next-20200703/Documentation/filesystems/proc.rst
@@ -123,10 +123,10 @@ show you how you can use /proc/sys to ch
 The directory  /proc  contains  (among other things) one subdirectory for each
 process running on the system, which is named after the process ID (PID).
 
-The link  self  points  to  the  process reading the file system. Each process
+The link  'self'  points to  the process reading the file system. Each process
 subdirectory has the entries listed in Table 1-1.
 
-Note that an open a file descriptor to /proc/<pid> or to any of its
+Note that an open file descriptor to /proc/<pid> or to any of its
 contained files or subdirectories does not prevent <pid> being reused
 for some other process in the event that <pid> exits. Operations on
 open /proc/<pid> file descriptors corresponding to dead processes
@@ -220,7 +220,7 @@ file /proc/PID/status. It fields are des
 
 The  statm  file  contains  more  detailed  information about the process
 memory usage. Its seven fields are explained in Table 1-3.  The stat file
-contains details information about the process itself.  Its fields are
+contains detailed information about the process itself.  Its fields are
 explained in Table 1-4.
 
 (for SMP CONFIG users)
@@ -782,7 +782,7 @@ SPU
   For this case the APIC will generate the interrupt with a IRQ vector
   of 0xff. This might also be generated by chipset bugs.
 
-RES, CAL, TLB]
+RES, CAL, TLB
   rescheduling, call and TLB flush interrupts are
   sent from one CPU to another per the needs of the OS.  Typically,
   their statistics are used by kernel developers and interested users to
@@ -794,7 +794,7 @@ suppressed when the system is a uniproce
 i386 and x86_64 platforms support the new IRQ vector displays.
 
 Of some interest is the introduction of the /proc/irq directory to 2.4.
-It could be used to set IRQ to CPU affinity, this means that you can "hook" an
+It could be used to set IRQ to CPU affinity. This means that you can "hook" an
 IRQ to only one CPU, or to exclude a CPU of handling IRQs. The contents of the
 irq subdir is one subdir for each IRQ, and two files; default_smp_affinity and
 prof_cpu_mask.
@@ -808,7 +808,7 @@ For example::
   smp_affinity
 
 smp_affinity is a bitmask, in which you can specify which CPUs can handle the
-IRQ, you can set it by doing::
+IRQ. You can set it by doing::
 
   > echo 1 > /proc/irq/10/smp_affinity
 
@@ -821,7 +821,7 @@ The contents of each smp_affinity file i
   ffffffff
 
 There is an alternate interface, smp_affinity_list which allows specifying
-a cpu range instead of a bitmask::
+a CPU range instead of a bitmask::
 
   > cat /proc/irq/0/smp_affinity_list
   1024-1031
@@ -835,7 +835,7 @@ reports itself as being attached. This h
 include information about any possible driver locality preference.
 
 prof_cpu_mask specifies which CPUs are to be profiled by the system wide
-profiler. Default value is ffffffff (all cpus if there are only 32 of them).
+profiler. Default value is ffffffff (all CPUs if there are only 32 of them).
 
 The way IRQs are routed is handled by the IO-APIC, and it's Round Robin
 between all the CPUs which are allowed to handle it. As usual the kernel has
@@ -897,7 +897,7 @@ pagetypeinfo::
 
 Fragmentation avoidance in the kernel works by grouping pages of different
 migrate types into the same contiguous regions of memory called page blocks.
-A page block is typically the size of the default hugepage size e.g. 2MB on
+A page block is typically the size of the default hugepage size, e.g. 2MB on
 X86-64. By keeping pages grouped based on their ability to move, the kernel
 can reclaim pages within a page block to satisfy a high-order allocation.
 
@@ -965,7 +965,7 @@ varies by architecture and compile optio
     ShmemPmdMapped:      0 kB
 
 MemTotal
-              Total usable ram (i.e. physical ram minus a few reserved
+              Total usable RAM (i.e. physical RAM minus a few reserved
               bits and the kernel binary code)
 MemFree
               The sum of LowFree+HighFree
@@ -996,7 +996,7 @@ Inactive
               Memory which has been less recently used.  It is more
               eligible to be reclaimed for other purposes
 HighTotal, HighFree
-              Highmem is all memory above ~860MB of physical memory
+              Highmem is all memory above ~860MB of physical memory.
               Highmem areas are for use by userspace programs, or
               for the pagecache.  The kernel must use tricks to access
               this memory, making it slower to access than lowmem.
@@ -1078,7 +1078,7 @@ Committed_AS
 	      using 1G. This 1G is memory which has been "committed" to
               by the VM and can be used at any time by the allocating
               application. With strict overcommit enabled on the system
-              (mode 2 in 'vm.overcommit_memory'),allocations which would
+              (mode 2 in 'vm.overcommit_memory'), allocations which would
               exceed the CommitLimit (detailed above) will not be permitted.
               This is useful if one needs to guarantee that processes will
               not fail due to lack of memory once that memory has been
@@ -1099,7 +1099,7 @@ vmallocinfo
 Provides information about vmalloced/vmaped areas. One line per area,
 containing the virtual address range of the area, size in bytes,
 caller information of the creator, and optional information depending
-on the kind of area :
+on the kind of area:
 
  ==========  ===================================================
  pages=nr    number of pages
@@ -1144,21 +1144,21 @@ on the kind of area :
 softirqs
 ~~~~~~~~
 
-Provides counts of softirq handlers serviced since boot time, for each cpu.
+Provides counts of softirq handlers serviced since boot time, for each CPU.
 
 ::
 
     > cat /proc/softirqs
-		    CPU0       CPU1       CPU2       CPU3
+		  CPU0       CPU1       CPU2       CPU3
 	HI:          0          0          0          0
-    TIMER:      27166      27120      27097      27034
+    TIMER:       27166      27120      27097      27034
     NET_TX:          0          0          0         17
     NET_RX:         42          0          0         39
-    BLOCK:          0          0        107       1121
-    TASKLET:          0          0          0        290
-    SCHED:      27035      26983      26971      26746
-    HRTIMER:          0          0          0          0
-	RCU:       1678       1769       2178       2250
+    BLOCK:           0          0        107       1121
+    TASKLET:         0          0          0        290
+    SCHED:       27035      26983      26971      26746
+    HRTIMER:         0          0          0          0
+	RCU:      1678       1769       2178       2250
 
 
 1.3 IDE devices in /proc/ide
@@ -1169,7 +1169,7 @@ the kernel  is  aware.  There is one sub
 file drivers  and a link for each IDE device, pointing to the device directory
 in the controller specific subtree.
 
-The file  drivers  contains general information about the drivers used for the
+The file 'drivers' contains general information about the drivers used for the
 IDE devices::
 
   > cat /proc/ide/drivers
@@ -1409,7 +1409,7 @@ These directories contain the four files
 -------------------------
 
 Information about  the  available  and actually used tty's can be found in the
-directory /proc/tty.You'll  find  entries  for drivers and line disciplines in
+directory /proc/tty. You'll find  entries  for drivers and line disciplines in
 this directory, as shown in Table 1-11.
 
 
@@ -1471,9 +1471,9 @@ second).  The meanings of the columns ar
 - iowait: In a word, iowait stands for waiting for I/O to complete. But there
   are several problems:
 
-  1. Cpu will not wait for I/O to complete, iowait is the time that a task is
-     waiting for I/O to complete. When cpu goes into idle state for
-     outstanding task io, another task will be scheduled on this CPU.
+  1. CPU will not wait for I/O to complete, iowait is the time that a task is
+     waiting for I/O to complete. When CPU goes into idle state for
+     outstanding task I/O, another task will be scheduled on this CPU.
   2. In a multi-core CPU, the task waiting for I/O to complete is not running
      on any CPU, so the iowait of each CPU is difficult to calculate.
   3. The value of iowait field in /proc/stat will decrease in certain
@@ -1529,8 +1529,8 @@ in Table 1-12, below.
  mb_groups       details of multiblock allocator buddy cache of free blocks
  ==============  ==========================================================
 
-2.0 /proc/consoles
-------------------
+1.10 /proc/consoles
+-------------------
 Shows registered system console lines.
 
 To see which character device lines are currently used for the system console
@@ -1590,10 +1590,9 @@ production system.  Set  up  a  developm
 everything works  the  way  you want it to. You may have no alternative but to
 reboot the machine once an error has been made.
 
-To change  a  value,  simply  echo  the new value into the file. An example is
-given below  in the section on the file system data. You need to be root to do
-this. You  can  create  your  own  boot script to perform this every time your
-system boots.
+To change  a  value,  simply  echo  the new value into the file.
+You need to be root to do this. You  can  create  your  own  boot script
+to perform this every time your system boots.
 
 The files  in /proc/sys can be used to fine tune and monitor miscellaneous and
 general things  in  the operation of the Linux kernel. Since some of the files
@@ -1624,8 +1623,8 @@ Chapter 3: Per-process Parameters
 3.1 /proc/<pid>/oom_adj & /proc/<pid>/oom_score_adj- Adjust the oom-killer score
 --------------------------------------------------------------------------------
 
-These file can be used to adjust the badness heuristic used to select which
-process gets killed in out of memory conditions.
+These files can be used to adjust the badness heuristic used to select which
+process gets killed in out of memory (oom) conditions.
 
 The badness heuristic assigns a value to each candidate task ranging from 0
 (never kill) to 1000 (always kill) to determine which process is targeted.  The
@@ -1681,7 +1680,7 @@ minimal amount of work.
 3.2 /proc/<pid>/oom_score - Display current oom-killer score
 -------------------------------------------------------------
 
-This file can be used to check the current score used by the oom-killer is for
+This file can be used to check the current score used by the oom-killer for
 any given <pid>. Use it together with /proc/<pid>/oom_score_adj to tune which
 process should be killed in an out-of-memory situation.
 
@@ -1689,7 +1688,7 @@ process should be killed in an out-of-me
 3.3  /proc/<pid>/io - Display the IO accounting fields
 -------------------------------------------------------
 
-This file contains IO statistics for each running process
+This file contains IO statistics for each running process.
 
 Example
 ~~~~~~~
@@ -1720,7 +1719,7 @@ The number of bytes which this task has
 is simply the sum of bytes which this process passed to read() and pread().
 It includes things like tty IO and it is unaffected by whether or not actual
 physical disk IO was required (the read might have been satisfied from
-pagecache)
+pagecache).
 
 
 wchar
@@ -1878,7 +1877,7 @@ For more information on mount propagatio
 
 3.6	/proc/<pid>/comm  & /proc/<pid>/task/<tid>/comm
 --------------------------------------------------------
-These files provide a method to access a tasks comm value. It also allows for
+These files provide a method to access a task's comm value. It also allows for
 a task to set its own or one of its thread siblings comm value. The comm value
 is limited in size compared to the cmdline value, so writing anything longer
 then the kernel's TASK_COMM_LEN (currently 16 chars) will result in a truncated
@@ -1891,21 +1890,21 @@ This file provides a fast way to retriev
 of a task pointed by <pid>/<tid> pair. The format is a space separated
 stream of pids.
 
-Note the "first level" here -- if a child has own children they will
-not be listed here, one needs to read /proc/<children-pid>/task/<tid>/children
+Note the "first level" here -- if a child has its own children they will
+not be listed here; one needs to read /proc/<children-pid>/task/<tid>/children
 to obtain the descendants.
 
 Since this interface is intended to be fast and cheap it doesn't
 guarantee to provide precise results and some children might be
 skipped, especially if they've exited right after we printed their
-pids, so one need to either stop or freeze processes being inspected
+pids, so one needs to either stop or freeze processes being inspected
 if precise results are needed.
 
 
 3.8	/proc/<pid>/fdinfo/<fd> - Information about opened file
 ---------------------------------------------------------------
 This file provides information associated with an opened file. The regular
-files have at least three fields -- 'pos', 'flags' and mnt_id. The 'pos'
+files have at least three fields -- 'pos', 'flags' and 'mnt_id'. The 'pos'
 represents the current offset of the opened file in decimal form [see lseek(2)
 for details], 'flags' denotes the octal O_xxx mask the file has been
 created with [see open(2) for details] and 'mnt_id' represents mount ID of
@@ -1976,7 +1975,7 @@ For inotify files the format is the foll
 	flags:	02000000
 	inotify wd:3 ino:9e7e sdev:800013 mask:800afce ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:7e9e0000640d1b6d
 
-where 'wd' is a watch descriptor in decimal form, ie a target file
+where 'wd' is a watch descriptor in decimal form, i.e. a target file
 descriptor number, 'ino' and 'sdev' are inode and device where the
 target file resides and the 'mask' is the mask of events, all in hex
 form [see inotify(7) for more details].
@@ -2003,10 +2002,10 @@ For fanotify files the format is::
 where fanotify 'flags' and 'event-flags' are values used in fanotify_init
 call, 'mnt_id' is the mount point identifier, 'mflags' is the value of
 flags associated with mark which are tracked separately from events
-mask. 'ino', 'sdev' are target inode and device, 'mask' is the events
+mask. 'ino' and 'sdev' are target inode and device, 'mask' is the events
 mask and 'ignored_mask' is the mask of events which are to be ignored.
-All in hex format. Incorporation of 'mflags', 'mask' and 'ignored_mask'
-does provide information about flags and mask used in fanotify_mark
+All are in hex format. Incorporation of 'mflags', 'mask' and 'ignored_mask'
+provide information about flags and mask used in fanotify_mark
 call [see fsnotify manpage for details].
 
 While the first three lines are mandatory and always printed, the rest is
@@ -2029,7 +2028,7 @@ Timerfd files
 where 'clockid' is the clock type and 'ticks' is the number of the timer expirations
 that have occurred [see timerfd_create(2) for details]. 'settime flags' are
 flags in octal form been used to setup the timer [see timerfd_settime(2) for
-details]. 'it_value' is remaining time until the timer exiration.
+details]. 'it_value' is remaining time until the timer expiration.
 'it_interval' is the interval for the timer. Note the timer might be set up
 with TIMER_ABSTIME option which will be shown in 'settime flags', but 'it_value'
 still exhibits timer's remaining time.
@@ -2059,13 +2058,13 @@ are actually shared.
 3.10	/proc/<pid>/timerslack_ns - Task timerslack value
 ---------------------------------------------------------
 This file provides the value of the task's timerslack value in nanoseconds.
-This value specifies a amount of time that normal timers may be deferred
+This value specifies an amount of time that normal timers may be deferred
 in order to coalesce timers and avoid unnecessary wakeups.
 
-This allows a task's interactivity vs power consumption trade off to be
+This allows a task's interactivity vs power consumption tradeoff to be
 adjusted.
 
-Writing 0 to the file will set the tasks timerslack to the default value.
+Writing 0 to the file will set the task's timerslack to the default value.
 
 Valid values are from 0 - ULLONG_MAX
 
@@ -2105,10 +2104,10 @@ Example
 Description
 ~~~~~~~~~~~
 
-x86 specific entries:
+x86 specific entries
 ~~~~~~~~~~~~~~~~~~~~~
 
-AVX512_elapsed_ms:
+AVX512_elapsed_ms
 ^^^^^^^^^^^^^^^^^^
 
   If AVX512 is supported on the machine, this entry shows the milliseconds
@@ -2134,8 +2133,8 @@ AVX512_elapsed_ms:
   the task is unlikely an AVX512 user, but depends on the workload and the
   scheduling scenario, it also could be a false negative mentioned above.
 
-Configuring procfs
-------------------
+Chapter 4: Configuring procfs
+=============================
 
 4.1	Mount options
 ---------------------
@@ -2178,8 +2177,8 @@ information about processes information,
 subset=pid hides all top level files and directories in the procfs that
 are not related to tasks.
 
-5	Filesystem behavior
----------------------------
+Chapter 5: Filesystem behavior
+==============================
 
 Originally, before the advent of pid namepsace, procfs was a global file
 system. It means that there was only one procfs instance in the system.


