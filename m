Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C180BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE059206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589431571;
	bh=CPpyjK70JvrMZ1aCu8A3U2yEThl5pWfq7ydEmrg/xXQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CeuZ9YiAPDsE+7OXd7eMkBjBZvmHAsdZ2Z9++pvSdXORNo6CeI3Lt5HLtBebrQpgg
	 Wi1RsAYxvHZuvUvLNQweP4fgI3Y0bEDLIQLBurLe+nOTdTFPC24jbSYoeU1orBjLzx
	 gLYx8Mw2UmsD0tBQFpuUkIYs3jyG4XOm9Jn4loOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgENEqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENEqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:46:10 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A049206F1
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589431569;
        bh=CPpyjK70JvrMZ1aCu8A3U2yEThl5pWfq7ydEmrg/xXQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QNSfJ24ZC0QoD9bjQhd+F30ocE6BFwnTp6U7/WL8OZ+BGPU3XOAjSucNbVtqtZFUE
         XYII32U/fghQiAIao3bvgsRDtawpsX7lX2OKHpr1daD0Ax/klJ0bZrStzA7T5OHB6w
         j1GzMNRVf408GuP1EQxo7VUqJ1vCBJzZW1dM7hNA=
Received: by mail-wm1-f48.google.com with SMTP id k12so28698282wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:46:09 -0700 (PDT)
X-Gm-Message-State: AGi0PuabGHzhHgYQDBtLSDFZb2teD7HtRDoRKk+59BpkPUImndxQqh3/
        Fp1rNiDLVnX+v0l5e11NoIe8Fo7mLrgK2DtZahlFLg==
X-Google-Smtp-Source: APiQypIyRVYK6x8j0RD3H6cK0UOvCsdTUuDBK7KedWelzNOin/fap2anKXhIt7kQXiCMptBU9uw2tSSbsZeU42MdPGE=
X-Received: by 2002:a1c:2bc2:: with SMTP id r185mr22197383wmr.49.1589431567995;
 Wed, 13 May 2020 21:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134905.056243863@linutronix.de>
In-Reply-To: <20200505134905.056243863@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:45:56 -0700
X-Gmail-Original-Message-ID: <CALCETrXMzwKON7SkfUo1jG2iEmzaxTEZi9pec59RrLdH5MUTMA@mail.gmail.com>
Message-ID: <CALCETrXMzwKON7SkfUo1jG2iEmzaxTEZi9pec59RrLdH5MUTMA@mail.gmail.com>
Subject: Re: [patch V4 part 3 18/29] x86/entry: Convert Device not available
 exception to IDTENTRY
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
> Convert #NM to IDTENTRY:
>   - Implement the C entry point with DEFINE_IDTENTRY
>   - Emit the ASM stub with DECLARE_IDTENTRY
>   - Remove the ASM idtentry in 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Fixup the XEN/PV code
>   - Remove the old prototyoes
>   - Remove the RCU warning as the new entry macro ensures correctness
>
> No functional change.


Acked-by: Andy Lutomirski <luto@kernel.org>
