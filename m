Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2126AC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECCD520720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589208580;
	bh=0BnE4wcUQiL5YliJfP6v8Tw5oJC+F0CqQy3cjkLBUuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=thdPFNOqauSOOfSJZODGYIAgYVz4/yJyyxHrFqTf+xizcLs4tvbO0OMr5JTAIgAj0
	 9e7nzA7uyeFGIIjjzSHoYuesH9Te1OFLB515I8sPTpQ3t8/ogWfCGyvxscbpbbrkZC
	 Xfk0Kg6Yih6kw4roh21+KG8vYZXnxayBgk5LmTgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbgEKOtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 10:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729463AbgEKOti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:49:38 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2992C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 07:49:38 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b6so8863214qkh.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gkrV0mSw419OC87OxKvOah2CgTI8JgcXYdLtKZtu+jI=;
        b=IZbkwj0dnYrfFciYxfmYFQ5udCQAC5qHRAPV9NNl0BoWruyERrJx3TquhZmI4vKroe
         bTPMv9wD6vIj8W55dt+aqU/X8/3frl3lNqZxFJjTsjkVU63G/mpVcOYbRJAsG6ftrYR8
         g/xpUNmnUFiFuwoNOEQtHFdIb/8b+UbRe7YsoKYIWSukk8twD4NgDyYEwFhtVIgvlpIT
         JqSCVJ6wok5wz5QnxN7pTC60Af6N0jD3c84DQp43B6zVkh40aBT5/whHXGLxQhb6XVWJ
         9Ddi8+64W/Wd1WjaALSO49zCtcKtaU7YziO8rguwnAY9T8WRNPQcYTbCQW2+e6ZEkYUD
         GK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gkrV0mSw419OC87OxKvOah2CgTI8JgcXYdLtKZtu+jI=;
        b=e/X6uQZgj/wxUklzigFw6wi6MUklu1uH3bW4u/O3ULsnnCr96OUhWWJ14MAwFMstJY
         I2+R91ndOQnpBt7sznFEZ+rtb4e6AgBN4h2eoihZhM34QTuzeWgL1YqkziLrpTA5vC/t
         CpCLCxrkyMFCA28KvO4DdyG6z4xau3Y4dB+ZKlZdVA5hicF1klbnc8PFjq3JxcP3ffZI
         WqsFeyk3EOnTeIlH1yfL4NEAvicZe16B7UD7FDCcnfAeUjGVtPS9LqCCeLmWYuO+5WXo
         zdsGyYy4XPhU4NzHWLYwkwBMOzXqVd808rpxjcLztY1O9i+CZLFB44/u35wBGI8oPYC+
         7/7g==
X-Gm-Message-State: AGi0PuaHEXyr+uISmrb2xXnT198+PkpEHZffDYSMUSD2t/cS1Vkz/xR8
        Nuslu6LG89F6ZizAgObHHdg=
X-Google-Smtp-Source: APiQypJoAuzVyc03cgE6RzbdljWE3MFT+haC+VE9LQTe3tyxSQRdD9fFW6Menc2CmBM6PpOz+553Hg==
X-Received: by 2002:a37:8302:: with SMTP id f2mr15691637qkd.220.1589208577620;
        Mon, 11 May 2020 07:49:37 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id b198sm7594350qkg.37.2020.05.11.07.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 07:49:37 -0700 (PDT)
Date:   Mon, 11 May 2020 10:49:35 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Liang Chen <cl@rock-chips.com>
Subject: Re: [RFC v4 01/12] kthread: Add kthread_queue_flush_work()
Message-ID: <20200511144935.GD16815@mtj.duckdns.org>
References: <20200508204751.155488-1-lyude@redhat.com>
 <20200508204751.155488-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508204751.155488-2-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, May 08, 2020 at 04:46:51PM -0400, Lyude Paul wrote:
> +bool kthread_queue_flush_work(struct kthread_work *work,
> +			      struct kthread_flush_work *fwork);
> +void __kthread_flush_work_fn(struct kthread_work *work);

As an exposed interface, this doesn't seem great. What the user wants to say
is "wait for the current instance of this guy" and the interface is asking
them to queue an extra work item whose queueing return state should be
checked and depending on that result wait on its internal completion.

I'm skeptical this is a good idea in general given that unless you define
"this instance" at the time of queueing the work item which is being
waited-upon, there's no way to guarantee that the instance you're queueing
the flush work item on is the instance you want unless the queuer is holding
external synchronization which prevents the instance from running. That's a
really confusing semantics to expose in the interface.

What the above means is that the ordering that you want is only defined
through your own locking and that maybe suggests that the sequencing should
be implemented on that side too. It may be a bit more code but a sequence
counter + wait queue might be the better solution here.

Thanks.

-- 
tejun
