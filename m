Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CECEC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703E82085B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588106165;
	bh=UVE90FLb+v1JZ+kaJjy37UArYOWhNaf9Mgfd2fQjcM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZLx5Os+afVt9nlidMVENTmUTmqK4UCeNVltooN6b2kyGdQM/7Ptlnb9/K8JWP7pQA
	 BlOdRrrZMFCc4qxk48vwkAYVCOrOvti74pyuzw+4akC6pcZAMdqiIrZlnM3Uu35bXu
	 +G+GZcwopG8yrTUv/tlvGBz73HCzwlQQiLT7xRMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgD1UgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726286AbgD1UgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:36:03 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C4CC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:36:02 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g4so181332ljl.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJax72ocdUnWPlq8DrAb6dWOUZzRYQd9t53hZiwnCc0=;
        b=fbg1bShRq6hvO38s7qQoBGECyDFmZa6HZKorx1W8TBj+86IXrlmKzbuJ0Vpe+J5IXu
         zgnpt4bOvv25nyaNigWvLJY3vioX69iQVYkUUx27rIW2Av4fgkIE0T9batznvahnEeNa
         PwBPTUOQZV1SVeIupxvfgreco0pGH9sp6WEZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJax72ocdUnWPlq8DrAb6dWOUZzRYQd9t53hZiwnCc0=;
        b=btQO3txEuRaPxOk6fA+yJNAXt3q5il/2o0OhDQU1uBAuFJtIHhfcd2JS9Nbo1yxfXZ
         GuoiWwhNhAKgXmTd6k77XR1fOl5dwGk52ohU+Gt9z7HV9LKdNlRvPNTCtQ5hjefkigx9
         npRhL72lXJu+fuOyoXRC8ZCf7ExdogGdYR6OJpyfiABns8wM3beMWdXK9MwKukRoZObJ
         Z2CFkZB3HLNgadRUyB0QJcMSMiV1aK3HeFsPMg1UNsPJXVMbdt4S2MJ8oIdYr++GIq+X
         3H2vsZ0XmoL3GLp+7fQ4MW2f7VOKl2ErHngQaA21aC7Qjq04nYHy2u+8PFL1L4hGcVUe
         mIrQ==
X-Gm-Message-State: AGi0PuZ7w+JfoFWwmxikF8tKfiuvmxbHL+xk/PMPvsQgAtq4MGaOsnEQ
        nBtoUTghIuNf5HT+hkWyiqDVufDeocc=
X-Google-Smtp-Source: APiQypJj84KauXR+YTX03Sdx/EtBOmyPZJKyDwIuZwm2TxpKFrSv9yHAS4ft72fiqePauUfakt2LUw==
X-Received: by 2002:a2e:87d9:: with SMTP id v25mr18343408ljj.241.1588106160287;
        Tue, 28 Apr 2020 13:36:00 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id k22sm235542ljj.85.2020.04.28.13.35.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 13:35:58 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id e25so163867ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:35:58 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr17484898ljj.265.1588106157681;
 Tue, 28 Apr 2020 13:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org> <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com> <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <20200412195049.GA23824@redhat.com> <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
 <AM6PR03MB51708CF53D8A02086427DAC2E4AC0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com> <20200428190836.GC29960@redhat.com>
In-Reply-To: <20200428190836.GC29960@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Apr 2020 13:35:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
Message-ID: <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000006586b205a45fc75c"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006586b205a45fc75c
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 28, 2020 at 12:08 PM Oleg Nesterov <oleg@redhat.com> wrote:
>
> Oops. I can update that old patch but somehow I thought there is a better
> plan which I don't yet understand...

I don't think any plan survived reality.

Unless we want to do something *really* hacky.. The attached patch is
not meant to be serious.

> And, IIRC, Jan had some ideas how to rework the new creds calculation in
> execve paths to avoid the cred_guard_mutex deadlock?

I'm not sure how you'd do that.

Execve() fundamentally needs to serialize with PTRACE_ATTACH somehow,
since the whole point is that "tsk->ptrace" changes how the
credentials are interpreted.

So PTRACE_ATTACH doesn't really _change_ the credentials, but it very
much changes what execve() will do with them.

But I guess we could do a "if somebody attached to us while we did the
execve(), just repeat the whole thing"

