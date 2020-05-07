Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF55CC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C45E21835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588873602;
	bh=TGNwlojB/j2uFXoocG2pNAWwUA/IRC4r9PXP+DroQd8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c3xZ9CtWUG2ezcHM6anG3IdvJgmWv+E7vXFCQ+WueExAKsrsGO7EBOw6F+J4Oh547
	 Bn2kftcVCCFXznDQHhLJF0sBnQUeSEFyQqn8pd/BEz96FOro+fa1WrT9sIQFz+oCZE
	 eCC1ampOM/dYaIT9nIaBWXseaMjeVy8YTAAGlO0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgEGRql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:46:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbgEGRql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:46:41 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4F3324953
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 17:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588873601;
        bh=TGNwlojB/j2uFXoocG2pNAWwUA/IRC4r9PXP+DroQd8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wE06tAbGV1gRVvRxAM6LS+vA3RYqZzxbEtDEAOZRvPoJ+1cZTScO3nTE6wd6Ibp8T
         AdeYSbT9HtXxEIcKZgmodjAkb9U1jE8PlkhmY2RjAhrezLQ9iA1PKuSwKio8fhsCDU
         Mx7Vumw55255VkRS3+lo3dbxIUvwUNsejdzIVDyU=
Received: by mail-wm1-f50.google.com with SMTP id y24so7834939wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 10:46:40 -0700 (PDT)
X-Gm-Message-State: AGi0PuYQlynBGI34HXJq7FLoWihWAGsMVK9xaI4sAK2ey9sKK/HYCVML
        QuSavoDBSntZ2RPkAt8w7HZUJXEXmyd5oc3Th6Myxg==
X-Google-Smtp-Source: APiQypJszx9udG6z/Eq1Onn+5U4Td8r+fKcLNwzecNRPUViwMRgiuq1Kk10MNKt3JAej8ufVaI+H/zNKNYu/CesXgDM=
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr11466099wma.138.1588873599199;
 Thu, 07 May 2020 10:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200505131602.633487962@linutronix.de> <20200505134059.462640294@linutronix.de>
In-Reply-To: <20200505134059.462640294@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 7 May 2020 10:46:26 -0700
X-Gmail-Original-Message-ID: <CALCETrXQLbmCw=8jZR6UbKvCB8ERg+75RWJgBBr5aFGbtVZTDA@mail.gmail.com>
Message-ID: <CALCETrXQLbmCw=8jZR6UbKvCB8ERg+75RWJgBBr5aFGbtVZTDA@mail.gmail.com>
Subject: Re: [patch V4 part 1 14/36] x86/entry: Get rid of ist_begin/end_non_atomic()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:13 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> This is completely overengineered and definitely not an interface which
> should be made available to anything else than this particular MCE case.

Sorry for the overengineering. :)

--Andy
