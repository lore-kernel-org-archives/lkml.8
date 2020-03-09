Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5747C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904EF208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583769185;
	bh=gMmrwKuiiPSrE5zFSZjJ3AXpeMxjqa2zX8pRsdKTGR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zu9pNFJvIQZpz1HyZ66Adp9kMinqlkNNaXtLZ653Wzg8oMRzLoo/L26KKhfvCPMxc
	 UIxba4WYygWlorJ0k5ewgw9brYObzBTs7IX3INNWGXSiovvHgUhKHE1EvLykThpcw4
	 nKSMip1I6KUK6CRYMRRnRcmuA7ZIDQ4nkJEpIePU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCIPxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:53:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34510 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbgCIPxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:53:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id s13so1274550ljm.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXfBgHukxBvsUIUUHVjFpSxz9MtCVwuKfkDGjmbjA74=;
        b=TUfdKwyMIdzZABuGfaz29jdL4jBWhfe9EDROAoWo7k6cs3dhd+ODiA8Fuv0zwjS7aR
         kaKK1YDIK5c5LCpnpOC9idRXWgQRLP0+CSXvTrz1Mfum6aCAyVhgPh163mCqXrvVGstE
         th+lI57YSlrxDwtOGDYLNp/qugF7/3vQm9KV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXfBgHukxBvsUIUUHVjFpSxz9MtCVwuKfkDGjmbjA74=;
        b=kES7Fojmeejgjo3DA5xAGThAHj7XsYN5WezM7MSvNSv9+TMYznfuHaOmMHTHUkT8wg
         WpSY90VJwE7jFdxNG95csqEkIXYkRI384CwconONcky7IuJFdamfVHWsyE/4MeLggGZX
         J6WQgiYc6a6CdmjAZsVKJ8c5yYaH4/p9lZ9AzmZd+DiYTa+Iwg2r/liZUYsJY+6A644/
         YsAPNgzrasPoY/+uAuD9f81ejM2y2z93/UcFz2LFCG3+/uEhlMYWpEc7Q0v2rJhcMSNP
         NDLsC5ts8/X1jc6+ZQnLXrxcBbauh3TGhNR7rtenNcRc0a3qILUCj1NKgkYVTdqRRZf7
         jM+A==
X-Gm-Message-State: ANhLgQ3+AGM0+SjU5L6E7mmAHLxie7Hx+kwU3KgzhtnsywxUA0134LtH
        mF6iVPkrp6X+fgL9w4yGBwp4mOstP48=
X-Google-Smtp-Source: ADFU+vskVYLFU7Qg5OXkUaOT5v4RyS6fAybzsvJ+Geg2dA6Tu9qGP8tYovZI5rIhPvlYZZaD0N16zQ==
X-Received: by 2002:a05:651c:201d:: with SMTP id s29mr4035841ljo.240.1583769180356;
        Mon, 09 Mar 2020 08:53:00 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id x23sm8433088ljj.8.2020.03.09.08.52.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 08:52:58 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id w1so10495106ljh.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 08:52:57 -0700 (PDT)
X-Received: by 2002:a2e:5850:: with SMTP id x16mr9457422ljd.209.1583769177624;
 Mon, 09 Mar 2020 08:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200308140314.GQ5972@shao2-debian> <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org>
In-Reply-To: <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Mar 2020 08:52:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com>
Message-ID: <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6% regression
To:     Jeff Layton <jlayton@kernel.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        yangerkun <yangerkun@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Neil Brown <neilb@suse.de>,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: multipart/mixed; boundary="0000000000003d346305a06dff90"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003d346305a06dff90
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 9, 2020 at 7:36 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Sun, 2020-03-08 at 22:03 +0800, kernel test robot wrote:
> >
> > FYI, we noticed a -96.6% regression of will-it-scale.per_process_ops due to commit:
>
> This is not completely unexpected as we're banging on the global
> blocked_lock_lock now for every unlock. This test just thrashes file
> locks and unlocks without doing anything in between, so the workload
> looks pretty artificial [1].
>
> It would be nice to avoid the global lock in this codepath, but it
> doesn't look simple to do. I'll keep thinking about it, but for now I'm
> inclined to ignore this result unless we see a problem in more realistic
> workloads.

That is a _huge_ regression, though.

What about something like the attached? Wouldn't that work? And make
the code actually match the old comment about wow "fl_blocker" being
NULL being special.

The old code seemed to not know about things like memory ordering either.

Patch is entirely untested, but aims to have that "smp_store_release()
means I'm done and not going to touch it any more", making that
smp_load_acquire() test hopefully be valid as per the comment..

Hmm?

                    Linus

--0000000000003d346305a06dff90
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k7kn615a0>
X-Attachment-Id: f_k7kn615a0

