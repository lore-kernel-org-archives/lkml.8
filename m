Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA79AC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19F820730
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgBEPsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:48:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35877 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgBEPsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:48:42 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1izMus-0004bD-Iv; Wed, 05 Feb 2020 16:48:38 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        lijiang <lijiang@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
References: <20200128161948.8524-1-john.ogness@linutronix.de>
        <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
        <20200205044848.GH41358@google.com>
        <20200205050204.GI41358@google.com>
        <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
        <20200205063640.GJ41358@google.com> <877e11h0ir.fsf@linutronix.de>
        <20200205110522.GA456@jagdpanzerIV.localdomain>
Date:   Wed, 05 Feb 2020 16:48:32 +0100
In-Reply-To: <20200205110522.GA456@jagdpanzerIV.localdomain> (Sergey
        Senozhatsky's message of "Wed, 5 Feb 2020 20:07:44 +0900")
Message-ID: <87wo919grz.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-05, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> 3BUG: KASAN: wild-memory-access in copy_data+0x129/0x220>
> 3Write of size 4 at addr 5a5a5a5a5a5a5a5a by task cat/474>

The problem was due to an uninitialized pointer.

Very recently the ringbuffer API was expanded so that it could
optionally count lines in a record. This made it possible for me to
implement record_print_text_inline(), which can do all the kmsg_dump
multi-line madness without requiring a temporary buffer. Rather than
passing an extra argument around for the optional line count, I added
the text_line_count pointer to the printk_record struct. And since line
counting is rarely needed, it is only performed if text_line_count is
non-NULL.

I oversaw that devkmsg_open() setup a printk_record and so I did not see
to add the extra NULL initialization of text_line_count. There should be
be an initializer function/macro to avoid this danger.

John Ogness

The quick fixup:

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d0d24ee1d1f4..5ad67ff60cd9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -883,6 +883,7 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 	user->record.text_buf_size = sizeof(user->text_buf);
 	user->record.dict_buf = &user->dict_buf[0];
 	user->record.dict_buf_size = sizeof(user->dict_buf);
+	user->record.text_line_count = NULL;
 
 	logbuf_lock_irq();
 	user->seq = prb_first_seq(prb);
