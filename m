Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ED8C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4833D2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598036801;
	bh=16I6RxPQayxG7h5WAKDCY2/JkUn2cQmczgjVECDriTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WwX9zQGCisivMHkLifK75JuVL92tVwsDxT+RKC1EpAxHQkcCKWbvxK3Iv2dPDdl+7
	 nIzb/QBHpnApRe3pQldf4qd6aCA2ON4VssD9igSw12h63WFMyBizCpRO4HapVKAB9Z
	 gWvBXshUGeAO2urA48EfbuRVzyJqjej/Hpykjt+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHUTGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgHUTGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:06:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF601C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:06:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v4so3031890ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BOJuBuA6j0mFVFe9omHwthNItrlB+aR2g9oJIkoH7Dw=;
        b=A9egEkbxH0ULsq+fJ7cUjoSHjAkT7H1JQYSOTJZA8FNKMPu4jSi9Z7eCeMd8eEVPks
         k3EUsfYC98uVuQ/wry8qCdHpOBrEBsybWIJN3UTP+p/8UZEot+OU0QKxkC1s18RR5ztG
         40hZbySFG3rdlJFqG/VIg8Z1zGxQuBdK2OP6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOJuBuA6j0mFVFe9omHwthNItrlB+aR2g9oJIkoH7Dw=;
        b=L8yOAZnb4oC93iqsFl73JBoLmFuRcmSA9Z307N7vDyTKje+ZdLuHR9C3+8WTnZY1wu
         AXwqrQ83BA8TWn72QLr892c7w5fTsKCJ153qZxxh55eQiFE8XnKUQw7jay85R+d1nn40
         yMgQCNl7j03vEGhRPk/RmKTwGFygPtYGVgbqcLO21J6psdkE+A+DZwuwlQcLfSJKskM1
         4Lv2prjuTFSo9ccjgaeQvp9dkC65zNVizPs6IQ3YDeSBV/Z2MCyQlYOBhNaCEWlkwIpG
         IcTRSY9mX2I6UA338GWUzPZVer4fKPh/96OvhXgINKu/mTXrOYBrlnRxW5lsb9Vjd1Xk
         VU2g==
X-Gm-Message-State: AOAM531dvRMuncSqn/p08fSeIyYG1Xy/amkKWUTglWwUKPMA4Csx10X4
        Ty0daJh0CQGSQSg4QEJPgwIxoGON6JumLg==
X-Google-Smtp-Source: ABdhPJw8jNdlDthZK9EKn8PKsAIttpseMTGlRo7SDsKYhEOklRiw4JOCHhx4N0CY1Sg3f6UexKkfhw==
X-Received: by 2002:a2e:82c5:: with SMTP id n5mr2017287ljh.195.1598036795802;
        Fri, 21 Aug 2020 12:06:35 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id k12sm550546lfe.68.2020.08.21.12.06.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 12:06:33 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id t23so3014202ljc.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:06:33 -0700 (PDT)
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr2025171lju.102.1598036793299;
 Fri, 21 Aug 2020 12:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wit7LDr0tA2eVn7yHHEH76oK=Lfm3tTs8_JxO8XEED4_g@mail.gmail.com>
 <CAHk-=wifRg0pDhufQFasWa7G3sMHbG0nahnm5yRwvTKpKU9g4A@mail.gmail.com>
 <20200811214255.GE6353@xz-x1> <CAHk-=wiVN-+P1vOCSMyfGwYQD3hF7A18OJyXgpiMwGDfMaU+8w@mail.gmail.com>
 <20200820215449.GB358043@xz-x1> <CAHk-=wjGzOjsfmX1Dc=yz6o_+62w4wcTVXX_hia9sHLfsCoxjg@mail.gmail.com>
 <20200821101333.GA3432@quack2.suse.cz> <CAHk-=whXfL5DtinS42dgtNu6i+xchK_VP+XLprQbu_og2J5Dkw@mail.gmail.com>
 <20200821154756.GC3432@quack2.suse.cz> <CAHk-=wj-pfzKf3JDe9fr4o_nKYXJXfuYAMFCajwhy0YYYri4Fw@mail.gmail.com>
 <20200821180848.GA11376@xz-x1> <CAHk-=wj3fY2dch7Ah-MLbJcfU3buoXgJnwc1zWFSjVujSd39GA@mail.gmail.com>
 <CAHk-=wj5Oyg0LeAxSw_vizerm=sLd=sHfcVecZMKPZn6kNbbXA@mail.gmail.com>
