Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B298C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8F120828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lkN3y01M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgCIRU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:20:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43156 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgCIRUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:20:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id q18so9970691qki.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 10:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/ltngBYRTq01VJ1mavtyfY7YquNSfQ240OOdDMNjEPw=;
        b=lkN3y01M+jRbyXcB2PTb34TCdZkzqNCpr3kKRGVsbTTkmQCpclvMil0PXwAnoS7hXJ
         IHgdcbnWhm53FlGQg+nw2uV+Uv8AN36EuGK2iJ2reiBH2vBPtIYTShFayJ/hGx6U1LR2
         nsxMOTTqqYuosJEz6PJ/49jXPJ/EtVbUp1IBJo1y0BWpDSMGvwGHvMIQcYtc1Iiz71K7
         cEvrkldGv792Wd+HiWmspFBhqY2pMPueB54emrTEyyDmQfgjxjrn21aEG/z5/tdiQ+5o
         xSyBwtLHD3ajRg8UVKDvavghCUhfG9ljykYwmIoITTQABBWIc6DRgHqHa/DPRqWX54vu
         68kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ltngBYRTq01VJ1mavtyfY7YquNSfQ240OOdDMNjEPw=;
        b=C3OlzbBxhSs69W7Dnsbt+JNvhS+6v+S2ILo2bqvH1cNn0H2lKjkwAl5Fze9yggCnNd
         JjYKeU8YdZz6ho4jZOZAxmONcau1oM6YvDehNDHo0UTxHfr6Yq8s3xcmFUJrBKaYywZb
         1wJyc03CPCqFf87kVgCBQjoDzbcQH8H3W2mRKWCW/SjGFDRHQ+UEn6ld9wwhmTnSFyqk
         ElbfUxBdtVutWGK/07zYWLxJamkddPVT+85WZTohVK3D/Wydkozu2cmYjMCT4eB1+iVL
         ooYZWD4SFvB44mpfEUlvUtKUxo5V/eawXZB5iPJ8k9E2LV5YATPlr7nz9x4JULoT3Ebi
         5Ltw==
X-Gm-Message-State: ANhLgQ1moTbURP2qMycha98soNr23S2eT6Vpewj5ioM/cF4Rjl8uPa1C
        wx1OLiHa9VIOgawcySMRK72qMQ==
X-Google-Smtp-Source: ADFU+vuon4UvVQ0IcBAxERt2kYVbP0L54kTICvX/0VCM97k+xQUtNluXnTuD0CRyl2AanS/HYCF5Pg==
X-Received: by 2002:a37:7744:: with SMTP id s65mr14967669qkc.405.1583774424715;
        Mon, 09 Mar 2020 10:20:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d1sm22308790qkj.29.2020.03.09.10.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 10:20:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBM4l-0003gE-Je; Mon, 09 Mar 2020 14:20:23 -0300
Date:   Mon, 9 Mar 2020 14:20:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+3fbea977bd382a4e6140@syzkaller.appspotmail.com>
Cc:     bmt@zurich.ibm.com, dledford@redhat.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in siw_create_listen
Message-ID: <20200309172023.GS31668@ziepe.ca>
References: <000000000000161ee805a039a49e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000161ee805a039a49e@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 05:25:10PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    68e2c376 Merge branch 'hsr-several-code-cleanup-for-hsr-mo..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10c92e91e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7e519c35f474a428
> dashboard link: https://syzkaller.appspot.com/bug?extid=3fbea977bd382a4e6140
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3fbea977bd382a4e6140@syzkaller.appspotmail.com

#syz dup: possible deadlock in cma_netdev_callback
