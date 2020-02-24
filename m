Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79659C38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E30D20880
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582575433;
	bh=4JDUxCnXhN8QU0v9ZPBFuh8gSJcvrxLC1tkI4jpDFm0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=drv5qZXrb5wMN5xYXPa7xsDtmywYnQwYid5B3NUYA2rjcBGmz2cOmAWCtFKx4KsDh
	 i2Ll+fIzEwDAg3r5AmryS9QGgwyDDbOeiDGQvXMBWM6ckMZ6rK7bmNBV0yX6CyZBgX
	 2VndOqiz6lbRRAv/cm+wSp3gCuGWaqcZv7InB5BM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBXURM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:17:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39192 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgBXURL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:17:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id o15so11567813ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 12:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSNWnI1c4cFgTcFCSRSzkFHe/QpedNaBy4vNqxXbuAQ=;
        b=P4EToDhGbYQaUjVNwLblwoyyxDJN17G6hPH1HFtBMlD4Sm85+CNr4EuAtf/OOgxD7O
         sgIgV8GbuChgLLkXofo4JOa408otw3lNhEm3RVv9gqIiH/qgS7OIT/FiTT2/KCMTeg9c
         OpMF+TVpR4qvKxn0OBH7tGju7hH+ptq8xN8G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSNWnI1c4cFgTcFCSRSzkFHe/QpedNaBy4vNqxXbuAQ=;
        b=rlC1h7kvuEXybynYp9wCxSzv2KveTBSEHoRRK6Cv9DKW/Yxb8bhgcud1t2RbzxfiYd
         13sqvd0KazphyeMHJsA9NK+PKA0dNcLWQRIy//FnapiddZDkns9k7yuGof5m3lL0EZkv
         9MFtCBSxBcBXsGLBhuDF0ZNDrNvQm+gGXnMqqiHfnidDu/SCz6Fi67cPDfDvhvq9U0i8
         RNLUKAahDLBa/CXaUveZSuHyZ9X2TumCz0rQq5Bfcz93Xb1EKHc3thhtEyOd1Q4o0l11
         y9WDqBDElKOn48x/gu7L+CV1jTXWiJ4TCoEQZHoEGWiI9PWFC4gWkg2u92FQGj99ZOcf
         ncAQ==
X-Gm-Message-State: APjAAAXZhyOV9Ggb1vCRbQF5+xxDlIYhUtiaGIcflEtxGCpUlJVZdFmn
        67FSW7B144BhPT++Mtp/NTdLDCxq1GU=
X-Google-Smtp-Source: APXvYqwXVR+sziyZDFlAFLhSKKrNacOeqFWN5GIQtSB7/0AEsvwOUMLilMBF8V2L4zy7PitPdne4+g==
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr32471956ljc.158.1582575427403;
        Mon, 24 Feb 2020 12:17:07 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id s17sm8088541ljo.18.2020.02.24.12.17.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 12:17:07 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id n18so11559375ljo.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 12:17:06 -0800 (PST)
X-Received: by 2002:a2e:461a:: with SMTP id t26mr31070734lja.204.1582574960486;
 Mon, 24 Feb 2020 12:09:20 -0800 (PST)
MIME-Version: 1.0
References: <20200205123216.GO12867@shao2-debian> <20200205125804.GM14879@hirez.programming.kicks-ass.net>
 <20200221080325.GA67807@shbuild999.sh.intel.com> <20200221132048.GE652992@krava>
 <20200223141147.GA53531@shbuild999.sh.intel.com> <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
 <20200224003301.GA5061@shbuild999.sh.intel.com> <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
 <20200224021915.GC5061@shbuild999.sh.intel.com> <CAHk-=wjkSb1OkiCSn_fzf2v7A=K0bNsUEeQa+06XMhTO+oQUaA@mail.gmail.com>
In-Reply-To: <CAHk-=wjkSb1OkiCSn_fzf2v7A=K0bNsUEeQa+06XMhTO+oQUaA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Feb 2020 12:09:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wifdJHrfnmwwzPpH-0X6SaZxtdmRWpSNwf8xsXD2iE4dA@mail.gmail.com>
Message-ID: <CAHk-=wifdJHrfnmwwzPpH-0X6SaZxtdmRWpSNwf8xsXD2iE4dA@mail.gmail.com>
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
To:     Feng Tang <feng.tang@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        andi.kleen@intel.com, "Huang, Ying" <ying.huang@intel.com>
Content-Type: multipart/mixed; boundary="0000000000005a186a059f57f234"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000005a186a059f57f234
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 24, 2020 at 11:24 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I don't know. This does not seem to be a particularly serious load.
> But it does feel like it should be possible to combine the two atomic
> accesses into one, where you don't need to do the refcount thing
> except for the case where sigcount goes from zero to non-zero (and
> back to zero again).

Ok, that looks just as simple as I thought it would be.

