Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65616C352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FE92082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sru0PbvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgBNCJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:09:39 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39311 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgBNCJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:09:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so3110461plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 18:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r2TroXA0yUI8fmWitO9N7P1hbpfN+w2qKJ2a2K3uBEs=;
        b=sru0PbvOJAEZZXTDaGXULSnWwdXKguUxzS3d4INf7nRpZZNUJEw5pvsk3qe8a91kCY
         nCAGD3OVgkkMTpr1uW0SUvWgqW9ITpkjgeiXedjFqp30lJJbk/r1MSqzhS1T47/3kY5S
         aoNi0r+WCHSGznV5AGXG5lUPuwYXUx5iGdxBXJDRlEB+G/1haaG5PJGu4eWauH52YXiy
         wi4ou8UWvSxxoeRDOU3VqM5wNn5V3oJUwFWX6pcZPLcKFLIDco12qSB84VBJmyNBHAri
         rub5CShxxQ0j4TA8hZQgxi+uIvjjUbSCfDGX7j9XQzSsTQ/XFmRmjpQwHF93JMyE2hP4
         YT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r2TroXA0yUI8fmWitO9N7P1hbpfN+w2qKJ2a2K3uBEs=;
        b=FHV5KdeahOHz/mzIFIHnbciTlacnh+SQQVoBN/NaZIRv1kIb7ZshfgbT6GbER4HYbp
         reWBMGlULUZ9HIH4L9hua64U0VlrhpCZTV4AM034Fg2QemZTUDEO/2kWs/e8a4D3ew9i
         SaKfI21DLEQGOjYjjW9fq4F7W5E6he8K6eCkP8kML4sHOntQpgKkHyAHpOXHQbq+w1hi
         Axli94TBDPvnkOjEKWlFBi0hqtHv9j2+wSfNVf+L0RnRNpwI30bpKHC5Pu150s4KkKcP
         Aty/zEb1yy8ToePY+Lthfm+4bnl6Tmmn+Rq0DSqZGBlVQrEO0ndMJ1Rdl81SnTMHDU1z
         STFg==
X-Gm-Message-State: APjAAAWyl5hUHmqeqeRdubTAmq4bgPtsvMDghJpa1M8RrcPnXAxd7zFV
        4HF6lp0KffYUVuVrIp4MU7A=
X-Google-Smtp-Source: APXvYqxXhys7hv2UAeS14KIOC/GApmukghj6i/r05NQrkHj9Q9QVNPxHcHkih0LuhLdWFJm4o+0HTA==
X-Received: by 2002:a17:90b:1245:: with SMTP id gx5mr593150pjb.105.1581646178190;
        Thu, 13 Feb 2020 18:09:38 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id 72sm4835507pfw.7.2020.02.13.18.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 18:09:37 -0800 (PST)
Date:   Fri, 14 Feb 2020 11:09:35 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 2/2] printk: use the lockless ringbuffer
Message-ID: <20200214020935.GF36551@google.com>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <20200128161948.8524-3-john.ogness@linutronix.de>
 <20200213090757.GA36551@google.com>
 <87v9oarfg4.fsf@linutronix.de>
 <20200213115957.GC36551@google.com>
 <87pneiyv12.fsf@linutronix.de>
 <20200214014113.GE36551@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214014113.GE36551@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/14 10:41), Sergey Senozhatsky wrote:
> On (20/02/13 23:36), John Ogness wrote:
[..]
> > We could implement it such that devkmsg_read() will skip over data-less
> > records instead of issuing an EPIPE. (That is what dmesg does.) But then
> > do we need EPIPE at all? The reader can see that is has missed records
> > by tracking the sequence number, so could we just get rid of EPIPE? Then
> > cat(1) would be a great tool to view the raw ringbuffer. Please share
> > your thoughts on this.
> 
> Looking at systemd/src/journal/journald-kmsg.c : server_read_dev_kmsg()
> -EPIPE is just one of the erronos they handle, nothing special. Could it
> be the case that some other loggers would have special handling for EPIPE?
> I'm not sure, let's look around.

rsyslog

static void
readkmsg(void)
{
	int i;
	uchar pRcv[8192+1];
	char errmsg[2048];

	for (;;) {
		dbgprintf("imkmsg waiting for kernel log line\n");

		/* every read() from the opened device node receives one record of the printk buffer */
		i = read(fklog, pRcv, 8192);

		if (i > 0) {
			/* successful read of message of nonzero length */
			pRcv[i] = '\0';
		} else if (i == -EPIPE) {
			imkmsgLogIntMsg(LOG_WARNING,
					"imkmsg: some messages in circular buffer got overwritten");
			continue;
		} else {
			/* something went wrong - error or zero length message */
			if (i < 0 && errno != EINTR && errno != EAGAIN) {
				/* error occured */
				imkmsgLogIntMsg(LOG_ERR,
				       "imkmsg: error reading kernel log - shutting down: %s",
					rs_strerror_r(errno, errmsg, sizeof(errmsg)));
				fklog = -1;
			}
			break;
		}

		submitSyslog(pRcv);
	}
}


So EPIPE errno better stay around.

	-ss
