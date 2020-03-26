Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDFEC2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682882073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HSv98EME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgCZM45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:56:57 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36107 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbgCZM45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:56:57 -0400
Received: by mail-yb1-f193.google.com with SMTP id i4so3168164ybl.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 05:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y9YWW6vz22mlq1guLvP+/fT4LGWaEEduUDPTk3TTYX4=;
        b=HSv98EMEHHKD7UrRFLWR8ZBt4EMruUsPmDtAvm0qup2h9sFn6HXYf98wloKcmRhC9c
         s9NomqprvtpQWkfHrqHk4EXaQ8ApGUgEUc7lgCJouaeYlOAeDpYcVxNcPoghjRyH/yRa
         aQ5GWklAUXwS8/Z/lnWserBu7VV4tBVRWz59he+CaMkmc5uIR6foZuF9Vi+QZ+V5KB7P
         pkbs8FYrAboUF0FhrJFzl5qHjoAwbuN3zggbIb76d2vgarOa9XHBPReLGMIbG99gYW32
         ar0IBEYhHFRy7EK6xYjVPSB2O8lrG4nqCSdcfFVSgu86gEygJpJ9eyHYnd7P2/olTVoy
         v8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9YWW6vz22mlq1guLvP+/fT4LGWaEEduUDPTk3TTYX4=;
        b=hgor6ruabJK/bGjAEix7oNpFGmVNul87H8a1hqNqOR0li2Kq+WpyfbNSnaVRtydCOo
         HtT8VGKtw1Li8BNQLI56ZF/OOxNSYyruf+9TNNPN6+4BsBxs4NuIoSLMAmtEN1+rewG0
         tLUeae5Fm8hnDyeo/fDXDBD2g/FPKOMztX8HBssShDlcm9osHr/7gaj4gMfmFi8NzgLG
         32XKM51saQ8NjwTbo1uk5Z7fw3JjXoce3diP5x7CKBs4Jzy5tFBAHexqCsMkY2SjvMHK
         7crEp67sTPeCbqzU99Q6bsQ3J/TtD1/3RAL4//j224sGLfv343T3zUQc+POgntjJqxsN
         +QGQ==
X-Gm-Message-State: ANhLgQ3Vbmqctq6Hk1sTfDrOWxHgyjePbnPdJHOo8oTQI46BuieWStS9
        g0r0upceSTVC1KuWc4+nKMo5cRf6UJ263/qQCAOAvAoegOQ=
X-Google-Smtp-Source: ADFU+vtF2qA3KBXX2BP5sJdWnpK/D2XCaS4hZJxxpwlwViIjO8YnBCF6JvUS+L7CIbDo7ziKEq2xz1Qd6tz/vPNxDBc=
X-Received: by 2002:a25:ccd0:: with SMTP id l199mr14690377ybf.446.1585227415649;
 Thu, 26 Mar 2020 05:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200326070236.235835-1-walken@google.com> <20200326070236.235835-6-walken@google.com>
 <20200326120931.GF22483@bombadil.infradead.org>
In-Reply-To: <20200326120931.GF22483@bombadil.infradead.org>
From:   Michel Lespinasse <walken@google.com>
Date:   Thu, 26 Mar 2020 05:56:43 -0700
Message-ID: <CANN689F_wVcLddAfcvZ+CvqW-JxF4=7an_B5WLRKjYcf31DkAg@mail.gmail.com>
Subject: Re: [PATCH 5/8] mmap locking API: convert nested write lock sites
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 5:09 AM Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Mar 26, 2020 at 12:02:33AM -0700, Michel Lespinasse wrote:
> > @@ -47,9 +48,9 @@ static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
> >        * when the new ->mm is used for the first time.
> >        */
> >       __switch_mm(&new->context.id);
> > -     down_write_nested(&new->mmap_sem, 1);
> > +     mmap_write_lock_nested(new, 1);
> >       uml_setup_stubs(new);
> > -     mmap_write_unlock(new);
> > +     mmap_write_unlock_nested(new);
>
> This is a bit of an oddity.  We don't usually have an unlock_nested()
> variant (a quick grep finds only something complicated in reiserfs).
> That's because it's legitimate to release locks in a different order from
> the one they were acquired in (eg lock A, lock B, unlock A, unlock B), and
> it's not clear whether "nested" would follow the lock (ie unlock_nested B)
> or whether it would follow the code (ie unlock_nested A).
>
> Does your future API require knowing the nested nature at the unlock
> point?  And if so, does it require it for A or B in the above scenario?
> And how does it mix with lock A or B being of a different type (eg a
> plain mutex or a spinlock)?

I'll admit it's a bit unusual.

In MM we have only two uses nested mmap locks (as you can see in this
patch), and they both release locks in the opposite order as they
acquire them. We could probably follow this pattern if additional use
cases end up being needed.

In my range locking patchset, nested locks need to pass an explicit
lock range. Also when implementing mmap_sem locking latencies, it can
be convenient to ignore the nested locks under the assumption that
their hold interval is contained within the outer lock's hold
interval.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
