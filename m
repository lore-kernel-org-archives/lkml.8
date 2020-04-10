Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CA1C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B0F20936
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJkyy99g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDJDHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:07:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46410 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDJDHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:07:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id x2so229053plv.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 20:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3yUNcbv0islnmYqkqeF/uP+mdb2JR14P5vkgcv9DY0c=;
        b=VJkyy99gnCAfDC7NDrLPj1S2EvIFVYgS5Kxx7pK7s7XeI27On6F4uDUx5xxFEnFUPr
         v0kjAw88vqEfj+UevpIILgrDWKsNsUpnZi5DsYiDrb3OoAIrOXnx1TztOWGrZW1JDoCw
         RGma0Bv/f1l+Xp+fltV6pFY7do5Lz2YAMcpJOIqYs/kjvoiHq4Ku6zi0gTFGuw2jd8kp
         EO3Ypv205K1CRPhPRCbC/B81yQ5m+tVGgM01Ctthnl3z65EsoqYUhkJp7xdfFObK48DI
         ZRTuGdrGn9iikmCzeaM/fc6ZRxrGkPzQp8rRgOMzb5pJTyS5ig68LjFN3R7/D0JljCOz
         2mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3yUNcbv0islnmYqkqeF/uP+mdb2JR14P5vkgcv9DY0c=;
        b=bmrFWj8LlHiofOFT5wEnMRz4rhQADRnoX8FtgpwcyGQKT94ckKwyofW/nI2+/6to9p
         fi1dF6g5KQ1oggnH55P0WG6rdsvaDABC4ih7ro0kH03FkPbnoIrRcJnGDdkLmR0k1ABm
         nC9dpRlJ/PS9Mjjf0HowH6Ya8Zg7S57aMhXPsYKrAT4bHW9aOcQssz9ZcpSFFUVL6HQv
         EJzkd7aPCnMyCLvoZTn9jEiTkXyHuBNlFlkbzUldtC8Fo9PuP3bvFHPoh2tBNEjZ1sXM
         xzpZDUU1wAx7mlR1EKwjEccNrS8Z1QiNBt1YhdSlE4WT7p93/2gdJY5TuJeNBn7vFnSy
         32BA==
X-Gm-Message-State: AGi0PuZxUMb527h0HAL8msbyhKi0OixxJq/XPWH7W78gf1s0w+Ga7Ef4
        c4sD1ICyctiUSTwz52OS6Mo=
X-Google-Smtp-Source: APiQypJ3WUH11Y+cYL97vBPFSjgNOCW4MussbBa9Rw5A9M0HrW5aiPyek1EVt56u2RnUQ3UkFN7msQ==
X-Received: by 2002:a17:902:dc83:: with SMTP id n3mr2674301pld.133.1586488028335;
        Thu, 09 Apr 2020 20:07:08 -0700 (PDT)
Received: from localhost (181.56.30.125.dy.iij4u.or.jp. [125.30.56.181])
        by smtp.gmail.com with ESMTPSA id a2sm469455pja.44.2020.04.09.20.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 20:07:07 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 10 Apr 2020 12:07:04 +0900
To:     Simon Kirby <sim@hostway.ca>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Theodore Ts'o <tytso@mit.edu>,
        John Ogness <john.ogness@linutronix.de>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCHv2] printk: queue wake_up_klogd irq_work only if per-CPU
 areas are ready
Message-ID: <20200410030704.GA20227@jagdpanzerIV.localdomain>
References: <20200303113002.63089-1-sergey.senozhatsky@gmail.com>
 <20200304152159.2p7d7dnztf433i24@pathway.suse.cz>
 <20200305013014.GA174444@google.com>
 <20200305185348.GB2141048@kroah.com>
 <20200409192543.GA30816@hostway.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409192543.GA30816@hostway.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/04/09 12:25), Simon Kirby wrote:
> This causes "dmesg -w" or "cat /dev/kmsg" to not print new messages after
> dumping the current ring. I hit this on v5.5.9, v5.5.15, v5.6.3, and
> Linus HEAD. This prints no "hi":
> 
> (sleep 1;echo hi > /dev/kmsg)& dmesg -w
> 
> ...curiously, "strace dmesg -w" shows the data received once ^C is hit.
> 
> Jann pointed me to this patch. Applying it or reverting 1b710b1b10eff9d4
> does fix it for me. However, Linus HEAD is still broken and, AFAICS,
> remains unreverted and unfixed in stable/linux-5.4.y through linux-5.6.y.
> It was introduced in 5.6 but backported to those, not just the LTS above.

I'm trying to land this patch. Give me a moment, I'll come back to
you shortly.

	-ss
