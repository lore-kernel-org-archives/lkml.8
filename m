Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C6FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF72620786
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596733686;
	bh=7Ca2EcNrZ0boJZGykMHg7vEz6vxxX93xe8FjxQdMS+g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tFXqczAZBF2c4VjFvvdUE7RYsZ68cf3zryOKPo74vxcU4IIkB6Z3K3IAkSS1rghv9
	 SXPNWWt0ntlUW+n0GY8aN6AcJPmlm+jPOQuOv273vzT8w0yZFQtSnMpnJA2p0EFJLs
	 hhsDWbMXn3CS5GN6t7GNOa5vf/FquypCwNzfL3uM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgHFRIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgHFRH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:07:29 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEA7C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 10:07:28 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t6so39677231ljk.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 10:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G1kr/KdpK7K9+qK2pAcuXU9ZXE5iljjpY3Xz6lkPqcA=;
        b=DyVEOZIvpemWX45QvIyHU7p+FW8ROOAiHMLZP/MfDL5jMXwT4OnaTgFAvllLRSmGzN
         kiOcI3NxCw2hT+BunwlQyoaN+TpElz9ro8Z49hhUuVxhLaOxfXjjWrpD1iyalveQItlv
         zlFmGg1A/SvoPOeealIBy2lbKw7zB3B9QmAqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1kr/KdpK7K9+qK2pAcuXU9ZXE5iljjpY3Xz6lkPqcA=;
        b=dyMENIPRvp2xQ2+Mbwrm6O7CS0p4sNWs47m3/BxlDgJSF0djduLnRS/vNCpileAtaV
         bS57Z4qEYVAOqEFCBt4lQfa1rkqd7CRADCV+qj60ZNENJT+bEmlzM3925jAMjwT8eq9n
         +bXd+RugZj7rzDUA+OeMJM3i7Hr/rPF2MNaoKqC4f7JEIWi9CbmPMHn/13/6rWyDtxP5
         uLX0Uf0UuW8Ap2wieHJP9rT38E+7NMp4gHGUCa1tJvA4xXPSWew+BfI1/Z7T/ftfw1Uy
         aLKKVjnKxtsBJUjshPy3icpu5rXlNfUlOxismN6G2OV5JAKd6IKUw51OREOW2ZonNlnv
         dgiA==
X-Gm-Message-State: AOAM533crnyTDzRHUGuq0SD7symwr7ggIuSUDoxTFBSXRqfIOZ4fEgDX
        iNgdZBH1lYq5R60NYvI3XYOphlaadRQ=
X-Google-Smtp-Source: ABdhPJwbec6RTEEI6jLKqB/xN1HA5yLxliWF8PiKPncsaBoRw93qBI6vwByWwr5BOZO2UoYOQmN6Aw==
X-Received: by 2002:a2e:80cd:: with SMTP id r13mr4229321ljg.148.1596733646821;
        Thu, 06 Aug 2020 10:07:26 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id y19sm2962998lfe.77.2020.08.06.10.07.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 10:07:24 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id w14so22775213ljj.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 10:07:24 -0700 (PDT)
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr2102500ljp.312.1596733644177;
 Thu, 06 Aug 2020 10:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
 <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
 <alpine.LSU.2.11.2007231549540.1016@eggly.anvils> <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
 <20200724152424.GC17209@redhat.com> <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
 <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com>
 <20200725101445.GB3870@redhat.com> <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
 <alpine.LSU.2.11.2007251343370.3804@eggly.anvils> <alpine.LSU.2.11.2007252100230.5376@eggly.anvils>
 <alpine.LSU.2.11.2007261246530.6812@eggly.anvils> <alpine.LSU.2.11.2008052105040.8716@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2008052105040.8716@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Aug 2020 10:07:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=whf7wCUV2oTDUg0eeNafhhk_OhJBT2SbHZXwgtmAzNeTg@mail.gmail.com>
Message-ID: <CAHk-=whf7wCUV2oTDUg0eeNafhhk_OhJBT2SbHZXwgtmAzNeTg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Hugh Dickins <hughd@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: multipart/mixed; boundary="000000000000a9dffa05ac388522"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a9dffa05ac388522
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 5, 2020 at 10:21 PM Hugh Dickins <hughd@google.com> wrote:
>
> Something I was interested to realize in looking at this: trylock_page()
> on a contended lock is now much less likely to jump the queue and
> succeed than before, since your lock holder hands off the page lock to
> the next holder: much smaller window than waiting for the next to wake
> to take it. Nothing wrong with that, but effect might be seen somewhere.

