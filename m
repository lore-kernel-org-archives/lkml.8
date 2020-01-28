Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF6BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCF62173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K62JkGjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgA1Miq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 07:38:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42082 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725283AbgA1Miq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 07:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580215125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jAUdcUoNlbNA3wmapQDhv1Xevu4+dUMP19fy7F3OARs=;
        b=K62JkGjHw2opSm71KNW93l2CKHflbv5kSV6NkSdYGQGB8md+cZT4jXle5eHX2DS/RcTxbk
        rdU+O/zD5aiL7QOPWnBxW1DvHujDP734+TwZmlJTUc6Ws+mBl/IIzrkkOaqAtxUQIfbiH9
        AzFZxJ8jGXTItgHWI9J4QKWMPbklIEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-GuLWnJoVMYevW03hQENvBQ-1; Tue, 28 Jan 2020 07:38:41 -0500
X-MC-Unique: GuLWnJoVMYevW03hQENvBQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 843518010C9;
        Tue, 28 Jan 2020 12:38:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0BD1D89D13;
        Tue, 28 Jan 2020 12:38:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 28 Jan 2020 13:38:38 +0100 (CET)
Date:   Tue, 28 Jan 2020 13:38:35 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Amol Grover <frextrite@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH] cred: Use RCU primitives to access RCU pointers
Message-ID: <20200128123834.GB17943@redhat.com>
References: <20200128072740.21272-1-frextrite@gmail.com>
 <CAG48ez3ZcO+kVPJVG6XpCPyGUKF2o4UJ6AVdgZXGQ6XJJpcdmg@mail.gmail.com>
 <20200128114818.GA17943@redhat.com>
 <CAG48ez2rJZGQyhOcgWe7NwLOxk-CBJugUFMM0Oa9JyuPamRwCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2rJZGQyhOcgWe7NwLOxk-CBJugUFMM0Oa9JyuPamRwCg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28, Jann Horn wrote:
>
> On Tue, Jan 28, 2020 at 12:48 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > On 01/28, Jann Horn wrote:
> > > On Tue, Jan 28, 2020 at 8:28 AM Amol Grover <frextrite@gmail.com> wrote:
> > > > task_struct.cred and task_struct.real_cred are annotated by __rcu,
> > >
> > > task_struct.cred doesn't actually have RCU semantics though, see
> > > commit d7852fbd0f0423937fa287a598bfde188bb68c22. For task_struct.cred,
> > > it would probably be more correct to remove the __rcu annotation?
> >
> > Yes, but get_task_cred() assumes it has RCU semantics...
>
> Oh, huh. AFAICS get_task_cred() makes no sense semantically, and I
> think it ought to be deleted.

Ah, sorry for noise Jann. Somehow I managed to missread this function
as if it uses task->cred. No, it reads ->real_cred so it is fine.

Oleg.

