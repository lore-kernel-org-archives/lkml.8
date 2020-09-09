Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BB8C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E038321D7F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rt6oj3RW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgIINKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 09:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726970AbgIINBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599656448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+NIE6K0SEq8nKfP31WlYgJcbDuMJT/y+y9JSkh//lEs=;
        b=Rt6oj3RWDizlKrhWjsO3vFXl3lSFv0VI+44yBbUiOAWN/2yMm1x+7oFTHmVcV6862swqPg
        N6a+8Zh1vmt48kgpXmKOKZt4B2o9My9yHjmjLp0Sl8uWZRI9CmDwi9+UlFUdT49toUUBNJ
        8Ds/B5ZxtiNi+S7Us+Gxo74HK874ctc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-hH_9fKxXOlGqZgNkAzRlgQ-1; Wed, 09 Sep 2020 09:00:44 -0400
X-MC-Unique: hH_9fKxXOlGqZgNkAzRlgQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABCAF1084CB6;
        Wed,  9 Sep 2020 13:00:42 +0000 (UTC)
Received: from treble (ovpn-117-163.rdu2.redhat.com [10.10.117.163])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0FFD5D9E8;
        Wed,  9 Sep 2020 13:00:37 +0000 (UTC)
Date:   Wed, 9 Sep 2020 08:00:35 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200909130035.4tzata2gwd6fahoe@treble>
References: <bef9e78f9486d2a06c3e026d401511ffa117b0da.1598973982.git.jpoimboe@redhat.com>
 <20200908174329.ryfprry62e4tuodw@treble>
 <01b027d0d46d4572b3b16e2b49f0f2b3@AcuMS.aculab.com>
 <20200909124644.dndmfnoob5qzd7xi@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200909124644.dndmfnoob5qzd7xi@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 07:46:51AM -0500, Josh Poimboeuf wrote:
> On Wed, Sep 09, 2020 at 08:20:07AM +0000, David Laight wrote:
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Sent: 08 September 2020 18:43
> > > Hi x86 maintainers,
> > ...
> > > > --- a/arch/x86/lib/putuser.S
> > > > +++ b/arch/x86/lib/putuser.S
> > > > @@ -38,6 +38,8 @@ SYM_FUNC_START(__put_user_1)
> > > >  	ENTER
> > > >  	cmp TASK_addr_limit(%_ASM_BX),%_ASM_CX
> > > >  	jae .Lbad_put_user
> > > > +	sbb %_ASM_BX, %_ASM_BX		/* uaccess_mask_ptr() */
> > > > +	and %_ASM_BX, %_ASM_CX
> > > >  	ASM_STAC
> > > >  1:	movb %al,(%_ASM_CX)
> > > >  	xor %eax,%eax
> > 
> > For 64bit the sbb+and pattern can be replaced by an instruction
> > that clears the high bit (eg btr $63, %rcx).
> > This isn't dependant on the earlier instructions so can execute
> > in parallel with them.
> 
> Wouldn't that break with KERNEL_DS?

Looks like the set_fs() removal patches are now in the vfs tree for
-next.  I doubt this is going in an -rc so I'll rework the patch based
on top of Christoph's changes.

-- 
Josh