Jann, what was your clever idea? Maybe it got lost in the long thread..

               Linus

--0000000000006586b205a45fc75c
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_k9kdajpw0>
X-Attachment-Id: f_k9kdajpw0

IGtlcm5lbC9wdHJhY2UuYyB8IDIxICsrKysrKysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5n
ZWQsIDE4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVs
L3B0cmFjZS5jIGIva2VybmVsL3B0cmFjZS5jCmluZGV4IDQzZDYxNzk1MDhkNi4uZWJiYzk4NzY5
MTRiIDEwMDY0NAotLS0gYS9rZXJuZWwvcHRyYWNlLmMKKysrIGIva2VybmVsL3B0cmFjZS5jCkBA
IC0zMSw2ICszMSw3IEBACiAjaW5jbHVkZSA8bGludXgvY25fcHJvYy5oPgogI2luY2x1ZGUgPGxp
bnV4L2NvbXBhdC5oPgogI2luY2x1ZGUgPGxpbnV4L3NjaGVkL3NpZ25hbC5oPgorI2luY2x1ZGUg
PGxpbnV4L2RlbGF5Lmg+CiAKICNpbmNsdWRlIDxhc20vc3lzY2FsbC5oPgkvKiBmb3Igc3lzY2Fs
bF9nZXRfKiAqLwogCkBAIC0zOTAsMTAgKzM5MSwyNCBAQCBzdGF0aWMgaW50IHB0cmFjZV9hdHRh
Y2goc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCBsb25nIHJlcXVlc3QsCiAJICogUHJvdGVjdCBl
eGVjJ3MgY3JlZGVudGlhbCBjYWxjdWxhdGlvbnMgYWdhaW5zdCBvdXIgaW50ZXJmZXJlbmNlOwog
CSAqIFNVSUQsIFNHSUQgYW5kIExTTSBjcmVkcyBnZXQgZGV0ZXJtaW5lZCBkaWZmZXJlbnRseQog
CSAqIHVuZGVyIHB0cmFjZS4KKwkgKgorCSAqIERvbid0IHdhaXQgZm9yZXZlciBvbiB0aGUgY3Jl
ZGVudGlhbCBsb2NrIGlmIHRoZSB0YXJnZXQgaXMKKwkgKiBnb2luZyB0aHJvdWdoIGFuIGV4ZWN2
ZS4KKwkgKgorCSAqIFdoYXRldmVyLiBXZSBkb24ndCBoYXZlICJtdXRleF9sb2NrX2ludGVycnVw
dGlibGVfdGltZW91dCgpIi4KKwkgKiBCdXQgdGhpcyB3b3VsZCBiZSBhIGRpc2d1c3RpbmcgaGFj
ayBldmVuIHdpdGggaXQuCiAJICovCi0JcmV0dmFsID0gLUVSRVNUQVJUTk9JTlRSOwotCWlmICht
dXRleF9sb2NrX2ludGVycnVwdGlibGUoJnRhc2stPnNpZ25hbC0+Y3JlZF9ndWFyZF9tdXRleCkp
Ci0JCWdvdG8gb3V0OworCWZvciAoOzspIHsKKwkJaWYgKG11dGV4X3RyeWxvY2soJnRhc2stPnNp
Z25hbC0+Y3JlZF9ndWFyZF9tdXRleCkpCisJCQlicmVhazsKKwkJcmV0dmFsID0gLUVSRVNUQVJU
Tk9JTlRSOworCQlpZiAoc2lnbmFsX3BlbmRpbmcoY3VycmVudCkpCisJCQlnb3RvIG91dDsKKwkJ
cmV0dmFsID0gLUVBR0FJTjsKKwkJaWYgKHRhc2stPmluX2V4ZWN2ZSkKKwkJCWdvdG8gb3V0Owor
CQltc2xlZXBfaW50ZXJydXB0aWJsZSgxMDApOworCX0KIAogCXRhc2tfbG9jayh0YXNrKTsKIAly
ZXR2YWwgPSBfX3B0cmFjZV9tYXlfYWNjZXNzKHRhc2ssIFBUUkFDRV9NT0RFX0FUVEFDSF9SRUFM
Q1JFRFMpOwo=
--0000000000006586b205a45fc75c--
