Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79224C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39120221E7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="n0vjFDUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgIKMCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgIKMC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:02:26 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E87C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 05:02:25 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id v123so9554750qkd.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 05:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D0ZOTZlli3YnxT/U7k9I9lkvcB/+y93d4fQplk7yHJk=;
        b=n0vjFDUzG4qczfNYYEQo0/PtVzhG6uwWdXe6pYAlq+bKliwiMGLEi6iZHnmN+MUf96
         vigHIL3FLLDBmZ208RA29lbJ853ZlKTcsSZwEjZwRKXuOo3+6wjXFz3y0FmOLmVRhoeE
         Oh1X21fEv4NbB+KAJR1egsZQ+e47DXNgoawyg+ok8Z3QC60bO3VMpeY+iag7pMD+MWIY
         SW52UKuvEUkCM3OcftS7ajs50GcI6NhFtwyGZnocEKuyJ3vdMYuu1Pu9MqgVhoApnikw
         NHC4nNhv//lnRtQ3N/pEnV9a0UkT4bLFNi9SQis9HU+SWBg5yPBUOd3+JQmQPQXkdNuj
         3rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D0ZOTZlli3YnxT/U7k9I9lkvcB/+y93d4fQplk7yHJk=;
        b=pZK2APKygWoW2uBgWhiIWzFhaQKVoSeeJYggafwToYyM3XS0HIfwHYNasHMjuOlZDE
         ne4V9XddZ8ocknpVrqvhMaPPeGDCh5tL+w+bV/ROlNcAnlz5KY4ac/gym41BW1CzMtp4
         7CvyHmsIwGi/56NwhiZ0+3uO0sLKAryAyGT3fAk2CR5xO5HZA0GKMnXotcgZtYuehFJr
         zDjCiw3s4Pk4KWWCL/aeHvRZECosDk1nqrBAt7llaKinp9OiBTMa6TE2qrixopDypINQ
         c+SuQv/+oWLWvFCrKWrpOu9S4T40JB2EzRq+NUIjuk/y3qx8J/qXIEXeoqwamnt7dIYB
         UhBQ==
X-Gm-Message-State: AOAM532pFjY4rrqWB/1LG+dKcaFgGRneTy9lSBjoMwUTZ6sDAup+A03N
        u5MJqja/NNtCx2tDibQrioBC2g==
X-Google-Smtp-Source: ABdhPJygUW9F4tubVaZ2xlkL1ks7ALZ2LGBS6K77k5kTwE5xiNcEmIj8mnjJVgK2kwSwFGx45VighA==
X-Received: by 2002:a37:4711:: with SMTP id u17mr1100114qka.54.1599825744148;
        Fri, 11 Sep 2020 05:02:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 202sm2417189qkg.56.2020.09.11.05.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 05:02:23 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kGhl0-004mB3-60; Fri, 11 Sep 2020 09:02:22 -0300
Date:   Fri, 11 Sep 2020 09:02:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in ucma_close (2)
Message-ID: <20200911120222.GT87483@ziepe.ca>
References: <0000000000008e7c8f05aef61d8d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008e7c8f05aef61d8d@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 07:09:24AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    34d4ddd3 Merge tag 'linux-kselftest-5.9-rc5' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1002ea2d900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=cc6fc752b3819e082d0c
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1600e053900000

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git 308571debccd7004acf02ea1b7163a96ad772292

Jason
