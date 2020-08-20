Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65302C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E6B52087D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597960886;
	bh=SOPU3VQ6p3Cl2aDqARAkUGBjRxzIK/F4rU11i7Epjk8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WJMvHy0z6euFnB/3qJ4nNn5iOvSTF8nYpRA97JlJlzbOuPcic95V3HU3lWYNgNfXD
	 /P/IDlMBqPWlLxawNZfqRNJXJO5BKpguWZFdmr8V0ppbNbTWv2iwqWm4i6LmKn22J2
	 KrSHz7M/LynwCJYg8zZFV/X+jx602UPdkXn64R2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgHTWBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgHTWBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:01:21 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED216C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:01:20 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y2so3803462ljc.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhS3pBgWvGPkso944E0GTs7HPQ2mFHvBZOTqxaoI5ss=;
        b=Fv9boQZV8ejQzchYvoSME/1lF+f4gEY7lMgb8iUq3vxM0n+1k6wlq/l0h4gQcQTBms
         eEWdRWaVmRDPPlNI/Pwy/p+tAQ/RHO8bJkc4aw1HJkI0bFzKVA1Ve3xy7f3dTFKsmOiJ
         9hisVBdFXd+IGZktDHtReyiXEgSQHWXm92c0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhS3pBgWvGPkso944E0GTs7HPQ2mFHvBZOTqxaoI5ss=;
        b=a7Zyx0iBOrv4iSaa64gNiSLVS3LHbPkXuSXPTFN3S4ig3JoUcJ7KScAFKQS32UzD4e
         mnDcKcrM/UvbiORxmmotwrSphjCL6MhPnCVwArynjqM2njNlgEKYE4ifHCbSP4cJgdmV
         64GrG0gj5qczGns+J46TQKeS1/UM0sUON2G+RrKutWkkIP6EPfcSOGp3fMkNl+ankaHI
         bp0TTaMjJxFu5zUQM3j6zmjdVK9sLq19QxJoPDEEGXp3nT4xWGXYjfAO1D9u9HHZjTeI
         3NjbJ4utFFIiSNpj1UylDJCCgdbyMNT+LMIpcXq7tUD+zzIub/EmSXQ8G57ypA5T8uI7
         DITw==
X-Gm-Message-State: AOAM530W+DoqP8V5DRDXCmb9vvjkoQ1PdF+EObMY9RVlTgL22SQjt5tt
        VTX9MNa/SLRQPKMPd8rI5Ion7ibBOU1oZA==
X-Google-Smtp-Source: ABdhPJxX/gpWiTLgx2keM5fdO+2qjSL8WSkhnhq0DL93k66PtdACNhLAmuEiJ8JwBUKgQgBoRaEqxw==
X-Received: by 2002:a2e:a28b:: with SMTP id k11mr10349lja.405.1597960879038;
        Thu, 20 Aug 2020 15:01:19 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id h2sm684612ljl.16.2020.08.20.15.01.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 15:01:17 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id d2so1732287lfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:01:17 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr4286lfp.10.1597960876766;
 Thu, 20 Aug 2020 15:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200811183950.10603-1-peterx@redhat.com> <CAHk-=whQM=m5td5tfbuxh1f_Gxjsa74XV962BYkjrbeDMAhBpA@mail.gmail.com>
 <CAHk-=wit7LDr0tA2eVn7yHHEH76oK=Lfm3tTs8_JxO8XEED4_g@mail.gmail.com>
 <CAHk-=wifRg0pDhufQFasWa7G3sMHbG0nahnm5yRwvTKpKU9g4A@mail.gmail.com>
 <20200811214255.GE6353@xz-x1> <CAHk-=wiVN-+P1vOCSMyfGwYQD3hF7A18OJyXgpiMwGDfMaU+8w@mail.gmail.com>
 <20200820215449.GB358043@xz-x1>
In-Reply-To: <20200820215449.GB358043@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Aug 2020 15:01:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGzOjsfmX1Dc=yz6o_+62w4wcTVXX_hia9sHLfsCoxjg@mail.gmail.com>
Message-ID: <CAHk-=wjGzOjsfmX1Dc=yz6o_+62w4wcTVXX_hia9sHLfsCoxjg@mail.gmail.com>
Subject: Re: [PATCH v3] mm/gup: Allow real explicit breaking of COW
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Content-Type: multipart/mixed; boundary="0000000000006d020005ad5642eb"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006d020005ad5642eb
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 20, 2020 at 2:54 PM Peter Xu <peterx@redhat.com> wrote:
>
> I kind of prefer the new suggestion to remove code rather than adding new
> codes.  I definitely don't know enough on the side effect of it, especially
> performance-wise on either ksm or swap, but... IIUC the worst case is we'll get
> some perf report later on, and it seems also not hard to revert the patch later
> if we want.

