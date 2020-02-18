Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDCFC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FA021D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582050527;
	bh=jJkCDGG5ZFNXNyHV2P6h6E/KRBQPh8St4HaG6x44ZrY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aN7iDzPakaiCSLfV1EXjYYAhU/c5QZwgh3A7SwQwYW8GyTvXYwpP3RswG8qO10YrW
	 wla5cjIXY+GGkLPoTGaGpTAAwyW8BVJ3nv5Aux5mKXVpS+YraYRPRedWwnZj64XTbh
	 uid2gjbJFSHN+iPaG6l+0PMLxmZt5LMEt+nSgVJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgBRS2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:28:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38442 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgBRS2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:28:45 -0500
Received: by mail-lj1-f196.google.com with SMTP id w1so24131780ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+QhJ1rq4OwV2iGSlB588wtXJvujKNK9tlxfzQJwyHS8=;
        b=ejxkrareXzY6YTUjQpMNQmMbBAVxAeHZpnsjqRJOfVCFhXRJpBgATWPZbLfOiAxW/a
         th7vIR385GnvQUqIU39rpkayyQ2QV5OZ329vYyqfpQ0PO3TGv7Tsc77viMB/prpd/EN7
         mxfaTk+8rftAr7S1xcTb0hs67cWZ0/zooHpA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+QhJ1rq4OwV2iGSlB588wtXJvujKNK9tlxfzQJwyHS8=;
        b=UUfaNAGPByPoupVDtyXU5PmjGkbpINVNV2SbuE/wisb6k/a5hYyW4cHHeMclQGMdaK
         YWPcjGgeMGS9WXJ/1Od4AwXVxaw2BLNzhPQH19yQIFQ5u2c96c1H7AslfALsXzeMO7DM
         vL42/5RC70sfyd3SvHeO4GkRh5vqpV+Z/dW42+bLkUASToIrMMxCmO8wmCn9RiiK4wse
         M1REVMBSpKX/1rtPZpyxOWYYSR1FFcYRsW5dhOOnfyCvrS8yLaWvHFsSIl3leddyWDwB
         RTkCgUzt09NrDE8AVFykduh2cxNxYr6wYpys2O5Yn1HQ1QSLcfVJkHESL+weBEgjKn1y
         ++CQ==
X-Gm-Message-State: APjAAAV1abo/XfP19zsKqQ0D6qBS70ZRQQXKfn5++pbsi5pptrLoAVUo
        BoU2KCl1wEKqu15sitldDIg8Znpjznw=
X-Google-Smtp-Source: APXvYqzLICwCjcGVTn+PwvmGWnukhfHBAU3gfwJ2PAI7DXwiqNYUShTFBpmvSYGWfobiD84qZjih6g==
X-Received: by 2002:a2e:3609:: with SMTP id d9mr13694692lja.188.1582050522105;
        Tue, 18 Feb 2020 10:28:42 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id n13sm3015653lji.91.2020.02.18.10.28.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 10:28:40 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id t23so15250090lfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:28:39 -0800 (PST)
X-Received: by 2002:a19:f514:: with SMTP id j20mr11229869lfb.31.1582050519448;
 Tue, 18 Feb 2020 10:28:39 -0800 (PST)
MIME-Version: 1.0
References: <20200214154854.6746-1-sashal@kernel.org> <20200214154854.6746-542-sashal@kernel.org>
 <CANaxB-zjYecWpjMoX6dXY3B5HtVu8+G9npRnaX2FnTvp9XucTw@mail.gmail.com>
 <CAHk-=wjd6BKXEpU0MfEaHuOEK-StRToEcYuu6NpVfR0tR5d6xw@mail.gmail.com>
 <CAHk-=wgs8E4JYVJHaRV2hMn3dxUnM8i0Kn2mA1SjzJdsbB9tXw@mail.gmail.com>
 <CAHk-=wiaDvYHBt8oyZGOp2XwJW4wNXVAchqTFuVBvASTFx_KfA@mail.gmail.com> <20200218182041.GB24185@bombadil.infradead.org>
In-Reply-To: <20200218182041.GB24185@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Feb 2020 10:28:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi8Q8xtZt1iKcqSaV1demDnyixXT+GyDZi-Lk61K3+9rw@mail.gmail.com>
Message-ID: <CAHk-=wi8Q8xtZt1iKcqSaV1demDnyixXT+GyDZi-Lk61K3+9rw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.5 542/542] pipe: use exclusive waits when
 reading or writing
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrei Vagin <avagin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        stable <stable@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000003aa18b059eddd731"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003aa18b059eddd731
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 18, 2020 at 10:20 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> You don't want to move wake_up_partner() up and call it from pipe_release()?

I was actually thinking of going the other way - two of three users of
wake_up_partner() are redundantly waking up the wrong side, and the
third user is pointlessly written too.

