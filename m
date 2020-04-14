Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3E6C352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD51A2051A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgrX9+Cy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391856AbgDNWYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 18:24:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29517 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387970AbgDNWYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 18:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586903058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TgHjv4gAaYYtx+HoAQH9PJ5czrGv0CeeW4y4HFuI5UM=;
        b=SgrX9+CyAAq4P97cyMSi3FHkTn7HOqNxP2VdJH+QCCF5bdmPpnZ0B8zLQeOsnGV3WQQwNY
        ZPnUIUYl09Vfs5pM5HdAzrlW8eLg4/beCvVzKrSXQztCsR3qVjaPr1meYHYNKYkucgHx9i
        8OEsdnuMVjgq6VTlq4PP4Rh0hmhd0GA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-ZxAkttFQP3eFsYHxH4ZOPA-1; Tue, 14 Apr 2020 18:24:14 -0400
X-MC-Unique: ZxAkttFQP3eFsYHxH4ZOPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 940711005513;
        Tue, 14 Apr 2020 22:24:12 +0000 (UTC)
Received: from treble (ovpn-116-146.rdu2.redhat.com [10.10.116.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D48E1001B0B;
        Tue, 14 Apr 2020 22:24:10 +0000 (UTC)
Date:   Tue, 14 Apr 2020 17:24:07 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Yan <yanaijie@huawei.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        peterz@infradead.org, shile.zhang@linux.alibaba.com,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] x86/unwind/orc: make some symbols static
Message-ID: <20200414222407.zygtmimv4ixwnxcz@treble>
References: <20200413082203.22853-1-yanaijie@huawei.com>
 <alpine.LSU.2.21.2004141121110.6508@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2004141121110.6508@pobox.suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 11:22:50AM +0200, Miroslav Benes wrote:
> On Mon, 13 Apr 2020, Jason Yan wrote:
> 
> > Fix the following sparse warning:
> > 
> > arch/x86/kernel/unwind_orc.c:19:5: warning: symbol 'cur_orc_ip_table'
> > was not declared. Should it be static?
> > arch/x86/kernel/unwind_orc.c:20:18: warning: symbol 'cur_orc_table' was
> > not declared. Should it be static?
> > arch/x86/kernel/unwind_orc.c:22:14: warning: symbol 'lookup_num_blocks'
> > was not declared. Should it be static?
> > arch/x86/kernel/unwind_orc.c:23:6: warning: symbol 'orc_init' was not
> > declared. Should it be static?
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Jason Yan <yanaijie@huawei.com>
> > ---
> >  arch/x86/kernel/unwind_orc.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> > index e9cc182aa97e..0dbabc469ce2 100644
> > --- a/arch/x86/kernel/unwind_orc.c
> > +++ b/arch/x86/kernel/unwind_orc.c
> > @@ -16,11 +16,11 @@ extern struct orc_entry __start_orc_unwind[];
> >  extern struct orc_entry __stop_orc_unwind[];
> >  
> >  static DEFINE_MUTEX(sort_mutex);
> > -int *cur_orc_ip_table = __start_orc_unwind_ip;
> > -struct orc_entry *cur_orc_table = __start_orc_unwind;
> > +static int *cur_orc_ip_table = __start_orc_unwind_ip;
> > +static struct orc_entry *cur_orc_table = __start_orc_unwind;
> >  
> > -unsigned int lookup_num_blocks;
> > -bool orc_init;
> > +static unsigned int lookup_num_blocks;
> > +static bool orc_init;
> >  
> >  static inline unsigned long orc_ip(const int *ip)
> >  {
> > -- 
> 
> Thanks for the patch, but Josh already fixed it in 
> https://lore.kernel.org/lkml/63b5cab2e28b9c08854fc57f5b512a9ccf76ad95.1584033751.git.jpoimboe@redhat.com/
> 
> Josh, any plans to add the patch set into the current queue?

Yeah, I have a v2 coming one of these days...

-- 
Josh