In-Reply-To: <CAHk-=wj5Oyg0LeAxSw_vizerm=sLd=sHfcVecZMKPZn6kNbbXA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Aug 2020 12:06:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjn90-=s6MBerxTuP=-FVEZtR-LpoH9eenEQ3A-QfKTZw@mail.gmail.com>
Message-ID: <CAHk-=wjn90-=s6MBerxTuP=-FVEZtR-LpoH9eenEQ3A-QfKTZw@mail.gmail.com>
Subject: Re: [PATCH v3] mm/gup: Allow real explicit breaking of COW
To:     Peter Xu <peterx@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>
Content-Type: multipart/mixed; boundary="00000000000067511605ad67efd0"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000067511605ad67efd0
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 21, 2020 at 12:05 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Well, the fix is simple, although I don't love the magic PageKsm
> semantics that hide it from the page count.
>
> But since (a) a Ksm page is presumably normally shared (ie things like
> all zeroes) and (b) copying should always be safe, just do that.

I meant to attach the patch that did that, but didn't. Here is the
obvious modified version.

             Linus

--00000000000067511605ad67efd0
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Trial-do_wp_page-simplification.patch"
Content-Disposition: attachment; 
	filename="0001-Trial-do_wp_page-simplification.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ke4lu2ew0>
X-Attachment-Id: f_ke4lu2ew0

