Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB18C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC65206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589432389;
	bh=SX6Vay+i/sL9lNviBR0X3XHpfUY3XG7IvWWYpzlejPM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q3aUMNKN5esENjhZvBIjqYmmNbSLZNVgt9ITnxnfIgMh0e6e3bs8Y2Kxv7wgzsIjx
	 LlG49EdDkySPmA6JC+653xU/AJy7jVpdn/aasK7eeT4smcVaF3wJA/7gdora0XQEiG
	 xagdQsJi0lmggM5iUZ844AeTpKm0LEg2j5gzkEp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgENE7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgENE7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:59:47 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54300205CB
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589432387;
        bh=SX6Vay+i/sL9lNviBR0X3XHpfUY3XG7IvWWYpzlejPM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DDDOXh1WH98RK8BhHj79qQF3if4FSr1Tq6ITdI3g+OeuRVmcKPGUln30Ote4v6kqh
         fPOM/OeUPAumpKR8mOMjx61ZFUogub5wSQAnuMaBajZYE5o80wUsw2BtPjBMz4s+X6
         AiJbmy8Fvd+bEiI41/JB95Ua8Ex8fSQcD+TvQo9M=
Received: by mail-wr1-f47.google.com with SMTP id h17so2112794wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:59:47 -0700 (PDT)
X-Gm-Message-State: AOAM532b9Ppt00+KlG5QMCVYqhfDn1o2AZYY8ntpW8y3R2U9YAE9qAi2
        6ALhnaxxwMfR1I4rTr3u9dLFpq7kg8Az2sSRI01x/g==
X-Google-Smtp-Source: ABdhPJy2E48mbnP2MQR/8N+8NTBvsqW0Glflep3UmW6scHBh05QBvoRDOZCSrnJK3LV3Ntcabz2Y0cv1WrIkFEzI7P8=
X-Received: by 2002:adf:eccf:: with SMTP id s15mr3079427wro.70.1589432385825;
 Wed, 13 May 2020 21:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135313.830540017@linutronix.de>
In-Reply-To: <20200505135313.830540017@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:59:34 -0700
X-Gmail-Original-Message-ID: <CALCETrW=RG_4EJAumWokbKby1gTig0hrexZsvJ_c_9YA7RK5oQ@mail.gmail.com>
Message-ID: <CALCETrW=RG_4EJAumWokbKby1gTig0hrexZsvJ_c_9YA7RK5oQ@mail.gmail.com>
Subject: Re: [patch V4 part 4 05/24] x86/entry: Provide IDTENTRY_RAW
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

On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Some exception handlers need to do extra work before any of the entry
> helpers are invoked. Provide IDTENTRY_RAW for this.


Acked-by: Andy Lutomirski <luto@kernel.org>
