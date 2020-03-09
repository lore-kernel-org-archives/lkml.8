Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F05C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E362B222D9
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Cr+A+zgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgCIRVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:21:52 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:33535 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgCIRVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:21:52 -0400
Received: by mail-qv1-f66.google.com with SMTP id cz10so1322803qvb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rXjYgzydEIFf6l4K9Z+TCKu5LCpXzo28EhasuTaYcPc=;
        b=Cr+A+zgpZdvxbpOgYgNFNbOk7jcWMIim0WKuj8k5ZLfc9pq/eLdoUOtag1aVvG90DB
         fACdHaxZ9DUgQoPDU+xUerOF8obi3FgOOSHln+z3aZF9ZtzfRbJJ3QMt0iTKmAb5Tdb1
         VEk/G9iiHGDON4B7ESjtKiohfcYBvRb6b5UdTs/ZhjmJu4IV0CO8P5Fo53NAhUHUhfUS
         kyWd0zdIwLqG2IIb40smVrle8jemsBXnf0hf9LzWQoVb353+gD0zFbPcbo/bYlPLTSjT
         m4uva7wEuPZtbQc4HC6ABUyvS3DHiTFRx9fe0mJs7CRzGCq8Ppfq8oGxOl8uYjGAMvaJ
         0y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rXjYgzydEIFf6l4K9Z+TCKu5LCpXzo28EhasuTaYcPc=;
        b=d4fCemi4/qg0E8pdP7ISDzydxEco7hsk8a0+Ekfbk6BfqtuK2LFm7oWzCbssrULZsT
         zCJ1HiG2zBvmDFg7bWq9CYdv6NYxqlt86AE7mifo/s5hSegDfgSLEMjd0ypS3YEOIBoa
         7FJCHRxBNmUvx4AmBCKe0d36A6Z3BnXFzhXIp+DRGGvLeuA+7RcJvGScRX606xQwBtoo
         e3S7di9pUH5XJ4zqnOkhreU1J8JAQNRiskycN6qlM14j6vdZwE4M+98Xtoc83S8JBAPM
         Mwd0AmUmr1j8VvlIa6DZuu2EpIr0+JqWeEw0bKBKUdtmLOtjYjoNaog3JFtR+NJt9BRL
         7cqg==
X-Gm-Message-State: ANhLgQ1oiZliWXZx/U1NlrpDds2/37AOshQBxnePtsUyfFWuK5ev0ZYY
        flUmjIqxMUb+OP0HG970nTAgog==
X-Google-Smtp-Source: ADFU+vv1L/8G08f/Yc85KgGY+AnoOBeVnN2dPlRns5bBi0k507dbTfnEb3f5U4Ev6N1wE3oD9bTBbQ==
X-Received: by 2002:a0c:c209:: with SMTP id l9mr1222037qvh.190.1583774511330;
        Mon, 09 Mar 2020 10:21:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 17sm5825822qkm.105.2020.03.09.10.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 10:21:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBM6A-0003hk-Cd; Mon, 09 Mar 2020 14:21:50 -0300
Date:   Mon, 9 Mar 2020 14:21:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+0abbad99bee187cf63d4@syzkaller.appspotmail.com>
Cc:     chuck.lever@oracle.com, dledford@redhat.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in rdma_destroy_id
Message-ID: <20200309172150.GU31668@ziepe.ca>
References: <00000000000059e701059fe3ec2f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000059e701059fe3ec2f@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 11:09:15AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=160452c3e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
> dashboard link: https://syzkaller.appspot.com/bug?extid=0abbad99bee187cf63d4
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0abbad99bee187cf63d4@syzkaller.appspotmail.com

#syz dup: KASAN: use-after-free Read in rdma_listen (2)
