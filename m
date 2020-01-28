Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0B3C33CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 03:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3DA24656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 03:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Efi5LnPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgA1DNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 22:13:01 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41184 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA1DNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 22:13:01 -0500
Received: by mail-qk1-f195.google.com with SMTP id s187so11969298qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 19:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CpTBH/hTdT0l/F/L7CxZYEhY24qneYEjEGIWtIprfiY=;
        b=Efi5LnPyMAIecBLN14nFMkFpsmRO5Al2/cM+y8IY5etEk3WqBqCZDDCqfK6pW1ZNdi
         lDgfVhZCIfTPbY/k7zLnZncTK5tJDcvT31P0QCQOj2o8joAyY38cQexDd/taYhbzdFFl
         hRXSy4EDXwjYePdlUcZQ1LAsNRB4zWgqEGFl6qj2atr07FFpoFJL7VYmLlKr42A3d9ZX
         MlLdbXRfq/wEBn1dQtDWWIQEXxK2EUEUqNWBvEoOYeNP+1E208cTNV+k6WxfH5eaxI/i
         HxSfxKnhPBhNFmYryxr7WZ3cGcpUHUupmnM+1so27fTSJsIPHw+9Pd4NIZ4Od/ipOyvy
         Qu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CpTBH/hTdT0l/F/L7CxZYEhY24qneYEjEGIWtIprfiY=;
        b=BQErGYDbHHj4kUR/Rcv3RwYlz8daCPCgRkwJe6nQ+JXH+xEY+Ya9OKhN/KRk55lCDN
         Hh40xd7jW37z9xWotx2PIpmjQO9Ppuy6e5yYQIO0subYoGeeEYCrBvIQNBBh2B85s8a6
         svgD2GXz8o/rT55XlJCZlw4EMsYnno8fwgaKsJSC3XfXAZ2ZG9OKB5EyWGqdlTCIU5iS
         wRQIc9j0sTCCgFjdcDtuSqRI5R8owYiez0EdGM7fbhTtRQsLdvgKAxS23Yi21bpB5b3H
         yiCMX1nLb9x55TLMHuA0EeD1qFxoxLfMQx7e+drTpX10evLcdobbys+Thocz3MeUvn2V
         S7YA==
X-Gm-Message-State: APjAAAX2oV1TPknP5qX0D57TJ6bNZA1hjltbWDp+Pm756XgnAO3C/4ph
        KmcJKIwXXDRmbIsKo4LloJ5Yhg==
X-Google-Smtp-Source: APXvYqxR1KIR0UzMdtpQI+dBNc6x/4TRFTnA4cRgKEOKNxl4FhnixuICLM+1KNjSHPa2kTJJu+vrAw==
X-Received: by 2002:a05:620a:1001:: with SMTP id z1mr18549202qkj.99.1580181179751;
        Mon, 27 Jan 2020 19:12:59 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z34sm11628640qtd.42.2020.01.27.19.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jan 2020 19:12:59 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200123093604.GT14914@hirez.programming.kicks-ass.net>
Date:   Mon, 27 Jan 2020 22:12:58 -0500
Cc:     Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "paul E. McKenney" <paulmck@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <2E13BFD2-A2E5-4CAA-B0D0-0DF2F5529F1B@lca.pw>
References: <20200122165938.GA16974@willie-the-truck>
 <A5114711-B8DE-48DA-AFD0-62128AC08270@lca.pw>
 <20200122223851.GA45602@google.com>
 <20200123093604.GT14914@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 23, 2020, at 4:36 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Wed, Jan 22, 2020 at 11:38:51PM +0100, Marco Elver wrote:
> 
>> If possible, decode and get the line numbers. I have observed a data
>> race in osq_lock before, however, this is the only one I have recently
>> seen in osq_lock:
>> 
>> read to 0xffff88812c12d3d4 of 4 bytes by task 23304 on cpu 0:
>>  osq_lock+0x170/0x2f0 kernel/locking/osq_lock.c:143
>> 
>> 	while (!READ_ONCE(node->locked)) {
>> 		/*
>> 		 * If we need to reschedule bail... so we can block.
>> 		 * Use vcpu_is_preempted() to avoid waiting for a preempted
>> 		 * lock holder:
>> 		 */
>> -->		if (need_resched() || vcpu_is_preempted(node_cpu(node->prev)))
>> 			goto unqueue;
>> 
>> 		cpu_relax();
>> 	}
>> 
>> where
>> 
>> 	static inline int node_cpu(struct optimistic_spin_node *node)
>> 	{
>> -->		return node->cpu - 1;
>> 	}
>> 
>> 
>> write to 0xffff88812c12d3d4 of 4 bytes by task 23334 on cpu 1:
>> osq_lock+0x89/0x2f0 kernel/locking/osq_lock.c:99
>> 
>> 	bool osq_lock(struct optimistic_spin_queue *lock)
>> 	{
>> 		struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
>> 		struct optimistic_spin_node *prev, *next;
>> 		int curr = encode_cpu(smp_processor_id());
>> 		int old;
>> 
>> 		node->locked = 0;
>> 		node->next = NULL;
>> -->		node->cpu = curr;
>> 
> 
> Yeah, that's impossible. This store happens before the node is
> published, so no matter how the load in node_cpu() is shattered, it must
> observe the right value.

Marco, any thought on how to do something about this? The worry is that
too many false positives like this will render the tool usefulness as a
general debug option.

