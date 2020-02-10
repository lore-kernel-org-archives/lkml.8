Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376CDC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED08420838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PFLoOMSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgBJTUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:20:52 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40098 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJTUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:20:51 -0500
Received: by mail-qk1-f193.google.com with SMTP id b7so7671862qkl.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 11:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=51cTgMiOzN6t4plcVzbyVxA/Hfa9K5s86D9XKz8foUc=;
        b=PFLoOMSZfjTakPZVVHiqEzms+nZhWicg0v1zcsw8tTRzCJMxWDJuQmA5jwSoqKlU4s
         JICVBeW0DysNGyBGonFTojE65BcE/jOVXNjeXDgaswSP6ZNIGTfsSvZwmkwVTW6w6IUS
         ygpfrmETR+yc0G4Xvye/XEUrAX7m18ZDcTlxSDPA8FQhebaeiQfdX6bxvzNMBmKYwT6g
         zd92I1ne0J1nArS0hsBnidJtl9YcKa4D+oRXMnE2Z5Cue6LyEvVkv0f6xcHqtvPZwvMg
         eiv5m6+Gmxp7qv0gnj21PnW80beAnVVJawRgiZBcYZcHbCGxGDKowx7ZfpH2s/SXZD2u
         RMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=51cTgMiOzN6t4plcVzbyVxA/Hfa9K5s86D9XKz8foUc=;
        b=S6h7YuPmQ3qFc88Tc+kQ5mzhmsnDO80UBCXi0HB1cRqVwYc74lAGBSmTELsXQGBsaa
         CDLD7+3th/oz841itvAFL4NcmKbgu3szLF2KUO7zb0jefiHxO2GorI+t+H3qCwcN3llh
         EDs7hjQJElBJ/+0x5EidrHLck6NGF9G4sQeolkTJBP1o1fO8JlbwsPcIimXDH4/pv7St
         +0IqnYNZ9opnV0cCftJ73o0eX/a2H2GNL3qn58oiKjz10QVmnUnhOTTQoi9XZqDUbdRx
         m1oP+MZwE0sKjSl6PZr5v8AzIFTWw5MWXFgyQPIMeUp6pI+PRJ9i0wfsqEOfWNNQvcv5
         zjgQ==
X-Gm-Message-State: APjAAAX+oFyDRCWDx/BZx6cCzXaH2B+4hSfsA9gmP4BUSGeiwV2lZQw8
        q3kyoP0xlrCY87gzS+QP7HWmEQ==
X-Google-Smtp-Source: APXvYqyhQWGDq29aObGBXAbdpZaBnQ19QBKCnGJjv7qDahD+7HvQ+r+O5f2OoOpwicdmPlWezdUQuA==
X-Received: by 2002:a05:620a:a09:: with SMTP id i9mr2788276qka.132.1581362450559;
        Mon, 10 Feb 2020 11:20:50 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h6sm665297qtr.33.2020.02.10.11.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 11:20:50 -0800 (PST)
Message-ID: <1581362448.7365.38.camel@lca.pw>
Subject: Re: [PATCH -next] mm/filemap: fix a data race in filemap_fault()
From:   Qian Cai <cai@lca.pw>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 10 Feb 2020 14:20:48 -0500
In-Reply-To: <20200210172511.GL8731@bombadil.infradead.org>
References: <1581354029-20154-1-git-send-email-cai@lca.pw>
         <20200210172511.GL8731@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-10 at 09:25 -0800, Matthew Wilcox wrote:
> On Mon, Feb 10, 2020 at 12:00:29PM -0500, Qian Cai wrote:
> > @@ -2622,7 +2622,7 @@ void filemap_map_pages(struct vm_fault *vmf,
> >  		if (page->index >= max_idx)
> >  			goto unlock;
> >  
> > -		if (file->f_ra.mmap_miss > 0)
> > +		if (data_race(file->f_ra.mmap_miss > 0))
> >  			file->f_ra.mmap_miss--;
> 
> How is this safe?  Two threads can each see 1, and then both decrement the
> in-memory copy, causing it to end up at -1.

Well, I meant to say it is safe from *data* races rather than all other races,
but it is a good catch for the underflow cases and makes some sense to fix them
together (so we don't need to touch the same lines over and over again).
