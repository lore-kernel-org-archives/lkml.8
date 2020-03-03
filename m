Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF51C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D0F2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HuvM+W94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgCCQ6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:58:49 -0500
Received: from mail.efficios.com ([167.114.26.124]:41744 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgCCQ6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:58:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9120D264E64;
        Tue,  3 Mar 2020 11:58:47 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rOfh5bAYWAUr; Tue,  3 Mar 2020 11:58:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2C07D264E63;
        Tue,  3 Mar 2020 11:58:47 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2C07D264E63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583254727;
        bh=IN+d9D3jOBZ17QKKFb5h3jUX+pZ2F6Dvnov6ZoaYUtI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=HuvM+W94C7oO9MMQWyefYdT2B2o6q84eeAh1LCL5nrvYEKWBbC6ZDJ0zqakTbFpmo
         1sHOgIy3uMzmgu1xBKJmiqbBU4gsYZCna5MGDC4BnJz9hY+9Fp6qBpPwxvcdHXt+gD
         OVDYkf9ckb0lV/rrxzBu7U2TaXCl8XCbd3QVXbxuT58VUt4H76OswRnNvY8vFj/hZM
         HPgcuQwqspVrPR+jgBP5nyBumVUE+rrCpvTaBzZRQJfBhm0Vo7M7K5EW0aCE5r6LNJ
         EyKO3XtHBnIZc0HXP/KPG7KifdqYh5mn62JyDvTI/jhTohK7sIgp4QAC8BqWBFJXlD
         EM2fqUfGS5Zeg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9FZLOMf3N0LS; Tue,  3 Mar 2020 11:58:47 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1A27D264E62;
        Tue,  3 Mar 2020 11:58:47 -0500 (EST)
Date:   Tue, 3 Mar 2020 11:58:47 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        K <prasad@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Quentin Perret <qperret@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        rostedt <rostedt@goodmis.org>
Message-ID: <34829202.16720.1583254727026.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200303065735.GA1172591@kroah.com>
References: <20200221114404.14641-1-will@kernel.org> <20200302192811.n6o5645rsib44vco@localhost> <20200302193658.GA272023@kroah.com> <20200302193957.GA276441@kroah.com> <1183544004.13859.1583180227118.JavaMail.zimbra@efficios.com> <20200303065735.GA1172591@kroah.com>
Subject: Re: [PATCH 0/3] Unexport kallsyms_lookup_name() and
 kallsyms_on_each_symbol()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: Unexport kallsyms_lookup_name() and kallsyms_on_each_symbol()
Thread-Index: UzWo64vliP0RjVx637ZWPKBQifr+4A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 3, 2020, at 1:57 AM, Greg Kroah-Hartman gregkh@linuxfoundation.org wrote:

> On Mon, Mar 02, 2020 at 03:17:07PM -0500, Mathieu Desnoyers wrote:
>> ----- On Mar 2, 2020, at 2:39 PM, Greg Kroah-Hartman gregkh@linuxfoundation.org
>> wrote:
>> 
>> > On Mon, Mar 02, 2020 at 08:36:58PM +0100, Greg Kroah-Hartman wrote:
[...]
>> >> 
>> >> I hate to ask, but why does anyone need block_class?  or disk_name or
>> >> disk_type?  I need to put them behind a driver core namespace or
>> >> something soon...
>> > 
>> 
>> In LTTng, we have a "statedump" which dumps all the relevant state of
>> the kernel at trace start (or when the user asks for it) into the
>> kernel trace. It is used to collect information which helps translating
>> compact numeric data into human-readable information at post-processing.
>> 
>> For block devices, the statedump contains the mapping between the
>> device number and the disk name [1]. It uses the "block_class",
>> "disk_name", and "disk_type" symbols for this. Here is the
>> post-processing output:
>> 
>> [14:48:41.388934812] (+?.?????????) compudjdev lttng_statedump_block_device: {
>> cpu_id = 0 }, { dev = 1048576, diskname = "ram0" }
>> [...]
>> [14:48:41.442548745] (+0.003574998) compudjdev lttng_statedump_block_device: {
>> cpu_id = 0 }, { dev = 1048591, diskname = "ram15" }
>> [14:48:41.446064977] (+0.003516232) compudjdev lttng_statedump_block_device: {
>> cpu_id = 0 }, { dev = 265289728, diskname = "vda" }
>> [14:48:41.449579781] (+0.003514804) compudjdev lttng_statedump_block_device: {
>> cpu_id = 0 }, { dev = 265289729, diskname = "vda1" }
>> [14:48:41.453113808] (+0.003534027) compudjdev lttng_statedump_block_device: {
>> cpu_id = 0 }, { dev = 265289744, diskname = "vdb" }
>> [14:48:41.456640876] (+0.003527068) compudjdev lttng_statedump_block_device: {
>> cpu_id = 0 }, { dev = 265289745, diskname = "vdb1" }
>> 
>> This information is then used in our I/O analyses to show information
>> comprehensible to a user.
> 
> But all of that is availble to you today in userspace, why dig through
> random kernel symbols?
> 
> Look in /sys/dev/block/ or in /sys/block/ for all of that information.
> Is there something that you can only find by the internal symbols that
> is not present today in sysfs?

There is indeed additional information we are getting by iterating
directly on the data structures and emitting tracepoints from within the
kernel which is lost when we copy the data to user-space: the time-stamp
at which the data is observed.

Please note that the statedump approach is applied not only to block
devices, but also to namespaces, thread scheduling, process memory
mappings, file descriptor tables, interrupt handlers, network
interfaces, and cpu topology. Those are more or less long running states
which can change dynamically while a trace is being recorded. Our trace 
post-processing tools model the overall kernel state over time by
reconciling tracepoints tracking all state changes (e.g.
insertions/removals) with the statedump information. The time-stamps
available for both state-change events and statedump events is what
allow us to do this modeling.

In the case of block/genhd.c, we care about the mapping between the
device number and the disk name, which is something which can be changed
dynamically, and is thus valid for a given time-range in the trace.

What we are trying to ensure is to gather all the relevant information
to allow trace analyses to re-create a precise model of the kernel
through time. In the case of genhd, that would be tuples of mapping
between device number and name, which are valid for given time-ranges.

These are recorded by the "lttng_statedump_block_device" event, which
has a timestamp generated by the LTTng tracer, along with the
(device_nr, disk_name) event payload. You will notice from what I stated 
above that we are missing information about disks being 
registered/unregistered later in the trace. Ideally, we would also like
to add tracepoints into register_disk() and del_gendisk() (or more
relevant functions nearby) to trace those state changes. We have those
state-change tracking tracepoints in other subsystems, but unfortunately
not in the block layer.

This information is then used at post-processing to augment the block
events (see include/trace/block.h) to convert the device numbers to
human-readable strings. It is also used to provide human-readable
rows, columns and graph labels when presenting block I/O state over
time, and aggregated summary, on a per disk basis.

If we would instead go through sysfs to export this block device
information, we end up copying the relevant information to user-space,
and only then write the data into a trace buffer. There ends up being a
delay between the point at which the state is observed within the kernel
and the sampling of the time-stamp describing when it occurs, which
introduces many interesting race scenarios where disk
registration/unregistration happens in parallel with a statedump and
block device activity emitting tracepoints into the trace. We lose the
ability to provide a reliable time-range for which the mapping between
(device_nr, disk_name) is valid. Going through uevent also lacks
time-stamp consistency with the block tracepoint events.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
