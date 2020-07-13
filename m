Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF2CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343EE20738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="YauW5eu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgGMQpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729593AbgGMQpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:45:33 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119D1C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 09:45:33 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n2so14247419edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YWJmchy5NBOUhyK5SwRwLbF2VzgzDqorZLs7Z4tlH84=;
        b=YauW5eu+U1WcnMWUhCH6USIo4RRa/4DjiT3BOcbbsGW0KeXV1YoHALoYmdaAuDYylQ
         xW3zY6dlDd+ktaWQENSLYYleqAJBN1mwxzFTHYSZhqqCbzDPkHsybQCD9Ue2e1XZtlDx
         VqnuSpVjTEL1T5Bs9LKIoi7gvVEmFp1gABikk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YWJmchy5NBOUhyK5SwRwLbF2VzgzDqorZLs7Z4tlH84=;
        b=tYbz+Kh9ObKOkXfvv5pTYUJ4CItYjkPltPFT9koxl16g4BvYvUCt71m67Oa7Lsl6Ec
         yYgpg3E1XUJ2qTLXtvisKjqt1fnp/Mke+4deLOGndgXwiGCSaq6Hzx1Wk/m8CmuW/C6f
         Q5hmbMqsrTyvxxtyUJidnfgutQn1WTiRI54RvOZiXVPM5xIXz/B+on2HQ8oJaVHJDvcq
         O9OQiGnLI8E37+HsgnTqrsq98RL0l/ansRG0NFUg9Ek3gRnL69Ijw8B1R26IDQS5RijI
         YGcdY9yNtoz12a3vKbb3E5hBaPQZ8DfHVFEWQtcn48IIhDdEfl5oIJx05SG5RCy2SN8J
         8V2A==
X-Gm-Message-State: AOAM5337N2mQry5q9LY3wM7aE6NJT2wtGN//lKVmeAn2SQCwPoVzeYlN
        JAj0JZKakWzCJK9u37Uv3OxrWw==
X-Google-Smtp-Source: ABdhPJzcKhMEWkxja+nXz5D6veGVU3r4UEuSD2r7Zl/utZcyhS3svSDQ5ap7tYvz3qxodpWBKIGFLQ==
X-Received: by 2002:a50:fd12:: with SMTP id i18mr256850eds.371.1594658731595;
        Mon, 13 Jul 2020 09:45:31 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ef88])
        by smtp.gmail.com with ESMTPSA id s7sm12186223edr.57.2020.07.13.09.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 09:45:31 -0700 (PDT)
Date:   Mon, 13 Jul 2020 17:45:30 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v6 1/2] tmpfs: Per-superblock i_ino support
Message-ID: <20200713164530.GB1065134@chrisdown.name>
References: <cover.1594656618.git.chris@chrisdown.name>
 <2cddd4498ba1db1c7a3831d47b9db0d063746a3b.1594656618.git.chris@chrisdown.name>
 <20200713164145.GY12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200713164145.GY12769@casper.infradead.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox writes:
>I don't think that works.  I think you meant to write ~(SHMEM_INO_BATCH - 1).
>Or just ino % SHMEM_INO_BATCH which works even for non-power-of-two.

Er, right. I now wonder why I didn't just write `ino % SHMEM_INO_BATCH` :-)

I'll send again with that fix.
