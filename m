Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAE9C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D292072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgAQVfR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:35:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41893 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQVfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:35:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so24066752wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 13:35:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=o2fqcGfWxtJPFlRizLS1TkRitXuWxcEwfNysk0XM7rU=;
        b=k4LEkXlgmY23JMGG+0mVz+7gpnmNH4qLvTiLq0nV6Zmapmz5S2K8MWfnphioq2FJrW
         U0DF0JqlKRdgeSjIW1vCpA/E0Fq2uAb5s3UfUkyfuVzjbKO542k4TriWiCYCOplXQ3/z
         VuZrC3CBgfdF7ZwmpsriqkI5Zzsjth90SC1X4KTnGfVUWWo4r1guU6tyBjNOOS7UyxjR
         B1ARWDQHVpaiEpQ5rExcqEfRH2jYUiEAB87HQxNgOgS6L/c5JO7tkcW4n2VmjKkuL0Wy
         iZRZdhGQJk9UOruM8XMqvA8RXkR3aagjLRZS5MKb75vBoCB7FQH719KNxmdoaBE2gd36
         +rRQ==
X-Gm-Message-State: APjAAAWA/DlhBmpMOjjGEvcaQS4ks50vsLWQtqZxcOoGAnbBv+u6w4tS
        pElxqXZZ8dG0U1i/UnUTs8vgjQ==
X-Google-Smtp-Source: APXvYqyHWpcY60WKn83COQcXQugLgcyUp3t2aQN/feyxetYQqOMaMmatAspUNYWJ62OIdUeEDdPMUg==
X-Received: by 2002:adf:f7c4:: with SMTP id a4mr5009738wrq.332.1579296914300;
        Fri, 17 Jan 2020 13:35:14 -0800 (PST)
Received: from [10.10.10.158] (x4d0be21e.dyn.telefonica.de. [77.11.226.30])
        by smtp.gmail.com with ESMTPSA id s10sm35422872wrw.12.2020.01.17.13.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 13:35:13 -0800 (PST)
Date:   Fri, 17 Jan 2020 22:35:11 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <202001171310.A74535C0@keescook>
References: <20200117105717.29803-1-christian.brauner@ubuntu.com> <202001171310.A74535C0@keescook>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3] ptrace: reintroduce usage of subjective credentials in ptrace_has_cap()
To:     Kees Cook <keescook@chromium.org>
CC:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, stable@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>, Eric Paris <eparis@redhat.com>
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <8D8E192A-37FE-4A08-AAAA-957EFB38A5A3@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 17, 2020 10:15:04 PM GMT+01:00, Kees Cook <keescook@chromium.org> wrote:
>On Fri, Jan 17, 2020 at 11:57:18AM +0100, Christian Brauner wrote:
>> -static int ptrace_has_cap(struct user_namespace *ns, unsigned int
>mode)
>> +static int ptrace_has_cap(const struct cred *cred, struct
>user_namespace *ns,
>> +			  unsigned int mode)
>>  {
>> -	if (mode & PTRACE_MODE_NOAUDIT)
>> -		return has_ns_capability_noaudit(current, ns, CAP_SYS_PTRACE);
>> -	else
>> -		return has_ns_capability(current, ns, CAP_SYS_PTRACE);
>> +	return security_capable(cred, ns, CAP_SYS_PTRACE,
>> +				(mode & PTRACE_MODE_NOAUDIT) ? CAP_OPT_NOAUDIT :
>> +							       CAP_OPT_NONE);
>>  }
>
>Eek, no. I think this inverts the check.
>
>Before:
>bool has_ns_capability(struct task_struct *t,
>                       struct user_namespace *ns, int cap)
>{
>	...
>        ret = security_capable(__task_cred(t), ns, cap, CAP_OPT_NONE);
>	...
>        return (ret == 0);
>}
>
>static int ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
>{
>	...
>                return has_ns_capability(current, ns, CAP_SYS_PTRACE);
>}
>
>After:
>static int ptrace_has_cap(const struct cred *cred, struct
>user_namespace *ns,
>                       unsigned int mode)
>{
>	return security_capable(cred, ns, CAP_SYS_PTRACE,
>				(mode & PTRACE_MODE_NOAUDIT) ? CAP_OPT_NOAUDIT :
>							       CAP_OPT_NONE);
>}
>
>Note lack of "== 0" on the security_capable() return value, but it's
>needed. To avoid confusion, I think ptrace_has_cap() should likely
>return bool too.
>
>-Kees

Ok, I'll make it bool. Can I retain your reviewed-by or do you want to provide a new one?
I want to have this in mainline asap because this is a cve waiting to happen as soon as io_uring for open and openat lands in v5.6.
I plan on sending a on sending a pr before Sunday.

Christian
