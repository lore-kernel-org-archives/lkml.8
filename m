Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E20C38BE0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDFB2176D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582577710;
	bh=ArPq6iVEnXCWW16uelwBG3/Y5hulYTmEjizgyn/tfsc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=g8UNmNgc/pmf5KRMxUsQddwacSiAcIURajqCJD0QjNUA4Y5Rx5U+XvhFHJnT/rqA1
	 57UluE1Zk0Y2QpUvVxayQotAFWj7sqivXbSK5Rv6d8M5Z3fsmc8AxW3YIGEXoIrlRH
	 SVZ0hUllHUvtx7G8F33+TvSiIY5w7Ta53LZu0uPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBXUzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:55:09 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44355 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgBXUzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:55:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id g19so13554008eds.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 12:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BY1FLkZ/d5Mam22BCzbsPJxVV/PsCNt3szpo7gapUE0=;
        b=U9jWH7Hxjj/2vLWMsWFFFd18H396h7+gcl13wkrs0AybCkyEaf5xI0TGSrxIUr/jBM
         HS7wgbw0TF2CFGvbyu0q/YD1FoHsq9hjOzzhb1DqN5gDur9IPKgFV77IJo9TaCqIItlE
         zya3mvHoWhjt7mAMKRpr355sHu6Tc3l9xUmQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BY1FLkZ/d5Mam22BCzbsPJxVV/PsCNt3szpo7gapUE0=;
        b=Uco+UMQHbyg9XIeqX4s7ulqBFALiPzgRUnwJlWZPJxehG8dvG90Zh69/J+N0GWyWzd
         NO1smJWhk0mNcpi8db97eruZFBOM+Zw4GDMzB4zvD6+MWJrVuPrl8D6bz40uI4p7JTa9
         EA/+udfxqXSc9XMIEQ5ORNJVKUWqEW/l2StKoBdGupnqKdZJbWuLpQKTR134JHc8xJ11
         3wF/7+Fng5RbhyFlvkVVjHZ6H+j062WjGoYehpqukS/Kd6VmQPaHcPLpvqrd8J++rGbs
         T7R44ByGKKseT33SNkMWlck+UjlIcBZWcfmkOWcHuyJL46i3j9S3spcQPxsOoME4sUml
         51cQ==
X-Gm-Message-State: APjAAAXaRWIMMtGMAEm9DWo1CcOJdiwR1soPD9XosR6GX9pQQA7WXcrd
        Oz8J0jkmDR+dLMPVjZK0vfPOGoa7Tz0=
X-Google-Smtp-Source: APXvYqxSu9KoHS0qoswfmygyeDH/mJ/x5zq4qUuwvvs+B6hZrIZNgP/dq25gbkyFTa0bpOKG/tihmA==
X-Received: by 2002:aa7:dad0:: with SMTP id x16mr48917422eds.307.1582577704864;
        Mon, 24 Feb 2020 12:55:04 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id e3sm1106456edu.3.2020.02.24.12.55.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 12:55:04 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id y17so3263773wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 12:55:04 -0800 (PST)
X-Received: by 2002:a05:651c:555:: with SMTP id q21mr4381361ljp.241.1582577251146;
 Mon, 24 Feb 2020 12:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20200205123216.GO12867@shao2-debian> <20200205125804.GM14879@hirez.programming.kicks-ass.net>
 <20200221080325.GA67807@shbuild999.sh.intel.com> <20200221132048.GE652992@krava>
 <20200223141147.GA53531@shbuild999.sh.intel.com> <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
 <20200224003301.GA5061@shbuild999.sh.intel.com> <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
 <20200224021915.GC5061@shbuild999.sh.intel.com> <CAHk-=wjkSb1OkiCSn_fzf2v7A=K0bNsUEeQa+06XMhTO+oQUaA@mail.gmail.com>
 <CAHk-=wifdJHrfnmwwzPpH-0X6SaZxtdmRWpSNwf8xsXD2iE4dA@mail.gmail.com>
In-Reply-To: <CAHk-=wifdJHrfnmwwzPpH-0X6SaZxtdmRWpSNwf8xsXD2iE4dA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Feb 2020 12:47:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgbR4ocHAOiaj7x+V7dVoYr-mD2N7Y_MRPJ+Q+GohDYeg@mail.gmail.com>
Message-ID: <CAHk-=wgbR4ocHAOiaj7x+V7dVoYr-mD2N7Y_MRPJ+Q+GohDYeg@mail.gmail.com>
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
To:     Feng Tang <feng.tang@intel.com>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
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
Content-Type: multipart/mixed; boundary="000000000000e292c5059f587a63"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e292c5059f587a63
Content-Type: text/plain; charset="UTF-8"

