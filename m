Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFA2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1807D2084E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="J1Ovu1Yq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgCBTbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:31:52 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37591 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgCBTbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:31:52 -0500
Received: by mail-qk1-f195.google.com with SMTP id m9so882243qke.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 11:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xL8xZpCvyDDEWzstYzSuK8iapRnn3cZQqCy0KFw3GXw=;
        b=J1Ovu1YqDDflfNXvkXlQ9H1iCZ9xgkiOv8Ud12jUl4jBVIu1GPpe5XyC0RxncSFMER
         lgRjnWF0Jsc7xDvmaJ2GoS4ESu9BPEkBbXLNZm6OlPmtVzLxrvYtP1zjIaEApHFmIM3T
         amr9UsIvEV72RcSHSc4P9c3iRBm03amonWXNVOt8/GHm8FJbhOvOCeyu0YLTy7M1/tNh
         pW+gnegFtnjhlAdInT0pn8ijvnHTk39Kt/RFhN9u90gNIbGT2+zqnFVWq/I+zdx4OcPb
         qlzMmMhLIOhzwhVZspbBtQ6UFmyxrj6Z9h4S+H+LocXFiOGShn9Wqp36EuUlNRiOuykP
         AK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xL8xZpCvyDDEWzstYzSuK8iapRnn3cZQqCy0KFw3GXw=;
        b=eBR7z2NXJ28Zl10pIbfC99UqgYMlM1WZpNjGZbrLXVeFLToJBwbptHMAFZavvfpIdZ
         pE5agbDolg/YmkFpBSnjw8SwoCkJ/naj5E2l4r0e2AYe0wMrhu2F3s4XMtn33qj8idx1
         fnw/N8fSGfz5bekPMX2jgopZEg5EyRrG7mZFTOue4jSo3Cb8EBcV3f+G7I1H9Q2yfghz
         9jESzHxKNVFdSjNtnFpD9oNbpLFgpEyusmVJunVbGr8SSl4z2l+5PYNT09Bv+hlIp2Ga
         bCt25Fu4eRQ/dTHEnY2y6PdKlrDA4OtiYhbs6BpoBBmcy91oOtTmeHd9USglPp3nqGcI
         hyZA==
X-Gm-Message-State: ANhLgQ0Mvz25+Gwkv9Ejg03XDGUzs0lM6ELjfAypEY3aoV/ZCGDeHYoQ
        iXRLo4VjWcYs2sWYyBsnzfJpc3xyS6g=
X-Google-Smtp-Source: ADFU+vtp8x5sAHLOGJtqPCnh1bGDsrNsgo+inCvvcfyoeX15OXjTu/ELQHs4B+AKsSO4Wb9ZLymreg==
X-Received: by 2002:a37:4808:: with SMTP id v8mr696355qka.263.1583177511234;
        Mon, 02 Mar 2020 11:31:51 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z4sm3737050qkz.85.2020.03.02.11.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 11:31:50 -0800 (PST)
Message-ID: <1583177508.7365.144.camel@lca.pw>
Subject: Re: + seq_read-info-message-about-buggy-next-functions.patch added
 to -mm tree
From:   Qian Cai <cai@lca.pw>
To:     linux-kernel@vger.kernel.org, dave@stgolabs.net,
        longman@redhat.com, manfred@colorfullife.com, mingo@redhat.com,
        mm-commits@vger.kernel.org, neilb@suse.com, oberpar@linux.ibm.com,
        rostedt@goodmis.org, viro@zeniv.linux.org.uk, vvs@virtuozzo.com
Cc:     akpm@linux-foundation.org
Date:   Mon, 02 Mar 2020 14:31:48 -0500
In-Reply-To: <1583173259.7365.142.camel@lca.pw>
References: <20200226035621.4NlNn738T%akpm@linux-foundation.org>
         <1583173259.7365.142.camel@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-02 at 13:20 -0500, Qian Cai wrote:
> This patch spams the console like crazy while reading sysfs,
> 
> # dmesg | grep 'buggy seq_file' | wc -l
> 4204
> 
> [ 9505.321981] LTP: starting read_all_proc (read_all -d /proc -q -r 10)
> [ 9508.222934] buggy seq_file .next function xt_match_seq_next [x_tables] did
> not updated position index
> [ 9508.223319] buggy seq_file .next function xt_match_seq_next [x_tables] did
> not updated position index
> [ 9508.223654] buggy seq_file .next function xt_match_seq_next [x_tables] did
> not updated position index
> [ 9508.223994] buggy seq_file .next function xt_match_seq_next [x_tables] did
> not updated position index
> [ 9508.224337] buggy seq_file .next function xt_match_seq_next [x_tables] did
> not updated position index
> ...
> 
> 
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=206283
> > Link: http://lkml.kernel.org/r/244674e5-760c-86bd-d08a-047042881748@virtuozzo.com
> > Link: http://lkml.kernel.org/r/7c24087c-e280-e580-5b0c-0cdaeb14cd18@virtuozzo.com
> > Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> > Cc: NeilBrown <neilb@suse.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Manfred Spraul <manfred@colorfullife.com>
> > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Cc: Waiman Long <longman@redhat.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > 
> >  fs/seq_file.c |    7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > --- a/fs/seq_file.c~seq_read-info-message-about-buggy-next-functions
> > +++ a/fs/seq_file.c
> > @@ -256,9 +256,12 @@ Fill:
> >  		loff_t pos = m->index;
> >  
> >  		p = m->op->next(m, p, &m->index);
> > -		if (pos == m->index)
> > -			/* Buggy ->next function */
> > +		if (pos == m->index) {
> > +			pr_info("buggy seq_file .next function %ps "
> > +				"did not updated position index\n",
> > +				m->op->next);

This?

s/pr_info/pr_info_ratelimited/

> >  			m->index++;
> > +		}
> >  		if (!p || IS_ERR(p)) {
> >  			err = PTR_ERR(p);
> >  			break;
> > _
> > 
> > Patches currently in -mm which might be from vvs@virtuozzo.com are
> > 
> > seq_read-info-message-about-buggy-next-functions.patch
> > pstore_ftrace_seq_next-should-increase-position-index.patch
> > gcov_seq_next-should-increase-position-index.patch
> > sysvipc_find_ipc-should-increase-position-index.patch
> > 
