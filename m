Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AF2C34048
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DCA24658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582047390;
	bh=RH94SPcHVLy/JhgwLM0HegIpDAz7SYTF4JnWYy8q34Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=J+sGnldS8pkJQ11GkBgEIR4Q8LvzDHKUddOdiBxOVL+++hkpuHBBoVmyjZBzhXvQh
	 mbXaSm0yydqaXkvmcOfusJdRsRpaAP3BoBvjl2b+C4SYPLw6OXrBcSUou1LRB9Nsbc
	 E1UovPVhyUAQ9yDB6eWpWU7CeIXXnuUXw4lI2g8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgBRRg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:36:29 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43282 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgBRRg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:36:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so23949310ljm.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 09:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ejn5UstmxF7lmN2AxfPRiO0l5wA0+kUDkpk4DTP/TNk=;
        b=BEZGdGO+K+CM8dnG/8KD7hitd4IDxMiSPgHJkRRJZDw97o+11Qbkvzpk38q2jJLsNY
         e8Xmr0kLH1BOqKRkok7gyQ3yQLJRWJmKpMsYQtr8L29SkIwjSlGqDIcKEmg/lRvanhR0
         YwYWAY6jQ3nzi1dL3iFw6Ug12aGV1djv1Up9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ejn5UstmxF7lmN2AxfPRiO0l5wA0+kUDkpk4DTP/TNk=;
        b=FLCEDKD0rOe+wuJmPCpIlL/M1dkjNXsSWYs4/fu/7xUkV6gM/Hy+/FnAg0npDZ1vpS
         BADmlumutxJvdbYguVoz0p0qxL+pifyoaYptqQgAt0jQEBHeiUC6hMdsTDzBfbxhBRJc
         D6TkKgmQD+17ZwiN/N5QFJCCeCNlNJ2xUItbvFLyXJcPCs7Ssqt7VYHXNRp0Xfjx+44P
         Hs647Fw/KoPdRKrlPLkVs+AwhUeXsoV17nRZ7ar4FM6lZAJl7/YF+B24utRFDAHmzpbF
         SwygaoF5LjwtZgdDTVHHXk3CJEBYVp+mo0hC0osZJifuanEElfOUFs1x+A4GsudOxUN/
         InoQ==
X-Gm-Message-State: APjAAAXr9hya6h+b+Psb4Ms3PgIGSE86Lgmg+e0aCoDJucDY/xm9xFRK
        FHgbOSbfKiRiWlK7Ch/uQJHwJi2svvM=
X-Google-Smtp-Source: APXvYqxH8POv22Js2qfejgWByJ90MPmf8UH9wO7ZrtDd9tAfysrAQ3GsmJYQTo5SKlTnpR+KhdAVqw==
X-Received: by 2002:a2e:8016:: with SMTP id j22mr12813327ljg.24.1582047386307;
        Tue, 18 Feb 2020 09:36:26 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id i19sm2647800lfj.17.2020.02.18.09.36.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 09:36:25 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id r14so15129647lfm.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 09:36:25 -0800 (PST)
X-Received: by 2002:a19:f514:: with SMTP id j20mr11135556lfb.31.1582047384649;
 Tue, 18 Feb 2020 09:36:24 -0800 (PST)
MIME-Version: 1.0
References: <20200214154854.6746-1-sashal@kernel.org> <20200214154854.6746-542-sashal@kernel.org>
 <CANaxB-zjYecWpjMoX6dXY3B5HtVu8+G9npRnaX2FnTvp9XucTw@mail.gmail.com>
In-Reply-To: <CANaxB-zjYecWpjMoX6dXY3B5HtVu8+G9npRnaX2FnTvp9XucTw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Feb 2020 09:36:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjd6BKXEpU0MfEaHuOEK-StRToEcYuu6NpVfR0tR5d6xw@mail.gmail.com>
Message-ID: <CAHk-=wjd6BKXEpU0MfEaHuOEK-StRToEcYuu6NpVfR0tR5d6xw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.5 542/542] pipe: use exclusive waits when
 reading or writing
