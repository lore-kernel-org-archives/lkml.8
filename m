Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F362FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 13:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69382166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 13:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AkyYdyS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgCDN4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 08:56:51 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36863 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbgCDN4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 08:56:51 -0500
Received: by mail-qv1-f65.google.com with SMTP id r15so798207qve.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 05:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rhip11nFmECovpT8lVmLzpPD3W/d2rlBg3mYVPTEngc=;
        b=AkyYdyS8nPkSQXKZ597tNqH6yb1SpRkXmJHVHxqVbM5fXqWPTLgiXZJ3zXtK4pSVAZ
         UPFlP20GJMn3HxihX5oIqnYZ6IaPCfYm950jychfRYSv+PwRaJxWif7QD3xgm7qWa2Uy
         uFJAxC4d73bNdcNwBOEOZl3RARtwcJAZEoUOcoh4DAzF/4yzM3GXSs18t08pn79cVE8M
         QsAeQmvhfW4jVZqcn5YI3kB41XAlQdDW6cF7b5WZCOqrAI0r+aHMrqZfuimI6zrmPqg8
         E5KtDlY1q+Y+kBRM42S2u73yhX0o+fyzcqOcnnghBDoQIN60UyIvb7Rn6O+dlg2yr0dn
         g3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rhip11nFmECovpT8lVmLzpPD3W/d2rlBg3mYVPTEngc=;
        b=FaoYyGc5gzAdk60F/0CQpzPi6lJU6CnTulOs4nU9dXF+a3Dz59mQKE/1hrwJhJi0ga
         GiS8lThy1r9CpcPsdnMj6ewFNYgh8dVLCy21HPcqpeIhz5Xs7ut8Z0jt3T+lRNNb3vHL
         GyGtE+6tbVR9xXEj5qhqjY5hCgDzN5SsbxsNW9dyDcqP7LJ2WGDy8GKdQx61gicny3d6
         IfcnvQnh/REA1cRRUMM/lPSwqStNjMlH8g8YuqyEhMER9cQqnN0xrn71B53oEDxrAn1M
         MO+o6Kj5JqQ1Tvu6PTg6DWncUUTy0nme52d+MSaNN/fLkYUX8GbLBsI6mepKOMDtrXqB
         uoaA==
X-Gm-Message-State: ANhLgQ0y542txgm3bnAG//edxFgY0w0jZVFKf8rqTyQdyxcCfDbLGwwI
        w0yJqLS0Hhqm53Jp+duiEEr4Zg==
X-Google-Smtp-Source: ADFU+vtecS5RrQ+sxl8h3ySuGL8wlLaGGPNxYxgbTg1P8ayAf6WqAVpCIwyGNMIOM2Za30TvZrOI1w==
X-Received: by 2002:ad4:58b3:: with SMTP id ea19mr2220940qvb.80.1583330210441;
        Wed, 04 Mar 2020 05:56:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id a6sm12453365qkn.104.2020.03.04.05.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 05:56:49 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9UW1-0008CZ-3g; Wed, 04 Mar 2020 09:56:49 -0400
Date:   Wed, 4 Mar 2020 09:56:49 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+2b10b240fbbed30f10fb@syzkaller.appspotmail.com>
Cc:     chuck.lever@oracle.com, dledford@redhat.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: BUG: corrupted list in cma_listen_on_dev
Message-ID: <20200304135649.GE31668@ziepe.ca>
References: <00000000000020c5d205a001c308@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000020c5d205a001c308@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 10:45:12PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11123e65e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
> dashboard link: https://syzkaller.appspot.com/bug?extid=2b10b240fbbed30f10fb
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d3b329e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16291291e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2b10b240fbbed30f10fb@syzkaller.appspotmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
