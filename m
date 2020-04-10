Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F59C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D15320730
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586478768;
	bh=0kbZVLTHFCmSCLRoau1kZkvF8DMXbiHqIrFbdUH4lCA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=z+uAe8YWuYBHixi0vE6BBvU7jkJ/YBTiVY5IkZ6nasfPcNowwQtKA7//0D6dV2hbh
	 zF+6H2fKIQho6Vu0M8L83CQpVyLK67/72OrqS4tjkPCWO0kQEuvLccCHaXkgBVSeo7
	 F4D0H3RI+Peoz+4MVQaNlz1xZxQsPBSJrGHQASCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgDJAcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:32:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43829 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgDJAcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:32:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id h25so420789lja.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 17:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZ1pjOVjJVRW+2KdGYkLhUXKWKGCL1ZMEQNyxZl/JuM=;
        b=UfNCxSi4fVNRQ5uifExQo408Jqzr4/Ca2uNNap2lOlGAAbhNP/ZvJpH0AM/2M1uZfL
         X84t09eWCo6i6/X2ImVw9XKr0mbTB4AA5NBI9CIVG3Mj0Z2W0VkTgiLmzPdASHA9SeUT
         KVI+eYf1teazgDly34dXdApk3D4emy8/cOPWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZ1pjOVjJVRW+2KdGYkLhUXKWKGCL1ZMEQNyxZl/JuM=;
        b=nhgkdhadRHNcs1PZBCAtokw9hNe2s6BZCVgM9/utIqZAOtCegoEpaP3iMxmPrllrfw
         LjO9e8IrAiuWnCXu8DpUDFhSyepgeDHapr6WUbQ1tQhMplcs/Q5AoLRRp0EaVUafnAEt
         DGHHUxtDWY6ZsyRJHX9PbSIHNrMTn3p3iCE//PLY9GpYbE8Ub03SP6zHpMHCTNYSnSCr
         W+i8aANBDiqoPb8xW6qw7j0n3r/nAEDFAxvNPtl+NDMu5iFwoP5p1hB6RNy0l8pq3+aA
         94Pyn1dqCvb8Omwkcx4tZkbQZoXV7yYzOsM7ZojcoBC57Rk/Hq0nNTw61TdbMnjIURwN
         oQ3w==
X-Gm-Message-State: AGi0PuZw9v7GWySagTKk10QmCPTbXUEhhK5t/yrdUSx4shvuJmEuU2FF
        U4bIaphuiiP0gaf8QIe3QTpx1927Ego=
X-Google-Smtp-Source: APiQypL1fJ5gnxSKOJyz6s2/ahEKwES1FZTzh8tXYvAbZTJfgKNo62DBeI4n/0fcVMuAbBZ3o9/tQg==
X-Received: by 2002:a05:651c:554:: with SMTP id q20mr1546560ljp.104.1586478762949;
        Thu, 09 Apr 2020 17:32:42 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 133sm158216ljj.91.2020.04.09.17.32.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 17:32:41 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id n17so433959lji.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 17:32:41 -0700 (PDT)
X-Received: by 2002:a2e:9845:: with SMTP id e5mr1450544ljj.201.1586478761167;
 Thu, 09 Apr 2020 17:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <87blo45keg.fsf@x220.int.ebiederm.org> <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
 <87v9maxb5q.fsf@x220.int.ebiederm.org> <CAHk-=wih4BqW7GTLaYxewynuT-iFHrXroip0wNo0CyPtmYGUow@mail.gmail.com>
 <87y2r4so3i.fsf@x220.int.ebiederm.org> <CAHk-=wjhAvv6s_7OVeZJiHaY7bBrHyiPTkSpq-TLr6qxYqxUUw@mail.gmail.com>
 <CAHk-=wi0jrKv9x6vJ9FDgTrSUbdbZYDX-79T-E87C48MGSn5=g@mail.gmail.com>
 <87wo6or3pg.fsf@x220.int.ebiederm.org> <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
 <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
 <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org> <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
In-Reply-To: <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 17:32:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmQREQzDa8LEoA2L=v=nWASk4n9R=G8SuAZ-1NK4FGPA@mail.gmail.com>
Message-ID: <CAHk-=wjmQREQzDa8LEoA2L=v=nWASk4n9R=G8SuAZ-1NK4FGPA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000014ada05a2e4dfc5"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000014ada05a2e4dfc5
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 9, 2020 at 5:30 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Instead of trying to change how notify_count gets decremented, we
> could do something like the attached patch: wait for it to go down to
> zero, yes, but go back and re-check until you don't have to wait any
> more. That should fix the underflow situation. The comment says it
> all.

The "attached" patch wasn't.

Blush.

Here it is. Still entirely and utterly untested.

           Linus

--000000000000014ada05a2e4dfc5
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k8tgh6uu0>
X-Attachment-Id: f_k8tgh6uu0

