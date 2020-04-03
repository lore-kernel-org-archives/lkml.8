Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB343C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848202073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585931086;
	bh=qG9VkxbIxtrI4QUvRUSl/G+6mL3XhNGugUV9YESKa24=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bDPQETzVgVQcYauiWIkd9cGu3jectoe7XMIPYzQFjONTYToKLC3Jp6LWTLTbsOdrJ
	 L0xUWiyagFC0amlCzdHedJW52EogsZKVB2jPwgXFDJsQf23TOzz0xrUHNXFJHJovXY
	 cd6HqUzRHh4i9MJUZRaTHK78mRlSUtIwEEhjDpTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404505AbgDCQYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:24:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37669 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404537AbgDCQYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:24:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so7560180ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 09:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOyQKAwqc8Gxb0xpBsZgHlEP0XcwDoIVSupNEPk+qKI=;
        b=V2C+0tZ5Bq1DupjTHOZEeBObtKtUQ4j5QEEkGzLQWoX4jJdZVdaJdWzJxz8fwLIMjd
         69iC5aZryyBU51Y3qBUR9LqOLQlC5Xsoc0CEbuWSt48lW11M8mNNABklvmO7ov+S7HNl
         qoIGpuB/bub78CGhedt+QXBEJcMA9uUbbkbkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOyQKAwqc8Gxb0xpBsZgHlEP0XcwDoIVSupNEPk+qKI=;
        b=MFYlHcW3MivcytjMACKI97nxZkTUVdm6jztU9Y3A0yYiCaNjS+/37RYC9N+9MtzfH8
         FaNA7VOl8ifLsnkYxFphnrer/YllIoViJwNjTy2gl3qtUIadqkBZKGB/c5rlQLckIy8A
         i4KFoaXnjZMbQLHFU4/0t+dFkKahdKPmqqcJGVXS5yPXGJaZHZqA+/66f4SG/0VCnYeg
         UwURXC/Avu69GMpVJkMrkumX7A+j9F4yJ+3iI2ztjDXj53CHu+w3aA+G7bZk67JszkPY
         k37QHRp/eM2NW6Jjbae/QH0hn00I8YAvlGULm9J2L30hoC1W9pi+UCSqAnDvsQMO9nwR
         3DcQ==
X-Gm-Message-State: AGi0PuaUeO4opE9HAE7faa4WbS8l75mpCMbCbVRG2t46c3rlmVhwxVUl
        1upnC6X4/qMAL/o2NsaMe9GL042G/Vw=
X-Google-Smtp-Source: APiQypK/eKpjLgtGEB4jyb/ZidPvvyKzuXxF9hWuOpkbiN4TrivoY8+tsw2NxDlCwkpgvS5dQtxTSQ==
X-Received: by 2002:a2e:8246:: with SMTP id j6mr5154057ljh.162.1585931081575;
        Fri, 03 Apr 2020 09:24:41 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id u7sm6247210lfb.84.2020.04.03.09.24.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 09:24:09 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id p14so7529889lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 09:24:09 -0700 (PDT)
X-Received: by 2002:a05:651c:50e:: with SMTP id o14mr5201205ljp.241.1585931048679;
 Fri, 03 Apr 2020 09:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB517026CDE64EC57DE37C6080E4C70@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB517026CDE64EC57DE37C6080E4C70@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Apr 2020 09:23:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjqNnpsBJR1xM_Ce91cNh=24CDt6ibpL2G=vDUbSFGR8g@mail.gmail.com>
Message-ID: <CAHk-=wjqNnpsBJR1xM_Ce91cNh=24CDt6ibpL2G=vDUbSFGR8g@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000cc044305a26558c3"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000cc044305a26558c3
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 3, 2020 at 8:09 AM Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>
> On 4/2/20 9:04 PM, Linus Torvalds wrote:
> > In fact, then you could drop the
> >
> >                         mutex_unlock(&tsk->signal->exec_update_mutex);
> >
> > in the error case of exec_mmap(), because now the error handling in
> > free_bprm() would do the cleanup automatically.
> >
>
> The error handling is sometimes called when the exec_update_mutex is
> not taken, in fact even de_thread not called.

But that's the whole point of the flag. Make the flag be about "do I
hold the mutex", and then the error handling does the right thing
regardless.

> Can you say how you would suggest that to be done?

I think the easiest thing to do to explain is to just write the patch.

This is entirely untested, but see what the difference is? I make the
flag be about exactly where I take the lock, not about some "I have
called exec_mmap".

Which means that now exec_mmap() doesn't even need to unlock it in the
error case, because the unlocking will happen properly in the
bprm_exit regardless.

