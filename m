Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF407C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ACAE207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWUGqFzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgFRW2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:28:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50825 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727937AbgFRW2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 18:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592519319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8+pq5KNQ7cig8DZxEE8yz2Racz4jPXVsBdHBmYL2X34=;
        b=DWUGqFzio+g08B96rqbYGu5tj2H2jvd7sDd/QcCGoWTZq6fVaFPtGTG/ZtZFkKEsEbEXny
        OmGObvRjU3JAKYMCpUtwCbUAY2xd4Cv842c3KvEuQeTHGQsKbSDp3pShxeuJNtglW1z1rH
        hOAoLRwh69iMwfFpzAwgB+fztkQBu3w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-sLFoyoRMNDei96W8lV6Psg-1; Thu, 18 Jun 2020 18:28:37 -0400
X-MC-Unique: sLFoyoRMNDei96W8lV6Psg-1
Received: by mail-qk1-f198.google.com with SMTP id v197so5590295qkb.16
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8+pq5KNQ7cig8DZxEE8yz2Racz4jPXVsBdHBmYL2X34=;
        b=Zn4FffmrfqSU5BNUZ/3IH5qwEuRPHG1sJM+A774cLIQnZbP+pEpcj0CbhmeZWKAyO2
         qb5z5VAO7zW5vCTetvqrrGlkrMWJWLi5a2q+NgvZswHE7faeQpLTq32T3HbenOBEAAVH
         MzDJH0i63RUn8Y8ZEStMiXo3i1ApJ8EHfVC9lQ7nASkXvgz01d2LxRCzd2t7vsUyfUJM
         u63rLnepkfJwJ/NsjLx1TA+TuXclY04PR8bec1eViNgiRQbNvqopnlU0C3YQYQac4OL+
         9nlE2twZNZkDC/NWPkLXm3/22cdGxi5hCMcjHqIgj9opi8ig3N+U4LVjeMgnwwvGrR7m
         wZjQ==
X-Gm-Message-State: AOAM533LmbMSCPgdh5ZjJveQPg0YbVBk14CK4UAaLt6QoRdXjzrw/JZ2
        V1vD7zaiCujTMH1ZqiIPwxur50XMgV8Vby0fL0gLIJzPfguFK84OhbNSJR8anFM0VgqV2VF75/H
        lTmic6Cl5AAQ/3YbexO7a3nNu
X-Received: by 2002:a0c:f78b:: with SMTP id s11mr6011564qvn.33.1592519317216;
        Thu, 18 Jun 2020 15:28:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbmu34+M16SgAS5U4xG/Drwrjpe5fqjxcuGoBXwT4tgVhl9fkHXVY+rIkocOe/GKWJxylauA==
X-Received: by 2002:a0c:f78b:: with SMTP id s11mr6011543qvn.33.1592519316979;
        Thu, 18 Jun 2020 15:28:36 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f3sm4003549qta.44.2020.06.18.15.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 15:28:36 -0700 (PDT)
Date:   Thu, 18 Jun 2020 18:28:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guo Ren <guoren@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-csky@vger.kernel.org
Subject: Re: [PATCH 07/25] mm/csky: Use mm_fault_accounting()
Message-ID: <20200618222834.GP76766@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615221607.7764-8-peterx@redhat.com>
 <CAJF2gTSVSXO=phc1eeb-ZmDMrSDjSSLd3tN6ng_8n-pCSZh5zw@mail.gmail.com>
 <20200617154925.GC76766@xz-x1>
 <CAHk-=wi=58J7d5iyFyYyHrU+pzjWB55cit_LQCkSkavpH-trsg@mail.gmail.com>
 <20200617195807.GH76766@xz-x1>
 <CAHk-=wj_V2Tps2QrMn20_W0OJF9xqNh52XSGA42s-ZJ8Y+GyKw@mail.gmail.com>
 <20200618143801.GK76766@xz-x1>
 <CAHk-=whFEZbTJZaNwEkyevUV2aqRwbeVmtp6hhk1sK2mW4vaGA@mail.gmail.com>
 <20200618212430.GO76766@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200618212430.GO76766@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 05:24:30PM -0400, Peter Xu wrote:
> >         /* Major fault */
> >         if ((ret & VM_FAULT_MAJOR) || (flags & FAULT_FLAG_TRIED)) {
> >                 flt = &current->maj_flt;
> >                 event_type = PERF_COUNT_SW_PAGE_FAULTS_MAJ;
> >         } else {
> >                 flt = &current->min_flt;
> >                 event_type = PERF_COUNT_SW_PAGE_FAULTS_MIN;
> >         }
> >         *flt++;
> >         if (regs)
> >                 perf_sw_event(event_type, 1, regs, address);

Sadly, this line seems to fail the compilation:

  CC      mm/memory.o
In file included from ././include/linux/compiler_types.h:68,
                 from <command-line>:                      
./arch/x86/include/asm/jump_label.h: In function ‘handle_mm_fault’:
./include/linux/compiler-gcc.h:120:38: warning: ‘asm’ operand 0 probably does not match constraints
  120 | #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
      |                                      ^~~
./arch/x86/include/asm/jump_label.h:25:2: note: in expansion of macro ‘asm_volatile_goto’
   25 |  asm_volatile_goto("1:" 
      |  ^~~~~~~~~~~~~~~~~
./include/linux/compiler-gcc.h:120:38: error: impossible constraint in ‘asm’
  120 | #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
      |                                      ^~~            
./arch/x86/include/asm/jump_label.h:25:2: note: in expansion of macro ‘asm_volatile_goto’
   25 |  asm_volatile_goto("1:"                                                                                                
      |  ^~~~~~~~~~~~~~~~~
make[1]: *** [scripts/Makefile.build:267: mm/memory.o] Error 1
make: *** [Makefile:1729: mm] Error 2

Frankly speaking I have no solid understanding on what's the error about... But
my gut feeling is that it's about the static keys, where perf_sw_event() may
only support static event types (otherwise we won't be able to know whether to
patch the instruction with no-op or a jump?).

I'll go back to the simple version for now, until I know a solution..

Thanks,

-- 
Peter Xu

