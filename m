Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027BFC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18AC22314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRSQ7z7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgBNN3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:29:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23506 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727822AbgBNN3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581686982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W/8ILaB0zsU/H7AUCCYBmUtn1Jd/MLd/GbjKL0Xgu7M=;
        b=PRSQ7z7atW/XyQ4ORGEf4AdY49PrBWoSk3QEsCxXcrUBSDSU2SiLaBzWuky8aa17r0Yvvw
        p50VBCLUPX+stOX79Vhjd57/MCYVktC8FqiLlLwC+rmOU6PyYFb2HeHi7ChKDgpTNk+08a
        Z9S+4oRIosry0C6kn4JCdzJeuMPpcfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-26jyM-XoMPqS42sPtK5DNg-1; Fri, 14 Feb 2020 08:29:36 -0500
X-MC-Unique: 26jyM-XoMPqS42sPtK5DNg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88BBF800D4E;
        Fri, 14 Feb 2020 13:29:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-202.pek2.redhat.com [10.72.12.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA39D8642B;
        Fri, 14 Feb 2020 13:29:27 +0000 (UTC)
Subject: Re: [PATCH 2/2] printk: use the lockless ringbuffer
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
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <20200128161948.8524-3-john.ogness@linutronix.de>
From:   lijiang <lijiang@redhat.com>
Message-ID: <ccbe1383-a4a4-41f8-3330-972f03c97429@redhat.com>
Date:   Fri, 14 Feb 2020 21:29:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200128161948.8524-3-john.ogness@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2020=E5=B9=B401=E6=9C=8829=E6=97=A5 00:19, John Ogness =E5=86=99=
=E9=81=93:
> Replace the existing ringbuffer usage and implementation with
> lockless ringbuffer usage. Even though the new ringbuffer does not
> require locking, all existing locking is left in place. Therefore,
> this change is purely replacing the underlining ringbuffer.
>=20
> Changes that exist due to the ringbuffer replacement:
>=20
> - The VMCOREINFO has been updated for the new structures.
>=20
> - Dictionary data is now stored in a separate data buffer from the
>   human-readable messages. The dictionary data buffer is set to the
>   same size as the message buffer. Therefore, the total reserved
>   memory for messages is 2 * (2 ^ CONFIG_LOG_BUF_SHIFT) for the
>   initial static buffer and 2x the specified size in the log_buf_len
>   kernel parameter.
>=20
> - Record meta-data is now stored in a separate array of descriptors.
>   This is an additional 72 * (2 ^ ((CONFIG_LOG_BUF_SHIFT - 6))) bytes
>   for the static array and 72 * (2 ^ ((log_buf_len - 6))) bytes for
>   the dynamic array.
>=20
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/kmsg_dump.h |   2 -
>  kernel/printk/Makefile    |   1 +
>  kernel/printk/printk.c    | 836 +++++++++++++++++++-------------------
>  3 files changed, 416 insertions(+), 423 deletions(-)
>=20
> diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
> index 2e7a1e032c71..ae6265033e31 100644
> --- a/include/linux/kmsg_dump.h
> +++ b/include/linux/kmsg_dump.h
> @@ -46,8 +46,6 @@ struct kmsg_dumper {
>  	bool registered;
> =20
>  	/* private state of the kmsg iterator */
> -	u32 cur_idx;
> -	u32 next_idx;
>  	u64 cur_seq;
>  	u64 next_seq;
>  };
> diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
> index 4d052fc6bcde..eee3dc9b60a9 100644
> --- a/kernel/printk/Makefile
> +++ b/kernel/printk/Makefile
> @@ -2,3 +2,4 @@
>  obj-y	=3D printk.o
>  obj-$(CONFIG_PRINTK)	+=3D printk_safe.o
>  obj-$(CONFIG_A11Y_BRAILLE_CONSOLE)	+=3D braille.o
> +obj-$(CONFIG_PRINTK)	+=3D printk_ringbuffer.o
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1ef6f75d92f1..d0d24ee1d1f4 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -56,6 +56,7 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/printk.h>
> =20
> +#include "printk_ringbuffer.h"
>  #include "console_cmdline.h"
>  #include "braille.h"
>  #include "internal.h"
> @@ -294,30 +295,22 @@ enum con_msg_format_flags {
>  static int console_msg_format =3D MSG_FORMAT_DEFAULT;
> =20
>  /*
> - * The printk log buffer consists of a chain of concatenated variable
> - * length records. Every record starts with a record header, containin=
g
> - * the overall length of the record.
> + * The printk log buffer consists of a sequenced collection of records=
, each
> + * containing variable length message and dictionary text. Every recor=
d
> + * also contains its own meta-data (@info).
>   *
> - * The heads to the first and last entry in the buffer, as well as the
> - * sequence numbers of these entries are maintained when messages are
> - * stored.
> - *
> - * If the heads indicate available messages, the length in the header
> - * tells the start next message. A length =3D=3D 0 for the next messag=
e
> - * indicates a wrap-around to the beginning of the buffer.
> - *
> - * Every record carries the monotonic timestamp in microseconds, as we=
ll as
> - * the standard userspace syslog level and syslog facility. The usual
> + * Every record meta-data carries the monotonic timestamp in microseco=
nds, as
> + * well as the standard userspace syslog level and syslog facility. Th=
e usual
>   * kernel messages use LOG_KERN; userspace-injected messages always ca=
rry
>   * a matching syslog facility, by default LOG_USER. The origin of ever=
y
>   * message can be reliably determined that way.
>   *
> - * The human readable log message directly follows the message header.=
 The
> - * length of the message text is stored in the header, the stored mess=
age
> - * is not terminated.
> + * The human readable log message of a record is available in @text, t=
he length
> + * of the message text in @text_len. The stored message is not termina=
ted.
>   *
> - * Optionally, a message can carry a dictionary of properties (key/val=
ue pairs),
> - * to provide userspace with a machine-readable message context.
> + * Optionally, a record can carry a dictionary of properties (key/valu=
e pairs),
> + * to provide userspace with a machine-readable message context. The l=
ength of
> + * the dictionary is available in @dict_len. The dictionary is not ter=
minated.
>   *
>   * Examples for well-defined, commonly used property names are:
>   *   DEVICE=3Db12:8               device identifier
> @@ -331,21 +324,19 @@ static int console_msg_format =3D MSG_FORMAT_DEFA=
ULT;
>   * follows directly after a '=3D' character. Every property is termina=
ted by
>   * a '\0' character. The last property is not terminated.
>   *
> - * Example of a message structure:
> - *   0000  ff 8f 00 00 00 00 00 00      monotonic time in nsec
> - *   0008  34 00                        record is 52 bytes long
> - *   000a        0b 00                  text is 11 bytes long
> - *   000c              1f 00            dictionary is 23 bytes long
> - *   000e                    03 00      LOG_KERN (facility) LOG_ERR (l=
evel)
> - *   0010  69 74 27 73 20 61 20 6c      "it's a l"
> - *         69 6e 65                     "ine"
> - *   001b           44 45 56 49 43      "DEVIC"
> - *         45 3d 62 38 3a 32 00 44      "E=3Db8:2\0D"
> - *         52 49 56 45 52 3d 62 75      "RIVER=3Dbu"
> - *         67                           "g"
> - *   0032     00 00 00                  padding to next message header
> - *
> - * The 'struct printk_log' buffer header must never be directly export=
ed to
> + * Example of record values:
> + *   record.text_buf       =3D "it's a line" (unterminated)
> + *   record.dict_buf       =3D "DEVICE=3Db8:2\0DRIVER=3Dbug" (untermin=
ated)
> + *   record.info.seq       =3D 56
> + *   record.info.ts_sec    =3D 36863
> + *   record.info.text_len  =3D 11
> + *   record.info.dict_len  =3D 22
> + *   record.info.facility  =3D 0 (LOG_KERN)
> + *   record.info.flags     =3D 0
> + *   record.info.level     =3D 3 (LOG_ERR)
> + *   record.info.caller_id =3D 299 (task 299)
> + *
> + * The 'struct printk_info' buffer must never be directly exported to
>   * userspace, it is a kernel-private implementation detail that might
>   * need to be changed in the future, when the requirements change.
>   *
> @@ -365,23 +356,6 @@ enum log_flags {
>  	LOG_CONT	=3D 8,	/* text is a fragment of a continuation line */
>  };
> =20
> -struct printk_log {
> -	u64 ts_nsec;		/* timestamp in nanoseconds */
> -	u16 len;		/* length of entire record */
> -	u16 text_len;		/* length of text buffer */
> -	u16 dict_len;		/* length of dictionary buffer */
> -	u8 facility;		/* syslog facility */
> -	u8 flags:5;		/* internal record flags */
> -	u8 level:3;		/* syslog level */
> -#ifdef CONFIG_PRINTK_CALLER
> -	u32 caller_id;            /* thread id or processor id */
> -#endif
> -}
> -#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> -__packed __aligned(4)
> -#endif
> -;
> -
>  /*
>   * The logbuf_lock protects kmsg buffer, indices, counters.  This can =
be taken
>   * within the scheduler's rq lock. It must be released before calling
> @@ -421,26 +395,17 @@ DEFINE_RAW_SPINLOCK(logbuf_lock);
>  DECLARE_WAIT_QUEUE_HEAD(log_wait);
>  /* the next printk record to read by syslog(READ) or /proc/kmsg */
>  static u64 syslog_seq;
> -static u32 syslog_idx;
>  static size_t syslog_partial;
>  static bool syslog_time;
> -
> -/* index and sequence number of the first record stored in the buffer =
*/
> -static u64 log_first_seq;
> -static u32 log_first_idx;
> -
> -/* index and sequence number of the next record to store in the buffer=
 */
> -static u64 log_next_seq;
> -static u32 log_next_idx;
> +DECLARE_PRINTKRB_RECORD(syslog_record, CONSOLE_EXT_LOG_MAX);
> =20
>  /* the next printk record to write to the console */
>  static u64 console_seq;
> -static u32 console_idx;
>  static u64 exclusive_console_stop_seq;
> +DECLARE_PRINTKRB_RECORD(console_record, CONSOLE_EXT_LOG_MAX);
> =20
>  /* the next printk record to read after the last 'clear' command */
>  static u64 clear_seq;
> -static u32 clear_idx;
> =20
>  #ifdef CONFIG_PRINTK_CALLER
>  #define PREFIX_MAX		48
> @@ -453,13 +418,28 @@ static u32 clear_idx;
>  #define LOG_FACILITY(v)		((v) >> 3 & 0xff)
> =20
>  /* record buffer */
> -#define LOG_ALIGN __alignof__(struct printk_log)
> +#define LOG_ALIGN __alignof__(unsigned long)
>  #define __LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
>  #define LOG_BUF_LEN_MAX (u32)(1 << 31)
>  static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
>  static char *log_buf =3D __log_buf;
>  static u32 log_buf_len =3D __LOG_BUF_LEN;
> =20
> +/*
> + * Define the average message size. This only affects the number of
> + * descriptors that will be available. Underestimating is better than
> + * overestimating (too many available descriptors is better than not e=
nough).
> + * The dictionary buffer will be the same size as the text buffer.
> + */
> +#define PRB_AVGBITS 6
> +
> +_DECLARE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS=
,
> +		  PRB_AVGBITS, PRB_AVGBITS, &__log_buf[0]);
> +
> +static struct printk_ringbuffer printk_rb_dynamic;
> +
> +static struct printk_ringbuffer *prb =3D &printk_rb_static;
> +
>  /* Return log buffer address */
>  char *log_buf_addr_get(void)
>  {
> @@ -472,108 +452,6 @@ u32 log_buf_len_get(void)
>  	return log_buf_len;
>  }
> =20
> -/* human readable text of the record */
> -static char *log_text(const struct printk_log *msg)
> -{
> -	return (char *)msg + sizeof(struct printk_log);
> -}
> -
> -/* optional key/value pair dictionary attached to the record */
> -static char *log_dict(const struct printk_log *msg)
> -{
> -	return (char *)msg + sizeof(struct printk_log) + msg->text_len;
> -}
> -
> -/* get record by index; idx must point to valid msg */
> -static struct printk_log *log_from_idx(u32 idx)
> -{
> -	struct printk_log *msg =3D (struct printk_log *)(log_buf + idx);
> -
> -	/*
> -	 * A length =3D=3D 0 record is the end of buffer marker. Wrap around =
and
> -	 * read the message at the start of the buffer.
> -	 */
> -	if (!msg->len)
> -		return (struct printk_log *)log_buf;
> -	return msg;
> -}
> -
> -/* get next record; idx must point to valid msg */
> -static u32 log_next(u32 idx)
> -{
> -	struct printk_log *msg =3D (struct printk_log *)(log_buf + idx);
> -
> -	/* length =3D=3D 0 indicates the end of the buffer; wrap */
> -	/*
> -	 * A length =3D=3D 0 record is the end of buffer marker. Wrap around =
and
> -	 * read the message at the start of the buffer as *this* one, and
> -	 * return the one after that.
> -	 */
> -	if (!msg->len) {
> -		msg =3D (struct printk_log *)log_buf;
> -		return msg->len;
> -	}
> -	return idx + msg->len;
> -}
> -
> -/*
> - * Check whether there is enough free space for the given message.
> - *
> - * The same values of first_idx and next_idx mean that the buffer
> - * is either empty or full.
> - *
> - * If the buffer is empty, we must respect the position of the indexes=
.
> - * They cannot be reset to the beginning of the buffer.
> - */
> -static int logbuf_has_space(u32 msg_size, bool empty)
> -{
> -	u32 free;
> -
> -	if (log_next_idx > log_first_idx || empty)
> -		free =3D max(log_buf_len - log_next_idx, log_first_idx);
> -	else
> -		free =3D log_first_idx - log_next_idx;
> -
> -	/*
> -	 * We need space also for an empty header that signalizes wrapping
> -	 * of the buffer.
> -	 */
> -	return free >=3D msg_size + sizeof(struct printk_log);
> -}
> -
> -static int log_make_free_space(u32 msg_size)
> -{
> -	while (log_first_seq < log_next_seq &&
> -	       !logbuf_has_space(msg_size, false)) {
> -		/* drop old messages until we have enough contiguous space */
> -		log_first_idx =3D log_next(log_first_idx);
> -		log_first_seq++;
> -	}
> -
> -	if (clear_seq < log_first_seq) {
> -		clear_seq =3D log_first_seq;
> -		clear_idx =3D log_first_idx;
> -	}
> -
> -	/* sequence numbers are equal, so the log buffer is empty */
> -	if (logbuf_has_space(msg_size, log_first_seq =3D=3D log_next_seq))
> -		return 0;
> -
> -	return -ENOMEM;
> -}
> -
> -/* compute the message size including the padding bytes */
> -static u32 msg_used_size(u16 text_len, u16 dict_len, u32 *pad_len)
> -{
> -	u32 size;
> -
> -	size =3D sizeof(struct printk_log) + text_len + dict_len;
> -	*pad_len =3D (-size) & (LOG_ALIGN - 1);
> -	size +=3D *pad_len;
> -
> -	return size;
> -}
> -
>  /*
>   * Define how much of the log buffer we could take at maximum. The val=
ue
>   * must be greater than two. Note that only half of the buffer is avai=
lable
> @@ -582,22 +460,26 @@ static u32 msg_used_size(u16 text_len, u16 dict_l=
en, u32 *pad_len)
>  #define MAX_LOG_TAKE_PART 4
>  static const char trunc_msg[] =3D "<truncated>";
> =20
> -static u32 truncate_msg(u16 *text_len, u16 *trunc_msg_len,
> -			u16 *dict_len, u32 *pad_len)
> +static void truncate_msg(u16 *text_len, u16 *trunc_msg_len, u16 *dict_=
len)
>  {
>  	/*
>  	 * The message should not take the whole buffer. Otherwise, it might
>  	 * get removed too soon.
>  	 */
>  	u32 max_text_len =3D log_buf_len / MAX_LOG_TAKE_PART;
> +
>  	if (*text_len > max_text_len)
>  		*text_len =3D max_text_len;
> -	/* enable the warning message */
> +
> +	/* enable the warning message (if there is room) */
>  	*trunc_msg_len =3D strlen(trunc_msg);
> +	if (*text_len >=3D *trunc_msg_len)
> +		*text_len -=3D *trunc_msg_len;
> +	else
> +		*trunc_msg_len =3D 0;
> +
>  	/* disable the "dict" completely */
>  	*dict_len =3D 0;
> -	/* compute the size again, count also the warning message */
> -	return msg_used_size(*text_len + *trunc_msg_len, 0, pad_len);
>  }
> =20
>  /* insert record into the buffer, discard old ones, update heads */
> @@ -606,60 +488,42 @@ static int log_store(u32 caller_id, int facility,=
 int level,
>  		     const char *dict, u16 dict_len,
>  		     const char *text, u16 text_len)
>  {
> -	struct printk_log *msg;
> -	u32 size, pad_len;
> +	struct prb_reserved_entry e;
> +	struct printk_record r;
>  	u16 trunc_msg_len =3D 0;
> =20
> -	/* number of '\0' padding bytes to next message */
> -	size =3D msg_used_size(text_len, dict_len, &pad_len);
> +	r.text_buf_size =3D text_len;
> +	r.dict_buf_size =3D dict_len;
> =20
> -	if (log_make_free_space(size)) {
> +	if (!prb_reserve(&e, prb, &r)) {
>  		/* truncate the message if it is too long for empty buffer */
> -		size =3D truncate_msg(&text_len, &trunc_msg_len,
> -				    &dict_len, &pad_len);
> +		truncate_msg(&text_len, &trunc_msg_len, &dict_len);
> +		r.text_buf_size =3D text_len + trunc_msg_len;
> +		r.dict_buf_size =3D dict_len;
>  		/* survive when the log buffer is too small for trunc_msg */
> -		if (log_make_free_space(size))
> +		if (!prb_reserve(&e, prb, &r))
>  			return 0;
>  	}
> =20
> -	if (log_next_idx + size + sizeof(struct printk_log) > log_buf_len) {
> -		/*
> -		 * This message + an additional empty header does not fit
> -		 * at the end of the buffer. Add an empty header with len =3D=3D 0
> -		 * to signify a wrap around.
> -		 */
> -		memset(log_buf + log_next_idx, 0, sizeof(struct printk_log));
> -		log_next_idx =3D 0;
> -	}
> -
>  	/* fill message */
> -	msg =3D (struct printk_log *)(log_buf + log_next_idx);
> -	memcpy(log_text(msg), text, text_len);
> -	msg->text_len =3D text_len;
> -	if (trunc_msg_len) {
> -		memcpy(log_text(msg) + text_len, trunc_msg, trunc_msg_len);
> -		msg->text_len +=3D trunc_msg_len;
> -	}
> -	memcpy(log_dict(msg), dict, dict_len);
> -	msg->dict_len =3D dict_len;
> -	msg->facility =3D facility;
> -	msg->level =3D level & 7;
> -	msg->flags =3D flags & 0x1f;
> +	memcpy(&r.text_buf[0], text, text_len);
> +	if (trunc_msg_len)
> +		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);
> +	if (r.dict_buf)
> +		memcpy(&r.dict_buf[0], dict, dict_len);
> +	r.info->facility =3D facility;
> +	r.info->level =3D level & 7;
> +	r.info->flags =3D flags & 0x1f;
>  	if (ts_nsec > 0)
> -		msg->ts_nsec =3D ts_nsec;
> +		r.info->ts_nsec =3D ts_nsec;
>  	else
> -		msg->ts_nsec =3D local_clock();
> -#ifdef CONFIG_PRINTK_CALLER
> -	msg->caller_id =3D caller_id;
> -#endif
> -	memset(log_dict(msg) + dict_len, 0, pad_len);
> -	msg->len =3D size;
> +		r.info->ts_nsec =3D local_clock();
> +	r.info->caller_id =3D caller_id;
> =20
>  	/* insert message */
> -	log_next_idx +=3D msg->len;
> -	log_next_seq++;
> +	prb_commit(&e);
> =20
> -	return msg->text_len;
> +	return text_len;
>  }
> =20
>  int dmesg_restrict =3D IS_ENABLED(CONFIG_SECURITY_DMESG_RESTRICT);
> @@ -711,13 +575,13 @@ static void append_char(char **pp, char *e, char =
c)
>  		*(*pp)++ =3D c;
>  }
> =20
> -static ssize_t msg_print_ext_header(char *buf, size_t size,
> -				    struct printk_log *msg, u64 seq)
> +static ssize_t info_print_ext_header(char *buf, size_t size,
> +				     struct printk_info *info)
>  {
> -	u64 ts_usec =3D msg->ts_nsec;
> +	u64 ts_usec =3D info->ts_nsec;
>  	char caller[20];
>  #ifdef CONFIG_PRINTK_CALLER
> -	u32 id =3D msg->caller_id;
> +	u32 id =3D info->caller_id;
> =20
>  	snprintf(caller, sizeof(caller), ",caller=3D%c%u",
>  		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
> @@ -728,8 +592,8 @@ static ssize_t msg_print_ext_header(char *buf, size=
_t size,
>  	do_div(ts_usec, 1000);
> =20
>  	return scnprintf(buf, size, "%u,%llu,%llu,%c%s;",
> -			 (msg->facility << 3) | msg->level, seq, ts_usec,
> -			 msg->flags & LOG_CONT ? 'c' : '-', caller);
> +			 (info->facility << 3) | info->level, info->seq,
> +			 ts_usec, info->flags & LOG_CONT ? 'c' : '-', caller);
>  }
> =20
>  static ssize_t msg_print_ext_body(char *buf, size_t size,
> @@ -783,10 +647,14 @@ static ssize_t msg_print_ext_body(char *buf, size=
_t size,
>  /* /dev/kmsg - userspace message inject/listen interface */
>  struct devkmsg_user {
>  	u64 seq;
> -	u32 idx;
>  	struct ratelimit_state rs;
>  	struct mutex lock;
>  	char buf[CONSOLE_EXT_LOG_MAX];
> +
> +	struct printk_info info;
> +	char text_buf[CONSOLE_EXT_LOG_MAX];
> +	char dict_buf[CONSOLE_EXT_LOG_MAX];
> +	struct printk_record record;
>  };
> =20
>  static __printf(3, 4) __cold
> @@ -869,7 +737,7 @@ static ssize_t devkmsg_read(struct file *file, char=
 __user *buf,
>  			    size_t count, loff_t *ppos)
>  {
>  	struct devkmsg_user *user =3D file->private_data;
> -	struct printk_log *msg;
> +	struct printk_record *r =3D &user->record;
>  	size_t len;
>  	ssize_t ret;
> =20
> @@ -881,7 +749,7 @@ static ssize_t devkmsg_read(struct file *file, char=
 __user *buf,
>  		return ret;
> =20
>  	logbuf_lock_irq();
> -	while (user->seq =3D=3D log_next_seq) {
> +	if (!prb_read_valid(prb, user->seq, r)) {
>  		if (file->f_flags & O_NONBLOCK) {
>  			ret =3D -EAGAIN;
>  			logbuf_unlock_irq();
> @@ -890,30 +758,26 @@ static ssize_t devkmsg_read(struct file *file, ch=
ar __user *buf,
> =20
>  		logbuf_unlock_irq();
>  		ret =3D wait_event_interruptible(log_wait,
> -					       user->seq !=3D log_next_seq);
> +					prb_read_valid(prb, user->seq, r));
>  		if (ret)
>  			goto out;
>  		logbuf_lock_irq();
>  	}
> =20
> -	if (user->seq < log_first_seq) {
> -		/* our last seen message is gone, return error and reset */
> -		user->idx =3D log_first_idx;
> -		user->seq =3D log_first_seq;
> +	if (user->seq < r->info->seq) {
> +		/* the expected message is gone, return error and reset */
> +		user->seq =3D r->info->seq;
>  		ret =3D -EPIPE;
>  		logbuf_unlock_irq();
>  		goto out;
>  	}
> =20
> -	msg =3D log_from_idx(user->idx);
> -	len =3D msg_print_ext_header(user->buf, sizeof(user->buf),
> -				   msg, user->seq);
> +	len =3D info_print_ext_header(user->buf, sizeof(user->buf), r->info);
>  	len +=3D msg_print_ext_body(user->buf + len, sizeof(user->buf) - len,
> -				  log_dict(msg), msg->dict_len,
> -				  log_text(msg), msg->text_len);
> +				  &r->dict_buf[0], r->info->dict_len,
> +				  &r->text_buf[0], r->info->text_len);
> =20
> -	user->idx =3D log_next(user->idx);
> -	user->seq++;
> +	user->seq =3D r->info->seq + 1;
>  	logbuf_unlock_irq();
> =20
>  	if (len > count) {
> @@ -945,8 +809,7 @@ static loff_t devkmsg_llseek(struct file *file, lof=
f_t offset, int whence)
>  	switch (whence) {
>  	case SEEK_SET:
>  		/* the first record */
> -		user->idx =3D log_first_idx;
> -		user->seq =3D log_first_seq;
> +		user->seq =3D prb_first_seq(prb);
>  		break;
>  	case SEEK_DATA:
>  		/*
> @@ -954,13 +817,11 @@ static loff_t devkmsg_llseek(struct file *file, l=
off_t offset, int whence)
>  		 * like issued by 'dmesg -c'. Reading /dev/kmsg itself
>  		 * changes no global state, and does not clear anything.
>  		 */
> -		user->idx =3D clear_idx;
>  		user->seq =3D clear_seq;
>  		break;
>  	case SEEK_END:
>  		/* after the last record */
> -		user->idx =3D log_next_idx;
> -		user->seq =3D log_next_seq;
> +		user->seq =3D prb_next_seq(prb);
>  		break;
>  	default:
>  		ret =3D -EINVAL;
> @@ -980,9 +841,9 @@ static __poll_t devkmsg_poll(struct file *file, pol=
l_table *wait)
>  	poll_wait(file, &log_wait, wait);
> =20
>  	logbuf_lock_irq();
> -	if (user->seq < log_next_seq) {
> +	if (prb_read_valid(prb, user->seq, NULL)) {
>  		/* return error when data has vanished underneath us */
> -		if (user->seq < log_first_seq)
> +		if (user->seq < prb_first_seq(prb))
>  			ret =3D EPOLLIN|EPOLLRDNORM|EPOLLERR|EPOLLPRI;
>  		else
>  			ret =3D EPOLLIN|EPOLLRDNORM;
> @@ -1017,9 +878,14 @@ static int devkmsg_open(struct inode *inode, stru=
ct file *file)
> =20
>  	mutex_init(&user->lock);
> =20
> +	user->record.info =3D &user->info;
> +	user->record.text_buf =3D &user->text_buf[0];
> +	user->record.text_buf_size =3D sizeof(user->text_buf);
> +	user->record.dict_buf =3D &user->dict_buf[0];
> +	user->record.dict_buf_size =3D sizeof(user->dict_buf);
> +
>  	logbuf_lock_irq();
> -	user->idx =3D log_first_idx;
> -	user->seq =3D log_first_seq;
> +	user->seq =3D prb_first_seq(prb);
>  	logbuf_unlock_irq();
> =20
>  	file->private_data =3D user;
> @@ -1062,21 +928,16 @@ void log_buf_vmcoreinfo_setup(void)
>  {
>  	VMCOREINFO_SYMBOL(log_buf);
>  	VMCOREINFO_SYMBOL(log_buf_len);

Hi, John Ogness

I notice that the "prb"(printk tb static) symbol is not exported into vmc=
oreinfo as follows:

+	VMCOREINFO_SYMBOL(prb);

Should the "prb"(printk tb static) symbol be exported into vmcoreinfo? Ot=
herwise, do you
happen to know how to walk through the log_buf and get all kernel logs fr=
om vmcore?

Thanks.
Lianbo

> -	VMCOREINFO_SYMBOL(log_first_idx);
> -	VMCOREINFO_SYMBOL(clear_idx);
> -	VMCOREINFO_SYMBOL(log_next_idx);
>  	/*
> -	 * Export struct printk_log size and field offsets. User space tools =
can
> -	 * parse it and detect any changes to structure down the line.
> +	 * Export struct printk_info size and field offsets. User space tools
> +	 * can parse it and detect any changes to structure down the line.
>  	 */
> -	VMCOREINFO_STRUCT_SIZE(printk_log);
> -	VMCOREINFO_OFFSET(printk_log, ts_nsec);
> -	VMCOREINFO_OFFSET(printk_log, len);
> -	VMCOREINFO_OFFSET(printk_log, text_len);
> -	VMCOREINFO_OFFSET(printk_log, dict_len);
> -#ifdef CONFIG_PRINTK_CALLER
> -	VMCOREINFO_OFFSET(printk_log, caller_id);
> -#endif
> +	VMCOREINFO_STRUCT_SIZE(printk_info);
> +	VMCOREINFO_OFFSET(printk_info, seq);
> +	VMCOREINFO_OFFSET(printk_info, ts_nsec);
> +	VMCOREINFO_OFFSET(printk_info, text_len);
> +	VMCOREINFO_OFFSET(printk_info, dict_len);
> +	VMCOREINFO_OFFSET(printk_info, caller_id);
>  }
>  #endif
> =20
> @@ -1146,11 +1007,55 @@ static void __init log_buf_add_cpu(void)
>  static inline void log_buf_add_cpu(void) {}
>  #endif /* CONFIG_SMP */
> =20
> +static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
> +				     struct printk_record *r)
> +{
> +	struct printk_info info;
> +	struct printk_record dest_r =3D {
> +		.info =3D &info,
> +		.text_buf_size =3D r->info->text_len,
> +		.dict_buf_size =3D r->info->dict_len,
> +	};
> +	struct prb_reserved_entry e;
> +
> +	if (!prb_reserve(&e, rb, &dest_r))
> +		return 0;
> +
> +	memcpy(&dest_r.text_buf[0], &r->text_buf[0], dest_r.text_buf_size);
> +	if (dest_r.dict_buf) {
> +		memcpy(&dest_r.dict_buf[0], &r->dict_buf[0],
> +		       dest_r.dict_buf_size);
> +	}
> +	dest_r.info->facility =3D r->info->facility;
> +	dest_r.info->level =3D r->info->level;
> +	dest_r.info->flags =3D r->info->flags;
> +	dest_r.info->ts_nsec =3D r->info->ts_nsec;
> +	dest_r.info->caller_id =3D r->info->caller_id;
> +
> +	prb_commit(&e);
> +
> +	return prb_record_text_space(&e);
> +}
> +
> +static char setup_text_buf[CONSOLE_EXT_LOG_MAX] __initdata;
> +static char setup_dict_buf[CONSOLE_EXT_LOG_MAX] __initdata;
> +
>  void __init setup_log_buf(int early)
>  {
> +	struct prb_desc *new_descs;
> +	struct printk_info info;
> +	struct printk_record r =3D {
> +		.info =3D &info,
> +		.text_buf =3D &setup_text_buf[0],
> +		.dict_buf =3D &setup_dict_buf[0],
> +		.text_buf_size =3D sizeof(setup_text_buf),
> +		.dict_buf_size =3D sizeof(setup_dict_buf),
> +	};
>  	unsigned long flags;
> +	char *new_dict_buf;
>  	char *new_log_buf;
>  	unsigned int free;
> +	u64 seq;
> =20
>  	if (log_buf !=3D __log_buf)
>  		return;
> @@ -1163,17 +1068,46 @@ void __init setup_log_buf(int early)
> =20
>  	new_log_buf =3D memblock_alloc(new_log_buf_len, LOG_ALIGN);
>  	if (unlikely(!new_log_buf)) {
> -		pr_err("log_buf_len: %lu bytes not available\n",
> +		pr_err("log_buf_len: %lu text bytes not available\n",
>  			new_log_buf_len);
>  		return;
>  	}
> =20
> +	new_dict_buf =3D memblock_alloc(new_log_buf_len, LOG_ALIGN);
> +	if (unlikely(!new_dict_buf)) {
> +		/* dictionary failure is allowed */
> +		pr_err("log_buf_len: %lu dict bytes not available\n",
> +			new_log_buf_len);
> +	}
> +
> +	new_descs =3D memblock_alloc((new_log_buf_len >> PRB_AVGBITS) *
> +				   sizeof(struct prb_desc), LOG_ALIGN);
> +	if (unlikely(!new_descs)) {
> +		pr_err("log_buf_len: %lu desc bytes not available\n",
> +			new_log_buf_len >> PRB_AVGBITS);
> +		if (new_dict_buf)
> +			memblock_free(__pa(new_dict_buf), new_log_buf_len);
> +		memblock_free(__pa(new_log_buf), new_log_buf_len);
> +		return;
> +	}
> +
>  	logbuf_lock_irqsave(flags);
> +
> +	prb_init(&printk_rb_dynamic,
> +		 new_log_buf, bits_per(new_log_buf_len) - 1,
> +		 new_dict_buf, bits_per(new_log_buf_len) - 1,
> +		 new_descs, (bits_per(new_log_buf_len) - 1) - PRB_AVGBITS);
> +
>  	log_buf_len =3D new_log_buf_len;
>  	log_buf =3D new_log_buf;
>  	new_log_buf_len =3D 0;
> -	free =3D __LOG_BUF_LEN - log_next_idx;
> -	memcpy(log_buf, __log_buf, __LOG_BUF_LEN);
> +
> +	free =3D __LOG_BUF_LEN;
> +	prb_for_each_record(0, &printk_rb_static, seq, &r)
> +		free -=3D add_to_rb(&printk_rb_dynamic, &r);
> +
> +	prb =3D &printk_rb_dynamic;
> +
>  	logbuf_unlock_irqrestore(flags);
> =20
>  	pr_info("log_buf_len: %u bytes\n", log_buf_len);
> @@ -1285,18 +1219,18 @@ static size_t print_caller(u32 id, char *buf)
>  #define print_caller(id, buf) 0
>  #endif
> =20
> -static size_t print_prefix(const struct printk_log *msg, bool syslog,
> -			   bool time, char *buf)
> +static size_t info_print_prefix(const struct printk_info  *info, bool =
syslog,
> +				bool time, char *buf)
>  {
>  	size_t len =3D 0;
> =20
>  	if (syslog)
> -		len =3D print_syslog((msg->facility << 3) | msg->level, buf);
> +		len =3D print_syslog((info->facility << 3) | info->level, buf);
> =20
>  	if (time)
> -		len +=3D print_time(msg->ts_nsec, buf + len);
> +		len +=3D print_time(info->ts_nsec, buf + len);
> =20
> -	len +=3D print_caller(msg->caller_id, buf + len);
> +	len +=3D print_caller(info->caller_id, buf + len);
> =20
>  	if (IS_ENABLED(CONFIG_PRINTK_CALLER) || time) {
>  		buf[len++] =3D ' ';
> @@ -1306,14 +1240,15 @@ static size_t print_prefix(const struct printk_=
log *msg, bool syslog,
>  	return len;
>  }
> =20
> -static size_t msg_print_text(const struct printk_log *msg, bool syslog=
,
> -			     bool time, char *buf, size_t size)
> +static size_t record_print_text(const struct printk_record *r, bool sy=
slog,
> +				bool time, char *buf, size_t size)
>  {
> -	const char *text =3D log_text(msg);
> -	size_t text_size =3D msg->text_len;
> +	const char *text =3D &r->text_buf[0];
> +	size_t text_size =3D r->info->text_len;
>  	size_t len =3D 0;
>  	char prefix[PREFIX_MAX];
> -	const size_t prefix_len =3D print_prefix(msg, syslog, time, prefix);
> +	const size_t prefix_len =3D info_print_prefix(r->info, syslog, time,
> +						    prefix);
> =20
>  	do {
>  		const char *next =3D memchr(text, '\n', text_size);
> @@ -1347,10 +1282,94 @@ static size_t msg_print_text(const struct print=
k_log *msg, bool syslog,
>  	return len;
>  }
> =20
> +static size_t record_print_text_inline(struct printk_record *r, bool s=
yslog,
> +				       bool time)
> +{
> +	size_t text_len =3D r->info->text_len;
> +	size_t buf_size =3D r->text_buf_size;
> +	char *text =3D r->text_buf;
> +	char prefix[PREFIX_MAX];
> +	bool truncated =3D false;
> +	size_t prefix_len;
> +	size_t len =3D 0;
> +
> +	prefix_len =3D info_print_prefix(r->info, syslog, time, prefix);
> +
> +	if (!text) {
> +		/* SYSLOG_ACTION_* buffer size only calculation */
> +		unsigned int line_count =3D 1;
> +
> +		if (r->text_line_count)
> +			line_count =3D *(r->text_line_count);
> +		/*
> +		 * Each line will be preceded with a prefix. The intermediate
> +		 * newlines are already within the text, but a final trailing
> +		 * newline will be added.
> +		 */
> +		return ((prefix_len * line_count) + r->info->text_len + 1);
> +	}
> +
> +	/*
> +	 * Add the prefix for each line by shifting the rest of the text to
> +	 * make room for the prefix. If the buffer is not large enough for al=
l
> +	 * the prefixes, then drop the trailing text and report the largest
> +	 * length that includes full lines with their prefixes.
> +	 */
> +	while (text_len) {
> +		size_t line_len;
> +		char *next;
> +
> +		next =3D memchr(text, '\n', text_len);
> +		if (next) {
> +			line_len =3D next - text;
> +		} else {
> +			/*
> +			 * If the text has been truncated, assume this line
> +			 * was truncated and do not include this text.
> +			 */
> +			if (truncated)
> +				break;
> +			line_len =3D text_len;
> +		}
> +
> +		/*
> +		 * Is there enough buffer available to shift this line
> +		 * (and add a newline at the end)?
> +		 */
> +		if (len + prefix_len + line_len >=3D buf_size)
> +			break;
> +
> +		/*
> +		 * Is there enough buffer available to shift all remaining
> +		 * text (and add a newline at the end)?
> +		 */
> +		if (len + prefix_len + text_len >=3D buf_size) {
> +			text_len =3D (buf_size - len) - prefix_len;
> +			truncated =3D true;
> +		}
> +
> +		memmove(text + prefix_len, text, text_len);
> +		memcpy(text, prefix, prefix_len);
> +
> +		text +=3D prefix_len + line_len;
> +		text_len -=3D line_len;
> +
> +		if (text_len) {
> +			text_len--;
> +			text++;
> +		} else {
> +			*text =3D '\n';
> +		}
> +
> +		len +=3D prefix_len + line_len + 1;
> +	}
> +
> +	return len;
> +}
> +
>  static int syslog_print(char __user *buf, int size)
>  {
>  	char *text;
> -	struct printk_log *msg;
>  	int len =3D 0;
> =20
>  	text =3D kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
> @@ -1362,16 +1381,15 @@ static int syslog_print(char __user *buf, int s=
ize)
>  		size_t skip;
> =20
>  		logbuf_lock_irq();
> -		if (syslog_seq < log_first_seq) {
> -			/* messages are gone, move to first one */
> -			syslog_seq =3D log_first_seq;
> -			syslog_idx =3D log_first_idx;
> -			syslog_partial =3D 0;
> -		}
> -		if (syslog_seq =3D=3D log_next_seq) {
> +		if (!prb_read_valid(prb, syslog_seq, &syslog_record)) {
>  			logbuf_unlock_irq();
>  			break;
>  		}
> +		if (syslog_record.info->seq !=3D syslog_seq) {
> +			/* messages are gone, move to first one */
> +			syslog_seq =3D syslog_record.info->seq;
> +			syslog_partial =3D 0;
> +		}
> =20
>  		/*
>  		 * To keep reading/counting partial line consistent,
> @@ -1381,13 +1399,11 @@ static int syslog_print(char __user *buf, int s=
ize)
>  			syslog_time =3D printk_time;
> =20
>  		skip =3D syslog_partial;
> -		msg =3D log_from_idx(syslog_idx);
> -		n =3D msg_print_text(msg, true, syslog_time, text,
> -				   LOG_LINE_MAX + PREFIX_MAX);
> +		n =3D record_print_text(&syslog_record, true, syslog_time, text,
> +				      LOG_LINE_MAX + PREFIX_MAX);
>  		if (n - syslog_partial <=3D size) {
>  			/* message fits into buffer, move forward */
> -			syslog_idx =3D log_next(syslog_idx);
> -			syslog_seq++;
> +			syslog_seq =3D syslog_record.info->seq + 1;
>  			n -=3D syslog_partial;
>  			syslog_partial =3D 0;
>  		} else if (!len){
> @@ -1420,9 +1436,7 @@ static int syslog_print_all(char __user *buf, int=
 size, bool clear)
>  {
>  	char *text;
>  	int len =3D 0;
> -	u64 next_seq;
>  	u64 seq;
> -	u32 idx;
>  	bool time;
> =20
>  	text =3D kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
> @@ -1435,38 +1449,30 @@ static int syslog_print_all(char __user *buf, i=
nt size, bool clear)
>  	 * Find first record that fits, including all following records,
>  	 * into the user-provided buffer for this dump.
>  	 */
> -	seq =3D clear_seq;
> -	idx =3D clear_idx;
> -	while (seq < log_next_seq) {
> -		struct printk_log *msg =3D log_from_idx(idx);
> -
> -		len +=3D msg_print_text(msg, true, time, NULL, 0);
> -		idx =3D log_next(idx);
> -		seq++;
> -	}
> +	prb_for_each_record(clear_seq, prb, seq, &syslog_record)
> +		len +=3D record_print_text(&syslog_record, true, time, NULL, 0);
> =20
>  	/* move first record forward until length fits into the buffer */
> -	seq =3D clear_seq;
> -	idx =3D clear_idx;
> -	while (len > size && seq < log_next_seq) {
> -		struct printk_log *msg =3D log_from_idx(idx);
> -
> -		len -=3D msg_print_text(msg, true, time, NULL, 0);
> -		idx =3D log_next(idx);
> -		seq++;
> +	prb_for_each_record(clear_seq, prb, seq, &syslog_record) {
> +		if (len <=3D size)
> +			break;
> +		len -=3D record_print_text(&syslog_record, true, time, NULL, 0);
>  	}
> =20
> -	/* last message fitting into this dump */
> -	next_seq =3D log_next_seq;
> -
>  	len =3D 0;
> -	while (len >=3D 0 && seq < next_seq) {
> -		struct printk_log *msg =3D log_from_idx(idx);
> -		int textlen =3D msg_print_text(msg, true, time, text,
> -					     LOG_LINE_MAX + PREFIX_MAX);
> +	prb_for_each_record(seq, prb, seq, &syslog_record) {
> +		int textlen;
> =20
> -		idx =3D log_next(idx);
> -		seq++;
> +		if (len < 0)
> +			break;
> +
> +		textlen =3D record_print_text(&syslog_record, true, time, text,
> +					    LOG_LINE_MAX + PREFIX_MAX);
> +
> +		if (len + textlen > size) {
> +			seq--;
> +			break;
> +		}
> =20
>  		logbuf_unlock_irq();
>  		if (copy_to_user(buf + len, text, textlen))
> @@ -1474,18 +1480,10 @@ static int syslog_print_all(char __user *buf, i=
nt size, bool clear)
>  		else
>  			len +=3D textlen;
>  		logbuf_lock_irq();
> -
> -		if (seq < log_first_seq) {
> -			/* messages are gone, move to next one */
> -			seq =3D log_first_seq;
> -			idx =3D log_first_idx;
> -		}
>  	}
> =20
> -	if (clear) {
> -		clear_seq =3D log_next_seq;
> -		clear_idx =3D log_next_idx;
> -	}
> +	if (clear)
> +		clear_seq =3D seq;
>  	logbuf_unlock_irq();
> =20
>  	kfree(text);
> @@ -1495,8 +1493,7 @@ static int syslog_print_all(char __user *buf, int=
 size, bool clear)
>  static void syslog_clear(void)
>  {
>  	logbuf_lock_irq();
> -	clear_seq =3D log_next_seq;
> -	clear_idx =3D log_next_idx;
> +	clear_seq =3D prb_next_seq(prb);
>  	logbuf_unlock_irq();
>  }
> =20
> @@ -1523,7 +1520,7 @@ int do_syslog(int type, char __user *buf, int len=
, int source)
>  		if (!access_ok(buf, len))
>  			return -EFAULT;
>  		error =3D wait_event_interruptible(log_wait,
> -						 syslog_seq !=3D log_next_seq);
> +				prb_read_valid(prb, syslog_seq, NULL));
>  		if (error)
>  			return error;
>  		error =3D syslog_print(buf, len);
> @@ -1572,10 +1569,9 @@ int do_syslog(int type, char __user *buf, int le=
n, int source)
>  	/* Number of chars in the log buffer */
>  	case SYSLOG_ACTION_SIZE_UNREAD:
>  		logbuf_lock_irq();
> -		if (syslog_seq < log_first_seq) {
> +		if (syslog_seq < prb_first_seq(prb)) {
>  			/* messages are gone, move to first one */
> -			syslog_seq =3D log_first_seq;
> -			syslog_idx =3D log_first_idx;
> +			syslog_seq =3D prb_first_seq(prb);
>  			syslog_partial =3D 0;
>  		}
>  		if (source =3D=3D SYSLOG_FROM_PROC) {
> @@ -1584,20 +1580,17 @@ int do_syslog(int type, char __user *buf, int l=
en, int source)
>  			 * for pending data, not the size; return the count of
>  			 * records, not the length.
>  			 */
> -			error =3D log_next_seq - syslog_seq;
> +			error =3D prb_next_seq(prb) - syslog_seq;
>  		} else {
> -			u64 seq =3D syslog_seq;
> -			u32 idx =3D syslog_idx;
>  			bool time =3D syslog_partial ? syslog_time : printk_time;
> +			u64 seq;
> =20
> -			while (seq < log_next_seq) {
> -				struct printk_log *msg =3D log_from_idx(idx);
> -
> -				error +=3D msg_print_text(msg, true, time, NULL,
> -							0);
> +			prb_for_each_record(syslog_seq, prb, seq,
> +					    &syslog_record) {
> +				error +=3D record_print_text(&syslog_record,
> +							   true, time,
> +							   NULL, 0);
>  				time =3D printk_time;
> -				idx =3D log_next(idx);
> -				seq++;
>  			}
>  			error -=3D syslog_partial;
>  		}
> @@ -1958,7 +1951,6 @@ asmlinkage int vprintk_emit(int facility, int lev=
el,
>  	int printed_len;
>  	bool in_sched =3D false, pending_output;
>  	unsigned long flags;
> -	u64 curr_log_seq;
> =20
>  	/* Suppress unimportant messages after panic happens */
>  	if (unlikely(suppress_printk))
> @@ -1974,9 +1966,9 @@ asmlinkage int vprintk_emit(int facility, int lev=
el,
> =20
>  	/* This stops the holder of console_sem just where we want him */
>  	logbuf_lock_irqsave(flags);
> -	curr_log_seq =3D log_next_seq;
> +	pending_output =3D !prb_read_valid(prb, console_seq, NULL);
>  	printed_len =3D vprintk_store(facility, level, dict, dictlen, fmt, ar=
gs);
> -	pending_output =3D (curr_log_seq !=3D log_next_seq);
> +	pending_output &=3D prb_read_valid(prb, console_seq, NULL);
>  	logbuf_unlock_irqrestore(flags);
> =20
>  	/* If called from the scheduler, we can not call up(). */
> @@ -2066,21 +2058,30 @@ EXPORT_SYMBOL(printk);
>  #define PREFIX_MAX		0
>  #define printk_time		false
> =20
> +#define prb_read_valid(rb, seq, r)	false
> +#define prb_first_seq(rb)		0
> +
>  static u64 syslog_seq;
> -static u32 syslog_idx;
>  static u64 console_seq;
> -static u32 console_idx;
>  static u64 exclusive_console_stop_seq;
> -static u64 log_first_seq;
> -static u32 log_first_idx;
> -static u64 log_next_seq;
> -static char *log_text(const struct printk_log *msg) { return NULL; }
> -static char *log_dict(const struct printk_log *msg) { return NULL; }
> -static struct printk_log *log_from_idx(u32 idx) { return NULL; }
> -static u32 log_next(u32 idx) { return 0; }
> -static ssize_t msg_print_ext_header(char *buf, size_t size,
> -				    struct printk_log *msg,
> -				    u64 seq) { return 0; }
> +struct printk_record console_record;
> +
> +static size_t record_print_text(const struct printk_record *r, bool sy=
slog,
> +				bool time, char *buf,
> +				size_t size)
> +{
> +	return 0;
> +}
> +static size_t record_print_text_inline(const struct printk_record *r,
> +				       bool syslog, bool time)
> +{
> +	return 0;
> +}
> +static ssize_t info_print_ext_header(char *buf, size_t size,
> +				     struct printk_info *info)
> +{
> +	return 0;
> +}
>  static ssize_t msg_print_ext_body(char *buf, size_t size,
>  				  char *dict, size_t dict_len,
>  				  char *text, size_t text_len) { return 0; }
> @@ -2088,8 +2089,6 @@ static void console_lock_spinning_enable(void) { =
}
>  static int console_lock_spinning_disable_and_check(void) { return 0; }
>  static void call_console_drivers(const char *ext_text, size_t ext_len,
>  				 const char *text, size_t len) {}
> -static size_t msg_print_text(const struct printk_log *msg, bool syslog=
,
> -			     bool time, char *buf, size_t size) { return 0; }
>  static bool suppress_message_printing(int level) { return false; }
> =20
>  #endif /* CONFIG_PRINTK */
> @@ -2406,35 +2405,28 @@ void console_unlock(void)
>  	}
> =20
>  	for (;;) {
> -		struct printk_log *msg;
>  		size_t ext_len =3D 0;
> -		size_t len;
> +		size_t len =3D 0;
> =20
>  		printk_safe_enter_irqsave(flags);
>  		raw_spin_lock(&logbuf_lock);
> -		if (console_seq < log_first_seq) {
> +skip:
> +		if (!prb_read_valid(prb, console_seq, &console_record))
> +			break;
> +
> +		if (console_seq < console_record.info->seq) {
>  			len =3D sprintf(text,
>  				      "** %llu printk messages dropped **\n",
> -				      log_first_seq - console_seq);
> -
> -			/* messages are gone, move to first one */
> -			console_seq =3D log_first_seq;
> -			console_idx =3D log_first_idx;
> -		} else {
> -			len =3D 0;
> +				      console_record.info->seq - console_seq);
>  		}
> -skip:
> -		if (console_seq =3D=3D log_next_seq)
> -			break;
> +		console_seq =3D console_record.info->seq;
> =20
> -		msg =3D log_from_idx(console_idx);
> -		if (suppress_message_printing(msg->level)) {
> +		if (suppress_message_printing(console_record.info->level)) {
>  			/*
>  			 * Skip record we have buffered and already printed
>  			 * directly to the console when we received it, and
>  			 * record that has level above the console loglevel.
>  			 */
> -			console_idx =3D log_next(console_idx);
>  			console_seq++;
>  			goto skip;
>  		}
> @@ -2445,19 +2437,20 @@ void console_unlock(void)
>  			exclusive_console =3D NULL;
>  		}
> =20
> -		len +=3D msg_print_text(msg,
> +		len +=3D record_print_text(&console_record,
>  				console_msg_format & MSG_FORMAT_SYSLOG,
>  				printk_time, text + len, sizeof(text) - len);
>  		if (nr_ext_console_drivers) {
> -			ext_len =3D msg_print_ext_header(ext_text,
> +			ext_len =3D info_print_ext_header(ext_text,
>  						sizeof(ext_text),
> -						msg, console_seq);
> +						console_record.info);
>  			ext_len +=3D msg_print_ext_body(ext_text + ext_len,
>  						sizeof(ext_text) - ext_len,
> -						log_dict(msg), msg->dict_len,
> -						log_text(msg), msg->text_len);
> +						&console_record.dict_buf[0],
> +						console_record.info->dict_len,
> +						&console_record.text_buf[0],
> +						console_record.info->text_len);
>  		}
> -		console_idx =3D log_next(console_idx);
>  		console_seq++;
>  		raw_spin_unlock(&logbuf_lock);
> =20
> @@ -2497,7 +2490,7 @@ void console_unlock(void)
>  	 * flush, no worries.
>  	 */
>  	raw_spin_lock(&logbuf_lock);
> -	retry =3D console_seq !=3D log_next_seq;
> +	retry =3D prb_read_valid(prb, console_seq, NULL);
>  	raw_spin_unlock(&logbuf_lock);
>  	printk_safe_exit_irqrestore(flags);
> =20
> @@ -2566,8 +2559,7 @@ void console_flush_on_panic(enum con_flush_mode m=
ode)
>  		unsigned long flags;
> =20
>  		logbuf_lock_irqsave(flags);
> -		console_seq =3D log_first_seq;
> -		console_idx =3D log_first_idx;
> +		console_seq =3D prb_first_seq(prb);
>  		logbuf_unlock_irqrestore(flags);
>  	}
>  	console_unlock();
> @@ -2770,8 +2762,6 @@ void register_console(struct console *newcon)
>  		 * for us.
>  		 */
>  		logbuf_lock_irqsave(flags);
> -		console_seq =3D syslog_seq;
> -		console_idx =3D syslog_idx;
>  		/*
>  		 * We're about to replay the log buffer.  Only do this to the
>  		 * just-registered console to avoid excessive message spam to
> @@ -2783,6 +2773,7 @@ void register_console(struct console *newcon)
>  		 */
>  		exclusive_console =3D newcon;
>  		exclusive_console_stop_seq =3D console_seq;
> +		console_seq =3D syslog_seq;
>  		logbuf_unlock_irqrestore(flags);
>  	}
>  	console_unlock();
> @@ -3127,9 +3118,7 @@ void kmsg_dump(enum kmsg_dump_reason reason)
> =20
>  		logbuf_lock_irqsave(flags);
>  		dumper->cur_seq =3D clear_seq;
> -		dumper->cur_idx =3D clear_idx;
> -		dumper->next_seq =3D log_next_seq;
> -		dumper->next_idx =3D log_next_idx;
> +		dumper->next_seq =3D prb_next_seq(prb);
>  		logbuf_unlock_irqrestore(flags);
> =20
>  		/* invoke dumper which will iterate over records */
> @@ -3163,28 +3152,29 @@ void kmsg_dump(enum kmsg_dump_reason reason)
>  bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog=
,
>  			       char *line, size_t size, size_t *len)
>  {
> -	struct printk_log *msg;
> +	struct printk_info info;
> +	struct printk_record r =3D {
> +		.info =3D &info,
> +		.text_buf =3D line,
> +		.text_buf_size =3D size,
> +	};
> +	unsigned int line_count;
>  	size_t l =3D 0;
>  	bool ret =3D false;
> =20
>  	if (!dumper->active)
>  		goto out;
> =20
> -	if (dumper->cur_seq < log_first_seq) {
> -		/* messages are gone, move to first available one */
> -		dumper->cur_seq =3D log_first_seq;
> -		dumper->cur_idx =3D log_first_idx;
> -	}
> +	/* Count text lines instead of reading text? */
> +	if (!line)
> +		r.text_line_count =3D &line_count;
> =20
> -	/* last entry */
> -	if (dumper->cur_seq >=3D log_next_seq)
> +	if (!prb_read_valid(prb, dumper->cur_seq, &r))
>  		goto out;
> =20
> -	msg =3D log_from_idx(dumper->cur_idx);
> -	l =3D msg_print_text(msg, syslog, printk_time, line, size);
> +	l =3D record_print_text_inline(&r, syslog, printk_time);
> =20
> -	dumper->cur_idx =3D log_next(dumper->cur_idx);
> -	dumper->cur_seq++;
> +	dumper->cur_seq =3D r.info->seq + 1;
>  	ret =3D true;
>  out:
>  	if (len)
> @@ -3245,23 +3235,27 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_line);
>  bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
>  			  char *buf, size_t size, size_t *len)
>  {
> +	struct printk_info info;
> +	unsigned int line_count;
> +	/* initially, only count text lines */
> +	struct printk_record r =3D {
> +		.info =3D &info,
> +		.text_line_count =3D &line_count,
> +	};
>  	unsigned long flags;
>  	u64 seq;
> -	u32 idx;
>  	u64 next_seq;
> -	u32 next_idx;
>  	size_t l =3D 0;
>  	bool ret =3D false;
>  	bool time =3D printk_time;
> =20
> -	if (!dumper->active)
> +	if (!dumper->active || !buf || !size)
>  		goto out;
> =20
>  	logbuf_lock_irqsave(flags);
> -	if (dumper->cur_seq < log_first_seq) {
> +	if (dumper->cur_seq < prb_first_seq(prb)) {
>  		/* messages are gone, move to first available one */
> -		dumper->cur_seq =3D log_first_seq;
> -		dumper->cur_idx =3D log_first_idx;
> +		dumper->cur_seq =3D prb_first_seq(prb);
>  	}
> =20
>  	/* last entry */
> @@ -3272,41 +3266,43 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *d=
umper, bool syslog,
> =20
>  	/* calculate length of entire buffer */
>  	seq =3D dumper->cur_seq;
> -	idx =3D dumper->cur_idx;
> -	while (seq < dumper->next_seq) {
> -		struct printk_log *msg =3D log_from_idx(idx);
> -
> -		l +=3D msg_print_text(msg, true, time, NULL, 0);
> -		idx =3D log_next(idx);
> -		seq++;
> +	while (prb_read_valid(prb, seq, &r)) {
> +		if (r.info->seq >=3D dumper->next_seq)
> +			break;
> +		l +=3D record_print_text_inline(&r, true, time);
> +		seq =3D r.info->seq + 1;
>  	}
> =20
>  	/* move first record forward until length fits into the buffer */
>  	seq =3D dumper->cur_seq;
> -	idx =3D dumper->cur_idx;
> -	while (l >=3D size && seq < dumper->next_seq) {
> -		struct printk_log *msg =3D log_from_idx(idx);
> -
> -		l -=3D msg_print_text(msg, true, time, NULL, 0);
> -		idx =3D log_next(idx);
> -		seq++;
> +	while (l >=3D size && prb_read_valid(prb, seq, &r)) {
> +		if (r.info->seq >=3D dumper->next_seq)
> +			break;
> +		l -=3D record_print_text_inline(&r, true, time);
> +		seq =3D r.info->seq + 1;
>  	}
> =20
>  	/* last message in next interation */
>  	next_seq =3D seq;
> -	next_idx =3D idx;
> +
> +	/* actually read data into the buffer now */
> +	r.text_buf =3D buf;
> +	r.text_buf_size =3D size;
> +	r.text_line_count =3D NULL;
> =20
>  	l =3D 0;
> -	while (seq < dumper->next_seq) {
> -		struct printk_log *msg =3D log_from_idx(idx);
> +	while (prb_read_valid(prb, seq, &r)) {
> +		if (r.info->seq >=3D dumper->next_seq)
> +			break;
> +
> +		l +=3D record_print_text_inline(&r, syslog, time);
> +		r.text_buf =3D buf + l;
> +		r.text_buf_size =3D size - l;
> =20
> -		l +=3D msg_print_text(msg, syslog, time, buf + l, size - l);
> -		idx =3D log_next(idx);
> -		seq++;
> +		seq =3D r.info->seq + 1;
>  	}
> =20
>  	dumper->next_seq =3D next_seq;
> -	dumper->next_idx =3D next_idx;
>  	ret =3D true;
>  	logbuf_unlock_irqrestore(flags);
>  out:
> @@ -3329,9 +3325,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
>  void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
>  {
>  	dumper->cur_seq =3D clear_seq;
> -	dumper->cur_idx =3D clear_idx;
> -	dumper->next_seq =3D log_next_seq;
> -	dumper->next_idx =3D log_next_idx;
> +	dumper->next_seq =3D prb_next_seq(prb);
>  }
> =20
>  /**
>=20