To:     Andrei Vagin <avagin@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        stable <stable@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000616ba8059edd1c62"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000616ba8059edd1c62
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 18, 2020 at 1:51 AM Andrei Vagin <avagin@gmail.com> wrote:
>
> This patch breaks one of CRIU tests. Here is a small reproducer:

Good catch.

> The quick fix looks like this:

That one works, but is not really right.

The things that change the number of readers or writers should simply
use "wake_up_all()".

I thought we did that already, but no - there _was_ one place where we
did it, but that was for the pipe buffer size case, and in that case
it's actually pointless. That case acts just like a "new space or data
was added"

So I think the right fix is the attached patch. Since you had such a
lovely test-case, let me go test it too ;)

                Linus

--000000000000616ba8059edd1c62
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k6s65iuv0>
X-Attachment-Id: f_k6s65iuv0

IGZzL3BpcGUuYyB8IDEwICsrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvcGlwZS5jIGIvZnMvcGlwZS5jCmlu
ZGV4IDVhMzRkNmMyMmQ0Yy4uNzZlN2Y2NmZlMmZlIDEwMDY0NAotLS0gYS9mcy9waXBlLmMKKysr
IGIvZnMvcGlwZS5jCkBAIC0xMDI2LDggKzEwMjYsOCBAQCBzdGF0aWMgaW50IHdhaXRfZm9yX3Bh
cnRuZXIoc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqcGlwZSwgdW5zaWduZWQgaW50ICpjbnQpCiAK
IHN0YXRpYyB2b2lkIHdha2VfdXBfcGFydG5lcihzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICpwaXBl
KQogewotCXdha2VfdXBfaW50ZXJydXB0aWJsZSgmcGlwZS0+cmRfd2FpdCk7Ci0Jd2FrZV91cF9p
bnRlcnJ1cHRpYmxlKCZwaXBlLT53cl93YWl0KTsKKwl3YWtlX3VwX2ludGVycnVwdGlibGVfYWxs
KCZwaXBlLT5yZF93YWl0KTsKKwl3YWtlX3VwX2ludGVycnVwdGlibGVfYWxsKCZwaXBlLT53cl93
YWl0KTsKIH0KIAogc3RhdGljIGludCBmaWZvX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3Ry
dWN0IGZpbGUgKmZpbHApCkBAIC0xMTQ0LDcgKzExNDQsNyBAQCBzdGF0aWMgaW50IGZpZm9fb3Bl
bihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlscCkKIAogZXJyX3dyOgogCWlm
ICghLS1waXBlLT53cml0ZXJzKQotCQl3YWtlX3VwX2ludGVycnVwdGlibGUoJnBpcGUtPnJkX3dh
aXQpOworCQl3YWtlX3VwX2ludGVycnVwdGlibGVfYWxsKCZwaXBlLT5yZF93YWl0KTsKIAlyZXQg
PSAtRVJFU1RBUlRTWVM7CiAJZ290byBlcnI7CiAKQEAgLTEyNzEsOCArMTI3MSw4IEBAIHN0YXRp
YyBsb25nIHBpcGVfc2V0X3NpemUoc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqcGlwZSwgdW5zaWdu
ZWQgbG9uZyBhcmcpCiAJcGlwZS0+bWF4X3VzYWdlID0gbnJfc2xvdHM7CiAJcGlwZS0+dGFpbCA9
IHRhaWw7CiAJcGlwZS0+aGVhZCA9IGhlYWQ7Ci0Jd2FrZV91cF9pbnRlcnJ1cHRpYmxlX2FsbCgm
cGlwZS0+cmRfd2FpdCk7Ci0Jd2FrZV91cF9pbnRlcnJ1cHRpYmxlX2FsbCgmcGlwZS0+d3Jfd2Fp
dCk7CisJd2FrZV91cF9pbnRlcnJ1cHRpYmxlKCZwaXBlLT5yZF93YWl0KTsKKwl3YWtlX3VwX2lu
dGVycnVwdGlibGUoJnBpcGUtPndyX3dhaXQpOwogCXJldHVybiBwaXBlLT5tYXhfdXNhZ2UgKiBQ
QUdFX1NJWkU7CiAKIG91dF9yZXZlcnRfYWNjdDoK
--000000000000616ba8059edd1c62--
