Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD45C4332B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6302070E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZfF0Aas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgDDRun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 13:50:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26838 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726582AbgDDRuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 13:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586022638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XpIFvMqlAZPPaPuZTXJXVsC8D8YnUvdMZglxGAOu27U=;
        b=GZfF0AasXfCLxmQ1+zSLNzfA7g44uzlsI2H7h8Pl5ZTr4KpnJb84wSWrnVo1hFEpN80eVk
        Cysmq6NAZghaAfj3XhnUNw/f7Qt0kz6ybyWn4rbzqVPJnELbdoGt3Ip5tZslo3OLeIfzaf
        M45V8/gSn2PWx/bTvDKrs8ZgbNGMCVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-Ihhp-RW2NgOWfPBvLNLeEQ-1; Sat, 04 Apr 2020 13:50:33 -0400
X-MC-Unique: Ihhp-RW2NgOWfPBvLNLeEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84432DB20;
        Sat,  4 Apr 2020 17:50:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.53])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7252DB19B5;
        Sat,  4 Apr 2020 17:50:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat,  4 Apr 2020 19:50:30 +0200 (CEST)
Date:   Sat, 4 Apr 2020 19:50:24 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Marco Elver <elver@google.com>,
        Brian Gerst <brgerst@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: signal: move save_altstack_ex out of generic
 headers
Message-ID: <20200404175023.GC26298@redhat.com>
References: <20200324220830.110002-1-ndesaulniers@google.com>
 <20200403231611.81444-1-ndesaulniers@google.com>
 <20200404160100.GB26298@redhat.com>
 <20200404170604.GN23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404170604.GN23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04, Al Viro wrote:
>
> On Sat, Apr 04, 2020 at 06:01:00PM +0200, Oleg Nesterov wrote:
> >
> > Nevermind, Al has already suggested to use signal_delivered()...
>
> FWIW, I propose to do is the patch below (against the current mainline);
> objections?

Looks great, fwiw

Acked-by: Oleg Nesterov <oleg@redhat.com>

