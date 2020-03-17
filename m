Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBA8C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116BE206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lpy1jRID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgCQLqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:46:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48137 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbgCQLqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584445582;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=qO0r+g91EGEGj/zcdZdMsM2EvLOuwtSwchtcsU4KDz4=;
        b=Lpy1jRIDKgWmeLgvG0vpl+7qJgKQqkw6jZTWracd9/djaAxx7yuauBFTBBiJcfj9TPRnE4
        G8/W4bN5oY1Ga+zqOGnNOx4fbp9dy3sdhTxzV+NVwwfKVVktdFAe+wIR3dyqkaDamy1DVR
        d8hc9T5uUNl086xJ5EdaOLab8BKpHpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-WwYYv83yPCevSbzM2-hkrA-1; Tue, 17 Mar 2020 07:46:16 -0400
X-MC-Unique: WwYYv83yPCevSbzM2-hkrA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D983C800D4E;
        Tue, 17 Mar 2020 11:46:14 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-112-22.ams2.redhat.com [10.36.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 693D26E3EE;
        Tue, 17 Mar 2020 11:46:14 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.15.2/8.15.2) with ESMTP id 02HBkBZb008460;
        Tue, 17 Mar 2020 12:46:11 +0100
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.15.2/8.15.2/Submit) id 02HBk5pw008459;
        Tue, 17 Mar 2020 12:46:05 +0100
Date:   Tue, 17 Mar 2020 12:46:05 +0100
From:   Jakub Jelinek <jakub@redhat.com>
To:     Sergei Trofimovich <slyfox@gentoo.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: Re: [PATCH] x86: fix early boot crash on gcc-10
Message-ID: <20200317114605.GG2156@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20200314164451.346497-1-slyfox@gentoo.org>
 <20200316130414.GC12561@hirez.programming.kicks-ass.net>
 <20200316132648.GM2156@tucnak>
 <20200316221251.7b4f5801@sf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316221251.7b4f5801@sf>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 10:12:51PM +0000, Sergei Trofimovich wrote:
> In case you are still interested in preprocessed files and results I've collected
> all the bits in a single tarball:
>     https://dev.gentoo.org/~slyfox/bugs/linux-gcc-10-boot-2020-03-14.tar.gz
> Same available in separate files in:
>     https://dev.gentoo.org/~slyfox/bugs/linux-gcc-10-boot-2020-03-14/

Thanks, that is helpful.
So, a few comments.

One thing I've noticed in the command line is that
--param=allow-store-data-races=0
got dropped.  That is fine, the parameter is gone, but it has been replaced
in https://gcc.gnu.org/PR92046 by the
-fno-allow-store-data-races
option.  Like the param which defaulted to 0 and has been enabled only with
-Ofast this option is also -fno-allow-store-data-races by default unless
-Ofast, but if kernel wanted to be explicit or make sure not to introduce
them even with -Ofast, I'd say it should:
 # Tell gcc to never replace conditional load with a non-conditional one
 KBUILD_CFLAGS   += $(call cc-option,--param=allow-store-data-races=0)
+KBUILD_CFLAGS   += $(call cc-option,-fno-allow-store-data-races)
in the toplevel Makefile.

The actual change that causes cpu_startup_entry to be tail called in GCC 10
was my https://gcc.gnu.org/PR59813 https://gcc.gnu.org/PR89060
https://gcc.gnu.org/r10-230-gab87ac8d53f3d903bfc9eeb0f0b5e7eed1f38cbc
optimization.  Previously, GCC punted just because it saw some earlier call
which passed address of some automatic variable to some other function and
escaped it that way (and could be possibly used during the function
considered for tail call, thus making the tail call not possible as with
tail call the frame is gone then).  Now, GCC tries to use information about
scopes to determine that eventhough some automatic variables can escape that
way, if they aren't in the scope anymore during the last call, they
shouldn't be problematic.  There are two variables that prevented the tail
call optimization in the past it seems, int cpuid; in smp_callin function
which is inlined, then its address escapes:
__dynamic_pr_debug(&__UNIQUE_ID_ddebug114, "smpboot" ": " "Stack at about %p\n", &cpuid);
and then cpuid goes out of scope.
Similarly, the u64 canary; variable in boot_init_stack_canary which is also
inlined.  The address escapes in
get_random_bytes(&canary, sizeof(canary));
and later on is used and eventually goes out of scope.
Finally, there is the cpu_startup_entry call at the end of function.

Regarding the reason why GCC doesn't tailcall noreturn functions, that is a
deliberate decision, often that results in shorter code (there is no need to
restore stack etc. before the call and because it is noreturn, anything
after the call can be thrown away as unreachable) and more importantly,
results in more useful backtraces when something calls abort etc.

Hope this helps.

	Jakub

