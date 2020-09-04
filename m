Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E622C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 23:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267482084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 23:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yBv6nkBc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jlZDiNAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgIDX1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 19:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbgIDX1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 19:27:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E29C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 16:27:16 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599262033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EJwojlnE2s15WtGyxEEC0ksdWuHJjbLM8eHBhqQhp8Q=;
        b=yBv6nkBce73q+hz4KYoBD90PqwfisE7nPKDNd/b+1H5ORngRitHMYM9SGn6HNym/UjY71G
        pTfIxXr3dwsbB1wo5wMq/kmCK48Y15qDgWB+0rbxAoNHzylPNAZDIisXLr+D791yMtE1K4
        ePunaVcuMODXBrmTdD+ezysaGaoq8qApYB3j4bJ9SBVi0t4KXGy9PckibIBEmgNEHfdocR
        VrcAZTvFgVJDeEJm+t/qKTWOVMjsViZ/OXbB3D5pH1+Q7KxntFBdKBU2yUCzc6yhcGPqqV
        78mapU9YwkVrs7ROxgDbKzLdr6D3wQfpPUsB6ur80l93puWjIPdiz4JGAJoguw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599262033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EJwojlnE2s15WtGyxEEC0ksdWuHJjbLM8eHBhqQhp8Q=;
        b=jlZDiNAOOM+0b10Th/R+icvRew6HUukQV70WEJOFtrk9Dw040wbVG1tUXNxbYnvnUp5CTE
        0TwCYIXmBz6AL8CQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Changki Kim <changki.kim@samsung.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        changbin.du@intel.com, masahiroy@kernel.org, rd.dunlap@gmail.com,
        gregkh@linuxfoundation.org, krzk@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: printk: Add process name information to printk() output.
In-Reply-To: <20200904151336.GC20558@alley>
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com> <20200904082438.20707-1-changki.kim@samsung.com> <874kod6fgh.fsf@jogness.linutronix.de> <20200904124530.GB20558@alley> <87y2lp4r6o.fsf@jogness.linutronix.de> <20200904151336.GC20558@alley>
Date:   Sat, 05 Sep 2020 01:33:12 +0206
Message-ID: <87ft7xazsf.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-04, Petr Mladek <pmladek@suse.com> wrote:
>>> I am currently playing with support for all three timestamps based
>>> on https://lore.kernel.org/lkml/20200814101933.574326079@linutronix.de/
>>>
>>> And I got the following idea:
>>>
>>> 1. Storing side:
>>>
>>>    Create one more ring/array for storing the optional metadata.
>>>    It might eventually replace dict ring, see below.
>>>
>>>    struct struct printk_ext_info {
>>> 	u64 ts_boot;			/* timestamp from boot clock */
>>> 	u64 ts_real;			/* timestamp from real clock */
>>> 	char process[TASK_COMM_LEN];	/* process name */
>>>    };
>>>
>>>    It must be in a separate array so that struct prb_desc stay stable
>>>    and crashdump tools do not need to be updated so often.
>>>
>>>    But the number of these structures must be the same as descriptors.
>>>    So it might be:
>>>
>>>    struct prb_desc_ring {
>>> 	unsigned int		count_bits;
>>> 	struct prb_desc		*descs;
>>> 	struct printk_ext_info  *ext_info
>>> 	atomic_long_t		head_id;
>>> 	atomic_long_t		tail_id;
>>>    };
>>>
>>>    One huge advantage is that these extra information would not block
>>>    pushing lockless printk buffer upstream.
>>>
>>>    It might be even possible to get rid of dict ring and just
>>>    add two more elements into struct printk_ext_info:
>>>
>>> 	  char subsystem[16];	/* for SUBSYSTEM= dict value */
>>> 	  char device[48];	/* for DEVICE= dict value */
>
> From my POV, if we support 3 timestamps then they must be stored
> reliably. And dict ring is out of the game.

Agreed. I am just trying to think of how to better manage the strings,
which currently are rare and optional. That is where the dict_ring
becomes interesting.

Perhaps we should use both the fixed structs with the variable
dict_ring. printk_ext_info could look like this:

struct struct printk_ext_info {
    u64 ts_boot;
    u64 ts_real;
    char *process;
    char *subsystem;
    char *device;
};

And @process, @subsystem, @device could all point to null-terminated
trings within the dict_ring. So printk.c code looks something like this:

size_t process_sz = strlen(process) + 1;
size_t subsystem_sz = strlen(subsystem) + 1;
size_t device_sz = strlen(device) + 1;
struct prb_reserved_entry e;
struct printk_record r;
char *p;

prb_rec_init_wr(&r, text_len, process_sz + subsystem_sz + device_sz);
prb_reserve(&e, prb, &r);

memcpy(r.text_buf, text, text_len);
r.info->text_len = text_len;

/* guaranteed ext data */
r.ext_info->ts_boot = time_boot();
r.ext_info->ts_real = time_real();

/* optional ext data */
if (r.dict_buf) {
    p = r.dict_buf;

    memcpy(p, process, process_sz);
    r.ext_info->process = p;
    p += process_sz;
    
    memcpy(p, subsystem, subsystem_sz);
    r.ext_info->subsystem = p;    
    p += subsystem_sz;
    
    memcpy(p, device, device_sz);
    r.ext_info->device = p;

    r.info->dict_len = process_sz + subsystem_sz + device_sz;
}

> And I am not comfortable even with the current dictionary handling.
> I already wrote this somewhere. The following command is supposed
> to show all kernel messages printed by "pci" subsystem:
>
> 	$> journalctl _KERNEL_SUBSYSTEM=pci
>
> It will be incomplete when the dictionary metadata were not saved.

In that case, perhaps @subsystem should be a static array in
printk_ext_info instead.

> Regarding the waste of space. The dict ring currently has the same
> size as the text ring. It is likely a waste of space as well. Any
> tuning is complicated because it depends on the use case.

The whole point of the dict_ring is that it allows for variable length
_optional_ data to be stored. If we decide there is no optional data,
then dict_ring is not needed.

> The advantage of the fixed @ext_info[] array is that everything is
> clear, simple, and predictable (taken space and name length limits).
> We could easily tell users what they will get for a given cost.

Agreed. For non-optional data (such as your timestamps), I am in full
agreement that a fixed array is the way to go. And it would only require
a couple lines of code added to the ringbuffer.

My concern is if we need to guarantee space for all possible dictionary
data of all records. I think the dict_ring can be very helpful here.

John Ogness