This makes that unconditional unlocking logic much more obvious.

That said, Eric says he can make it all properly static so that it
doesn't need that kind of dynamic "if (x) unlock()" logic at all,
which is much better.

So this patch is not for consumption, it's purely for "look, something
like this"

              Linus

--000000000000cc044305a26558c3
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k8kedlln0>
X-Attachment-Id: f_k8kedlln0

IGZzL2V4ZWMuYyAgICAgICAgICAgICAgIHwgMTUgKysrKysrKy0tLS0tLS0tCiBpbmNsdWRlL2xp
bnV4L2JpbmZtdHMuaCB8ICAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwg
OSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9leGVjLmMgYi9mcy9leGVjLmMKaW5kZXgg
MDZiNGM1NTBhZjVkLi5jZGM3ZjExNDU2NjIgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZWMuYworKysgYi9m
cy9leGVjLmMKQEAgLTEwNDEsOCArMTA0MSw5IEBAIEVYUE9SVF9TWU1CT0wocmVhZF9jb2RlKTsK
ICAqIE9uIHN1Y2Nlc3MsIHRoaXMgZnVuY3Rpb24gcmV0dXJucyB3aXRoIHRoZSBtdXRleAogICog
ZXhlY191cGRhdGVfbXV0ZXggbG9ja2VkLgogICovCi1zdGF0aWMgaW50IGV4ZWNfbW1hcChzdHJ1
Y3QgbW1fc3RydWN0ICptbSkKK3N0YXRpYyBpbnQgZXhlY19tbWFwKHN0cnVjdCBsaW51eF9iaW5w
cm0gKmJwcm0pCiB7CisJc3RydWN0IG1tX3N0cnVjdCAqbW0gPSBicHJtLT5tbTsKIAlzdHJ1Y3Qg
dGFza19zdHJ1Y3QgKnRzazsKIAlzdHJ1Y3QgbW1fc3RydWN0ICpvbGRfbW0sICphY3RpdmVfbW07
CiAJaW50IHJldDsKQEAgLTEwNTUsNiArMTA1Niw3IEBAIHN0YXRpYyBpbnQgZXhlY19tbWFwKHN0
cnVjdCBtbV9zdHJ1Y3QgKm1tKQogCXJldCA9IG11dGV4X2xvY2tfa2lsbGFibGUoJnRzay0+c2ln
bmFsLT5leGVjX3VwZGF0ZV9tdXRleCk7CiAJaWYgKHJldCkKIAkJcmV0dXJuIHJldDsKKwlicHJt
LT51cGRhdGVfbXV0ZXhfaGVsZCA9IDE7CiAKIAlpZiAob2xkX21tKSB7CiAJCXN5bmNfbW1fcnNz
KG9sZF9tbSk7CkBAIC0xMDY3LDcgKzEwNjksNiBAQCBzdGF0aWMgaW50IGV4ZWNfbW1hcChzdHJ1
Y3QgbW1fc3RydWN0ICptbSkKIAkJZG93bl9yZWFkKCZvbGRfbW0tPm1tYXBfc2VtKTsKIAkJaWYg
KHVubGlrZWx5KG9sZF9tbS0+Y29yZV9zdGF0ZSkpIHsKIAkJCXVwX3JlYWQoJm9sZF9tbS0+bW1h
cF9zZW0pOwotCQkJbXV0ZXhfdW5sb2NrKCZ0c2stPnNpZ25hbC0+ZXhlY191cGRhdGVfbXV0ZXgp
OwogCQkJcmV0dXJuIC1FSU5UUjsKIAkJfQogCX0KQEAgLTEzMjEsMTcgKzEzMjIsMTUgQEAgaW50
IGZsdXNoX29sZF9leGVjKHN0cnVjdCBsaW51eF9iaW5wcm0gKiBicHJtKQogCSAqIFJlbGVhc2Ug
YWxsIG9mIHRoZSBvbGQgbW1hcCBzdHVmZgogCSAqLwogCWFjY3RfYXJnX3NpemUoYnBybSwgMCk7
Ci0JcmV0dmFsID0gZXhlY19tbWFwKGJwcm0tPm1tKTsKKwlyZXR2YWwgPSBleGVjX21tYXAoYnBy
bSk7CiAJaWYgKHJldHZhbCkKIAkJZ290byBvdXQ7CiAKIAkvKgotCSAqIEFmdGVyIHNldHRpbmcg
YnBybS0+Y2FsbGVkX2V4ZWNfbW1hcCAodG8gbWFyayB0aGF0IGN1cnJlbnQgaXMKLQkgKiB1c2lu
ZyB0aGUgcHJlcGFyZWQgbW0gbm93KSwgd2UgaGF2ZSBub3RoaW5nIGxlZnQgb2YgdGhlIG9yaWdp
bmFsCisJICogQWZ0ZXIgc2V0dGluZyBicHJtLT5tbSB0byBOVUxMLCB3ZSBoYXZlIG5vdGhpbmcg
bGVmdCBvZiB0aGUgb3JpZ2luYWwKIAkgKiBwcm9jZXNzLiBJZiBhbnl0aGluZyBmcm9tIGhlcmUg
b24gcmV0dXJucyBhbiBlcnJvciwgdGhlIGNoZWNrCiAJICogaW4gc2VhcmNoX2JpbmFyeV9oYW5k
bGVyKCkgd2lsbCBTRUdWIGN1cnJlbnQuCiAJICovCi0JYnBybS0+Y2FsbGVkX2V4ZWNfbW1hcCA9
IDE7CiAJYnBybS0+bW0gPSBOVUxMOwogCiAjaWZkZWYgQ09ORklHX1BPU0lYX1RJTUVSUwpAQCAt
MTQ3Nyw3ICsxNDc2LDcgQEAgc3RhdGljIHZvaWQgZnJlZV9icHJtKHN0cnVjdCBsaW51eF9iaW5w
cm0gKmJwcm0pCiB7CiAJZnJlZV9hcmdfcGFnZXMoYnBybSk7CiAJaWYgKGJwcm0tPmNyZWQpIHsK
LQkJaWYgKGJwcm0tPmNhbGxlZF9leGVjX21tYXApCisJCWlmIChicHJtLT51cGRhdGVfbXV0ZXhf
aGVsZCkKIAkJCW11dGV4X3VubG9jaygmY3VycmVudC0+c2lnbmFsLT5leGVjX3VwZGF0ZV9tdXRl
eCk7CiAJCW11dGV4X3VubG9jaygmY3VycmVudC0+c2lnbmFsLT5jcmVkX2d1YXJkX211dGV4KTsK
IAkJYWJvcnRfY3JlZHMoYnBybS0+Y3JlZCk7CkBAIC0xNzIwLDcgKzE3MTksNyBAQCBpbnQgc2Vh
cmNoX2JpbmFyeV9oYW5kbGVyKHN0cnVjdCBsaW51eF9iaW5wcm0gKmJwcm0pCiAKIAkJcmVhZF9s
b2NrKCZiaW5mbXRfbG9jayk7CiAJCXB1dF9iaW5mbXQoZm10KTsKLQkJaWYgKHJldHZhbCA8IDAg
JiYgYnBybS0+Y2FsbGVkX2V4ZWNfbW1hcCkgeworCQlpZiAocmV0dmFsIDwgMCAmJiAhYnBybS0+
bW0pIHsKIAkJCS8qIHdlIGdvdCB0byBmbHVzaF9vbGRfZXhlYygpIGFuZCBmYWlsZWQgYWZ0ZXIg
aXQgKi8KIAkJCXJlYWRfdW5sb2NrKCZiaW5mbXRfbG9jayk7CiAJCQlmb3JjZV9zaWdzZWd2KFNJ
R1NFR1YpOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9iaW5mbXRzLmggYi9pbmNsdWRlL2xp
bnV4L2JpbmZtdHMuaAppbmRleCBhMzQ1ZDlmZWQzZDguLmI4MTU3ODNjOGIyYyAxMDA2NDQKLS0t
IGEvaW5jbHVkZS9saW51eC9iaW5mbXRzLmgKKysrIGIvaW5jbHVkZS9saW51eC9iaW5mbXRzLmgK
QEAgLTUwLDcgKzUwLDcgQEAgc3RydWN0IGxpbnV4X2JpbnBybSB7CiAJCSAqIFRoaXMgaXMgcGFz
dCB0aGUgcG9pbnQgb2Ygbm8gcmV0dXJuLCB3aGVuIHRoZQogCQkgKiBleGVjX3VwZGF0ZV9tdXRl
eCBoYXMgYmVlbiB0YWtlbi4KIAkJICovCi0JCWNhbGxlZF9leGVjX21tYXA6MTsKKwkJdXBkYXRl
X211dGV4X2hlbGQ6MTsKICNpZmRlZiBfX2FscGhhX18KIAl1bnNpZ25lZCBpbnQgdGFzbzoxOwog
I2VuZGlmCg==
--000000000000cc044305a26558c3--
