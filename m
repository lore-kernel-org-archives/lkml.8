Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F94C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67E62074F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586461592;
	bh=nyIxC51HalWMRwc3hiGxkNzVsGOnzfveJQoVOdQQS4Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=L12e0KT5vvrXtusyGSsmG7EH61/biC2fgI/YryexJeGCq48SshpSZ/IBbaSXwtC4V
	 BqZ2rOaXg7kLw8LNMEiLIo55wUx4RMMJ+4CcTI435vMakt1QFvBJXQvms00dLkaYe2
	 VDmf6rNtBZgxPFNjFtrwLcoZZlHaZUA7iTk2GcqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgDITqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:46:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35447 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgDITqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:46:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id k21so1015840ljh.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 12:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjfybBxyqmuwHGmDDwKLdjIJ1653tk8qO60kNFLbN8A=;
        b=IWnFxrUY/thW/sA/QeSSfAPLOpd4p1So2iL2LPuQC1akZHOrayroIFWWhti4GiWB5w
         HA7NTMOyg7mQOwJImFIz8RFqDddnmDfaL323qNEr+xdlhDYa8Td2WY15tWUpsV23lC6d
         Z3lphMt2q2O3weJzPo202RCcG5FEEc/EAHIRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjfybBxyqmuwHGmDDwKLdjIJ1653tk8qO60kNFLbN8A=;
        b=fNB/yn1ega/Esz8iTS7OR5CV6jxJGSMS9suL/2hPlcFNsmS0lK7CVU9CwN8+YAZ2ME
         GUV4zb2QfvSB5749bFiURVFTfTFJAWsthyvevs5JyYlaC0wG/1ciQCiXv0KlFqanae8v
         iJHE4CVyXsnw205u9F9/Hyr9PhPRjMPDJGJ5wNsEMmNF1Ude3nRNI5zImhdZaFhYLLK7
         wLwDP5GCxZfHBDdZDyycxoz7EcvcEa4B9QEG+DSZTlF1ipqGOPB/Dl+n0LjI4qDnh+xD
         +gfSOUsSJV9kruR5tg69HjHcaL1TiGeLiaebhBSiknaFckMYxKavo3KhRLJtV0/gz3pS
         7nMw==
X-Gm-Message-State: AGi0Puam36dZxxViZXRyA5IZyw50EfJHgbnR3RpQ0e5OHZeFiMWHUcgK
        oWPzgkX/ZVDK2VFEmj5bdgXEQ/40nOQ=
X-Google-Smtp-Source: APiQypKGjeMi3gEtGzss9lfLkEEO3U5A/5IozZ2I6F5OdOex4EgNYKC+kLNafsG8rMAuQho2Js6T0g==
X-Received: by 2002:a2e:3507:: with SMTP id z7mr890929ljz.111.1586461586515;
        Thu, 09 Apr 2020 12:46:26 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id c22sm15914978lja.86.2020.04.09.12.46.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 12:46:25 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id b1so1018729ljp.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 12:46:24 -0700 (PDT)
X-Received: by 2002:a2e:b619:: with SMTP id r25mr899283ljn.150.1586461584547;
 Thu, 09 Apr 2020 12:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200408014010.80428-1-peterx@redhat.com> <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
 <20200409114940.GT21484@bombadil.infradead.org> <CACT4Y+ZvQ9UvVAwTjjD8Zxo0X_nfxa3+6n6TqWk2g+hahBwdCw@mail.gmail.com>
 <20200409111604.c778ff091c00fab5db095e48@linux-foundation.org>
 <CAHk-=wiU77DeNxQsU4XrDCk59asyTs=Hn+mnTx6-SHB1_fA2NQ@mail.gmail.com> <20200409121250.d6bba6965b86c8dfcf325fbc@linux-foundation.org>
In-Reply-To: <20200409121250.d6bba6965b86c8dfcf325fbc@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 12:46:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgy3XRiyRP7vdfF6bHwWGaB1RwyWJmyphh+Q3qYk6w27w@mail.gmail.com>
Message-ID: <CAHk-=wgy3XRiyRP7vdfF6bHwWGaB1RwyWJmyphh+Q3qYk6w27w@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 12:12 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> And now the challenge is to protect your tree from the bad patches.

Well, right now, yes.

But in the longer term, I think we want to protect linux-next from the
bad patches so that they don't poison the testing that the bots can
do.

So that's why I suggested that linux-next and syzbot have some
protocol to have things that cause syzbot pain to be removed from
linux-next more aggressively.

              Linus
