Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28423C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 12:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001E02073A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 12:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b/eh4WHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgGRMLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 08:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgGRMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 08:11:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E78C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 05:11:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so13683124wrm.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 05:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yd988VmnLN/Evex/lk7gxM8L3Wlcp7x47UNg48SVZhM=;
        b=b/eh4WHmjFhZP0lwcUYhjcYOR8wTV6RAZwQKbcCPlico2mH9f4EbZh42If1ty39AEh
         py+pffvII5FYXMWYnxdnLiDX8d8pxCqRwDDKXqOSuBXxr12eUcogk0D4zDcXH/qB6pNB
         8diikFnmQnqRAMus0TynztvS1hvlLcQ5SeLm27TUesbXVqHxUJrirp+Ifqj7URnxyugn
         QtZ0QNTlW3CW7slDK84XxSymljY77Fz8ee8IJnN9sUW0WzoWx6VXfDXC0UBC3OMkzHxv
         BlGIJXrNFnmMya7/R2ddpeE8RDRtKbjZglC4KHbtC9zk5rG26lPkYpApgwIL47lbIcpW
         0J9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yd988VmnLN/Evex/lk7gxM8L3Wlcp7x47UNg48SVZhM=;
        b=qRZPR0gE/PamieNstH9gKSgqKPUnKQq0AQMVKdw/w548EKUf/mq+gkzFGkBXHlcj7v
         Y8YB1/bjx/ByvYb/wo84n5l6hWsAFzNzMs5betGfaZuMK00MoLwNjCdhTeXgQ4AyQIIl
         MioOC/rYODHBlgvbEjXJsdNnQg/7DzQnSbb3F7YaZ0m5IT/pFa0sT0sh1au9Po5duM+/
         QkvDz/oip1HdZGGZoVIVj+b/V0cmcdEWHtA0ZfhNF3w1qULUZKJ81TeDF+E7HsxzhY+n
         pxiWpNzhn1ShBgMWuod0cVAEvK0kwYqA4m5UWbOGgEkVLaAOwxT2ZRd66zY5EBIBuFAY
         oglA==
X-Gm-Message-State: AOAM533DeL7IjOsWj6sRAXvnFXmtYH9AuUYOwnvAAljU/5wlvx+ixiYY
        VZ9hdGRTUZgBfGaHMZ2CI68/Qw==
X-Google-Smtp-Source: ABdhPJyLfO3AL55wPirTmxrm3z08HD177j/RU5fw3FeXuGovsuT8lCG++lB0Gqs/O6ZRHDDUDiLm5g==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr13994838wrv.162.1595074259455;
        Sat, 18 Jul 2020 05:10:59 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id h199sm20123027wme.42.2020.07.18.05.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 05:10:58 -0700 (PDT)
Date:   Sat, 18 Jul 2020 14:10:53 +0200
From:   Marco Elver <elver@google.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] printk: use the lockless ringbuffer
Message-ID: <20200718121053.GA691245@elver.google.com>
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709132344.760-5-john.ogness@linutronix.de>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 03:29PM +0206, John Ogness wrote:
> Replace the existing ringbuffer usage and implementation with
> lockless ringbuffer usage. Even though the new ringbuffer does not
> require locking, all existing locking is left in place. Therefore,
> this change is purely replacing the underlining ringbuffer.
> 
> Changes that exist due to the ringbuffer replacement:
> 
> - The VMCOREINFO has been updated for the new structures.
> 
> - Dictionary data is now stored in a separate data buffer from the
>   human-readable messages. The dictionary data buffer is set to the
>   same size as the message buffer. Therefore, the total required
>   memory for both dictionary and message data is
>   2 * (2 ^ CONFIG_LOG_BUF_SHIFT) for the initial static buffers and
>   2 * log_buf_len (the kernel parameter) for the dynamic buffers.
> 
> - Record meta-data is now stored in a separate array of descriptors.
>   This is an additional 72 * (2 ^ (CONFIG_LOG_BUF_SHIFT - 5)) bytes
>   for the static array and 72 * (log_buf_len >> 5) bytes for the
>   dynamic array.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

It seems this causes a regression observed at least with newline-only
printks. I noticed this during -next testing because various debugging
tools (K*SAN, lockdep, etc.) use e.g. pr_{err,warn,info}("\n") to format
reports.

Without wanting to wait for a report from one of these debugging tools,
a simple reproducer is below. Without this patch, the expected newline
is printed.

Thanks,
-- Marco

------ >8 ------

--- a/init/main.c
+++ b/init/main.c
@@ -1039,6 +1039,10 @@ asmlinkage __visible void __init start_kernel(void)
 	sfi_init_late();
 	kcsan_init();
 
+	pr_info("EXPECT BLANK LINE --vv\n");
+	pr_info("\n");
+	pr_info("EXPECT BLANK LINE --^^\n");
+
 	/* Do the rest non-__init'ed, we're now alive */
 	arch_call_rest_init();
 
