Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D662C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2DE20575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589431740;
	bh=LNBsN7Ecdx0UyTB8fDhHuSBj0TN5gw7/I+WdErk8vyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lGuA/kdi4i/bc4NDuuaNkOeFLp2s+40GnOxbT3O0iDxRvtsjsFW6g90Aa6pvLgG2W
	 bbHrt+jZaKio5aj9BzfhhQ24I6zMziV9fQbAC4A7WWLViHJXldZxa5U+CZx+U5ZakQ
	 Ofivdy/waTn1f4r8OAC69CjIAyamWzasmkyENino=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgENEs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENEs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:48:58 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F3CC2070A
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589431738;
        bh=LNBsN7Ecdx0UyTB8fDhHuSBj0TN5gw7/I+WdErk8vyE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0CKHIcqUtnyRvwxtaj8oWozZK68ZTx/nlkgMSIIV83hjuHnArBv3gZHKy5aqcKdwj
         O9ZDym1tcHQOaaN6a/BNnNOZ1kgelqnOSISTbE+n/qjlx5B02H2fl31G5IH74v9H0T
         0D3tb0wpac1yUtRpYSKZwB5hhdgZDSXz9+hrCl4U=
Received: by mail-wr1-f54.google.com with SMTP id l11so2154194wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:48:58 -0700 (PDT)
X-Gm-Message-State: AOAM532FzX8r8D54omoQwfq1u29/FFnjOAlkH/ktEjwOue5Y0ZL3YG5F
        8Pxd1rft25ePxfI/2ljZ6E9CGuC7wdoirNKvOB6dWQ==
X-Google-Smtp-Source: ABdhPJxFkndUlYze1b7aTzWc8V6R25U0KTfGc7p9kbRlGbnIQOEo8BSAa3tei0jJzFwF7fLcu/bVMXCN3tko0DvX+Ds=
X-Received: by 2002:adf:f446:: with SMTP id f6mr3036373wrp.75.1589431736693;
 Wed, 13 May 2020 21:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134905.350676449@linutronix.de>
In-Reply-To: <20200505134905.350676449@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:48:45 -0700
X-Gmail-Original-Message-ID: <CALCETrUXpes-4TUewbAv8QmKx0GEntSmra+vTT+w2B-NGamuhQ@mail.gmail.com>
Message-ID: <CALCETrUXpes-4TUewbAv8QmKx0GEntSmra+vTT+w2B-NGamuhQ@mail.gmail.com>
Subject: Re: [patch V4 part 3 21/29] x86/entry: Convert Invalid TSS exception
 to IDTENTRY
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
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Convert #TS to IDTENTRY_ERRORCODE:
>   - Implement the C entry point with DEFINE_IDTENTRY
>   - Emit the ASM stub with DECLARE_IDTENTRY
>   - Remove the ASM idtentry in 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Fixup the XEN/PV code
>   - Remove the old prototyoes
>
> No functional change.

I confess that I'm a bit mystified as to why we have all the machinery
in place to send a signal if #TS happens.  Whatever.

Acked-by: Andy Lutomirski <luto@kernel.org>
