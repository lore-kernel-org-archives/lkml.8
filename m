Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E2FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2064F20756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597178790;
	bh=KCaFr7cVz1idwlfS9VAfTiZWL3KMGPCdy+C8IwnjGhw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LxDsZnzc74s2B7vPFJEoxAFoCbe1BhzlMYzNRd9H2dlm5gN/PsjibZh9ni3oUVTVI
	 nivOvMQ4KczNJ05+vhzXsEFblKAUK5ilqKTUACb7V4Oqaq+P8bgQmd6e3y6zngTcv+
	 el2tMMO0IbSA/29eJ3Vup1LqVLvq3StCOPtTaS8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgHKUq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgHKUq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:46:28 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A234C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:46:27 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v15so7384869lfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZe75UFLfITAAmIeNDbAzsOBmvV4RSPUEOqHg3l7jUw=;
        b=IMdn9XLtN1CZPiqDOc5nHwwsTSpq4Fn1lMUvGjdT4Syjvo3UbZqo/PYZfhb12PIT+w
         0CQ5j/1SD1y898z3WwPFERJmKo05ajw+EZyAurkgo/4F4+GjxAjB9Z2WkFlTWZlsct5Q
         vFbV4ctkkFe6wGN1i6LxW9q7Uu6GOFFkAPw3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZe75UFLfITAAmIeNDbAzsOBmvV4RSPUEOqHg3l7jUw=;
        b=j6O9e403hwz+/DEVYmu2gVzd2S2AErjzZ4v8XkBkf576KlQTi3Eyg2BJhfKauEe31x
         mq5P+R894CIr2RLfJNKoL6TgAsj6HfcmQv9VX2BYXqWkC74PKYKJLkzIcFs/Dx/Gi84G
         vD04ZRsHxNZvNy1lpUcgb7kg9kEBh1TQyfJqxpi/tXOE7HxV8Z2oDTpkF8NMpglGZ8+1
         lIvnkcje4ssuzVgOM1M/koI7xJ4h3H5OwWce5OonBkuXylRZUyVxrm48sFPj9Qf9z3iL
         JDm4C7JNZh5sqAfNh5zfcCbkf0L89xLzB0xPkD7OqhzjewxH7cGOJSfgPeQsJ1zwGslU
         LbDQ==
X-Gm-Message-State: AOAM533CjQlcD0QWvbXcF43+Ygzeifdy0H3q3btcqH2S2NNyqit28hS+
        2KIJevZkrm03zGwP4YP0TGH0ErgS70s=
X-Google-Smtp-Source: ABdhPJzB9bkOyn3iJHUfFu4dmLUqMbB0tDfpC4xCpp9pgS2Z3y3JnJpSXqAAV3gGqLW21swUysYiww==
X-Received: by 2002:ac2:58c6:: with SMTP id u6mr4027471lfo.105.1597178784624;
        Tue, 11 Aug 2020 13:46:24 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id n24sm6786865lji.83.2020.08.11.13.46.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 13:46:22 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id h19so15026133ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:46:22 -0700 (PDT)
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr4015314ljp.312.1597178781721;
 Tue, 11 Aug 2020 13:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200811183950.10603-1-peterx@redhat.com> <CAHk-=whQM=m5td5tfbuxh1f_Gxjsa74XV962BYkjrbeDMAhBpA@mail.gmail.com>
 <CAHk-=wit7LDr0tA2eVn7yHHEH76oK=Lfm3tTs8_JxO8XEED4_g@mail.gmail.com>
In-Reply-To: <CAHk-=wit7LDr0tA2eVn7yHHEH76oK=Lfm3tTs8_JxO8XEED4_g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 13:46:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifRg0pDhufQFasWa7G3sMHbG0nahnm5yRwvTKpKU9g4A@mail.gmail.com>
Message-ID: <CAHk-=wifRg0pDhufQFasWa7G3sMHbG0nahnm5yRwvTKpKU9g4A@mail.gmail.com>
Subject: Re: [PATCH v3] mm/gup: Allow real explicit breaking of COW
To:     Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Content-Type: multipart/mixed; boundary="000000000000edc16805aca02981"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000edc16805aca02981
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 11, 2020 at 1:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Maybe trying to reuse the page just isn't worth it?

