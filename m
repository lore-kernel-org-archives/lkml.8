Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285DAC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0132074D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFoLGWdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgC0CpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:45:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43326 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgC0CpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:45:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id f206so3782133pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 19:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LAMb+jlGrdkLX6VOk3N/mFLnqMd6XkoSxNzF6Ai8PSQ=;
        b=KFoLGWdJUk50xliH1dInPtU9IE8SXuW1ZUBrxy4d76EkLW0+SASrewTXqamugdhOTY
         hb2YJN9pxDWNiHKPWXi8VEwLT46Jfn30xe8HBO80vvfTtEcKXvaHSWRaZU1PKkDgyBDx
         t6zoDQRAuLD9qL400X3C9D+zTP8vgees8ab4VS6udvGE6PyTszZnhqDv8guZG13rZR7R
         rVfU2cHkyGaBqwvqZdrz5PLok/28u2YTfC7vmAO1VZnCl7jdcQyMt7G8bV95wG0Dtkpe
         ZTal2e3oAmL+1AZCT8LwrYVu5rwpWqlgA6uR7fUkOoB0coJO9HNlJM5RT+/pvA/s+7Vf
         3UkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LAMb+jlGrdkLX6VOk3N/mFLnqMd6XkoSxNzF6Ai8PSQ=;
        b=AVDEMb9ZoDR2WPuS6gWqh1WNJYPPTIbeJPjKDO4/R77VoB6R8Xbo8g5knYXGkBa1ib
         P/N94+gbZHddYD/hYrHTtO9svN5EDkda5pPbfS17vIvv4tiSQQ6syTIhesxuvesEmmpC
         m87Qfay7AyVZI09FSsBxQ+uqiN9I9u4lGpYaOJTyo8+08JqSlxieFc8IAOGySnQ9fSpl
         kw3049lgiqie6brwCSI9OYtccWSMF/m97uEhvn1llaIn22mkwNYql+zBkqnDk3a29z7D
         JEUiYFEi4ZhIkPm7Q4UWd4cPjdHh+6uap/a0WanO94AhtsPzm3N34ZLIVUELAWpxdgGV
         ss+A==
X-Gm-Message-State: ANhLgQ0Ku6kMGlHZ1IA6CJvRVPyOwoizKjKl6q+q6aRQYJaB17bJ9jk7
        sik1Ju3LvRm3kkRw/ZYXpfM=
X-Google-Smtp-Source: ADFU+vutCaKHR/azZNcj5vfWMrb+ncvddMxVqa+gyoM/pAazfDJDMMhGKxL+SEZhn3VDXbITC6tOTQ==
X-Received: by 2002:a63:574c:: with SMTP id h12mr12080935pgm.424.1585277103315;
        Thu, 26 Mar 2020 19:45:03 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id v5sm2810584pfn.105.2020.03.26.19.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 19:45:02 -0700 (PDT)
Date:   Fri, 27 Mar 2020 11:45:00 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 0/2] Make printk_deferred() work properly before percpu
 setup is done
Message-ID: <20200327024500.GA211096@google.com>
References: <20200326163245.119670-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326163245.119670-1-jannh@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/26 17:32), Jann Horn wrote:
> While I was doing some development work, I noticed that if you call
> printk_deferred() before percpu setup has finished, stuff breaks, and
> e.g. "dmesg -w" fails to print new messages.
> 
> This happens because writing to percpu memory before percpu
> initialization is done causes the modified percpu memory to be
> propagated from the boot CPU to all the secondary CPUs; and both the
> printk code as well as the irq_work implementation use percpu memory.
> 
> I think that printk_deferred() ought to work even before percpu
> initialization, since it is used by things like pr_warn_ratelimited()
> and the unwinder infrastructure. I'm not entirely sure though whether
> this is the best way to implement that, or whether it would be better to
> let printk_deferred() do something different if it is called during
> early boot.

Hi Jann,

I believe we have a patch for this issue

https://lore.kernel.org/lkml/20200303113002.63089-1-sergey.senozhatsky@gmail.com/

	-ss
