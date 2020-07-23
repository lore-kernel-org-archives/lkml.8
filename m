Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC0FC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF4420714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595525570;
	bh=uA89iAP5Y9Blim1HKIJXo24BEw/VSCPj/wHdwW2m6nY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oLIjONYPrWbs8BoyrJBbucPCg1malH70GIfF+x1xrnNe3yWN5G12fjpwCvB8S0jgl
	 U0ENlkoxNf2jpOb50zfVeLPd2V730ixHF+/C2sBhzBxVCNTFolBnoBW2NYkfCQNwg1
	 A+PPVQTraEscJs7Mcs+mjqvJsP0TY5Fw0y2kStY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgGWRct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGWRcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:32:48 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4634EC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 10:32:48 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u12so3726272lff.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 10:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5zYkE2fMUPzpDtnOFHRFwbdoB4F8fyP/RyQx4kUy0rU=;
        b=Bp+4h9iMj4m/fVv488OdlZ0/KQu4TNZM6LfRO4nxTEcsOrXCt+AKX+lc0iFLbCyADc
         ie8cAnnFvURkAJ0QFkdq2L1rj21VQV4tO5Qp8sDxzWMr2pfVJptsFBXJcQYNZGz5wtJz
         XHNTbUy22gwkEX8rouEuDmiDCGfKkvNaEg26g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zYkE2fMUPzpDtnOFHRFwbdoB4F8fyP/RyQx4kUy0rU=;
        b=HRPQ6FiD+Gk6nTGd3DMhkS63/Q5H4bRv7GvfXHblPC98pMdtwdXloGJyHC4Txc45Tq
         ZsMzaEJlmUV2ylnfFubt+G2bYOXr3tmIlu0/cJ4aJFLroow2i8lbl2wUZccJaxfrrQWx
         TZF1M4mIot5YDtTWtZzLWu2yfZ+wbdmhI/8yX9vuSl7zrDxFyjEV/hv8X3tr58WudjPd
         1/VwffraIWvcsYFX20Xn8CchF4kYYCCgrU562F3vGdzE5xW2uTwPdrhkt5pd4sVDkSMf
         2WA3n4Pa0uMyu479H4g5baSe4cLyfcFWwUV5rWHNTxmkaYFdkGps/GgsuEYc6/Nfb5V+
         daDg==
X-Gm-Message-State: AOAM533YLuVmEpThlAGPgCBAFHURp2IkvAAUTNtdhP2MIJGQ2oMwByvI
        Ad+BTkYZ5qjiRmYUZtYI0JlGrvL9nJw=
X-Google-Smtp-Source: ABdhPJwoziHRw6+gXfWtykplC498femXmrlh1wdaV+M1AeB4o9RhkNR6GVkhEb5OuJww5vh+Wlu+gQ==
X-Received: by 2002:a05:6512:2082:: with SMTP id t2mr2872611lfr.142.1595525566372;
        Thu, 23 Jul 2020 10:32:46 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id d26sm3225612lfq.73.2020.07.23.10.32.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 10:32:45 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id h22so7214991lji.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 10:32:45 -0700 (PDT)
X-Received: by 2002:a05:651c:1b6:: with SMTP id c22mr2177312ljn.421.1595525564657;
 Thu, 23 Jul 2020 10:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200721063258.17140-1-mhocko@kernel.org> <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
 <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
 <alpine.LSU.2.11.2007221359450.1017@eggly.anvils> <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com> <20200723124749.GA7428@redhat.com>
In-Reply-To: <20200723124749.GA7428@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jul 2020 10:32:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
Message-ID: <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: multipart/mixed; boundary="000000000000832cd805ab1f3e64"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000832cd805ab1f3e64
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 23, 2020 at 5:47 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> I still can't convince myself thatI fully understand this patch but I see
> nothing really wrong after a quick glance...

I guess my comments should be extended further then.

Is there anything in particular you think is unclear?

> > +     wake_up_state(target, mode);
>
> We can no longer use 'target'. If it was already woken up it can notice
> list_empty_careful(), return without taking q->lock, and exit.

Good point.

And yes, I think using WQ_FLAG_WOKEN is the right thing to do, and I
wouldn't call it "abuse". It's exactly what it's for.

And that also allows us to just use finish_wait(), since we no longer
care as deeply about the waitlist state, we can just test that
WQ_FLAG_WOKEN at the end instead.

