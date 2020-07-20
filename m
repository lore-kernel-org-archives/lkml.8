Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D9DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13EF722B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfdMPEas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgGTIlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTIlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:41:06 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CF2C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:41:06 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m16so8370913pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wJVaqEwj+i9esEAclMGRP9Zfh0g/F6dNbku9w6XnviM=;
        b=TfdMPEasQT3G+tfqzADvLujHuxexhLRJ/plXttAQMI/n79r14vE+9EgS9X61y2x1ai
         +NffY2FQTULcj5DhilVQK0uMlOQCO1O4IwpfxJYeCoAPlyc5FAETNZ9n0AZJI5gMxrHu
         yy0O/H5bNUky91nSddtnq0aguz31//kJvMFbLTolcHAtNidnrFe5N6Z2Vz7AwaJTEj18
         UNHkDqQV5l5MaiADb20P9L/4VsBCkJAV3RRjJvCjWP4ehVgNSXJRvIzm37jw80pM8QtT
         9uF8pLlEdopnr7CKw7KGdlQJBfvj3EHl8K8IjJOglIaVK+vV7sPk28X8HBQr6NVzPyzU
         iE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJVaqEwj+i9esEAclMGRP9Zfh0g/F6dNbku9w6XnviM=;
        b=RQM9vKYXWEsmtvT5FyGeL/+3625BiUoGmCOywtQy0a9WV7nHAoGfnOHrV1draNRlEY
         T7QTOnCMr+iqs3O+ONSG758irL2bFpqYK2Sw4F7/v6LBQNUp01udjh4D8g4DOVg64Eal
         D8UrtzSsfswYN4shqsZ0eisGUnKjhs7IdOLi3YIqgYKXPVGwdpyqUPaxY7Uo9PI3JQjZ
         kmZBrIypCd1+SuG3BHcZVPhWmf5qSoXMCY+POLkxaGi/lKFN4c1SPC9l8QcAWzd9UDH/
         tfRSJDcMCNHtVpZsYEduV9EnOvq4Yy/EziMfxTrOoEOLpCpM5TjpzWHrvNMbOUbKX1fA
         MIrQ==
X-Gm-Message-State: AOAM532+cJEmhTXhmzFpf+H/hcQ71G5+idDcREGMJwpuJkP3A77CK4f1
        v1wTQvgwlYfUW9grGdWbGFI=
X-Google-Smtp-Source: ABdhPJyw0SFDFAB9z1Re98/4CrbPAPEVCxg/GXuVgVhN0OjY0CiciY/rJMPbK9vj3nWWM+V4/+y8CQ==
X-Received: by 2002:a17:90a:cc03:: with SMTP id b3mr20585675pju.80.1595234465832;
        Mon, 20 Jul 2020 01:41:05 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id u66sm16035298pfb.191.2020.07.20.01.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 01:41:05 -0700 (PDT)
Date:   Mon, 20 Jul 2020 17:41:02 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] printk: use the lockless ringbuffer
Message-ID: <20200720084102.GC463@jagdpanzerIV.localdomain>
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-5-john.ogness@linutronix.de>
 <20200718121053.GA691245@elver.google.com>
 <20200719034312.GA566736@jagdpanzerIV.localdomain>
 <20200720064303.GA2144711@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720064303.GA2144711@elver.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/20 08:43), Marco Elver wrote:
> On Sun, Jul 19, 2020 at 12:43PM +0900, Sergey Senozhatsky wrote:
> 
> As I said, a number of debugging tools use them to format reports to be
> more readable (visually separate title and report body, and separate
> parts of the report). Also, such reports are often parsed by CI systems,
> and by changing the reports, these CI systems may break. But those are
> just the usecases I'm acutely aware of

Can you give example of such CI systems? // that's a real question //

	-ss
