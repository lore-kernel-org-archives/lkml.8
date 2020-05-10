Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31462C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 21:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD70208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 21:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589144570;
	bh=fiSMKVu1l4jCjDxko+mRVFCFIvy0QxVX6nymNmzbzyI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tM7Wn8K8+qrryxW/PQoHown/3yPs2f1QKXBqwgxoxf+XcYfAGE2ZrkMtxncGqRpd6
	 7dd5axBmy+jAc7rCISf7Prv/5V/X+AjOmYdReBVlnWd/a5aXa1DqAzAUj82zznHT51
	 28mZLBxrVmxWyaVMcHNKKafxTKJI+USCPBiFPsC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgEJVCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 17:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgEJVCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 17:02:48 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00B0D2192A
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 21:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589144568;
        bh=fiSMKVu1l4jCjDxko+mRVFCFIvy0QxVX6nymNmzbzyI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R4RwKpd5yKP9U6Y8Vz2dllnPpMdY3Xf5ZFGzJ6vOvw4Lf/kFmo556kjqsSSZI3oq7
         mqeu45OcogcOOCgw4YLFh0FcYoR5trNyXrZ8bO1jkcQuFgWr3lG/UGn1YWXNQTcQmd
         v7fBh+dMqzzOkRkWHGgmItQTfY1zj4UqPOZYiTmY=
Received: by mail-wr1-f44.google.com with SMTP id k1so8472868wrx.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 14:02:47 -0700 (PDT)
X-Gm-Message-State: AGi0PuaxFqcoV1/P0mdgx1Ejck0/pkZqs8YVebM047rUSkXKTiX+MXQM
        wqyJi4F5qSVYsgSIvV+SYUZk/EX2Byn4Sbdk+j3LPA==
X-Google-Smtp-Source: APiQypJQglxscP90vUcIIJU5+ow4N9EVg91Hh/bKRT0Kt6Ry2gsCTRSXDzaXajLwKChp+e1LWsUoE0WEHhWmknnukrE=
X-Received: by 2002:adf:eccf:: with SMTP id s15mr14244642wro.70.1589144566465;
 Sun, 10 May 2020 14:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134904.058904490@linutronix.de>
In-Reply-To: <20200505134904.058904490@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 10 May 2020 14:02:34 -0700
X-Gmail-Original-Message-ID: <CALCETrWpqAeNG7sv3R_JHt7jagNycQAZWXH-VbG47VuqsTbDcg@mail.gmail.com>
Message-ID: <CALCETrWpqAeNG7sv3R_JHt7jagNycQAZWXH-VbG47VuqsTbDcg@mail.gmail.com>
Subject: Re: [patch V4 part 3 08/29] x86/entry/64: Provide sane error entry/exit
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
> For gradual conversion provide a macro parameter and the required code
> which allows to handle instrumentation and interrupt flags tracking in C.

Acked-by: Andy Lutomirski <luto@kernel.org>