Well, would you be willing to try this patch out?

After you apply that patch, you should be able to remove the
should_force_cow_break() games entirely, because a write to the page
should always break cow towards the writer if there are any GUP users
around (put another way: away from the GUP).

However, to make the test meaningful, it really should do some swap testing too.

            Linus

--0000000000006d020005ad5642eb
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Trial-do_wp_page-simplification.patch"
Content-Disposition: attachment; 
	filename="0001-Trial-do_wp_page-simplification.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ke3cjhmd0>
X-Attachment-Id: f_ke3cjhmd0

RnJvbSBmNDEwODI4NDRlYTgyYWQxMjc4ZTE2N2ZlNmU5NzNmYTRlZmM5NzRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFR1ZSwgMTEgQXVnIDIwMjAgMTQ6MjM6MDQgLTA3MDAKU3ViamVjdDog
W1BBVENIXSBUcmlhbCBkb193cF9wYWdlKCkgc2ltcGxpZmljYXRpb24KCkhvdyBhYm91dCB3ZSBq
dXN0IG1ha2Ugc3VyZSB3ZSdyZSB0aGUgb25seSBwb3NzaWJsZSB2YWxpZCB1c2VyIGZvIHRoZQpw
YWdlIGJlZm9yZSB3ZSBib3RoZXIgdG8gcmV1c2UgaXQ/CgpTaW1wbGlmeSwgc2ltcGxpZnksIHNp
bXBsaWZ5LgoKQW5kIGdldCByaWQgb2YgdGhlIG5hc3R5IHNlcmlhbGl6YXRpb24gb24gdGhlIHBh
Z2UgbG9jayBhdCB0aGUgc2FtZSB0aW1lLgoKU2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFsZHMg
PHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPgotLS0KIG1tL21lbW9yeS5jIHwgNTggKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9tbS9tZW1vcnkuYyBiL21tL21lbW9yeS5jCmluZGV4IDYwMmY0MjgzMTIyZi4uYTQzMDA0ZGQy
ZmY2IDEwMDY0NAotLS0gYS9tbS9tZW1vcnkuYworKysgYi9tbS9tZW1vcnkuYwpAQCAtMjkyNyw1
MCArMjkyNywyNCBAQCBzdGF0aWMgdm1fZmF1bHRfdCBkb193cF9wYWdlKHN0cnVjdCB2bV9mYXVs
dCAqdm1mKQogCSAqIG5vdCBkaXJ0eSBhY2NvdW50YWJsZS4KIAkgKi8KIAlpZiAoUGFnZUFub24o
dm1mLT5wYWdlKSkgewotCQlpbnQgdG90YWxfbWFwX3N3YXBjb3VudDsKLQkJaWYgKFBhZ2VLc20o
dm1mLT5wYWdlKSAmJiAoUGFnZVN3YXBDYWNoZSh2bWYtPnBhZ2UpIHx8Ci0JCQkJCSAgIHBhZ2Vf
Y291bnQodm1mLT5wYWdlKSAhPSAxKSkKKwkJc3RydWN0IHBhZ2UgKnBhZ2UgPSB2bWYtPnBhZ2U7
CisKKwkJaWYgKHBhZ2VfY291bnQocGFnZSkgIT0gMSkKKwkJCWdvdG8gY29weTsKKwkJaWYgKCF0
cnlsb2NrX3BhZ2UocGFnZSkpCisJCQlnb3RvIGNvcHk7CisJCWlmIChwYWdlX21hcGNvdW50KHBh
Z2UpICE9IDEgJiYgcGFnZV9jb3VudChwYWdlKSAhPSAxKSB7CisJCQl1bmxvY2tfcGFnZShwYWdl
KTsKIAkJCWdvdG8gY29weTsKLQkJaWYgKCF0cnlsb2NrX3BhZ2Uodm1mLT5wYWdlKSkgewotCQkJ
Z2V0X3BhZ2Uodm1mLT5wYWdlKTsKLQkJCXB0ZV91bm1hcF91bmxvY2sodm1mLT5wdGUsIHZtZi0+
cHRsKTsKLQkJCWxvY2tfcGFnZSh2bWYtPnBhZ2UpOwotCQkJdm1mLT5wdGUgPSBwdGVfb2Zmc2V0
X21hcF9sb2NrKHZtYS0+dm1fbW0sIHZtZi0+cG1kLAotCQkJCQl2bWYtPmFkZHJlc3MsICZ2bWYt
PnB0bCk7Ci0JCQlpZiAoIXB0ZV9zYW1lKCp2bWYtPnB0ZSwgdm1mLT5vcmlnX3B0ZSkpIHsKLQkJ
CQl1cGRhdGVfbW11X3RsYih2bWEsIHZtZi0+YWRkcmVzcywgdm1mLT5wdGUpOwotCQkJCXVubG9j
a19wYWdlKHZtZi0+cGFnZSk7Ci0JCQkJcHRlX3VubWFwX3VubG9jayh2bWYtPnB0ZSwgdm1mLT5w
dGwpOwotCQkJCXB1dF9wYWdlKHZtZi0+cGFnZSk7Ci0JCQkJcmV0dXJuIDA7Ci0JCQl9Ci0JCQlw
dXRfcGFnZSh2bWYtPnBhZ2UpOwotCQl9Ci0JCWlmIChQYWdlS3NtKHZtZi0+cGFnZSkpIHsKLQkJ
CWJvb2wgcmV1c2VkID0gcmV1c2Vfa3NtX3BhZ2Uodm1mLT5wYWdlLCB2bWYtPnZtYSwKLQkJCQkJ
CSAgICAgdm1mLT5hZGRyZXNzKTsKLQkJCXVubG9ja19wYWdlKHZtZi0+cGFnZSk7Ci0JCQlpZiAo
IXJldXNlZCkKLQkJCQlnb3RvIGNvcHk7Ci0JCQl3cF9wYWdlX3JldXNlKHZtZik7Ci0JCQlyZXR1
cm4gVk1fRkFVTFRfV1JJVEU7Ci0JCX0KLQkJaWYgKHJldXNlX3N3YXBfcGFnZSh2bWYtPnBhZ2Us
ICZ0b3RhbF9tYXBfc3dhcGNvdW50KSkgewotCQkJaWYgKHRvdGFsX21hcF9zd2FwY291bnQgPT0g
MSkgewotCQkJCS8qCi0JCQkJICogVGhlIHBhZ2UgaXMgYWxsIG91cnMuIE1vdmUgaXQgdG8KLQkJ
CQkgKiBvdXIgYW5vbl92bWEgc28gdGhlIHJtYXAgY29kZSB3aWxsCi0JCQkJICogbm90IHNlYXJj
aCBvdXIgcGFyZW50IG9yIHNpYmxpbmdzLgotCQkJCSAqIFByb3RlY3RlZCBhZ2FpbnN0IHRoZSBy
bWFwIGNvZGUgYnkKLQkJCQkgKiB0aGUgcGFnZSBsb2NrLgotCQkJCSAqLwotCQkJCXBhZ2VfbW92
ZV9hbm9uX3JtYXAodm1mLT5wYWdlLCB2bWEpOwotCQkJfQotCQkJdW5sb2NrX3BhZ2Uodm1mLT5w
YWdlKTsKLQkJCXdwX3BhZ2VfcmV1c2Uodm1mKTsKLQkJCXJldHVybiBWTV9GQVVMVF9XUklURTsK
IAkJfQotCQl1bmxvY2tfcGFnZSh2bWYtPnBhZ2UpOworCQkvKgorCQkgKiBPaywgd2UndmUgZ290
IHRoZSBvbmx5IG1hcCByZWZlcmVuY2UsIGFuZCB0aGUgb25seQorCQkgKiBwYWdlIGNvdW50IHJl
ZmVyZW5jZSwgYW5kIHRoZSBwYWdlIGlzIGxvY2tlZCwKKwkJICogaXQncyBkYXJrIG91dCwgYW5k
IHdlJ3JlIHdlYXJpbmcgc3VuZ2xhc3Nlcy4gSGl0IGl0LgorCQkgKi8KKwkJd3BfcGFnZV9yZXVz
ZSh2bWYpOworCQl1bmxvY2tfcGFnZShwYWdlKTsKKwkJcmV0dXJuIFZNX0ZBVUxUX1dSSVRFOwog
CX0gZWxzZSBpZiAodW5saWtlbHkoKHZtYS0+dm1fZmxhZ3MgJiAoVk1fV1JJVEV8Vk1fU0hBUkVE
KSkgPT0KIAkJCQkJKFZNX1dSSVRFfFZNX1NIQVJFRCkpKSB7CiAJCXJldHVybiB3cF9wYWdlX3No
YXJlZCh2bWYpOwotLSAKMi4yOC4wLjIxOC5nYzEyZWYzZDM0OQoK
--0000000000006d020005ad5642eb--
