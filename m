Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99552C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75CD42074D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4mDUYV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHMJxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgHMJxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:53:34 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086EBC061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 02:53:34 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id q3so2982113ybp.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yul9D5KaapMfO0wSYYumb3nXfH25wAQuTtPB6LytFFQ=;
        b=g4mDUYV/kR2xqvMovbB9tOP1UwfQk6O047mQnaEfU/wAgqPu1NK8GhI6gfzcY5gZQ3
         kZdFLbxgB7OqRvASEeMmcEe99LPAOZaz1kZskBXb/8XLTVke3a8uOYyXOpCAh4FedTtR
         9E7hUlfMGcRn3WfwvWi5YlF/FOSHG3E+wgdpSgj+p9Y2eLtGyRueVDENXxuIaA1s3otY
         fFOfdc7Cz1qEY35Es+aJJFSnpioiFZWGZk+LMsIWu/gGIUaAk2if4K2HJi4QVVS8cDdU
         ckMfr+jW5QSRMSVhuiCR8ex32+qd5wmgdgLepZcJIB/BCSs6gIOX0NPYuRcry/7YIAgL
         JPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yul9D5KaapMfO0wSYYumb3nXfH25wAQuTtPB6LytFFQ=;
        b=tYSVKjhiedHQCNPiw6F/HhiqK6ILeuvTPAyJ/Ngv74UxjvCMw/9j+v/3ccWD6H1UWI
         0UI0sAxPdz/FyapEdLGkT07wpkuHCt4Qx9n4mD0lw+fSClpio4weFBu4IViec8/i1RkM
         udTuNi2AAuAaSGUu8R0l/HjMiNiDwz6nPkMgCaZI0GUj0SFFcMRPK5iiTIGUrflmJtAx
         9JWvTXuAuyr8bA3u2JVaf3p/3D/t5Y3iZg3fptrWiX8U7puqJ9lw1J2s8UM7ssi68Ko1
         56eDS8k2WKLnQhyhetcpJ5A9ISPJy/6CzJtLe96ci1I+ztTAms+O5yuq5YVfUGFlETu6
         cCmw==
X-Gm-Message-State: AOAM531uS146DMhGu4kpTZHp4tqOe8RXOlpUXlDUmrpY3B66+tBwfK3o
        mOmPUkw9wCPJwQNIR3yrBicc2dK9Rk9LWb4PfOjadQ==
X-Google-Smtp-Source: ABdhPJzfpaSBTx1xrZzflOrcYcv5QD4lOFsRlbhX3DHwVGqruN6Tmp191fs//DhyO/wYUtsNm9az23vyctAAcFPz7n0=
X-Received: by 2002:a25:ab34:: with SMTP id u49mr5170276ybi.516.1597312412264;
 Thu, 13 Aug 2020 02:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <1597284810-17454-1-git-send-email-chinwen.chang@mediatek.com>
In-Reply-To: <1597284810-17454-1-git-send-email-chinwen.chang@mediatek.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Thu, 13 Aug 2020 02:53:20 -0700
Message-ID: <CANN689G0DkL-wpxMha=nyysPYG6LM3Aw7060k2xQTxTA4PAf-w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Try to release mmap_lock temporarily in smaps_rollup
To:     Chinwen Chang <chinwen.chang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Steven Price <steven.price@arm.com>,
        Song Liu <songliubraving@fb.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 7:14 PM Chinwen Chang
<chinwen.chang@mediatek.com> wrote:
> Recently, we have observed some janky issues caused by unpleasantly long
> contention on mmap_lock which is held by smaps_rollup when probing large
> processes. To address the problem, we let smaps_rollup detect if anyone
> wants to acquire mmap_lock for write attempts. If yes, just release the
> lock temporarily to ease the contention.
>
> smaps_rollup is a procfs interface which allows users to summarize the
> process's memory usage without the overhead of seq_* calls. Android uses it
> to sample the memory usage of various processes to balance its memory pool
> sizes. If no one wants to take the lock for write requests, smaps_rollup
> with this patch will behave like the original one.
>
> Although there are on-going mmap_lock optimizations like range-based locks,
> the lock applied to smaps_rollup would be the coarse one, which is hard to
> avoid the occurrence of aforementioned issues. So the detection and
> temporary release for write attempts on mmap_lock in smaps_rollup is still
> necessary.

I do not mind extending the mmap lock API as needed. However, in the
past I have tried adding rwsem_is_contended to mlock(), and later to
mm_populate() paths, and IIRC gotten pushback on it both times. I
don't feel strongly on this, but would prefer if someone else approved
the rwsem_is_contended() use case.

Couple related questions, how many VMAs are we looking at here ? Would
need_resched() be workable too ?

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
