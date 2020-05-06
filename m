Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FE3C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0101E2078C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMwrOBLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgEFJVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:21:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42788 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728385AbgEFJVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588756881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aIo2zuJchWCSmqy9y7JZdRjvNdfxtS8vv0xwKTDl+iM=;
        b=SMwrOBLn+Apx9jMwm0pLX+bFiXqleUdeAVLWUYRL+dpRQLJ6rl5Pd1pb2Yiuq3BgopEwML
        kvALd4BZ9dcPrp2F3VopHGbpPx+w5HjO2ldtVrldAWrEg7l2QmF3ta7fru7A9D8kjOw46I
        6jWV846I4/Z3Zn9ASOVX7kBomu997J0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-G5iF5F6aPiyCW8gfT-F_5g-1; Wed, 06 May 2020 05:21:20 -0400
X-MC-Unique: G5iF5F6aPiyCW8gfT-F_5g-1
Received: by mail-wr1-f70.google.com with SMTP id u4so996564wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 02:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aIo2zuJchWCSmqy9y7JZdRjvNdfxtS8vv0xwKTDl+iM=;
        b=tuVAqITKexhTy7mfMuk98kgTY7XxVtKOPWO9djlBsuSoGiMmwZBQQ3u4CDlh0IObno
         4VcB4+weXb4U72D1dz4vKsbMAIcXbzE5aphSYfHMSIS6PVUSfTH0xpaz/hpcEdbqubbB
         NG7CF5twftEJm3nGnQsVOFn5/mcllNHWCE5WDYSu5ZW7/6LMip2cjVLZ6PCtP7sT/SYk
         eXC5dA74VJR5tzaiozDbv8L0F6lEcu0rXuVRT0m/SmKrHSk0hvPwhg5+i4buiwgEX8uU
         LEQPGnPXQQa9i8cKEyWqFvuyVYPW7KViMTzlLA6RpTGG6J+vTtIvzN9udoapzn2PhFNe
         lO+Q==
X-Gm-Message-State: AGi0PuaQbO5M/2pu0pW2B1Hm04kC6Y5/rwZbd2SHFoI57N+p4FkreW+N
        X8jiO9OsXXCk7auztcJa2z/DmWyVoJUJt8hMu/NMBLCiVAC1q6gX/7bmdZ8EYpY3F/znf9668kX
        etKicaISzXRhXrEMtG8bVoFAd
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr3297082wmm.104.1588756879041;
        Wed, 06 May 2020 02:21:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypIjTzrGAR4XHcO8KggyM1MB+dxXNV1av9LaxnOCk+jHtQJuOYZkS4SQDdtE1ApTxRl4oA/LKA==
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr3297051wmm.104.1588756878796;
        Wed, 06 May 2020 02:21:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11d7:2f21:f38b:17e? ([2001:b07:6468:f312:11d7:2f21:f38b:17e])
        by smtp.gmail.com with ESMTPSA id 1sm2125032wmz.13.2020.05.06.02.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 02:21:18 -0700 (PDT)
Subject: Re: [patch V4 part 2 15/18] x86/kvm/svm: Handle hardirqs proper on
 guest enter/exit
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
References: <20200505134112.272268764@linutronix.de>
 <20200505134341.579034898@linutronix.de>
 <baf61125-72f4-5fd1-9ba1-6d55a2efdddd@redhat.com>
 <87imh9o3e1.fsf@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cade8b44-4330-2dc1-e490-c2f001cc1c95@redhat.com>
Date:   Wed, 6 May 2020 11:21:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87imh9o3e1.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/20 10:48, Thomas Gleixner wrote:
> So for instrumentation, especially interrupt disabled tracing we must
> track that change otherwise a latency analysis would claim that
> interrupts were disabled for the full time a task spent in user
> mode.

Oh okay, that's clear now.  I would just replace the four bullets in the
first comment with this sentence, and remove altogether the three
bullets in the second comment.

Thanks,

Paolo

