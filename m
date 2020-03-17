Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B07C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756D020752
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbPS5+7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCQOje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:39:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55253 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726248AbgCQOjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584455972;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=cTFqU/I5vZ/SQbtcIgbGrlxryRVnOa8A+7W1PFxjykk=;
        b=TbPS5+7lXxiu0Z4ctUulAGCeq7phq/p6Q9MgYk8Js43nuF53L8+D1uol+mhWskkAY56CN/
        KH5QO9rpv2Z54U8Q2W3BTsNKpl1ifkrOzU3Dj/E7jxXAtF7WYKn6f4ApkImPOnUOOsQA7L
        Mj5uJw/QxBH9VN93D2lxWYx0p1S2WNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-G8mX7Sl3OAi95uLDW2rLaw-1; Tue, 17 Mar 2020 10:39:28 -0400
X-MC-Unique: G8mX7Sl3OAi95uLDW2rLaw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02BD21005F99;
        Tue, 17 Mar 2020 14:39:27 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-112-22.ams2.redhat.com [10.36.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96B2590811;
        Tue, 17 Mar 2020 14:39:26 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.15.2/8.15.2) with ESMTP id 02HEdNuC011604;
        Tue, 17 Mar 2020 15:39:23 +0100
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.15.2/8.15.2/Submit) id 02HEdE0J011603;
        Tue, 17 Mar 2020 15:39:14 +0100
Date:   Tue, 17 Mar 2020 15:39:14 +0100
From:   Jakub Jelinek <jakub@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86: fix early boot crash on gcc-10
Message-ID: <20200317143914.GI2156@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20200314164451.346497-1-slyfox@gentoo.org>
 <20200316130414.GC12561@hirez.programming.kicks-ass.net>
 <20200316132648.GM2156@tucnak>
 <20200316134234.GE12561@hirez.programming.kicks-ass.net>
 <20200316175450.GO26126@zn.tnic>
 <20200316180303.GR2156@tucnak>
 <20200317143602.GC15609@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317143602.GC15609@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 03:36:02PM +0100, Borislav Petkov wrote:
> On Mon, Mar 16, 2020 at 07:03:03PM +0100, Jakub Jelinek wrote:
> > On Mon, Mar 16, 2020 at 06:54:50PM +0100, Borislav Petkov wrote:
> > > So having a way to state "do not add stack canary checking to this
> > > particular function" would be optimal. And since you already have the
> > > "stack_protect" function attribute I figure adding a "no_stack_protect"
> > > one should be easy...
> > 
> > Easy, but a waste when GCC already has the optimize attribute that can
> > handle also ~450 other options that are per-function rather than per-TU.
> 
> Ok, Micha explained to me what you mean here and I did:
> 
> static void __attribute__((optimize("no-stack-protect"))) notrace start_secondary(void *unused)
> {
> 
> but it said

That is because the option is called -fno-stack-protector, so one needs to
use __attribute__((optimize("no-stack-protector")))

	Jakub

