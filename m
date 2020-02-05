Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73ADC35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DF42082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSEFDeWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgBEGgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 01:36:43 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53090 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgBEGgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 01:36:43 -0500
Received: by mail-pj1-f65.google.com with SMTP id ep11so539825pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 22:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NR5HHqY14nVKiwN1pnGOCIaNnlF4MJl1CZSdtbVmuTk=;
        b=aSEFDeWldjG7yFrvO1YqEPyjmp+WjO9Y1I/fRf1tF8L1//bP8rbNOx542hjgvyowZI
         CJTeFWOLyxLIV/k2cRV3Ln7wCL8kXkqHoejpHlrAqfMzhbdfxbqBUePxgYmOLeZsf6q4
         U5Rd7t7jot8QcZ/9SsBgDC10uZfEvwz4eriiIXuosVy0Fi4Ljqhr0oNfjTlVKkEB8JXX
         MOjIgJqmNAGXdmg0AYR+Biamoehpfz8JYeEe32HFRsCl/uBWLxNq5NQKW0ki9YjnwYIx
         sYuObbHtIaewfpxSU3hzyyPtKPFWMZYihtWHZHRAXrAAKM6+yvROtDfzEM1CWZL+sa1h
         Rpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NR5HHqY14nVKiwN1pnGOCIaNnlF4MJl1CZSdtbVmuTk=;
        b=EkepaFLdnVBhqablKoqB17OKw9fHojKBBnXdjUefCBl5yjukVFbFmBAVzp1fO+sZZD
         pCFSZK2iIqg7kxd5ExTroDwBaZCf/ehTIKK7feaASa5gYs7C1p79vbQqttUiyNCFc99u
         YubUnormE+lE0vLqPb3/vl5DVMjHKL4HArcn0u+ukzqe4UvioAUxzYnIB06OqZR7cTk0
         9CVYqyXeOwJEQJ8a/mxgV7f1tsFvbDtxQWGMrsnfql4ea6uPSrqyRjOL/SkjCC6yvETa
         RLraQGBwvoONSN1ZzAhMbkipqh9a0iGPikOvz8N2FbI6WP0jcVxm8HeJdc06I0VuQ77U
         GeYQ==
X-Gm-Message-State: APjAAAULRdeXy7QMB86UFfGqISMuYqBaq8qzWGdyVBb6L0YlBEf8XErp
        KcYDBlL4OHwnXAFhCGcwbSg=
X-Google-Smtp-Source: APXvYqx+puy+6sb4HFx3KAsl7TfpxjwMo113X6yG3BHkUMt1zGTj2Zqfz0NX9sVKRKwlTQJsjYsYcg==
X-Received: by 2002:a17:90a:6:: with SMTP id 6mr3971648pja.71.1580884602719;
        Tue, 04 Feb 2020 22:36:42 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id 196sm27200499pfy.86.2020.02.04.22.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 22:36:41 -0800 (PST)
Date:   Wed, 5 Feb 2020 15:36:40 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     lijiang <lijiang@redhat.com>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
Message-ID: <20200205063640.GJ41358@google.com>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
 <20200205044848.GH41358@google.com>
 <20200205050204.GI41358@google.com>
 <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/05 13:38), lijiang wrote:
> > On (20/02/05 13:48), Sergey Senozhatsky wrote:
> >> On (20/02/05 12:25), lijiang wrote:

[..]

> >>
> >> So there is a General protection fault. That's the type of a problem that
> >> kills the boot for me as well (different backtrace, tho).
> > 
> > Do you have CONFIG_RELOCATABLE and CONFIG_RANDOMIZE_BASE (KASLR) enabled?
> > 
> 
> Yes. These two options are enabled.
> 
> CONFIG_RELOCATABLE=y
> CONFIG_RANDOMIZE_BASE=y

So KASLR kills the boot for me. So does KASAN.

John, do you see any of these problems on your test machine?

	-ss
