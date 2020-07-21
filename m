Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2EAC433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E14642077D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P3PuuKNk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OQCTim2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgGUKbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbgGUKa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:30:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A73C0619D8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:30:57 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595327455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qOVLaqXa4p0kjzp5+1KGLHc1IcglR9RSNi8fA+3plcY=;
        b=P3PuuKNkQwFzaw//Nry6ahwvQnLY2SJ8BqcHwjr7aSnt7a43pJ2uFkWre9bSfLhUwrm/Qi
        Bpnh3VFxZjXpkyRD4i4sPNEQQPPIjW7wplh+XEgRhnYgFL1vhRmktVXMBb+6ettEz+UmLU
        4adfncFuEhmRh4L5wmAIzagstFOlSaTZ9h+ca9jZxVH5NBnb/0LITEIuQ6syjxGPIZbGOW
        Vb5C3k+RGwxEGpYuAfgLHuNhKSie2JCj3m4ZmgqsdLDS1ehTSl7kNcxV/eS/MouOZy3R07
        4Ouv4MzTtiiaPVasGEmezobdjiXSiIx/ft+bvhvVW8JlX7h612Wql+AISqugWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595327455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qOVLaqXa4p0kjzp5+1KGLHc1IcglR9RSNi8fA+3plcY=;
        b=OQCTim2uTJ34LKp/UbgncHr6wkLvLCAL/9EFsc1GPYW0JjWtDlWGfAORenoO1XIpVx+J+d
        xaEci8eEzojxQtDA==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] printk: ringbuffer: support dataless records
In-Reply-To: <20200721025450.GA5678@jagdpanzerIV.localdomain>
References: <20200720140111.19935-1-john.ogness@linutronix.de> <20200721025450.GA5678@jagdpanzerIV.localdomain>
Date:   Tue, 21 Jul 2020 12:36:55 +0206
Message-ID: <87lfjdw468.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-21, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>> @@ -1402,7 +1396,9 @@ static int prb_read(struct printk_ringbuffer *rb, u64 seq,
>>  	/* Copy text data. If it fails, this is a data-less record. */
>>  	if (!copy_data(&rb->text_data_ring, &desc.text_blk_lpos, desc.info.text_len,
>>  		       r->text_buf, r->text_buf_size, line_count)) {
>> -		return -ENOENT;
>> +		/* Report an error if there should have been data. */
>> +		if (desc.info.text_len != 0)
>> +			return -ENOENT;
>>  	}
>
> If this is a dataless record then should copy_data() return error?

You are correct. That makes more sense. I will send a v2.

John Ogness
