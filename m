Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70A6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6F120644
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOVWb49A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgDQIHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 04:07:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20799 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729176AbgDQIHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587110863;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=NccU6pdLlMoSxH6d3Hr9mUjUtMyNeVmxbtBZCQRRwy8=;
        b=GOVWb49AHhiCqAwLlh5xSsXDvBDAlRl9SCAIJzYuU5yeggMN+gh/AtiStBV5Sdna6BoAKk
        TZ07O4gYDJqALsoX/hRNp+3XUNljYvFwy64bwaaipOiAlrglarI3p+bYzundPdFsrLiP9z
        D5U71PLjsa9nBeZ8uBMAPL2KpRIl/U4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-aan4zgP_MUezxqVGX3NAHw-1; Fri, 17 Apr 2020 04:07:39 -0400
X-MC-Unique: aan4zgP_MUezxqVGX3NAHw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FF2D18C35A2;
        Fri, 17 Apr 2020 08:07:37 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-112-104.ams2.redhat.com [10.36.112.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 676BB1001B3F;
        Fri, 17 Apr 2020 08:07:36 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.15.2/8.15.2) with ESMTP id 03H87XoG004216;
        Fri, 17 Apr 2020 10:07:33 +0200
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.15.2/8.15.2/Submit) id 03H87QGB004215;
        Fri, 17 Apr 2020 10:07:26 +0200
Date:   Fri, 17 Apr 2020 10:07:26 +0200
From:   Jakub Jelinek <jakub@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Michael Matz <matz@suse.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
Message-ID: <20200417080726.GS2424@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20200326223501.GK11398@zn.tnic>
 <20200328084858.421444-1-slyfox@gentoo.org>
 <20200413163540.GD3772@zn.tnic>
 <alpine.LSU.2.21.2004141343370.11688@wotan.suse.de>
 <20200415074842.GA31016@zn.tnic>
 <alpine.LSU.2.21.2004151445520.11688@wotan.suse.de>
 <20200415231930.19755bc7@sf>
 <20200417075739.GA7322@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417075739.GA7322@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 09:57:39AM +0200, Borislav Petkov wrote:
> On Wed, Apr 15, 2020 at 11:19:30PM +0100, Sergei Trofimovich wrote:
> > Ah, that makes sense. Borislav, should I send a fix forward against
> > x86 tree to move -fno-stack-protector as it was in v1 patch?
> > Or you'll revert v2 and apply v1 ~as is? Or should I send those myself?
> 
> Yeah, Peter and I have been discussing something like the below
> yesterday. I don't like the additional exports too much but would
> disable stack protector only for the one function...

If you want minimal changes, you can as I said earlier either
mark cpu_startup_entry noreturn (in the declaration in some header so that
smpboot.c sees it), or you could add something after the cpu_startup_entry
call to ensure it is not tail call optimized (e.g. just
	/* Prevent tail call to cpu_startup_entry because the stack
	   protector guard has been changed in the middle of this function
	   and must not be checked before tail calling another function.  */
	asm ("");
would do, or for (;;); , or combine both, mark cpu_startup_entry noreturn and
add asm (""); (which most GCC versions will optimize away as unreachable).

	Jakub

