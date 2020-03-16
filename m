Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E945AC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F1320674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGzyfmb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbgCPSW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:22:27 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:35882 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732353AbgCPSW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:22:27 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2020 14:22:26 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584382945;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=DOkg2HYesbm/DvOYb8iVIt2On33s6oF2eyXue+ZWcxI=;
        b=eGzyfmb/2Q1Rw62J3frQjFVoC3dBKdwEbIeB3/C3O/Jw6D4072OLpGsaL2KQjVDfEHWtvH
        hptaZszIJf0397pkbCzPCQQ+tC5IH/sdtm+ZT1bdr/MaT6L5hQ2Tve4H3jvbJjqa1ZgJxL
        +VbVqNi70jqAmi9e7xdibuS0HtSiRQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-SYqmuXwsN1-bEeJ1H2NUmg-1; Mon, 16 Mar 2020 14:16:17 -0400
X-MC-Unique: SYqmuXwsN1-bEeJ1H2NUmg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D320411360A9;
        Mon, 16 Mar 2020 18:03:14 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A2755D9C9;
        Mon, 16 Mar 2020 18:03:14 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.15.2/8.15.2) with ESMTP id 02GI3B0b024323;
        Mon, 16 Mar 2020 19:03:11 +0100
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.15.2/8.15.2/Submit) id 02GI33u0024322;
        Mon, 16 Mar 2020 19:03:03 +0100
Date:   Mon, 16 Mar 2020 19:03:03 +0100
From:   Jakub Jelinek <jakub@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: Re: [PATCH] x86: fix early boot crash on gcc-10
Message-ID: <20200316180303.GR2156@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20200314164451.346497-1-slyfox@gentoo.org>
 <20200316130414.GC12561@hirez.programming.kicks-ass.net>
 <20200316132648.GM2156@tucnak>
 <20200316134234.GE12561@hirez.programming.kicks-ass.net>
 <20200316175450.GO26126@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316175450.GO26126@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 06:54:50PM +0100, Borislav Petkov wrote:
> So having a way to state "do not add stack canary checking to this
> particular function" would be optimal. And since you already have the
> "stack_protect" function attribute I figure adding a "no_stack_protect"
> one should be easy...

Easy, but a waste when GCC already has the optimize attribute that can
handle also ~450 other options that are per-function rather than per-TU.

	Jakub

