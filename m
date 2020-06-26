Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5E0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A00E206E9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgFZPC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgFZPC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:02:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74B3C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:02:58 -0700 (PDT)
Received: from p508752b4.dip0.t-ipconnect.de ([80.135.82.180] helo=vostro)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jopsU-0005A7-V7; Fri, 26 Jun 2020 17:02:55 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: buffer allocation: was: [PATCH v3 3/3] printk: use the lockless ringbuffer
References: <20200618144919.9806-1-john.ogness@linutronix.de>
        <20200618144919.9806-4-john.ogness@linutronix.de>
        <20200625082838.GF6156@alley>
Date:   Fri, 26 Jun 2020 17:02:48 +0200
In-Reply-To: <20200625082838.GF6156@alley> (Petr Mladek's message of "Thu, 25
        Jun 2020 10:28:38 +0200")
Message-ID: <87sgeh3m5j.fsf@jogness.linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-25, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1176,11 +1068,46 @@ static void __init set_percpu_data_ready(void)
>>  	__printk_percpu_data_ready = true;
>>  }
>>  
>> +static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
>> +				     struct printk_record *r)
>> +{
>> +	struct prb_reserved_entry e;
>> +	struct printk_record dest_r;
>> +
>> +	prb_rec_init_wr(&dest_r, r->info->text_len, r->info->dict_len);
>> +
>> +	if (!prb_reserve(&e, rb, &dest_r))
>> +		return 0;
>> +
>> +	memcpy(&dest_r.text_buf[0], &r->text_buf[0], dest_r.text_buf_size);
>> +	if (dest_r.dict_buf) {
>> +		memcpy(&dest_r.dict_buf[0], &r->dict_buf[0],
>> +		       dest_r.dict_buf_size);
>> +	}
>> +	dest_r.info->facility = r->info->facility;
>> +	dest_r.info->level = r->info->level;
>> +	dest_r.info->flags = r->info->flags;
>> +	dest_r.info->ts_nsec = r->info->ts_nsec;
>> +	dest_r.info->caller_id = r->info->caller_id;
>> +
>> +	prb_commit(&e);
>> +
>> +	return prb_record_text_space(&e);
>> +}
>> +
>> +static char setup_text_buf[CONSOLE_EXT_LOG_MAX] __initdata;
>> +static char setup_dict_buf[CONSOLE_EXT_LOG_MAX] __initdata;
>> +
>>  void __init setup_log_buf(int early)
>>  {
>> +	struct prb_desc *new_descs;
>> +	struct printk_info info;
>> +	struct printk_record r;
>>  	unsigned long flags;
>> +	char *new_dict_buf;
>>  	char *new_log_buf;
>>  	unsigned int free;
>> +	u64 seq;
>>  
>>  	/*
>>  	 * Some archs call setup_log_buf() multiple times - first is very
>> @@ -1201,17 +1128,50 @@ void __init setup_log_buf(int early)
>>  
>>  	new_log_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
>>  	if (unlikely(!new_log_buf)) {
>> -		pr_err("log_buf_len: %lu bytes not available\n",
>> +		pr_err("log_buf_len: %lu text bytes not available\n",
>>  			new_log_buf_len);
>>  		return;
>>  	}
>>  
>> +	new_dict_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
>> +	if (unlikely(!new_dict_buf)) {
>> +		/* dictionary failure is allowed */
>> +		pr_err("log_buf_len: %lu dict bytes not available\n",
>> +			new_log_buf_len);
>> +	}
>> +
>> +	new_descs = memblock_alloc((new_log_buf_len >> PRB_AVGBITS) *
>> +				   sizeof(struct prb_desc), LOG_ALIGN);
>> +	if (unlikely(!new_descs)) {
>> +		pr_err("log_buf_len: %lu desc bytes not available\n",
>> +			new_log_buf_len >> PRB_AVGBITS);
>> +		if (new_dict_buf)
>> +			memblock_free(__pa(new_dict_buf), new_log_buf_len);
>> +		memblock_free(__pa(new_log_buf), new_log_buf_len);
>> +		return;
>> +	}
>> +
>> +	prb_rec_init_rd(&r, &info,
>> +			&setup_text_buf[0], sizeof(setup_text_buf),
>> +			&setup_dict_buf[0], sizeof(setup_dict_buf));
>> +
>>  	logbuf_lock_irqsave(flags);
>> +
>> +	prb_init(&printk_rb_dynamic,
>> +		 new_log_buf, bits_per(new_log_buf_len) - 1,
>> +		 new_dict_buf, bits_per(new_log_buf_len) - 1,
>
> This does not check whether new_dict_buf was really allocated.

Thank you.

> I suggest to make it easy and switch to the new buffers only when
> all three could get allocated.

Agreed.

> Well, I still feel a bit uneasy about these PRB_AVGBITS operations,
> including new_log_buf_len >> PRB_AVGBITS used above.
>
> A more safe design would be to add some sanity checks at the beginning
> of the function. And maybe convert new_log_buf_let to number of bits.
> Then operate with the number of bits in the rest of the function.  It
> might be easier to make sure that we are on the safe side.

I will clean it up with additional checks and temporary variables.

>>  	log_buf_len = new_log_buf_len;
>>  	log_buf = new_log_buf;
>>  	new_log_buf_len = 0;
>> -	free = __LOG_BUF_LEN - log_next_idx;
>> -	memcpy(log_buf, __log_buf, __LOG_BUF_LEN);
>> +
>> +	free = __LOG_BUF_LEN;
>> +	prb_for_each_record(0, &printk_rb_static, seq, &r)
>> +		free -= add_to_rb(&printk_rb_dynamic, &r);
>> +
>> +	prb = &printk_rb_dynamic;
>
> This might deserve a comment that this is safe (no lost message)
> because it is called early enough when everything is still running
> on the boot CPU.

I will add a comment and an extra check to make sure.

Once everything is lockless, new messages could appear (for example, due
to NMI messages). The simple check should probably change to a loop. But
let us not worry about that at this point.

Below is a new version of the relevant patch snippets against mainline
just to show you how I plan to make it look for the next version.

John Ogness

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ @@
+#define PRB_AVGBITS 5	/* 32 character average length */
+
+#if CONFIG_LOG_BUF_SHIFT <= PRB_AVGBITS
+#error CONFIG_LOG_BUF_SHIFT value too small.
+#endif
+_DEFINE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
+		 PRB_AVGBITS, PRB_AVGBITS, &__log_buf[0]);
+
@@ @@
 void __init setup_log_buf(int early)
 {
+	unsigned int new_descs_count;
+	struct prb_desc *new_descs;
+	struct printk_info info;
+	struct printk_record r;
+	size_t new_descs_size;
 	unsigned long flags;
+	char *new_dict_buf;
 	char *new_log_buf;
 	unsigned int free;
+	u64 seq;
 
 	/*
 	 * Some archs call setup_log_buf() multiple times - first is very
@@ @@ void __init setup_log_buf(int early)
 	if (!new_log_buf_len)
 		return;
 
+	new_descs_count = new_log_buf_len >> PRB_AVGBITS;
+	if (new_descs_count == 0) {
+		pr_err("new_log_buf_len: %lu too small\n", new_log_buf_len);
+		return;
+	}
+
 	new_log_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
 	if (unlikely(!new_log_buf)) {
-		pr_err("log_buf_len: %lu bytes not available\n",
-			new_log_buf_len);
+		pr_err("log_buf_len: %lu text bytes not available\n",
+		       new_log_buf_len);
+		return;
+	}
+
+	new_dict_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
+	if (unlikely(!new_dict_buf)) {
+		pr_err("log_buf_len: %lu dict bytes not available\n",
+		       new_log_buf_len);
+		memblock_free(__pa(new_log_buf), new_log_buf_len);
 		return;
 	}
 
+	new_descs_size = new_descs_count * sizeof(struct prb_desc);
+	new_descs = memblock_alloc(new_descs_size, LOG_ALIGN);
+	if (unlikely(!new_descs)) {
+		pr_err("log_buf_len: %lu desc bytes not available\n",
+		       new_descs_size);
+		memblock_free(__pa(new_dict_buf), new_log_buf_len);
+		memblock_free(__pa(new_log_buf), new_log_buf_len);
+		return;
+	}
+
+	prb_rec_init_rd(&r, &info,
+			&setup_text_buf[0], sizeof(setup_text_buf),
+			&setup_dict_buf[0], sizeof(setup_dict_buf));
+
+	prb_init(&printk_rb_dynamic,
+		 new_log_buf, order_base_2(new_log_buf_len),
+		 new_dict_buf, order_base_2(new_log_buf_len),
+		 new_descs, order_base_2(new_descs_count));
+
 	logbuf_lock_irqsave(flags);
+
 	log_buf_len = new_log_buf_len;
 	log_buf = new_log_buf;
 	new_log_buf_len = 0;
-	free = __LOG_BUF_LEN - log_next_idx;
-	memcpy(log_buf, __log_buf, __LOG_BUF_LEN);
+
+	free = __LOG_BUF_LEN;
+	prb_for_each_record(0, &printk_rb_static, seq, &r)
+		free -= add_to_rb(&printk_rb_dynamic, &r);
+
+	/*
+	 * This is early enough that everything is still running on the
+	 * boot CPU and interrupts are disabled. So no new messages will
+	 * appear during this switch.
+	 */
+	prb = &printk_rb_dynamic;
+
 	logbuf_unlock_irqrestore(flags);
 
+	/* Verify no messages were dropped. */
+	if (seq != prb_next_seq(&printk_rb_static)) {
+		pr_err("dropped %llu messages\n",
+		       prb_next_seq(&printk_rb_static) - seq);
+	}
+
 	pr_info("log_buf_len: %u bytes\n", log_buf_len);
 	pr_info("early log buf free: %u(%u%%)\n",
 		free, (free * 100) / __LOG_BUF_LEN);