Yeah, the window is smaller, but it's not gone.

It *might* be interesting to actually do the handover directly from
"unlock_page()", and avoid clearing (and then setting) the bit
entirely.

Something like the attached TOTALLY UNTESTED patch.

NOTE! Sometimes when I say something is untested, I think the patch is
fine because it's simple and straightforward, I just didn't test it.

This time it's both untested and very very subtle indeed. Did I get
the hand-over case SMP memory barriers right? Did I screw something
else up?

So this might be complete garbage. I really don't know. But it might
close the window for an unfair trylock (or lucky page_lock())
entirely.

Or maybe it just makes page locking break entirely. It's a very real risk.

The upside may not be worth it.

               Linus

--000000000000a9dffa05ac388522
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kdj1z0ge0>
X-Attachment-Id: f_kdj1z0ge0

IGluY2x1ZGUvbGludXgvd2FpdC5oIHwgIDIgKy0KIGtlcm5lbC9zY2hlZC93YWl0LmMgIHwgIDkg
KysrKysrKy0tCiBtbS9maWxlbWFwLmMgICAgICAgICB8IDUxICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCA0NiBpbnNl
cnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3dh
aXQuaCBiL2luY2x1ZGUvbGludXgvd2FpdC5oCmluZGV4IDg5OGM4OTBmYzE1My4uNWFiM2RmNTM1
ZjM5IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3dhaXQuaAorKysgYi9pbmNsdWRlL2xpbnV4
L3dhaXQuaApAQCAtMjAwLDcgKzIwMCw3IEBAIF9fcmVtb3ZlX3dhaXRfcXVldWUoc3RydWN0IHdh
aXRfcXVldWVfaGVhZCAqd3FfaGVhZCwgc3RydWN0IHdhaXRfcXVldWVfZW50cnkgKndxCiAKIHZv
aWQgX193YWtlX3VwKHN0cnVjdCB3YWl0X3F1ZXVlX2hlYWQgKndxX2hlYWQsIHVuc2lnbmVkIGlu
dCBtb2RlLCBpbnQgbnIsIHZvaWQgKmtleSk7CiB2b2lkIF9fd2FrZV91cF9sb2NrZWRfa2V5KHN0
cnVjdCB3YWl0X3F1ZXVlX2hlYWQgKndxX2hlYWQsIHVuc2lnbmVkIGludCBtb2RlLCB2b2lkICpr
ZXkpOwotdm9pZCBfX3dha2VfdXBfbG9ja2VkX2tleV9ib29rbWFyayhzdHJ1Y3Qgd2FpdF9xdWV1
ZV9oZWFkICp3cV9oZWFkLAoraW50IF9fd2FrZV91cF9sb2NrZWRfa2V5X2Jvb2ttYXJrKHN0cnVj
dCB3YWl0X3F1ZXVlX2hlYWQgKndxX2hlYWQsCiAJCXVuc2lnbmVkIGludCBtb2RlLCB2b2lkICpr
ZXksIHdhaXRfcXVldWVfZW50cnlfdCAqYm9va21hcmspOwogdm9pZCBfX3dha2VfdXBfc3luY19r
ZXkoc3RydWN0IHdhaXRfcXVldWVfaGVhZCAqd3FfaGVhZCwgdW5zaWduZWQgaW50IG1vZGUsIHZv
aWQgKmtleSk7CiB2b2lkIF9fd2FrZV91cF9sb2NrZWRfc3luY19rZXkoc3RydWN0IHdhaXRfcXVl
dWVfaGVhZCAqd3FfaGVhZCwgdW5zaWduZWQgaW50IG1vZGUsIHZvaWQgKmtleSk7CmRpZmYgLS1n
aXQgYS9rZXJuZWwvc2NoZWQvd2FpdC5jIGIva2VybmVsL3NjaGVkL3dhaXQuYwppbmRleCAwMWY1
ZDMwMjA1ODkuLjU3OGY0ZjRhNDAwZCAxMDA2NDQKLS0tIGEva2VybmVsL3NjaGVkL3dhaXQuYwor
KysgYi9rZXJuZWwvc2NoZWQvd2FpdC5jCkBAIC0xNTgsMTAgKzE1OCwxNSBAQCB2b2lkIF9fd2Fr
ZV91cF9sb2NrZWRfa2V5KHN0cnVjdCB3YWl0X3F1ZXVlX2hlYWQgKndxX2hlYWQsIHVuc2lnbmVk
IGludCBtb2RlLCB2bwogfQogRVhQT1JUX1NZTUJPTF9HUEwoX193YWtlX3VwX2xvY2tlZF9rZXkp
OwogCi12b2lkIF9fd2FrZV91cF9sb2NrZWRfa2V5X2Jvb2ttYXJrKHN0cnVjdCB3YWl0X3F1ZXVl
X2hlYWQgKndxX2hlYWQsCisvKgorICogVGhpcyByZXR1cm5zIHRydWUgaWYgaXQgd29rZSB1cCBh
biBleGNsdXNpdmUgd2FpdGVyIChpZQorICogJ25yX2V4Y2x1c2l2ZScgZHJvcHBlZCBmcm9tIDEg
dG8gMCkuIE1heSBiZSB1c2VmdWwgZm9yCisgKiBsb2NrIGhhbmRvZmYuCisgKi8KK2ludCBfX3dh
a2VfdXBfbG9ja2VkX2tleV9ib29rbWFyayhzdHJ1Y3Qgd2FpdF9xdWV1ZV9oZWFkICp3cV9oZWFk
LAogCQl1bnNpZ25lZCBpbnQgbW9kZSwgdm9pZCAqa2V5LCB3YWl0X3F1ZXVlX2VudHJ5X3QgKmJv
b2ttYXJrKQogewotCV9fd2FrZV91cF9jb21tb24od3FfaGVhZCwgbW9kZSwgMSwgMCwga2V5LCBi
b29rbWFyayk7CisJcmV0dXJuICFfX3dha2VfdXBfY29tbW9uKHdxX2hlYWQsIG1vZGUsIDEsIDAs
IGtleSwgYm9va21hcmspOwogfQogRVhQT1JUX1NZTUJPTF9HUEwoX193YWtlX3VwX2xvY2tlZF9r
ZXlfYm9va21hcmspOwogCmRpZmYgLS1naXQgYS9tbS9maWxlbWFwLmMgYi9tbS9maWxlbWFwLmMK
aW5kZXggOWYxMzFmMWNmZGUzLi4xZTI1MzZiOTgwMDAgMTAwNjQ0Ci0tLSBhL21tL2ZpbGVtYXAu
YworKysgYi9tbS9maWxlbWFwLmMKQEAgLTk5OCw4ICs5OTgsOSBAQCBzdGF0aWMgaW50IHdha2Vf
cGFnZV9mdW5jdGlvbih3YWl0X3F1ZXVlX2VudHJ5X3QgKndhaXQsIHVuc2lnbmVkIG1vZGUsIGlu
dCBzeW5jLAogCQlyZXR1cm4gMDsKIAogCS8qCi0JICogSWYgaXQncyBhbiBleGNsdXNpdmUgd2Fp
dCwgd2UgZ2V0IHRoZSBiaXQgZm9yIGl0LCBhbmQKLQkgKiBzdG9wIHdhbGtpbmcgaWYgd2UgY2Fu
J3QuCisJICogSWYgaXQncyBhbiBleGNsdXNpdmUgd2FpdCwgd2UganVzdCB0ZWxsIHRoZSB3YWtl
ciB0aGF0CisJICogd2UgaGF2ZSBkb25lIHRoZSBleGNsdXNpdmUgd2FpdC4gSXQgd2lsbCBrbm93
IG5ldmVyIHRvCisJICogYWN0dWFsbHkgZXZlbiBjbGVhciB0aGUgYml0LgogCSAqCiAJICogSWYg
aXQncyBhIG5vbi1leGNsdXNpdmUgd2FpdCwgdGhlbiB0aGUgZmFjdCB0aGF0IHRoaXMKIAkgKiB3
YWtlIGZ1bmN0aW9uIHdhcyBjYWxsZWQgbWVhbnMgdGhhdCB0aGUgYml0IGFscmVhZHkKQEAgLTEw
MDcsMTEgKzEwMDgsOCBAQCBzdGF0aWMgaW50IHdha2VfcGFnZV9mdW5jdGlvbih3YWl0X3F1ZXVl
X2VudHJ5X3QgKndhaXQsIHVuc2lnbmVkIG1vZGUsIGludCBzeW5jLAogCSAqIHJlLXRvb2sgaXQu
CiAJICovCiAJcmV0ID0gMDsKLQlpZiAod2FpdC0+ZmxhZ3MgJiBXUV9GTEFHX0VYQ0xVU0lWRSkg
ewotCQlpZiAodGVzdF9hbmRfc2V0X2JpdChrZXktPmJpdF9uciwgJmtleS0+cGFnZS0+ZmxhZ3Mp
KQotCQkJcmV0dXJuIC0xOworCWlmICh3YWl0LT5mbGFncyAmIFdRX0ZMQUdfRVhDTFVTSVZFKQog
CQlyZXQgPSAxOwotCX0KIAl3YWl0LT5mbGFncyB8PSBXUV9GTEFHX1dPS0VOOwogCiAJd2FrZV91
cF9zdGF0ZSh3YWl0LT5wcml2YXRlLCBtb2RlKTsKQEAgLTEwMjksMTIgKzEwMjcsMTMgQEAgc3Rh
dGljIGludCB3YWtlX3BhZ2VfZnVuY3Rpb24od2FpdF9xdWV1ZV9lbnRyeV90ICp3YWl0LCB1bnNp
Z25lZCBtb2RlLCBpbnQgc3luYywKIAlyZXR1cm4gcmV0OwogfQogCi1zdGF0aWMgdm9pZCB3YWtl
X3VwX3BhZ2VfYml0KHN0cnVjdCBwYWdlICpwYWdlLCBpbnQgYml0X25yKQorc3RhdGljIGludCB3
YWtlX3VwX3BhZ2VfYml0KHN0cnVjdCBwYWdlICpwYWdlLCBpbnQgYml0X25yKQogewogCXdhaXRf
cXVldWVfaGVhZF90ICpxID0gcGFnZV93YWl0cXVldWUocGFnZSk7CiAJc3RydWN0IHdhaXRfcGFn
ZV9rZXkga2V5OwogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAJd2FpdF9xdWV1ZV9lbnRyeV90IGJv
b2ttYXJrOworCWludCBleGNsdXNpdmU7CiAKIAlrZXkucGFnZSA9IHBhZ2U7CiAJa2V5LmJpdF9u
ciA9IGJpdF9ucjsKQEAgLTEwNDYsNyArMTA0NSw3IEBAIHN0YXRpYyB2b2lkIHdha2VfdXBfcGFn
ZV9iaXQoc3RydWN0IHBhZ2UgKnBhZ2UsIGludCBiaXRfbnIpCiAJSU5JVF9MSVNUX0hFQUQoJmJv
b2ttYXJrLmVudHJ5KTsKIAogCXNwaW5fbG9ja19pcnFzYXZlKCZxLT5sb2NrLCBmbGFncyk7Ci0J
X193YWtlX3VwX2xvY2tlZF9rZXlfYm9va21hcmsocSwgVEFTS19OT1JNQUwsICZrZXksICZib29r
bWFyayk7CisJZXhjbHVzaXZlID0gX193YWtlX3VwX2xvY2tlZF9rZXlfYm9va21hcmsocSwgVEFT
S19OT1JNQUwsICZrZXksICZib29rbWFyayk7CiAKIAl3aGlsZSAoYm9va21hcmsuZmxhZ3MgJiBX
UV9GTEFHX0JPT0tNQVJLKSB7CiAJCS8qCkBAIC0xMDU4LDcgKzEwNTcsNyBAQCBzdGF0aWMgdm9p
ZCB3YWtlX3VwX3BhZ2VfYml0KHN0cnVjdCBwYWdlICpwYWdlLCBpbnQgYml0X25yKQogCQlzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZxLT5sb2NrLCBmbGFncyk7CiAJCWNwdV9yZWxheCgpOwogCQlz
cGluX2xvY2tfaXJxc2F2ZSgmcS0+bG9jaywgZmxhZ3MpOwotCQlfX3dha2VfdXBfbG9ja2VkX2tl
eV9ib29rbWFyayhxLCBUQVNLX05PUk1BTCwgJmtleSwgJmJvb2ttYXJrKTsKKwkJZXhjbHVzaXZl
IHw9IF9fd2FrZV91cF9sb2NrZWRfa2V5X2Jvb2ttYXJrKHEsIFRBU0tfTk9STUFMLCAma2V5LCAm
Ym9va21hcmspOwogCX0KIAogCS8qCkBAIC0xMDgxLDYgKzEwODAsNyBAQCBzdGF0aWMgdm9pZCB3
YWtlX3VwX3BhZ2VfYml0KHN0cnVjdCBwYWdlICpwYWdlLCBpbnQgYml0X25yKQogCQkgKi8KIAl9
CiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcS0+bG9jaywgZmxhZ3MpOworCXJldHVybiBleGNs
dXNpdmU7CiB9CiAKIHN0YXRpYyB2b2lkIHdha2VfdXBfcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSwg
aW50IGJpdCkKQEAgLTEzMzksMTEgKzEzMzksMzYgQEAgc3RhdGljIGlubGluZSBib29sIGNsZWFy
X2JpdF91bmxvY2tfaXNfbmVnYXRpdmVfYnl0ZShsb25nIG5yLCB2b2xhdGlsZSB2b2lkICptZW0K
ICAqLwogdm9pZCB1bmxvY2tfcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSkKIHsKLQlCVUlMRF9CVUdf
T04oUEdfd2FpdGVycyAhPSA3KTsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOworCiAJcGFnZSA9IGNv
bXBvdW5kX2hlYWQocGFnZSk7Ci0JVk1fQlVHX09OX1BBR0UoIVBhZ2VMb2NrZWQocGFnZSksIHBh
Z2UpOwotCWlmIChjbGVhcl9iaXRfdW5sb2NrX2lzX25lZ2F0aXZlX2J5dGUoUEdfbG9ja2VkLCAm
cGFnZS0+ZmxhZ3MpKQotCQl3YWtlX3VwX3BhZ2VfYml0KHBhZ2UsIFBHX2xvY2tlZCk7CisKKwlm
bGFncyA9IFJFQURfT05DRShwYWdlLT5mbGFncyk7CisJVk1fQlVHX09OX1BBR0UoIShmbGFncyAm
ICgxIDw8IFBHX2xvY2tlZCkpLCBwYWdlKTsKKworCWZvciAoOzspIHsKKwkJdW5zaWduZWQgbG9u
ZyBuZXc7CisKKwkJLyoKKwkJICogSWYgd2FrZV91cF9wYWdlX2JpdCgpIHdha2VzIGFuIGV4Y2x1
c2l2ZQorCQkgKiB3YWl0ZXIsIGl0IHdpbGwgaGF2ZSBoYW5kZWQgdGhlIGxvY2sgb3ZlcgorCQkg
KiBkaXJlY3RseS4KKwkJICovCisJCWlmIChmbGFncyAmICgxIDw8IFBHX3dhaXRlcnMpKSB7CisJ
CQkvKgorCQkJICogTG9jayBoYW5kLW92ZXIgc2VyaWFsaXphdGlvbi4gVGhlIGF0b21pYyBpcyB0
aGUKKwkJCSAqIHNwaW5sb2NrIHdha2VfdXBfcGFnZV9iaXQoKSB3aWxsIGRvLgorCQkJICovCisJ
CQlzbXBfbWJfX2JlZm9yZV9hdG9taWMoKTsKKwkJCWlmICh3YWtlX3VwX3BhZ2VfYml0KHBhZ2Us
IFBHX2xvY2tlZCkpCisJCQkJcmV0dXJuOworCQl9CisJCW5ldyA9IGNtcHhjaGdfcmVsZWFzZSgm
cGFnZS0+ZmxhZ3MsIGZsYWdzLCBmbGFncyAmIH4oMSA8PCBQR19sb2NrZWQpKTsKKwkJaWYgKGxp
a2VseShuZXcgPT0gZmxhZ3MpKQorCQkJcmV0dXJuOworCisJCWZsYWdzID0gbmV3OworCX0KIH0K
IEVYUE9SVF9TWU1CT0wodW5sb2NrX3BhZ2UpOwogCg==
--000000000000a9dffa05ac388522--
