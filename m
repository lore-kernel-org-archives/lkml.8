Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFEAC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2A02187F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Enc+4Ffz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgCBURK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:17:10 -0500
Received: from mail.efficios.com ([167.114.26.124]:54650 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgCBURJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:17:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B07D02433D8;
        Mon,  2 Mar 2020 15:17:07 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LioklzsSvCIl; Mon,  2 Mar 2020 15:17:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 475E1243444;
        Mon,  2 Mar 2020 15:17:07 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 475E1243444
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583180227;
        bh=vUQHSN2S8pO8DYDTLlHsHq6yUAxZUvhQdiudOhqhxns=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Enc+4Ffz7rCzbWymLqCB6N6ph3xhXCJBXojVPGYxIDDoxxOebgcZpVOHxEasZ6sIP
         r9KjnjgBZSjPeu1bj7WPWY3BrM99zDRaXSQUXDN28LB82qExEqIQ4inr4SuGrE63ra
         b7DzPecMSl0fsOYIBSJvLvKXvdcla9bJyqaxQQo7lH6xSJa31baO9H1THau3PDfmtK
         02ey1lKCGG0d0dLhu7MR+Io95626cR7xN0bxvOuel3DykiDqNcXEFhcN0UCmrlV3Ue
         E3caFiG2m15vWq0aqSYevHodOlualByFdofaOiS/jVJE9cdQ5AA8X40m0dsMSUovEV
         wbY7GREUcla1w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id i8EEFes_nu-J; Mon,  2 Mar 2020 15:17:07 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 34EA52434AD;
        Mon,  2 Mar 2020 15:17:07 -0500 (EST)
Date:   Mon, 2 Mar 2020 15:17:07 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Quentin Perret <qperret@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        rostedt <rostedt@goodmis.org>
Message-ID: <1183544004.13859.1583180227118.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200302193957.GA276441@kroah.com>
References: <20200221114404.14641-1-will@kernel.org> <20200302192811.n6o5645rsib44vco@localhost> <20200302193658.GA272023@kroah.com> <20200302193957.GA276441@kroah.com>
Subject: Re: [PATCH 0/3] Unexport kallsyms_lookup_name() and
 kallsyms_on_each_symbol()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: Unexport kallsyms_lookup_name() and kallsyms_on_each_symbol()
Thread-Index: fos3cr6ROn/KiR3DQsae2mE8DEbr3Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 2, 2020, at 2:39 PM, Greg Kroah-Hartman gregkh@linuxfoundation.org wrote:

> On Mon, Mar 02, 2020 at 08:36:58PM +0100, Greg Kroah-Hartman wrote:
>> On Mon, Mar 02, 2020 at 02:28:11PM -0500, Mathieu Desnoyers wrote:
>> > On 21-Feb-2020 11:44:01 AM, Will Deacon wrote:
>> > > Hi folks,
>> > > 
>> > > Despite having just a single modular in-tree user that I could spot,
>> > > kallsyms_lookup_name() is exported to modules and provides a mechanism
>> > > for out-of-tree modules to access and invoke arbitrary, non-exported
>> > > kernel symbols when kallsyms is enabled.
>> > > 
>> > > This patch series fixes up that one user and unexports the symbol along
>> > > with kallsyms_on_each_symbol(), since that could also be abused in a
>> > > similar manner.
>> > 
>> > Hi,
>> > 
>> > I maintain a GPL kernel tracer (LTTng) since 2005 which happens to be
>> > out-of-tree, even though we have made unsuccessful attempts to upstream
>> > it in the past. It uses kallsyms_lookup_name() to fetch a few symbols. I
>> > would be very glad to have them GPL-exported upstream rather than
>> > relying on this work-around. Here is the list of symbols we would need
>> > to GPL-export:
>> > 
>> > stack_trace_save
>> > stack_trace_save_user
>> > vmalloc_sync_all (CONFIG_X86)
>> > get_pfnblock_flags_mask
>> > disk_name
>> > block_class
>> > disk_type
>> 
>> I hate to ask, but why does anyone need block_class?  or disk_name or
>> disk_type?  I need to put them behind a driver core namespace or
>> something soon...
> 

In LTTng, we have a "statedump" which dumps all the relevant state of
the kernel at trace start (or when the user asks for it) into the
kernel trace. It is used to collect information which helps translating
compact numeric data into human-readable information at post-processing.

For block devices, the statedump contains the mapping between the
device number and the disk name [1]. It uses the "block_class",
"disk_name", and "disk_type" symbols for this. Here is the
post-processing output:

[14:48:41.388934812] (+?.?????????) compudjdev lttng_statedump_block_device: { cpu_id = 0 }, { dev = 1048576, diskname = "ram0" }
[...]
[14:48:41.442548745] (+0.003574998) compudjdev lttng_statedump_block_device: { cpu_id = 0 }, { dev = 1048591, diskname = "ram15" }
[14:48:41.446064977] (+0.003516232) compudjdev lttng_statedump_block_device: { cpu_id = 0 }, { dev = 265289728, diskname = "vda" }
[14:48:41.449579781] (+0.003514804) compudjdev lttng_statedump_block_device: { cpu_id = 0 }, { dev = 265289729, diskname = "vda1" }
[14:48:41.453113808] (+0.003534027) compudjdev lttng_statedump_block_device: { cpu_id = 0 }, { dev = 265289744, diskname = "vdb" }
[14:48:41.456640876] (+0.003527068) compudjdev lttng_statedump_block_device: { cpu_id = 0 }, { dev = 265289745, diskname = "vdb1" }

This information is then used in our I/O analyses to show information
comprehensible to a user.

> Wait, disk_type is a static variable.  And there's multiple ones of
> them, how does that work?

Yes, this is far from ideal. Here are the ones I observe in the kernel
sources:

block/genhd.c
40:static const struct device_type disk_type;   <---- the one we use

lib/raid6/test/test.c
41:static char disk_type(int d)  <---- this is a stand-alone user-space test program, not part of the kernel image.

crypto/async_tx/raid6test.c (depends on CONFIG_ASYNC_RAID6_TEST)
44:static char disk_type(int d, int disks) <---- the compiler optimizes away this function, so this symbol is not present in the kernel image.

I think a better approach to solve this would be to implement and expose an
iterator function in the core kernel which could invoke a callback. However,
the main issue remains: if the only user is out-of-tree, I cannot justify
adding an exported kernel helper for this.

Thanks,

Mathieu

[1] https://github.com/lttng/lttng-modules/blob/master/lttng-statedump-impl.c#L125

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
