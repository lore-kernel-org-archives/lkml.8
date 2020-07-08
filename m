Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03AEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C2C2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="34KLThHp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SySxJPDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgGHNSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbgGHNSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:18:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD99C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 06:18:23 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594214301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZUazG+j+kI1930BTbc0/bqv2TsWNNEbE1MGkVz6uV9s=;
        b=34KLThHpioqqC54Kgwrqzjn+OlkcE7fTctzXYyiEmCD5k1r/80a6oTqMNHmEVxtyuX0lfv
        6VChSEW+1KTZr8loA28XGwIIk9aSaKGi391iGQH1soEHK62xHmwbD2ndFSao5QiHgbBaWD
        mRy9trtqx1jMnROXB2DPHCEvchp1EbDcwFXL7VLxavaese5Sp81SpP2wd9jsgfKLtn6Dsj
        8kd07xmlaRvay4zHwfPmPgbRgteZyySxtTtprHMQsHLTcyFdroFCyIjY/xgYkRxRzWiQlc
        FNQf2FWRhnY7maM8QUL7EKr7Xe5Xg9NTSlFYwwIqr7/U5D+wtpIL1vTNZeWjcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594214301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZUazG+j+kI1930BTbc0/bqv2TsWNNEbE1MGkVz6uV9s=;
        b=SySxJPDKr98X19wC70QSlsUPzdFnfZ1w5ZNtBMr/772LxZUCQndO9IOCNA8sfKJb8ZpSo9
        GF6KtY3H2TMV77CQ==
To:     kernel test robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] printk: use the lockless ringbuffer
In-Reply-To: <202007080356.fSb8SLZk%lkp@intel.com>
References: <20200707145932.8752-5-john.ogness@linutronix.de> <202007080356.fSb8SLZk%lkp@intel.com>
Date:   Wed, 08 Jul 2020 15:24:20 +0206
Message-ID: <87r1tmcfhf.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix prepared for for v5.

On 2020-07-08, kernel test robot <lkp@intel.com> wrote:
>>> kernel/printk/printk.c:1146:10: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
>                           new_descs_size);
>                           ^~~~~~~~~~~~~~
>    include/linux/printk.h:338:33: note: expanded from macro 'pr_err'
>            printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>                                   ~~~     ^~~~~~~~~~~
>    1 warning generated.

Reported-by: kernel test robot <lkp@intel.com>

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index de8d54be4115..0b1337f4188c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1142,7 +1142,7 @@ void __init setup_log_buf(int early)
 	new_descs_size = new_descs_count * sizeof(struct prb_desc);
 	new_descs = memblock_alloc(new_descs_size, LOG_ALIGN);
 	if (unlikely(!new_descs)) {
-		pr_err("log_buf_len: %lu desc bytes not available\n",
+		pr_err("log_buf_len: %zu desc bytes not available\n",
 		       new_descs_size);
 		memblock_free(__pa(new_dict_buf), new_log_buf_len);
 		memblock_free(__pa(new_log_buf), new_log_buf_len);