TOTALLY UNTESTED patch attached. It may be completely buggy garbage,
but it _looks_ trivial enough. Just make the rule be that "if we have
any user->sigpending cases, we'll get a ref to the user for the first
one, and drop it only when getting rid of the last one".

So it might be worth testing this. But again: I have NOT done so.

There might be some silly reason why this doesn't work because I just
did the tests wrong or missed some case.

Or there might be some subtle reason why it doesn't work because I
didn't think this through properly.

But it _looks_ obvious and simple enough. And it compiles for me. So
maybe it works.

              Linus

--0000000000005a186a059f57f234
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k70w8onv0>
X-Attachment-Id: f_k70w8onv0

IGtlcm5lbC9zaWduYWwuYyB8IDE3ICsrKysrKysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
MTEgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvc2ln
bmFsLmMgYi9rZXJuZWwvc2lnbmFsLmMKaW5kZXggOWFkOGRlYTkzZGJiLi4wMGFkZGFhODMxOWYg
MTAwNjQ0Ci0tLSBhL2tlcm5lbC9zaWduYWwuYworKysgYi9rZXJuZWwvc2lnbmFsLmMKQEAgLTQx
NywxMCArNDE3LDE1IEBAIF9fc2lncXVldWVfYWxsb2MoaW50IHNpZywgc3RydWN0IHRhc2tfc3Ry
dWN0ICp0LCBnZnBfdCBmbGFncywgaW50IG92ZXJyaWRlX3JsaW1pCiAJLyoKIAkgKiBQcm90ZWN0
IGFjY2VzcyB0byBAdCBjcmVkZW50aWFscy4gVGhpcyBjYW4gZ28gYXdheSB3aGVuIGFsbAogCSAq
IGNhbGxlcnMgaG9sZCByY3UgcmVhZCBsb2NrLgorCSAqCisJICogTk9URSEgQSBwZW5kaW5nIHNp
Z25hbCB3aWxsIGhvbGQgb24gdG8gdGhlIHVzZXIgcmVmY291bnQsCisJICogYW5kIHdlIGdldC9w
dXQgdGhlIHJlZmNvdW50IG9ubHkgd2hlbiB0aGUgc2lncGVuZGluZyBjb3VudAorCSAqIGNoYW5n
ZXMgZnJvbS90byB6ZXJvLgogCSAqLwogCXJjdV9yZWFkX2xvY2soKTsKLQl1c2VyID0gZ2V0X3Vp
ZChfX3Rhc2tfY3JlZCh0KS0+dXNlcik7Ci0JYXRvbWljX2luYygmdXNlci0+c2lncGVuZGluZyk7
CisJdXNlciA9IF9fdGFza19jcmVkKHQpLT51c2VyOworCWlmIChhdG9taWNfaW5jX3JldHVybigm
dXNlci0+c2lncGVuZGluZykgPT0gMSkKKwkJZ2V0X3VpZCh1c2VyKTsKIAlyY3VfcmVhZF91bmxv
Y2soKTsKIAogCWlmIChvdmVycmlkZV9ybGltaXQgfHwKQEAgLTQzMiw4ICs0MzcsOCBAQCBfX3Np
Z3F1ZXVlX2FsbG9jKGludCBzaWcsIHN0cnVjdCB0YXNrX3N0cnVjdCAqdCwgZ2ZwX3QgZmxhZ3Ms
IGludCBvdmVycmlkZV9ybGltaQogCX0KIAogCWlmICh1bmxpa2VseShxID09IE5VTEwpKSB7Ci0J
CWF0b21pY19kZWMoJnVzZXItPnNpZ3BlbmRpbmcpOwotCQlmcmVlX3VpZCh1c2VyKTsKKwkJaWYg
KGF0b21pY19kZWNfYW5kX3Rlc3QoJnVzZXItPnNpZ3BlbmRpbmcpKQorCQkJZnJlZV91aWQodXNl
cik7CiAJfSBlbHNlIHsKIAkJSU5JVF9MSVNUX0hFQUQoJnEtPmxpc3QpOwogCQlxLT5mbGFncyA9
IDA7CkBAIC00NDcsOCArNDUyLDggQEAgc3RhdGljIHZvaWQgX19zaWdxdWV1ZV9mcmVlKHN0cnVj
dCBzaWdxdWV1ZSAqcSkKIHsKIAlpZiAocS0+ZmxhZ3MgJiBTSUdRVUVVRV9QUkVBTExPQykKIAkJ
cmV0dXJuOwotCWF0b21pY19kZWMoJnEtPnVzZXItPnNpZ3BlbmRpbmcpOwotCWZyZWVfdWlkKHEt
PnVzZXIpOworCWlmIChhdG9taWNfZGVjX2FuZF90ZXN0KCZxLT51c2VyLT5zaWdwZW5kaW5nKSkK
KwkJZnJlZV91aWQocS0+dXNlcik7CiAJa21lbV9jYWNoZV9mcmVlKHNpZ3F1ZXVlX2NhY2hlcCwg
cSk7CiB9CiAK
--0000000000005a186a059f57f234--