IGZzL2xvY2tzLmMgfCAyOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNo
YW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9s
b2Nrcy5jIGIvZnMvbG9ja3MuYwppbmRleCA0MjZiNTVkMzMzZDUuLmJjNWNhNTRhMDc0OSAxMDA2
NDQKLS0tIGEvZnMvbG9ja3MuYworKysgYi9mcy9sb2Nrcy5jCkBAIC03MjUsNyArNzI1LDYgQEAg
c3RhdGljIHZvaWQgX19sb2Nrc19kZWxldGVfYmxvY2soc3RydWN0IGZpbGVfbG9jayAqd2FpdGVy
KQogewogCWxvY2tzX2RlbGV0ZV9nbG9iYWxfYmxvY2tlZCh3YWl0ZXIpOwogCWxpc3RfZGVsX2lu
aXQoJndhaXRlci0+ZmxfYmxvY2tlZF9tZW1iZXIpOwotCXdhaXRlci0+ZmxfYmxvY2tlciA9IE5V
TEw7CiB9CiAKIHN0YXRpYyB2b2lkIF9fbG9ja3Nfd2FrZV91cF9ibG9ja3Moc3RydWN0IGZpbGVf
bG9jayAqYmxvY2tlcikKQEAgLTc0MCw2ICs3MzksMTIgQEAgc3RhdGljIHZvaWQgX19sb2Nrc193
YWtlX3VwX2Jsb2NrcyhzdHJ1Y3QgZmlsZV9sb2NrICpibG9ja2VyKQogCQkJd2FpdGVyLT5mbF9s
bW9wcy0+bG1fbm90aWZ5KHdhaXRlcik7CiAJCWVsc2UKIAkJCXdha2VfdXAoJndhaXRlci0+Zmxf
d2FpdCk7CisKKwkJLyoKKwkJICogVGVsbCB0aGUgd29ybGQgd2UncmUgZG9uZSB3aXRoIGl0IC0g
c2VlIGNvbW1lbnQgYXQKKwkJICogdG9wIG9mIGxvY2tzX2RlbGV0ZV9ibG9jaygpLgorCQkgKi8K
KwkJc21wX3N0b3JlX3JlbGVhc2UoJndhaXRlci0+ZmxfYmxvY2tlciwgTlVMTCk7CiAJfQogfQog
CkBAIC03NTMsMTEgKzc1OCwzMyBAQCBpbnQgbG9ja3NfZGVsZXRlX2Jsb2NrKHN0cnVjdCBmaWxl
X2xvY2sgKndhaXRlcikKIHsKIAlpbnQgc3RhdHVzID0gLUVOT0VOVDsKIAorCS8qCisJICogSWYg
ZmxfYmxvY2tlciBpcyBOVUxMLCBpdCB3b24ndCBiZSBzZXQgYWdhaW4gYXMgdGhpcyB0aHJlYWQK
KwkgKiAib3ducyIgdGhlIGxvY2sgYW5kIGlzIHRoZSBvbmx5IG9uZSB0aGF0IG1pZ2h0IHRyeSB0
byBjbGFpbQorCSAqIHRoZSBsb2NrLiAgU28gaXQgaXMgc2FmZSB0byB0ZXN0IGZsX2Jsb2NrZXIg
bG9ja2xlc3NseS4KKwkgKiBBbHNvIGlmIGZsX2Jsb2NrZXIgaXMgTlVMTCwgdGhpcyB3YWl0ZXIg
aXMgbm90IGxpc3RlZCBvbgorCSAqIGZsX2Jsb2NrZWRfcmVxdWVzdHMgZm9yIHNvbWUgbG9jaywg
c28gbm8gb3RoZXIgcmVxdWVzdCBjYW4KKwkgKiBiZSBhZGRlZCB0byB0aGUgbGlzdCBvZiBmbF9i
bG9ja2VkX3JlcXVlc3RzIGZvciB0aGlzCisJICogcmVxdWVzdC4gIFNvIGlmIGZsX2Jsb2NrZXIg
aXMgTlVMTCwgaXQgaXMgc2FmZSB0bworCSAqIGxvY2tsZXNzbHkgY2hlY2sgaWYgZmxfYmxvY2tl
ZF9yZXF1ZXN0cyBpcyBlbXB0eS4gIElmIGJvdGgKKwkgKiBvZiB0aGVzZSBjaGVja3Mgc3VjY2Vl
ZCwgdGhlcmUgaXMgbm8gbmVlZCB0byB0YWtlIHRoZSBsb2NrLgorCSAqLworCWlmICghc21wX2xv
YWRfYWNxdWlyZSgmd2FpdGVyLT5mbF9ibG9ja2VyKSkgeworCQlpZiAobGlzdF9lbXB0eSgmd2Fp
dGVyLT5mbF9ibG9ja2VkX3JlcXVlc3RzKSkKKwkJICAgICAgICByZXR1cm4gc3RhdHVzOworCX0K
KwogCXNwaW5fbG9jaygmYmxvY2tlZF9sb2NrX2xvY2spOwogCWlmICh3YWl0ZXItPmZsX2Jsb2Nr
ZXIpCiAJCXN0YXR1cyA9IDA7CiAJX19sb2Nrc193YWtlX3VwX2Jsb2Nrcyh3YWl0ZXIpOwogCV9f
bG9ja3NfZGVsZXRlX2Jsb2NrKHdhaXRlcik7CisKKwkvKgorCSAqIFRlbGwgdGhlIHdvcmxkIHdl
J3JlIGRvbmUgd2l0aCBpdCAtIHNlZSBjb21taXQgYXQgdG9wCisJICogb2YgdGhpcyBmdW5jdGlv
bgorCSAqLworCXNtcF9zdG9yZV9yZWxlYXNlKCZ3YWl0ZXItPmZsX2Jsb2NrZXIsIE5VTEwpOwog
CXNwaW5fdW5sb2NrKCZibG9ja2VkX2xvY2tfbG9jayk7CiAJcmV0dXJuIHN0YXR1czsKIH0K
--0000000000003d346305a06dff90--
