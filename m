Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC2CC54FCB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 00:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC61D20782
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 00:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hAguJWaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgDUAse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbgDUAse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 20:48:34 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54512C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 17:48:33 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id n2so6458063ybg.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 17:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=z0ja3Th+CdUlodwbGEEsUxidU7Y+85Og8bujWPpY0cQ=;
        b=hAguJWaGdH55B3MavbpnIxsn7IrA16X3qfchaGAjjqNJ4KnZWCZ27FGGN3iTfnDVIj
         pmGgmvQ7XrVuzhl1aBsHlHmxqFGcxN+HsGUM/UjXZbT9+9OPsQZ8p+hurP+O4rQGxyen
         t9fA9k4/I21eO9oChjuIadcpugvzOlKrYywnUHiKSZT4xZNydTNi8ZkodiH3CS22GAco
         Z0EYSG8y9cVzdvHICqmf+ZiETQnHLfa8FwKmaYMNzuHzlaIYp05Lpbx15KL2rh0XO4Ks
         EayTLzmipUEbTvVM5CU6OPg7sxq9R0S073vUSwCdjwcgRfyv7fM1uoDGyr3PAPZu5jlj
         cBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=z0ja3Th+CdUlodwbGEEsUxidU7Y+85Og8bujWPpY0cQ=;
        b=lhrSaz8eqZVY0BJih85fceGNqVvMl2bCqilvpq0FwQwCsHRJGMj+0HdRCqFhvrzaB4
         S52qc2uwQTdkKWDKxScHNY8bQFQsWbV3xIV9ohkfchT+Miizt0LyKNN1q4JTG4YzDA1a
         Fx26l2nG5w2Q5XE8dhL1QP3ZgTqUhd8Rx5umoEAUhauOA4QRRX75Sv26Qvlle+4+H1VI
         mK/XXkRsrBlbkuFOAjgilKtdLoKr/6sCpD3gFwf37VKMOCukg4akI3dTx50uPw0WP+sZ
         6Axl4tAjOoNTIFQkYakATFyBRaifxLmt4cqPGKVXBAMrPmPaz7/IyE432U493o9+hR09
         oFsA==
X-Gm-Message-State: AGi0PubHqQHuU1bQ6nGFB9lHDgNmUoDI6LkQ4Q0tbWx9R4IeapixYKto
        jRMNoag+svpx7YqTEWee1OBhJgr6dE+USQg3opaGDg==
X-Google-Smtp-Source: APiQypJ6DaxKI4w07yIv2d5ffhJGEtEQyzfpfwQsrY9bsV/vCWXNDin0t2nFXmc7XxRQrJuGCWHT7AZ5Gs0CJ3aynFc=
X-Received: by 2002:a25:12c1:: with SMTP id 184mr13762167ybs.162.1587430112263;
 Mon, 20 Apr 2020 17:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200415004353.130248-1-walken@google.com> <20200415004353.130248-2-walken@google.com>
 <20200420194813.v7m7tmqhuza6qzoi@linux-p48b>
In-Reply-To: <20200420194813.v7m7tmqhuza6qzoi@linux-p48b>
From:   Michel Lespinasse <walken@google.com>
Date:   Mon, 20 Apr 2020 17:48:20 -0700
Message-ID: <CANN689HXMXCSZ_+uZVEXWpPX0qGA2gSzqrtgSn4UrgKX5731rg@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] mmap locking API: initial implementation as
 rwsem wrappers
To:     Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 12:51 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
> With one observation below.
>
> >+static inline void mmap_downgrade_write_lock(struct mm_struct *mm)
> >+{
> >+      downgrade_write(&mm->mmap_sem);
> >+}
>
> Shouldn't this really be just mmap_downgrade_write()? In locking
> normally don't add the _lock at the end as it implies the operation
> of acquiring the lock.

Hmmm, I see your point. Actually here the operation is downgrade, so
arguably the name should be mmap_write_downgrade ? I'm not sure I like
the name though, as it does not make it entirely obvious that the
function is a locking primitive.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
