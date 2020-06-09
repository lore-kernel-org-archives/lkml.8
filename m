Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0718C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA2E206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RgSgDCsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgFIX6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 19:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFIX6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 19:58:33 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F676C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 16:58:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l26so178347wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 16:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=anN6VMBl2Y9GxNCV0A1oarrG+zWFZt2u/6ksmBGcqW0=;
        b=RgSgDCsvEyHGnhAp5C37EQIqSsiB1CL2i0Ym94l0O4LKQ6Xn4TUhNDHHCOrUvYaUz5
         8sUjc897Cu59ZnqOQ7rwiogas5ToiVDXcOvxaTZquYAP4VNi2mokGfHCplMZDMuE7gFQ
         YtjbJRhW3hMgW/6/JSabc8Z2s2gHWjDzS7udo7jh8JH7/c+C/G/PqJrH/ZaSU6fdMEsy
         dRPKGvEWXoKxrVM1d/4pcwsohTPdfcDRJb3lWT4JqBZWnTgH+7Z5+jFaZldsrMkeA/bU
         +Pbnk8ywIesXCp/8q7sILDLYktxe3egDhZdgl9+lcsKpNVln4naz4JosB4Q4KYMH2w+t
         ncJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=anN6VMBl2Y9GxNCV0A1oarrG+zWFZt2u/6ksmBGcqW0=;
        b=HdcWRCGSRkYUaOArEkAUs31ER+9VJMCwEz4RBqDdFUrOFst1Qs3hVBa+fds0z8e2Iq
         qvvIR9Mhiv1F+VdA/Z24W4iLfY1aF6SLF/BAuuyTYrP7UO0YGA4YDVmtWzhpbOl2gKUK
         edCG8Jgu7c3GSh4JOTwR+E2U5T9jv0Pq3x0Mr78m9KSnXqtIsJIrfoSNdqW373Aw8wcP
         /iVOtjL2wilLHFcFgLjkCTTdHGXZ9Dzy8z3Q2ZjA1E8MI2RekI7dqNrxvwPJkN5ukt3c
         vZkbZS7qqRcLS0/O2/oAbqiM5oOmmRSWzEjQDSnivZsE4aPFbEmAYYmMPJprkHzfv7T1
         0A4Q==
X-Gm-Message-State: AOAM533z7IXAiXzkZ8tPwRqyYdKATCclZV610pTYPy89shzJxlEUjthR
        TNSuyUJVpn89l/Itr5k+56XnfkS5dmAlPvB5l96S9Q==
X-Google-Smtp-Source: ABdhPJzMP0kmh6XWaWinUMdbdyrwWIOs/rX+w+yqa+18XKlOc48LRYGwWM4q2ORG8KnQemkVhFQaLlFPtULeV09nMCU=
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr471675wmi.126.1591747111836;
 Tue, 09 Jun 2020 16:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200610093012.13391de8@canb.auug.org.au>
In-Reply-To: <20200610093012.13391de8@canb.auug.org.au>
From:   Arjun Roy <arjunroy@google.com>
Date:   Tue, 9 Jun 2020 16:58:21 -0700
Message-ID: <CAOFY-A0gpqNHCThu8QFuy_AOEpnGHAqcBbFbuGNw1wuyeTerkg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the net tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ack, and thank you very much for the fix.

-Arjun


On Tue, Jun 9, 2020 at 4:30 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the net tree got a conflict in:
>
>   net/ipv4/tcp.c
>
> between commit:
>
>   d8ed45c5dcd4 ("mmap locking API: use coccinelle to convert mmap_sem rwsem call sites")
>
> from Linus' tree and commit:
>
>   3763a24c727e ("net-zerocopy: use vm_insert_pages() for tcp rcv zerocopy")
>
> from the net tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc net/ipv4/tcp.c
> index 27716e4932bc,ecbba0abd3e5..000000000000
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@@ -1762,7 -1796,9 +1796,9 @@@ static int tcp_zerocopy_receive(struct
>
>         sock_rps_record_flow(sk);
>
> +       tp = tcp_sk(sk);
> +
>  -      down_read(&current->mm->mmap_sem);
>  +      mmap_read_lock(current->mm);
>
>         vma = find_vma(current->mm, address);
>         if (!vma || vma->vm_start > address || vma->vm_ops != &tcp_vm_ops) {
> @@@ -1817,17 -1863,27 +1863,27 @@@
>                         zc->recv_skip_hint -= remaining;
>                         break;
>                 }
> -               ret = vm_insert_page(vma, address + length,
> -                                    skb_frag_page(frags));
> -               if (ret)
> -                       break;
> +               pages[pg_idx] = skb_frag_page(frags);
> +               pg_idx++;
>                 length += PAGE_SIZE;
> -               seq += PAGE_SIZE;
>                 zc->recv_skip_hint -= PAGE_SIZE;
>                 frags++;
> +               if (pg_idx == PAGE_BATCH_SIZE) {
> +                       ret = tcp_zerocopy_vm_insert_batch(vma, pages, pg_idx,
> +                                                          &curr_addr, &length,
> +                                                          &seq, zc);
> +                       if (ret)
> +                               goto out;
> +                       pg_idx = 0;
> +               }
> +       }
> +       if (pg_idx) {
> +               ret = tcp_zerocopy_vm_insert_batch(vma, pages, pg_idx,
> +                                                  &curr_addr, &length, &seq,
> +                                                  zc);
>         }
>   out:
>  -      up_read(&current->mm->mmap_sem);
>  +      mmap_read_unlock(current->mm);
>         if (length) {
>                 WRITE_ONCE(tp->copied_seq, seq);
>                 tcp_rcv_space_adjust(sk);
