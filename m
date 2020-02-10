Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001BFC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C951D20714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Iekk9bq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgBJOFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:05:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44099 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgBJOFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:05:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id m16so7834969wrx.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 06:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BC1QTV/GfMFylgzZm/gKJk3DiF0TG5sJ3VTno2jRAlI=;
        b=Iekk9bq4F28Gr2PTANmaR5TKRz2l2cSkpYQ+qCTfsRVdLawWZdCCp3Af+vlX30kgSi
         fgL6BHZsIaf1QEoCSi89WYSt0gU856BczLvho22GkdDjbf6RFwTP/8erFdChy6y5HIYE
         fKV1hc+hOozeBQGUMTQUPOybobwuYykLiBnm2iKZrJHWtXT89YrNZcdDvrO8blIsTpod
         iwAA2lqThkYXxaAO35y5gjfeXmzAU822WHp6DKA1qZP8kH5qbwcV+mOfK1UomI8uYrlb
         X49GLHF1Stmhcx311k+ZJ9NAMp8j9WXovacJPkDmNsvNebbSJHEoqF9L/wkH1Sxbd2iX
         0MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BC1QTV/GfMFylgzZm/gKJk3DiF0TG5sJ3VTno2jRAlI=;
        b=YR8ApgZuEvY4zHbd2kl375uaOdN3wDYei9RlXWXBBRwNrLBGuGchG7I+oXgFel8FRj
         +g4sf1u4Zj/kHZgWIjoKXKMvItPEjqZJ5+Eo4VQUqUlqw+NfnuQcGW83i81DjgCjq5/R
         RO3oyrnECXlrBfy8IForhw/khFsneYDr7ZW+ZrY4CRDZgM+tmyzA3WEQTU/iX4SQlZJ3
         4S7AiGuhEsC9M5yu8ztIv5BdQgpcuClk4DIeOZK76G5WNcpr6lo6giIbW4nO8rItkIzA
         L0lyB5oVER0SXlfq83Gc/V2vj/BKoJD8ypr7AUsUfTezD3bO3gdLSwvQ6G2MFU2pIQN9
         sa+Q==
X-Gm-Message-State: APjAAAV5c4cJDK87Gh9IsFmCk2rBoAOljM4QDa52CMVZU11Y3n/e58d4
        2I4yLpHqURCzyBAGS+WNtSax3Q==
X-Google-Smtp-Source: APXvYqzsuss4SpmtNHijxh8UGeCSj0dPqDqaFBPHwOVzY4qj/xMJsEIyjCohiinzMrMnHKqQBxSjWQ==
X-Received: by 2002:adf:f80b:: with SMTP id s11mr2342329wrp.12.1581343550219;
        Mon, 10 Feb 2020 06:05:50 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id y20sm646715wmi.25.2020.02.10.06.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:05:49 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH-4.19-stable 0/2] Backport ENCODE_FRAME_POINTER hint
Date:   Mon, 10 Feb 2020 14:05:41 +0000
Message-Id: <20200210140543.79641-1-dima@arista.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.19.93 the following warning was observed with CONFIG_FRAME_POINTER:
> WARNING: kernel stack frame pointer at 00000000bceb5183 in Coronavirus:3282 has bad value           (null)
>  unwind stack type:0 next_sp:          (null) mask:0x2 graph_idx:0
>  000000009630aa47: ffffc9000126fdb0 (0xffffc9000126fdb0)
>  0000000020360f53: ffffffff81038e33 (__save_stack_trace+0xcb/0xee)
>  00000000675081f2: 0000000000000000 ...
>  0000000043198fe7: ffffc9000126c000 (0xffffc9000126c000)
>  0000000008a46231: ffffc90001270000 (0xffffc90001270000)
[..]

It turns to be missing %rbp hint was making frame pointer unwinder
a bit tipsy.
The observed is WARN_ONCE(), so it one time per boot, but imho, worth to
have in stable too.

Peter Zijlstra (2):
  x86/stackframe: Move ENCODE_FRAME_POINTER to asm/frame.h
  x86/stackframe, x86/ftrace: Add pt_regs frame annotations

 arch/x86/entry/calling.h     | 15 -----------
 arch/x86/entry/entry_32.S    | 16 ------------
 arch/x86/include/asm/frame.h | 49 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/ftrace_32.S  |  3 +++
 arch/x86/kernel/ftrace_64.S  |  3 +++
 5 files changed, 55 insertions(+), 31 deletions(-)

-- 
2.25.0