[ Adding a few more people that tend to be involved in signal
handling. Just in case - even if they probably don't care ]

On Mon, Feb 24, 2020 at 12:09 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> TOTALLY UNTESTED patch attached. It may be completely buggy garbage,
> but it _looks_ trivial enough.

I've tested it, and the profiles on the silly microbenchmark look much
nicer. Now it's just the sigpending update shows up, the refcount case
clearly still occasionally happens, but it's now in the noise.

I made slight changes to the __sigqueue_alloc() case to generate
better code: since we now use that atomic_inc_return() anyway, we
might as well then use the value that is returned for the
RLIMIT_SIGPENDING check too, instead of reading it again.

That might avoid another potential cacheline bounce, plus the
generated code just looks better.

Updated (and now slightly tested!) patch attached.

It would be interesting if this is noticeable on your benchmark
numbers. I didn't actually _time_ anything, I just looked at profiles.

But my setup clearly isn't going to see the horrible contention case
anyway, so my timing numbers wouldn't be all that interesting.

             Linus

--000000000000e292c5059f587a63
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k70xjn140>
X-Attachment-Id: f_k70xjn140

IGtlcm5lbC9zaWduYWwuYyB8IDIzICsrKysrKysrKysrKysrLS0tLS0tLS0tCiAxIGZpbGUgY2hh
bmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9rZXJu
ZWwvc2lnbmFsLmMgYi9rZXJuZWwvc2lnbmFsLmMKaW5kZXggOWFkOGRlYTkzZGJiLi41YjIzOTYz
NTBkZDEgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9zaWduYWwuYworKysgYi9rZXJuZWwvc2lnbmFsLmMK
QEAgLTQxMywyNyArNDEzLDMyIEBAIF9fc2lncXVldWVfYWxsb2MoaW50IHNpZywgc3RydWN0IHRh
c2tfc3RydWN0ICp0LCBnZnBfdCBmbGFncywgaW50IG92ZXJyaWRlX3JsaW1pCiB7CiAJc3RydWN0
IHNpZ3F1ZXVlICpxID0gTlVMTDsKIAlzdHJ1Y3QgdXNlcl9zdHJ1Y3QgKnVzZXI7CisJaW50IHNp
Z3BlbmRpbmc7CiAKIAkvKgogCSAqIFByb3RlY3QgYWNjZXNzIHRvIEB0IGNyZWRlbnRpYWxzLiBU
aGlzIGNhbiBnbyBhd2F5IHdoZW4gYWxsCiAJICogY2FsbGVycyBob2xkIHJjdSByZWFkIGxvY2su
CisJICoKKwkgKiBOT1RFISBBIHBlbmRpbmcgc2lnbmFsIHdpbGwgaG9sZCBvbiB0byB0aGUgdXNl
ciByZWZjb3VudCwKKwkgKiBhbmQgd2UgZ2V0L3B1dCB0aGUgcmVmY291bnQgb25seSB3aGVuIHRo
ZSBzaWdwZW5kaW5nIGNvdW50CisJICogY2hhbmdlcyBmcm9tL3RvIHplcm8uCiAJICovCiAJcmN1
X3JlYWRfbG9jaygpOwotCXVzZXIgPSBnZXRfdWlkKF9fdGFza19jcmVkKHQpLT51c2VyKTsKLQlh
dG9taWNfaW5jKCZ1c2VyLT5zaWdwZW5kaW5nKTsKKwl1c2VyID0gX190YXNrX2NyZWQodCktPnVz
ZXI7CisJc2lncGVuZGluZyA9IGF0b21pY19pbmNfcmV0dXJuKCZ1c2VyLT5zaWdwZW5kaW5nKTsK
KwlpZiAoc2lncGVuZGluZyA9PSAxKQorCQlnZXRfdWlkKHVzZXIpOwogCXJjdV9yZWFkX3VubG9j
aygpOwogCi0JaWYgKG92ZXJyaWRlX3JsaW1pdCB8fAotCSAgICBhdG9taWNfcmVhZCgmdXNlci0+
c2lncGVuZGluZykgPD0KLQkJCXRhc2tfcmxpbWl0KHQsIFJMSU1JVF9TSUdQRU5ESU5HKSkgewor
CWlmIChvdmVycmlkZV9ybGltaXQgfHwgbGlrZWx5KHNpZ3BlbmRpbmcgPD0gdGFza19ybGltaXQo
dCwgUkxJTUlUX1NJR1BFTkRJTkcpKSkgewogCQlxID0ga21lbV9jYWNoZV9hbGxvYyhzaWdxdWV1
ZV9jYWNoZXAsIGZsYWdzKTsKIAl9IGVsc2UgewogCQlwcmludF9kcm9wcGVkX3NpZ25hbChzaWcp
OwogCX0KIAogCWlmICh1bmxpa2VseShxID09IE5VTEwpKSB7Ci0JCWF0b21pY19kZWMoJnVzZXIt
PnNpZ3BlbmRpbmcpOwotCQlmcmVlX3VpZCh1c2VyKTsKKwkJaWYgKGF0b21pY19kZWNfYW5kX3Rl
c3QoJnVzZXItPnNpZ3BlbmRpbmcpKQorCQkJZnJlZV91aWQodXNlcik7CiAJfSBlbHNlIHsKIAkJ
SU5JVF9MSVNUX0hFQUQoJnEtPmxpc3QpOwogCQlxLT5mbGFncyA9IDA7CkBAIC00NDcsOCArNDUy
LDggQEAgc3RhdGljIHZvaWQgX19zaWdxdWV1ZV9mcmVlKHN0cnVjdCBzaWdxdWV1ZSAqcSkKIHsK
IAlpZiAocS0+ZmxhZ3MgJiBTSUdRVUVVRV9QUkVBTExPQykKIAkJcmV0dXJuOwotCWF0b21pY19k
ZWMoJnEtPnVzZXItPnNpZ3BlbmRpbmcpOwotCWZyZWVfdWlkKHEtPnVzZXIpOworCWlmIChhdG9t
aWNfZGVjX2FuZF90ZXN0KCZxLT51c2VyLT5zaWdwZW5kaW5nKSkKKwkJZnJlZV91aWQocS0+dXNl
cik7CiAJa21lbV9jYWNoZV9mcmVlKHNpZ3F1ZXVlX2NhY2hlcCwgcSk7CiB9CiAK
--000000000000e292c5059f587a63--