IGZzL2V4ZWMuYyAgICAgICB8IDIyICsrKysrKysrKysrKysrKysrKy0tLS0KIGtlcm5lbC9zaWdu
YWwuYyB8ICAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZXhlYy5jIGIvZnMvZXhlYy5jCmluZGV4IDA2YjRjNTUw
YWY1ZC4uZTg0N2MwNDE3ZTM0IDEwMDY0NAotLS0gYS9mcy9leGVjLmMKKysrIGIvZnMvZXhlYy5j
CkBAIC0xMTIyLDExICsxMTIyLDI1IEBAIHN0YXRpYyBpbnQgZGVfdGhyZWFkKHN0cnVjdCB0YXNr
X3N0cnVjdCAqdHNrKQogCX0KIAogCXNpZy0+Z3JvdXBfZXhpdF90YXNrID0gdHNrOwotCXNpZy0+
bm90aWZ5X2NvdW50ID0gemFwX290aGVyX3RocmVhZHModHNrKTsKLQlpZiAoIXRocmVhZF9ncm91
cF9sZWFkZXIodHNrKSkKLQkJc2lnLT5ub3RpZnlfY291bnQtLTsKIAotCXdoaWxlIChzaWctPm5v
dGlmeV9jb3VudCkgeworCS8qCisJICogWmFwIGFuZCB3YWl0IGZvciBvdGhlciB0aHJlYWRzIHRv
IGdvIGF3YXkuCisJICoKKwkgKiBOb3RlIHRoYXQgJ25vdGlmeV9jb3VudCcgaXMgbm90IHN0YWJs
ZSwgYmVjYXVzZQorCSAqIGl0IGFsc28gZ2V0cyBtb2RpZmllZCBieSB6b21iaWUgdGhyZWFkcyB0
aGF0CisJICogemFwX290aGVyX3RocmVhZHMoKSBkb2VzIG5vdCBjb3VudCwgYnV0IHdlJ3JlCisJ
ICogZ3VhcmFudGVlZCB0byB1bmRlci1jb3VudCwgYW5kIGF0IHdvcnN0IHRoYXQgd2lsbAorCSAq
IGNhdXNlIHVzIHRvIHdha2UgdXAgZWFybHkgYW5kIGdvIHRocm91Z2ggdGhlCisJICogbG9vcCBh
IGZldyB0aW1lcy4KKwkgKi8KKwlmb3IgKDs7KSB7CisJCXNpZy0+bm90aWZ5X2NvdW50ID0gemFw
X290aGVyX3RocmVhZHModHNrKTsKKwkJaWYgKCF0aHJlYWRfZ3JvdXBfbGVhZGVyKHRzaykpCisJ
CQlzaWctPm5vdGlmeV9jb3VudC0tOworCQlpZiAoIXNpZy0+bm90aWZ5X2NvdW50KQorCQkJYnJl
YWs7CisKKwkJLyogc2lnLT5ub3RpZnlfY291bnQgZ29pbmcgZG93biB0byB6ZXJvIHdpbGwgd2Fr
ZSB1cyB1cCAqLwogCQlfX3NldF9jdXJyZW50X3N0YXRlKFRBU0tfS0lMTEFCTEUpOwogCQlzcGlu
X3VubG9ja19pcnEobG9jayk7CiAJCXNjaGVkdWxlKCk7CmRpZmYgLS1naXQgYS9rZXJuZWwvc2ln
bmFsLmMgYi9rZXJuZWwvc2lnbmFsLmMKaW5kZXggZTU4YTZjNjE5ODI0Li45OGU1NTIzZjc5MmMg
MTAwNjQ0Ci0tLSBhL2tlcm5lbC9zaWduYWwuYworKysgYi9rZXJuZWwvc2lnbmFsLmMKQEAgLTEz
NTMsMTEgKzEzNTMsMTEgQEAgaW50IHphcF9vdGhlcl90aHJlYWRzKHN0cnVjdCB0YXNrX3N0cnVj
dCAqcCkKIAogCXdoaWxlX2VhY2hfdGhyZWFkKHAsIHQpIHsKIAkJdGFza19jbGVhcl9qb2JjdGxf
cGVuZGluZyh0LCBKT0JDVExfUEVORElOR19NQVNLKTsKLQkJY291bnQrKzsKIAogCQkvKiBEb24n
dCBib3RoZXIgd2l0aCBhbHJlYWR5IGRlYWQgdGhyZWFkcyAqLwogCQlpZiAodC0+ZXhpdF9zdGF0
ZSkKIAkJCWNvbnRpbnVlOworCQljb3VudCsrOwogCQlzaWdhZGRzZXQoJnQtPnBlbmRpbmcuc2ln
bmFsLCBTSUdLSUxMKTsKIAkJc2lnbmFsX3dha2VfdXAodCwgMSk7CiAJfQo=
--000000000000014ada05a2e4dfc5--
