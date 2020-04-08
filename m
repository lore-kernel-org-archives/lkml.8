Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A592C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCA920768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586341294;
	bh=0eNZTLTy4Ap3sHMkzerika51Bzubd5eN0L0PAEgmjbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s4C7I/128say+OqNXIhMr4ArTHJ40C0AqakUXWukqq0qbBGarikLPZuYgzbsSQJSa
	 Fgoquza08xnRoKsIsVYWj73Pu7+MqNkYDkRmhYwX2qd1AWhLX6yebf4K4/cxvpsSW2
	 1QHu+8VIS74ySKZUQROGLuihWmAe9Sds5QbScpCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgDHKVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 06:21:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33905 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgDHKVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 06:21:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id 65so7212892wrl.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 03:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fdVczqsLYJ2DIvo2k7kUsz9yNfr4DQ6vZjZROaUu81k=;
        b=La4Q1q0Vw7qiKlqHhjZMPpYCAg5pSYT0NXEj24KeFO7sLEPDv4Hi8S3SwjGdJUG1z8
         r801Ll26uroBg5mFa/g3W5TlzhCdSMHcA6waWgZdL2+1FHVFfHlE9eg7udOuwiUnYNzP
         +QDnMRyGwJ/hQfHMCZDVPwVFhO/mVA/hGmRtX1464gxcXLAeu1EOaZfFMPe7wy/Ty3Lg
         579MK6qsNQwytDh0ioa/2+QsYksMh1OPMDehOsr2PPJvUA433HK+jZAc6xhPgyYlU93N
         rbH7WiJnPONLk4AhdVR57EMymRFh0DP3M50SIGHtW51k4HFOYeUBQGbvoRg0+ibBqGQW
         MpyQ==
X-Gm-Message-State: AGi0PuZhtb0KE5hfEPm+baxzH6VB4/r8CghvP5W1a5rPYeEcc4+N2rcl
        4e+JchU2TIH91Z7O6bIQ1R0=
X-Google-Smtp-Source: APiQypJYp2QwZD21P2CHJAnre1Yfs+Cr+P/d72eYb87+4V1sWEXzF5pCej6nNSz5az7RMys/uBBcNQ==
X-Received: by 2002:adf:cd0c:: with SMTP id w12mr2248969wrm.12.1586341290985;
        Wed, 08 Apr 2020 03:21:30 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id u7sm6843865wmg.41.2020.04.08.03.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 03:21:29 -0700 (PDT)
Date:   Wed, 8 Apr 2020 12:21:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/mempolicy: Allow lookup_node() to handle fatal
 signal
Message-ID: <20200408102128.GX18914@dhcp22.suse.cz>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408014010.80428-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408014010.80428-2-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-04-20 21:40:09, Peter Xu wrote:
> lookup_node() uses gup to pin the page and get node information.  It
> checks against ret>=0 assuming the page will be filled in.  However
> it's also possible that gup will return zero, for example, when the
> thread is quickly killed with a fatal signal.  Teach lookup_node() to
> gracefully return an error -EFAULT if it happens.
> 
> Meanwhile, initialize "page" to NULL to avoid potential risk of
> exploiting the pointer.
> 
> Reported-by: syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
> Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")

I am not familiar with thic commit but shouldn't gup return ERESTARTSYS
on a fatal signal?
-- 
Michal Hocko
SUSE Labs