Well, the attached patch boots, and hasn't slowed kernel compiles
down. But it may do horrible things due to leaving swap cache pages
and KSM pages to be reaped by the memory scanner, instead of being
reused.

I wouldn't notice, I have too much memory in this machine anyway.

It might have positive side effects too, of course. Not waiting for
the page lock in the page fault case could be a big win on some loads.
We do_wp_page() was one of the paths to the page lock that caused the
nasty latency spikes (I'm not sure it was a dominant one, but it was
up there).

So maybe it is worth running some test loads on. And while this patch
doesn't do it, applying this should mean that you can just revert all
the COW games entirely, and we can remove the should_force_cow_break()
from the GUP paths.

(Also - if this actually works, we can get rid of reuse_ksm_page(),
this was the only user)

                 Linus

--000000000000edc16805aca02981
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kdqewza70>
X-Attachment-Id: f_kdqewza70

IG1tL21lbW9yeS5jIHwgNTggKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDQy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL21tL21lbW9yeS5jIGIvbW0vbWVtb3J5LmMKaW5k
ZXggYzM5YTEzYjA5NjAyLi5iNGE1NzczMDUzOWQgMTAwNjQ0Ci0tLSBhL21tL21lbW9yeS5jCisr
KyBiL21tL21lbW9yeS5jCkBAIC0yOTI3LDUwICsyOTI3LDI0IEBAIHN0YXRpYyB2bV9mYXVsdF90
IGRvX3dwX3BhZ2Uoc3RydWN0IHZtX2ZhdWx0ICp2bWYpCiAJICogbm90IGRpcnR5IGFjY291bnRh
YmxlLgogCSAqLwogCWlmIChQYWdlQW5vbih2bWYtPnBhZ2UpKSB7Ci0JCWludCB0b3RhbF9tYXBf
c3dhcGNvdW50OwotCQlpZiAoUGFnZUtzbSh2bWYtPnBhZ2UpICYmIChQYWdlU3dhcENhY2hlKHZt
Zi0+cGFnZSkgfHwKLQkJCQkJICAgcGFnZV9jb3VudCh2bWYtPnBhZ2UpICE9IDEpKQorCQlzdHJ1
Y3QgcGFnZSAqcGFnZSA9IHZtZi0+cGFnZTsKKworCQlpZiAocGFnZV9jb3VudChwYWdlKSAhPSAx
KQorCQkJZ290byBjb3B5OworCQlpZiAoIXRyeWxvY2tfcGFnZShwYWdlKSkKKwkJCWdvdG8gY29w
eTsKKwkJaWYgKHBhZ2VfbWFwY291bnQocGFnZSkgIT0gMSAmJiBwYWdlX2NvdW50KHBhZ2UpICE9
IDEpIHsKKwkJCXVubG9ja19wYWdlKHBhZ2UpOwogCQkJZ290byBjb3B5OwotCQlpZiAoIXRyeWxv
Y2tfcGFnZSh2bWYtPnBhZ2UpKSB7Ci0JCQlnZXRfcGFnZSh2bWYtPnBhZ2UpOwotCQkJcHRlX3Vu
bWFwX3VubG9jayh2bWYtPnB0ZSwgdm1mLT5wdGwpOwotCQkJbG9ja19wYWdlKHZtZi0+cGFnZSk7
Ci0JCQl2bWYtPnB0ZSA9IHB0ZV9vZmZzZXRfbWFwX2xvY2sodm1hLT52bV9tbSwgdm1mLT5wbWQs
Ci0JCQkJCXZtZi0+YWRkcmVzcywgJnZtZi0+cHRsKTsKLQkJCWlmICghcHRlX3NhbWUoKnZtZi0+
cHRlLCB2bWYtPm9yaWdfcHRlKSkgewotCQkJCXVwZGF0ZV9tbXVfdGxiKHZtYSwgdm1mLT5hZGRy
ZXNzLCB2bWYtPnB0ZSk7Ci0JCQkJdW5sb2NrX3BhZ2Uodm1mLT5wYWdlKTsKLQkJCQlwdGVfdW5t
YXBfdW5sb2NrKHZtZi0+cHRlLCB2bWYtPnB0bCk7Ci0JCQkJcHV0X3BhZ2Uodm1mLT5wYWdlKTsK
LQkJCQlyZXR1cm4gMDsKLQkJCX0KLQkJCXB1dF9wYWdlKHZtZi0+cGFnZSk7Ci0JCX0KLQkJaWYg
KFBhZ2VLc20odm1mLT5wYWdlKSkgewotCQkJYm9vbCByZXVzZWQgPSByZXVzZV9rc21fcGFnZSh2
bWYtPnBhZ2UsIHZtZi0+dm1hLAotCQkJCQkJICAgICB2bWYtPmFkZHJlc3MpOwotCQkJdW5sb2Nr
X3BhZ2Uodm1mLT5wYWdlKTsKLQkJCWlmICghcmV1c2VkKQotCQkJCWdvdG8gY29weTsKLQkJCXdw
X3BhZ2VfcmV1c2Uodm1mKTsKLQkJCXJldHVybiBWTV9GQVVMVF9XUklURTsKLQkJfQotCQlpZiAo
cmV1c2Vfc3dhcF9wYWdlKHZtZi0+cGFnZSwgJnRvdGFsX21hcF9zd2FwY291bnQpKSB7Ci0JCQlp
ZiAodG90YWxfbWFwX3N3YXBjb3VudCA9PSAxKSB7Ci0JCQkJLyoKLQkJCQkgKiBUaGUgcGFnZSBp
cyBhbGwgb3Vycy4gTW92ZSBpdCB0bwotCQkJCSAqIG91ciBhbm9uX3ZtYSBzbyB0aGUgcm1hcCBj
b2RlIHdpbGwKLQkJCQkgKiBub3Qgc2VhcmNoIG91ciBwYXJlbnQgb3Igc2libGluZ3MuCi0JCQkJ
ICogUHJvdGVjdGVkIGFnYWluc3QgdGhlIHJtYXAgY29kZSBieQotCQkJCSAqIHRoZSBwYWdlIGxv
Y2suCi0JCQkJICovCi0JCQkJcGFnZV9tb3ZlX2Fub25fcm1hcCh2bWYtPnBhZ2UsIHZtYSk7Ci0J
CQl9Ci0JCQl1bmxvY2tfcGFnZSh2bWYtPnBhZ2UpOwotCQkJd3BfcGFnZV9yZXVzZSh2bWYpOwot
CQkJcmV0dXJuIFZNX0ZBVUxUX1dSSVRFOwogCQl9Ci0JCXVubG9ja19wYWdlKHZtZi0+cGFnZSk7
CisJCS8qCisJCSAqIE9rLCB3ZSd2ZSBnb3QgdGhlIG9ubHkgbWFwIHJlZmVyZW5jZSwgYW5kIHRo
ZSBvbmx5CisJCSAqIHBhZ2UgY291bnQgcmVmZXJlbmNlLCBhbmQgdGhlIHBhZ2UgaXMgbG9ja2Vk
LAorCQkgKiBpdCdzIGRhcmsgb3V0LCBhbmQgd2UncmUgd2VhcmluZyBzdW5nbGFzc2VzLiBIaXQg
aXQuCisJCSAqLworCQl3cF9wYWdlX3JldXNlKHZtZik7CisJCXVubG9ja19wYWdlKHBhZ2UpOwor
CQlyZXR1cm4gVk1fRkFVTFRfV1JJVEU7CiAJfSBlbHNlIGlmICh1bmxpa2VseSgodm1hLT52bV9m
bGFncyAmIChWTV9XUklURXxWTV9TSEFSRUQpKSA9PQogCQkJCQkoVk1fV1JJVEV8Vk1fU0hBUkVE
KSkpIHsKIAkJcmV0dXJuIHdwX3BhZ2Vfc2hhcmVkKHZtZik7Cg==
--000000000000edc16805aca02981--