RnJvbSBjZDc4YmI3MmM3NDQ3YjA1YWUzMDM0MWVlZDJkMDdhMDQ2ZDMyZTVmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFR1ZSwgMTEgQXVnIDIwMjAgMTQ6MjM6MDQgLTA3MDAKU3ViamVjdDog
W1BBVENIXSBUcmlhbCBkb193cF9wYWdlKCkgc2ltcGxpZmljYXRpb24KCkhvdyBhYm91dCB3ZSBq
dXN0IG1ha2Ugc3VyZSB3ZSdyZSB0aGUgb25seSBwb3NzaWJsZSB2YWxpZCB1c2VyIGZvIHRoZQpw
YWdlIGJlZm9yZSB3ZSBib3RoZXIgdG8gcmV1c2UgaXQ/CgpTaW1wbGlmeSwgc2ltcGxpZnksIHNp
bXBsaWZ5LgoKQW5kIGdldCByaWQgb2YgdGhlIG5hc3R5IHNlcmlhbGl6YXRpb24gb24gdGhlIHBh
Z2UgbG9jayBhdCB0aGUgc2FtZSB0aW1lLgoKU2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFsZHMg
PHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPgotLS0KIG1tL21lbW9yeS5jIHwgNTkgKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9tbS9tZW1vcnkuYyBiL21tL21lbW9yeS5jCmluZGV4IDYwMmY0MjgzMTIyZi4uY2I5MDA2MTg5
ZDIyIDEwMDY0NAotLS0gYS9tbS9tZW1vcnkuYworKysgYi9tbS9tZW1vcnkuYwpAQCAtMjkyNyw1
MCArMjkyNywyNSBAQCBzdGF0aWMgdm1fZmF1bHRfdCBkb193cF9wYWdlKHN0cnVjdCB2bV9mYXVs
dCAqdm1mKQogCSAqIG5vdCBkaXJ0eSBhY2NvdW50YWJsZS4KIAkgKi8KIAlpZiAoUGFnZUFub24o
dm1mLT5wYWdlKSkgewotCQlpbnQgdG90YWxfbWFwX3N3YXBjb3VudDsKLQkJaWYgKFBhZ2VLc20o
dm1mLT5wYWdlKSAmJiAoUGFnZVN3YXBDYWNoZSh2bWYtPnBhZ2UpIHx8Ci0JCQkJCSAgIHBhZ2Vf
Y291bnQodm1mLT5wYWdlKSAhPSAxKSkKKwkJc3RydWN0IHBhZ2UgKnBhZ2UgPSB2bWYtPnBhZ2U7
CisKKwkJLyogUGFnZUtzbSgpIGRvZXNuJ3QgbmVjZXNzYXJpbHkgcmFpc2UgdGhlIHBhZ2UgcmVm
Y291bnQgKi8KKwkJaWYgKFBhZ2VLc20ocGFnZSkgfHwgcGFnZV9jb3VudChwYWdlKSAhPSAxKQor
CQkJZ290byBjb3B5OworCQlpZiAoIXRyeWxvY2tfcGFnZShwYWdlKSkKKwkJCWdvdG8gY29weTsK
KwkJaWYgKFBhZ2VLc20ocGFnZSkgfHwgcGFnZV9tYXBjb3VudChwYWdlKSAhPSAxIHx8IHBhZ2Vf
Y291bnQocGFnZSkgIT0gMSkgeworCQkJdW5sb2NrX3BhZ2UocGFnZSk7CiAJCQlnb3RvIGNvcHk7
Ci0JCWlmICghdHJ5bG9ja19wYWdlKHZtZi0+cGFnZSkpIHsKLQkJCWdldF9wYWdlKHZtZi0+cGFn
ZSk7Ci0JCQlwdGVfdW5tYXBfdW5sb2NrKHZtZi0+cHRlLCB2bWYtPnB0bCk7Ci0JCQlsb2NrX3Bh
Z2Uodm1mLT5wYWdlKTsKLQkJCXZtZi0+cHRlID0gcHRlX29mZnNldF9tYXBfbG9jayh2bWEtPnZt
X21tLCB2bWYtPnBtZCwKLQkJCQkJdm1mLT5hZGRyZXNzLCAmdm1mLT5wdGwpOwotCQkJaWYgKCFw
dGVfc2FtZSgqdm1mLT5wdGUsIHZtZi0+b3JpZ19wdGUpKSB7Ci0JCQkJdXBkYXRlX21tdV90bGIo
dm1hLCB2bWYtPmFkZHJlc3MsIHZtZi0+cHRlKTsKLQkJCQl1bmxvY2tfcGFnZSh2bWYtPnBhZ2Up
OwotCQkJCXB0ZV91bm1hcF91bmxvY2sodm1mLT5wdGUsIHZtZi0+cHRsKTsKLQkJCQlwdXRfcGFn
ZSh2bWYtPnBhZ2UpOwotCQkJCXJldHVybiAwOwotCQkJfQotCQkJcHV0X3BhZ2Uodm1mLT5wYWdl
KTsKLQkJfQotCQlpZiAoUGFnZUtzbSh2bWYtPnBhZ2UpKSB7Ci0JCQlib29sIHJldXNlZCA9IHJl
dXNlX2tzbV9wYWdlKHZtZi0+cGFnZSwgdm1mLT52bWEsCi0JCQkJCQkgICAgIHZtZi0+YWRkcmVz
cyk7Ci0JCQl1bmxvY2tfcGFnZSh2bWYtPnBhZ2UpOwotCQkJaWYgKCFyZXVzZWQpCi0JCQkJZ290
byBjb3B5OwotCQkJd3BfcGFnZV9yZXVzZSh2bWYpOwotCQkJcmV0dXJuIFZNX0ZBVUxUX1dSSVRF
OwotCQl9Ci0JCWlmIChyZXVzZV9zd2FwX3BhZ2Uodm1mLT5wYWdlLCAmdG90YWxfbWFwX3N3YXBj
b3VudCkpIHsKLQkJCWlmICh0b3RhbF9tYXBfc3dhcGNvdW50ID09IDEpIHsKLQkJCQkvKgotCQkJ
CSAqIFRoZSBwYWdlIGlzIGFsbCBvdXJzLiBNb3ZlIGl0IHRvCi0JCQkJICogb3VyIGFub25fdm1h
IHNvIHRoZSBybWFwIGNvZGUgd2lsbAotCQkJCSAqIG5vdCBzZWFyY2ggb3VyIHBhcmVudCBvciBz
aWJsaW5ncy4KLQkJCQkgKiBQcm90ZWN0ZWQgYWdhaW5zdCB0aGUgcm1hcCBjb2RlIGJ5Ci0JCQkJ
ICogdGhlIHBhZ2UgbG9jay4KLQkJCQkgKi8KLQkJCQlwYWdlX21vdmVfYW5vbl9ybWFwKHZtZi0+
cGFnZSwgdm1hKTsKLQkJCX0KLQkJCXVubG9ja19wYWdlKHZtZi0+cGFnZSk7Ci0JCQl3cF9wYWdl
X3JldXNlKHZtZik7Ci0JCQlyZXR1cm4gVk1fRkFVTFRfV1JJVEU7CiAJCX0KLQkJdW5sb2NrX3Bh
Z2Uodm1mLT5wYWdlKTsKKwkJLyoKKwkJICogT2ssIHdlJ3ZlIGdvdCB0aGUgb25seSBtYXAgcmVm
ZXJlbmNlLCBhbmQgdGhlIG9ubHkKKwkJICogcGFnZSBjb3VudCByZWZlcmVuY2UsIGFuZCB0aGUg
cGFnZSBpcyBsb2NrZWQsCisJCSAqIGl0J3MgZGFyayBvdXQsIGFuZCB3ZSdyZSB3ZWFyaW5nIHN1
bmdsYXNzZXMuIEhpdCBpdC4KKwkJICovCisJCXdwX3BhZ2VfcmV1c2Uodm1mKTsKKwkJdW5sb2Nr
X3BhZ2UocGFnZSk7CisJCXJldHVybiBWTV9GQVVMVF9XUklURTsKIAl9IGVsc2UgaWYgKHVubGlr
ZWx5KCh2bWEtPnZtX2ZsYWdzICYgKFZNX1dSSVRFfFZNX1NIQVJFRCkpID09CiAJCQkJCShWTV9X
UklURXxWTV9TSEFSRUQpKSkgewogCQlyZXR1cm4gd3BfcGFnZV9zaGFyZWQodm1mKTsKLS0gCjIu
MjguMC4yMTguZ2MxMmVmM2QzNDkKCg==
--00000000000067511605ad67efd0--
