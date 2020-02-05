Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AB7C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 04:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5182085B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 04:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0QmZBta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgBEEmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 23:42:25 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39961 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgBEEmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 23:42:25 -0500
Received: by mail-pj1-f66.google.com with SMTP id 12so415652pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 20:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9STCbbuzxRjANH/8OF1zRC4hgXnZKSXlKFJvi0xPy10=;
        b=s0QmZBtaYq9wJo2YpX882G8dcPqRlZeffRqtA1pRr6NzmdCX6drgxppRxSUmkT3YR3
         ZBGG0DnwvBNW64eDV4GYDLzdLIrDXQE1KTHSbzRdbL4X2GpUls2lbY8jWYYL4RDStb1m
         RBZJtUsHXHET38dFjNc3vUSiaCOiZ06xH+krCTZpDotgW71JNw452hxQt/MaEpzd5FPV
         mDUEU+IAygqTbV0b5wt8n1QAUvfwdqYoLoU/XAJbIkWQubg22QMuTHxFGFMrZFz0Cd4k
         QCyVJIKtG0R90WnRMWZKKnKRPoQTuIY2iLnPt7SqOCumyd5Oky2XKCSQryWAMfVnxSvF
         nrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9STCbbuzxRjANH/8OF1zRC4hgXnZKSXlKFJvi0xPy10=;
        b=edX76az40xi41OWb+8JdiMoAgcghIooBkuSJ4EtVJMdC2PM0p4gHfMujEZY6a8uY1j
         LF/1qaVvUIVBtPtislOw7M1El2ZkQTMgrhQZRnTLIeTCY4eBs0cHMZmKeCIkxnjeY/y6
         yaVfdcRZwhV/Mb9BDwbYj6LkWz5yT+1okTvre+E/aNwI90YSy4fMRzPFiayHnCfD0XYF
         XCabbzrsSwEAKTRgM9gPE52jg86528+AvGbxwPIZH6qNmUW+L80eNNeDao7HIpSwfJ4U
         PI8wiyY+tz795eFMRWbZYecRD/gsfd3gjiWDxNmKLrxH+vZ8fJdOaSvEzB3kDbXMfbKM
         Lasw==
X-Gm-Message-State: APjAAAXmcwh5s3NOnPXlc98N4d99RgJFF0an9ECAKkLKJy4oPWHgQdiq
        kgjR5xeXw4J4QhYGoAhWIpk=
X-Google-Smtp-Source: APXvYqxmOsNib4rBggoP0d1dSb7To7lUzPBF19d+DrOzknfbGCeWJmN9lff3J+lL3SncHQkJBQ+uEg==
X-Received: by 2002:a17:902:8341:: with SMTP id z1mr32369408pln.178.1580877744529;
        Tue, 04 Feb 2020 20:42:24 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id 144sm24548510pfc.45.2020.02.04.20.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 20:42:23 -0800 (PST)
Date:   Wed, 5 Feb 2020 13:42:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     lijiang <lijiang@redhat.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
Message-ID: <20200205044221.GG41358@google.com>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/05 12:25), lijiang wrote:
> Hi, John Ogness
> 
> Thank you for improving the patch series and making great efforts.
> 
> I'm not sure if I missed anything else. Or are there any other related patches to be applied?
> 
> After applying this patch series, NMI watchdog detected a hard lockup, which caused that kernel can not boot, please refer to
> the following call trace. And I put the complete kernel log in the attachment.

I'm also having some problems running the code on my laptop. But may be
I did something wrong while applying patch 0002 (which didn't apply
cleanly). Will look more.

	-ss