So that actually makes the patch much more straightforward too. I
really disliked my open-coding there. Your suggestion fixes
everything.

> do we need SetPageWaiters() if trylock() succeeds ?

We need to set it before the final page flag test, because otherwise
we might miss somebody just about to wake us up (ie we see the bit
set, but it's getting cleared on another CPU, and if PageWaiters isn't
set then that other CPU won't do the wakeup).

So here's a v2, now as a "real" commit with a commit message and everything.

Is there anything in particular you would like clarified, or something
else you find in this?

Hugh - this should make your "patch 2" redundant. Is there any way to
test that in your environment that triggered it?

This v2 isn't tested, but the core of it is the same, just with nice
cleanups from Oleg's suggestion, and an added comment about that
SetPageWaiters() thing.

            Linus

--000000000000832cd805ab1f3e64
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-mm-rewrite-wait_on_page_bit_common-logic.patch"
Content-Disposition: attachment; 
	filename="0001-mm-rewrite-wait_on_page_bit_common-logic.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kcz2p3g30>
X-Attachment-Id: f_kcz2p3g30

RnJvbSA3MWM0OGYyZTUwZmNkNTZiNmU5NDFiNDZjMGVhN2RkZGQzMGFkMTQ2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFRodSwgMjMgSnVsIDIwMjAgMTA6MTY6NDkgLTA3MDAKU3ViamVjdDog
W1BBVENIXSBtbTogcmV3cml0ZSB3YWl0X29uX3BhZ2VfYml0X2NvbW1vbigpIGxvZ2ljCgpJdCB0
dXJucyBvdXQgdGhhdCB3YWl0X29uX3BhZ2VfYml0X2NvbW1vbigpIGhhZCBzZXZlcmFsIHByb2Js
ZW1zLApyYW5naW5nIGZyb20ganVzdCB1bmZhaXIgYmVoYXZpb2UgZHVlIHRvIHJlLXF1ZXVlaW5n
IGF0IHRoZSBlbmQgb2YgdGhlCndhaXQgcXVldWUgd2hlbiByZS10cnlpbmcsIGFuZCBhbiBvdXRy
aWdodCBidWcgdGhhdCBjb3VsZCByZXN1bHQgaW4KbWlzc2VkIHdha2V1cHMgKGJ1dCBwcm9iYWJs
eSBuZXZlciBoYXBwZW5lZCBpbiBwcmFjdGljZSkuCgpUaGlzIHJld3JpdGVzIHRoZSB3aG9sZSBs
b2dpYyB0byBhdm9pZCBib3RoIGlzc3VlcywgYnkgc2ltcGx5IG1vdmluZyB0aGUKbG9naWMgdG8g
Y2hlY2sgKGFuZCBwb3NzaWJseSB0YWtlKSB0aGUgYml0IGxvY2sgaW50byB0aGUgd2FrZXVwIHBh
dGgKaW5zdGVhZC4KClRoYXQgbWFrZXMgZXZlcnl0aGluZyBtdWNoIG1vcmUgc3RyYWlnaHRmb3J3
YXJkLCBhbmQgbWVhbnMgdGhhdCB3ZSBuZXZlcgpuZWVkIHRvIHJlLXF1ZXVlIHRoZSB3YWl0IGVu
dHJ5OiBpZiB3ZSBnZXQgd29rZW4gdXAsIHdlJ2xsIGJlIG5vdGlmaWVkCnRocm91Z2ggV1FfRkxB
R19XT0tFTiwgYW5kIHRoZSB3YWl0IHF1ZXVlIGVudHJ5IHdpbGwgaGF2ZSBiZWVuIHJlbW92ZWQs
CmFuZCBldmVyeXRoaW5nIHdpbGwgaGF2ZSBiZWVuIGRvbmUgZm9yIHVzLgoKTGluazogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9DQUhrLT13akpBMloza1VGYi01cz02K24wcWJUczhFTHFL
RnQ5QjNwSDg1YThmR0Q3M3dAbWFpbC5nbWFpbC5jb20vCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvYWxwaW5lLkxTVS4yLjExLjIwMDcyMjEzNTk0NTAuMTAxN0BlZ2dseS5hbnZp
bHMvClJlcG9ydGVkLWJ5OiBPbGVnIE5lc3Rlcm92IDxvbGVnQHJlZGhhdC5jb20+ClJlcG9ydGVk
LWJ5OiBIdWdoIERpY2tpbnMgPGh1Z2hkQGdvb2dsZS5jb20+CkNjOiBNaWNoYWwgSG9ja28gPG1o
b2Nrb0BzdXNlLmNvbT4KU2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxp
bnV4LWZvdW5kYXRpb24ub3JnPgotLS0KIG1tL2ZpbGVtYXAuYyB8IDExOSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3
MSBpbnNlcnRpb25zKCspLCA0OCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9tbS9maWxlbWFw
LmMgYi9tbS9maWxlbWFwLmMKaW5kZXggMzg1NzU5YzRjZTRiLi4zN2Y2NDJjMDcxMDYgMTAwNjQ0
Ci0tLSBhL21tL2ZpbGVtYXAuYworKysgYi9tbS9maWxlbWFwLmMKQEAgLTEwMDIsNiArMTAwMiw3
IEBAIHN0cnVjdCB3YWl0X3BhZ2VfcXVldWUgewogCiBzdGF0aWMgaW50IHdha2VfcGFnZV9mdW5j
dGlvbih3YWl0X3F1ZXVlX2VudHJ5X3QgKndhaXQsIHVuc2lnbmVkIG1vZGUsIGludCBzeW5jLCB2
b2lkICphcmcpCiB7CisJaW50IHJldDsKIAlzdHJ1Y3Qgd2FpdF9wYWdlX2tleSAqa2V5ID0gYXJn
OwogCXN0cnVjdCB3YWl0X3BhZ2VfcXVldWUgKndhaXRfcGFnZQogCQk9IGNvbnRhaW5lcl9vZih3
YWl0LCBzdHJ1Y3Qgd2FpdF9wYWdlX3F1ZXVlLCB3YWl0KTsKQEAgLTEwMTMsMTggKzEwMTQsNDAg
QEAgc3RhdGljIGludCB3YWtlX3BhZ2VfZnVuY3Rpb24od2FpdF9xdWV1ZV9lbnRyeV90ICp3YWl0
LCB1bnNpZ25lZCBtb2RlLCBpbnQgc3luYywKIAlpZiAod2FpdF9wYWdlLT5iaXRfbnIgIT0ga2V5
LT5iaXRfbnIpCiAJCXJldHVybiAwOwogCisJLyogU3RvcCB3YWxraW5nIGlmIGl0J3MgbG9ja2Vk
ICovCisJaWYgKHdhaXQtPmZsYWdzICYgV1FfRkxBR19FWENMVVNJVkUpIHsKKwkJaWYgKHRlc3Rf
YW5kX3NldF9iaXQoa2V5LT5iaXRfbnIsICZrZXktPnBhZ2UtPmZsYWdzKSkKKwkJCXJldHVybiAt
MTsKKwl9IGVsc2UgeworCQlpZiAodGVzdF9iaXQoa2V5LT5iaXRfbnIsICZrZXktPnBhZ2UtPmZs
YWdzKSkKKwkJCXJldHVybiAtMTsKKwl9CisKIAkvKgotCSAqIFN0b3Agd2Fsa2luZyBpZiBpdCdz
IGxvY2tlZC4KLQkgKiBJcyB0aGlzIHNhZmUgaWYgcHV0X2FuZF93YWl0X29uX3BhZ2VfbG9ja2Vk
KCkgaXMgaW4gdXNlPwotCSAqIFllczogdGhlIHdha2VyIG11c3QgaG9sZCBhIHJlZmVyZW5jZSB0
byB0aGlzIHBhZ2UsIGFuZCBpZiBQR19sb2NrZWQKLQkgKiBoYXMgbm93IGFscmVhZHkgYmVlbiBz
ZXQgYnkgYW5vdGhlciB0YXNrLCB0aGF0IHRhc2sgbXVzdCBhbHNvIGhvbGQKLQkgKiBhIHJlZmVy
ZW5jZSB0byB0aGUgKnNhbWUgdXNhZ2UqIG9mIHRoaXMgcGFnZTsgc28gdGhlcmUgaXMgbm8gbmVl
ZAotCSAqIHRvIHdhbGsgb24gdG8gd2FrZSBldmVuIHRoZSBwdXRfYW5kX3dhaXRfb25fcGFnZV9s
b2NrZWQoKSBjYWxsZXJzLgorCSAqIExldCB0aGUgd2FpdGVyIGtub3cgd2UgaGF2ZSBkb25lIHRo
ZSBwYWdlIGZsYWcKKwkgKiBoYW5kbGluZyBmb3IgaXQgKGFuZCB0aGUgcmV0dXJuIHZhbHVlIGxl
dHMgdGhlCisJICogd2FrZXVwIGxvZ2ljIGNvdW50IGV4Y2x1c2l2ZSB3YWtldXAgZXZlbnRzKS4K
IAkgKi8KLQlpZiAodGVzdF9iaXQoa2V5LT5iaXRfbnIsICZrZXktPnBhZ2UtPmZsYWdzKSkKLQkJ
cmV0dXJuIC0xOworCXJldCA9ICh3YWl0LT5mbGFncyAmIFdRX0ZMQUdfRVhDTFVTSVZFKSAhPSAw
OworCXdhaXQtPmZsYWdzIHw9IFdRX0ZMQUdfV09LRU47CisJd2FrZV91cF9zdGF0ZSh3YWl0LT5w
cml2YXRlLCBtb2RlKTsKIAotCXJldHVybiBhdXRvcmVtb3ZlX3dha2VfZnVuY3Rpb24od2FpdCwg
bW9kZSwgc3luYywga2V5KTsKKwkvKgorCSAqIE9rLCB3ZSBoYXZlIHN1Y2Nlc3NmdWxseSBkb25l
IHdoYXQgd2UncmUgd2FpdGluZyBmb3IsCisJICogYW5kIHdlIGNhbiB1bmNvbmRpdGlvbmFsbHkg
cmVtb3ZlIHRoZSB3YWl0IGVudHJ5LgorCSAqCisJICogTm90ZSB0aGF0IHRoaXMgaGFzIHRvIGJl
IHRoZSBhYnNvbHV0ZSBsYXN0IHRoaW5nIHdlIGRvLAorCSAqIHNpbmNlIGFmdGVyIGxpc3RfZGVs
X2luaXQoJndhaXQtPmVudHJ5KSB0aGUgd2FpdCBlbnRyeQorCSAqIG1pZ2h0IGJlIGRlLWFsbG9j
YXRlZCBhbmQgdGhlIHByb2Nlc3MgbWlnaHQgZXZlbiBoYXZlCisJICogZXhpdGVkLgorCSAqCisJ
ICogV2UgX3JlYWxseV8gc2hvdWxkIGhhdmUgYSAibGlzdF9kZWxfaW5pdF9jYXJlZnVsKCkiIHRv
CisJICogcHJvcGVybHkgcGFpciB3aXRoIHRoZSB1bmxvY2tlZCAibGlzdF9lbXB0eV9jYXJlZnVs
KCkiCisJICogaW4gZmluaXNoX3dhaXQoKS4KKwkgKi8KKwlzbXBfbWIoKTsKKwlsaXN0X2RlbF9p
bml0KCZ3YWl0LT5lbnRyeSk7CisJcmV0dXJuIHJldDsKIH0KIAogc3RhdGljIHZvaWQgd2FrZV91
cF9wYWdlX2JpdChzdHJ1Y3QgcGFnZSAqcGFnZSwgaW50IGJpdF9ucikKQEAgLTExMDMsMTYgKzEx
MjYsMjIgQEAgZW51bSBiZWhhdmlvciB7CiAJCQkgKi8KIH07CiAKK3N0YXRpYyBpbmxpbmUgaW50
IHRyeWxvY2tfcGFnZV9iaXRfY29tbW9uKHN0cnVjdCBwYWdlICpwYWdlLCBpbnQgYml0X25yLAor
CWVudW0gYmVoYXZpb3IgYmVoYXZpb3IpCit7CisJcmV0dXJuIGJlaGF2aW9yID09IEVYQ0xVU0lW
RSA/CisJCSF0ZXN0X2FuZF9zZXRfYml0KGJpdF9uciwgJnBhZ2UtPmZsYWdzKSA6CisJCSF0ZXN0
X2JpdChiaXRfbnIsICZwYWdlLT5mbGFncyk7Cit9CisKIHN0YXRpYyBpbmxpbmUgaW50IHdhaXRf
b25fcGFnZV9iaXRfY29tbW9uKHdhaXRfcXVldWVfaGVhZF90ICpxLAogCXN0cnVjdCBwYWdlICpw
YWdlLCBpbnQgYml0X25yLCBpbnQgc3RhdGUsIGVudW0gYmVoYXZpb3IgYmVoYXZpb3IpCiB7CiAJ
c3RydWN0IHdhaXRfcGFnZV9xdWV1ZSB3YWl0X3BhZ2U7CiAJd2FpdF9xdWV1ZV9lbnRyeV90ICp3
YWl0ID0gJndhaXRfcGFnZS53YWl0OwotCWJvb2wgYml0X2lzX3NldDsKIAlib29sIHRocmFzaGlu
ZyA9IGZhbHNlOwogCWJvb2wgZGVsYXlhY2N0ID0gZmFsc2U7CiAJdW5zaWduZWQgbG9uZyBwZmxh
Z3M7Ci0JaW50IHJldCA9IDA7CiAKIAlpZiAoYml0X25yID09IFBHX2xvY2tlZCAmJgogCSAgICAh
UGFnZVVwdG9kYXRlKHBhZ2UpICYmIFBhZ2VXb3JraW5nc2V0KHBhZ2UpKSB7CkBAIC0xMTMwLDQ4
ICsxMTU5LDQyIEBAIHN0YXRpYyBpbmxpbmUgaW50IHdhaXRfb25fcGFnZV9iaXRfY29tbW9uKHdh
aXRfcXVldWVfaGVhZF90ICpxLAogCXdhaXRfcGFnZS5wYWdlID0gcGFnZTsKIAl3YWl0X3BhZ2Uu
Yml0X25yID0gYml0X25yOwogCisJLyoKKwkgKiBBZGQgb3Vyc2VsdmVzIHRvIHRoZSB3YWl0IHF1
ZXVlLgorCSAqCisJICogTk9URSEgVGhpcyBpcyB3aGVyZSB3ZSBhbHNvIGNoZWNrIHRoZSBwYWdl
CisJICogc3RhdGUgc3luY2hyb25vdXNseSB0aGUgbGFzdCB0aW1lIHRvIHNlZSB0aGF0CisJICog
c29tZWJvZHkgZGlkbid0IGp1c3QgY2xlYXIgdGhlIGJpdC4gRG8gdGhlCisJICogU2V0UGFnZVdh
aXRlcnMoKSBiZWZvcmUgdGhhdCB0byBsZXQgYW55Ym9keQorCSAqIHdlIGp1c3QgbWlzcyBrbm93
IHRoZXkgbmVlZCB0byB3YWtlIHVzIHVwLgorCSAqLworCXNwaW5fbG9ja19pcnEoJnEtPmxvY2sp
OworCVNldFBhZ2VXYWl0ZXJzKHBhZ2UpOworCWlmICghdHJ5bG9ja19wYWdlX2JpdF9jb21tb24o
cGFnZSwgYml0X25yLCBiZWhhdmlvcikpCisJCV9fYWRkX3dhaXRfcXVldWVfZW50cnlfdGFpbChx
LCB3YWl0KTsKKwlzcGluX3VubG9ja19pcnEoJnEtPmxvY2spOworCisJLyoKKwkgKiBGcm9tIG5v
dyBvbiwgYWxsIHRoZSBsb2dpYyB3aWxsIGJlIGJhc2VkIG9uCisJICogd2hldGhlciB0aGUgd2Fp
dCBlbnRyeSBpcyBvbiB0aGUgcXVldWUgb3Igbm90LAorCSAqIGFuZCB0aGUgcGFnZSBiaXQgdGVz
dGluZyAoYW5kIHNldHRpbmcpIHdpbGwgYmUKKwkgKiBkb25lIGJ5IHRoZSB3YWtlIGZ1bmN0aW9u
LCBub3QgdXMuCisJICoKKwkgKiBXZSBjYW4gZHJvcCBvdXIgcmVmZXJlbmNlIHRvIHRoZSBwYWdl
LgorCSAqLworCWlmIChiZWhhdmlvciA9PSBEUk9QKQorCQlwdXRfcGFnZShwYWdlKTsKKwogCWZv
ciAoOzspIHsKLQkJc3Bpbl9sb2NrX2lycSgmcS0+bG9jayk7Ci0KLQkJaWYgKGxpa2VseShsaXN0
X2VtcHR5KCZ3YWl0LT5lbnRyeSkpKSB7Ci0JCQlfX2FkZF93YWl0X3F1ZXVlX2VudHJ5X3RhaWwo
cSwgd2FpdCk7Ci0JCQlTZXRQYWdlV2FpdGVycyhwYWdlKTsKLQkJfQotCiAJCXNldF9jdXJyZW50
X3N0YXRlKHN0YXRlKTsKIAotCQlzcGluX3VubG9ja19pcnEoJnEtPmxvY2spOwotCi0JCWJpdF9p
c19zZXQgPSB0ZXN0X2JpdChiaXRfbnIsICZwYWdlLT5mbGFncyk7Ci0JCWlmIChiZWhhdmlvciA9
PSBEUk9QKQotCQkJcHV0X3BhZ2UocGFnZSk7Ci0KLQkJaWYgKGxpa2VseShiaXRfaXNfc2V0KSkK
LQkJCWlvX3NjaGVkdWxlKCk7Ci0KLQkJaWYgKGJlaGF2aW9yID09IEVYQ0xVU0lWRSkgewotCQkJ
aWYgKCF0ZXN0X2FuZF9zZXRfYml0X2xvY2soYml0X25yLCAmcGFnZS0+ZmxhZ3MpKQotCQkJCWJy
ZWFrOwotCQl9IGVsc2UgaWYgKGJlaGF2aW9yID09IFNIQVJFRCkgewotCQkJaWYgKCF0ZXN0X2Jp
dChiaXRfbnIsICZwYWdlLT5mbGFncykpCi0JCQkJYnJlYWs7Ci0JCX0KLQotCQlpZiAoc2lnbmFs
X3BlbmRpbmdfc3RhdGUoc3RhdGUsIGN1cnJlbnQpKSB7Ci0JCQlyZXQgPSAtRUlOVFI7CisJCWlm
IChzaWduYWxfcGVuZGluZ19zdGF0ZShzdGF0ZSwgY3VycmVudCkpCiAJCQlicmVhazsKLQkJfQog
Ci0JCWlmIChiZWhhdmlvciA9PSBEUk9QKSB7Ci0JCQkvKgotCQkJICogV2UgY2FuIG5vIGxvbmdl
ciBzYWZlbHkgYWNjZXNzIHBhZ2UtPmZsYWdzOgotCQkJICogZXZlbiBpZiBDT05GSUdfTUVNT1JZ
X0hPVFJFTU9WRSBpcyBub3QgZW5hYmxlZCwKLQkJCSAqIHRoZXJlIGlzIGEgcmlzayBvZiB3YWl0
aW5nIGZvcmV2ZXIgb24gYSBwYWdlIHJldXNlZAotCQkJICogZm9yIHNvbWV0aGluZyB0aGF0IGtl
ZXBzIGl0IGxvY2tlZCBpbmRlZmluaXRlbHkuCi0JCQkgKiBCdXQgYmVzdCBjaGVjayBmb3IgLUVJ
TlRSIGFib3ZlIGJlZm9yZSBicmVha2luZy4KLQkJCSAqLworCQlpZiAod2FpdC0+ZmxhZ3MgJiBX
UV9GTEFHX1dPS0VOKQogCQkJYnJlYWs7Ci0JCX0KKworCQlpb19zY2hlZHVsZSgpOwogCX0KIAog
CWZpbmlzaF93YWl0KHEsIHdhaXQpOwpAQCAtMTE5MCw3ICsxMjEzLDcgQEAgc3RhdGljIGlubGlu
ZSBpbnQgd2FpdF9vbl9wYWdlX2JpdF9jb21tb24od2FpdF9xdWV1ZV9oZWFkX3QgKnEsCiAJICog
Ym90aGVyIHdpdGggc2lnbmFscyBlaXRoZXIuCiAJICovCiAKLQlyZXR1cm4gcmV0OworCXJldHVy
biB3YWl0LT5mbGFncyAmIFdRX0ZMQUdfV09LRU4gPyAwIDogLUVJTlRSOwogfQogCiB2b2lkIHdh
aXRfb25fcGFnZV9iaXQoc3RydWN0IHBhZ2UgKnBhZ2UsIGludCBiaXRfbnIpCi0tIAoyLjI4LjAu
cmMwLjMuZzFlMjVkM2E2MmYKCg==
--000000000000832cd805ab1f3e64--
