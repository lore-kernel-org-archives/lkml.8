Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB9EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 16:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB1A20723
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 16:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYtmpq1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgE3Qn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 12:43:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20154 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728998AbgE3QnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 12:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590857002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wZf4AcQfH0ropKMoOlCZU3Elgy9S461kQFfCXa24wvE=;
        b=bYtmpq1lG4+SUTnN2bJ7se/Zd0fzB7HU9jfwcPlSiXJuHnHiE7les3RTt05F16Q2P6FJJK
        QzFTC2a7i3qin2U1PVrHoFCC6DmiSbcyrAwcxsneItLhSeqMuG25N+MdPKrY8rKx8iQOPS
        /KahqeSFtLg0nCfBsTr6h7bmsBxBqic=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-zyZ9qcdPOoKsgRYQCfbWGA-1; Sat, 30 May 2020 12:43:18 -0400
X-MC-Unique: zyZ9qcdPOoKsgRYQCfbWGA-1
Received: by mail-wr1-f70.google.com with SMTP id l18so2419137wrm.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 09:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wZf4AcQfH0ropKMoOlCZU3Elgy9S461kQFfCXa24wvE=;
        b=HeU75oW9QWlLb/fIvYxv5bS4ZWkPNIAMnlWliydENrL20P1q9A8xiYSlvrLGxq8Dw3
         IbLVY0Hxqb2pu8AKQiZ3GdnvjcJa2RdNUT8LLIEltrFEhAhCD//B7n3I75BZfvjgZ0U1
         nHdVypHc2QzCI3noGKxNXltO7zPFoDbYPwWW7pfbJIpx1X3cIPzawIJP+/D7e/lvAuaY
         1iEm7nKSzZgzocy7pwHHsks4hj0Xy9ulFHMO96m+jAj08nolhtYbsue1EL9DAB4CYe+m
         BMdLmHHPhS+g8MEvBf9bmphpMVONaQ03R5kKpbH4e4oF3fOcN5r2RYsiD55NxXjdHZNg
         NVvA==
X-Gm-Message-State: AOAM530N7+L/3S1MX10L1uIzG4E5lPjJFuSpmzr+b9v77h8EHO1viU4t
        L8OTplr1TakZ/cwGdEGBapDIqUxUIEbLemxOskMgg+iDSFro82bhuH/9EVXWXMewZWx7tRX/2Ya
        mbyjmcPh2iW1irLqv/HOGTUeS
X-Received: by 2002:a1c:7903:: with SMTP id l3mr6749819wme.50.1590856997684;
        Sat, 30 May 2020 09:43:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8w3ZNctiQFmF5ZSRztquGP+y9cNvFSewUVTCPhNv0kpqsXEoYgjFdjybNCjr1Odx9xbgdjA==
X-Received: by 2002:a1c:7903:: with SMTP id l3mr6749808wme.50.1590856997496;
        Sat, 30 May 2020 09:43:17 -0700 (PDT)
Received: from pc-3.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id s8sm11446368wrm.96.2020.05.30.09.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 09:43:16 -0700 (PDT)
Date:   Sat, 30 May 2020 18:43:14 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Vlad Buslov <vladbu@mellanox.com>,
        Xin Long <lucien.xin@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] flow_dissector: work around stack frame size warning
Message-ID: <20200530164314.GA31920@pc-3.home>
References: <20200529201413.397679-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529201413.397679-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 10:13:58PM +0200, Arnd Bergmann wrote:
> The fl_flow_key structure is around 500 bytes, so having two of them
> on the stack in one function now exceeds the warning limit after an
> otherwise correct change:
> 
> net/sched/cls_flower.c:298:12: error: stack frame size of 1056 bytes in function 'fl_classify' [-Werror,-Wframe-larger-than=]
> 
> I suspect the fl_classify function could be reworked to only have one
> of them on the stack and modify it in place, but I could not work out
> how to do that.
> 
> As a somewhat hacky workaround, move one of them into an out-of-line
> function to reduce its scope. This does not necessarily reduce the stack
> usage of the outer function, but at least the second copy is removed
> from the stack during most of it and does not add up to whatever is
> called from there.
> 
> I now see 552 bytes of stack usage for fl_classify(), plus 528 bytes
> for fl_mask_lookup().
> 
> Fixes: 58cff782cc55 ("flow_dissector: Parse multiple MPLS Label Stack Entries")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
Sorry, I didn't see that, as my .config has CONFIG_FRAME_WARN=2048,
which seems to be the default for x86_64.

Acked-by: Guillaume Nault <gnault@redhat.com>