So I was _thinking_ of a patch like the appended (which is on top of
the previous patch), but ended up not doing it. Until you brought it
up.

But I won't bother committing this, since it shouldn't really matter.

                 Linus

--0000000000003aa18b059eddd731
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k6s80fwq0>
X-Attachment-Id: f_k6s80fwq0

IGZzL3BpcGUuYyB8IDE4ICsrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvcGlwZS5jIGIvZnMv
cGlwZS5jCmluZGV4IDIxNDQ1MDc0NDdjNS4uNzliYTYxNDMwZjljIDEwMDY0NAotLS0gYS9mcy9w
aXBlLmMKKysrIGIvZnMvcGlwZS5jCkBAIC0xMDI1LDEyICsxMDI1LDYgQEAgc3RhdGljIGludCB3
YWl0X2Zvcl9wYXJ0bmVyKHN0cnVjdCBwaXBlX2lub2RlX2luZm8gKnBpcGUsIHVuc2lnbmVkIGlu
dCAqY250KQogCXJldHVybiBjdXIgPT0gKmNudCA/IC1FUkVTVEFSVFNZUyA6IDA7CiB9CiAKLXN0
YXRpYyB2b2lkIHdha2VfdXBfcGFydG5lcihzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICpwaXBlKQot
ewotCXdha2VfdXBfaW50ZXJydXB0aWJsZV9hbGwoJnBpcGUtPnJkX3dhaXQpOwotCXdha2VfdXBf
aW50ZXJydXB0aWJsZV9hbGwoJnBpcGUtPndyX3dhaXQpOwotfQotCiBzdGF0aWMgaW50IGZpZm9f
b3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlscCkKIHsKIAlzdHJ1Y3Qg
cGlwZV9pbm9kZV9pbmZvICpwaXBlOwpAQCAtMTA3OCw3ICsxMDcyLDcgQEAgc3RhdGljIGludCBm
aWZvX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbHApCiAJICovCiAJ
CXBpcGUtPnJfY291bnRlcisrOwogCQlpZiAocGlwZS0+cmVhZGVycysrID09IDApCi0JCQl3YWtl
X3VwX3BhcnRuZXIocGlwZSk7CisJCQl3YWtlX3VwX2ludGVycnVwdGlibGVfYWxsKCZwaXBlLT53
cl93YWl0KTsKIAogCQlpZiAoIWlzX3BpcGUgJiYgIXBpcGUtPndyaXRlcnMpIHsKIAkJCWlmICgo
ZmlscC0+Zl9mbGFncyAmIE9fTk9OQkxPQ0spKSB7CkBAIC0xMTA0LDcgKzEwOTgsNyBAQCBzdGF0
aWMgaW50IGZpZm9fb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlscCkK
IAogCQlwaXBlLT53X2NvdW50ZXIrKzsKIAkJaWYgKCFwaXBlLT53cml0ZXJzKyspCi0JCQl3YWtl
X3VwX3BhcnRuZXIocGlwZSk7CisJCQl3YWtlX3VwX2ludGVycnVwdGlibGVfYWxsKCZwaXBlLT5y
ZF93YWl0KTsKIAogCQlpZiAoIWlzX3BpcGUgJiYgIXBpcGUtPnJlYWRlcnMpIHsKIAkJCWlmICh3
YWl0X2Zvcl9wYXJ0bmVyKHBpcGUsICZwaXBlLT5yX2NvdW50ZXIpKQpAQCAtMTEyMCwxMiArMTEx
NCwxMiBAQCBzdGF0aWMgaW50IGZpZm9fb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3Qg
ZmlsZSAqZmlscCkKIAkgKiAgdGhlIHByb2Nlc3MgY2FuIGF0IGxlYXN0IHRhbGsgdG8gaXRzZWxm
LgogCSAqLwogCi0JCXBpcGUtPnJlYWRlcnMrKzsKLQkJcGlwZS0+d3JpdGVycysrOworCQlpZiAo
cGlwZS0+cmVhZGVycysrID09IDApCisJCQl3YWtlX3VwX2ludGVycnVwdGlibGVfYWxsKCZwaXBl
LT53cl93YWl0KTsKKwkJaWYgKHBpcGUtPndyaXRlcnMrKyA9PSAwKQorCQkJd2FrZV91cF9pbnRl
cnJ1cHRpYmxlX2FsbCgmcGlwZS0+cmRfd2FpdCk7CiAJCXBpcGUtPnJfY291bnRlcisrOwogCQlw
aXBlLT53X2NvdW50ZXIrKzsKLQkJaWYgKHBpcGUtPnJlYWRlcnMgPT0gMSB8fCBwaXBlLT53cml0
ZXJzID09IDEpCi0JCQl3YWtlX3VwX3BhcnRuZXIocGlwZSk7CiAJCWJyZWFrOwogCiAJZGVmYXVs
dDoK
--0000000000003aa18b059eddd731--
