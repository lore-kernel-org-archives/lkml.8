Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225D2C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 22:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26272074A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 22:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585519606;
	bh=DD4ExzACxmpaytGy6Jhd2869kxAYkRioZLNpQbnm9gE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AKGF9QOMzZKr+bSsGLGTmgZnYNqN33H5ixYxsbKuN13kdo5ZszqKkYfuDz5HtyGgF
	 neAkUL0DUy4gSOT1ABn0XHWlY1TkOgAN1XA7bxbOyN5hmbzLFHrVBtiObPFVdPkGjV
	 fP5h+hzrKG82d7kIRn/mqFjV4wnjgE287th6KsDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgC2WGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 18:06:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41282 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbgC2WGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 18:06:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id n17so15992304lji.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUl8UKYc4nsp/6S1OBKZwco0VpM6yIv4J8yu81qNB9A=;
        b=A/w2aA+rhJy5+8BagvXzUdEgfGJblH6oT8mRimw3+/aa2XIygwSU1ob1Xm2IMyqjMK
         bcvA3Tso2LVEUs+qNOgkfaOqk5IRQev6CQ7o4rbKN8TJlh9WDRztDYnYpkiJBKGPNu+h
         FiPiWhUbQfwH/Ar2QB38jSTNjkKTr58j6ASis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUl8UKYc4nsp/6S1OBKZwco0VpM6yIv4J8yu81qNB9A=;
        b=uM483kiJZXldDvvMHDH78a5MR+mMXjN2qA8Ep+HDVXVOZ7WS+6oBcT4IEFt3LRuaa9
         lZ3PsDWEyEYdUlFPFmEtnRxbYMILbCQVZpWUz660QkMy7heGANAgrgKz6HMIEiwI56Ln
         A7SRPFfeMv3GUyNxCkj8iCpJknZfWhvHL0sOEpIBY+ilz+qF0htDuK3jVgTsTw5ZIZ5l
         DGSnptlRPPh1AAWsVEWvI9W+hiXIKsSENLNqkaX6/31x8mlJyfAADroZ6GcmAGNjfPEW
         Ff3U8LnIh8to0eM9zpT7BvDs8Z2PWyO1AKqomo97JNUMHoUaXD35Mwc2FyHyy4Ejb0ka
         YK0g==
X-Gm-Message-State: AGi0PuaJkY9COxgHEu4TWTWtxVtX82znh0eAdEYLRnu2VdwPIS6XGyCI
        w71HONIg3TqChAhd/H9YIWO/Jgg+9mo=
X-Google-Smtp-Source: APiQypIJNOO8YJEI7BNw0JN3qw8rLrunwEmjm96JzBElbzkUg1xwxiYQJ9ASYz+jlmn+SNIXFSaL8Q==
X-Received: by 2002:a2e:8290:: with SMTP id y16mr5448911ljg.186.1585519597736;
        Sun, 29 Mar 2020 15:06:37 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 22sm6006762ljq.69.2020.03.29.15.06.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 15:06:35 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id q19so15933003ljp.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 15:06:35 -0700 (PDT)
X-Received: by 2002:a05:651c:50e:: with SMTP id o14mr5288434ljp.241.1585519595292;
 Sun, 29 Mar 2020 15:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200323183620.GD23230@ZenIV.linux.org.uk> <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200328104857.GA93574@gmail.com> <20200328115936.GA23230@ZenIV.linux.org.uk>
 <20200329092602.GB93574@gmail.com> <CALCETrX=nXN14fqu-yEMGwwN-vdSz=-0C3gcOMucmxrCUpevdA@mail.gmail.com>
 <489c9af889954649b3453e350bab6464@AcuMS.aculab.com> <CAHk-=whDAxb+83gYCv4=-armoqXQXgzshaVCCe9dNXZb9G_CxQ@mail.gmail.com>
 <9352bc55302d4589aaf2461c7b85fb6b@AcuMS.aculab.com> <CAHk-=wjEf+0sBkPFKWpYZK_ygS9=ig3KTZkDe5jkDj+v8i7B+w@mail.gmail.com>
 <CALCETrXWKE8RMX-mZ=p5T19sfS8Rn+1b_EtJz4TXbmf57_aY5g@mail.gmail.com>
In-Reply-To: <CALCETrXWKE8RMX-mZ=p5T19sfS8Rn+1b_EtJz4TXbmf57_aY5g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Mar 2020 15:06:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi74U0VLhHLBUqRPrPgercnAdt_8cJ_vjwcTeMzEwocnw@mail.gmail.com>
Message-ID: <CAHk-=wi74U0VLhHLBUqRPrPgercnAdt_8cJ_vjwcTeMzEwocnw@mail.gmail.com>
Subject: Re: [RFC][PATCH 01/22] x86 user stack frame reads: switch to explicit __get_user()
To:     Andy Lutomirski <luto@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: multipart/mixed; boundary="00000000000043f50705a2058c9c"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000043f50705a2058c9c
Content-Type: text/plain; charset="UTF-8"

On Sun, Mar 29, 2020 at 2:22 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Sun, Mar 29, 2020 at 11:16 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > But that magical asm-goto-with-outputs patch probably won't land
> > upstream for a couple of years.
>
> I'm not that familiar with gcc politics, but what's the delay?

No, I mean that _my_ magical patch for the kernel won't land upstream,
simply because even if both gcc and clang supported it today, nobody
would effectively have those compilers for a couple of years..

> ISTM
> having an actual upstream Linux asm-goto-with-outputs that works on
> clang might help light a fire under some butts and/or convince someone
> to pay a gcc developer to implement it on gcc.

Yes, but even for clang, it needs a version that isn't even released yet.

And right now my patch is unconditional. It started out that way
because the whole x86 uaccess.h files were such a mess, and I couldn't
be bothered to fix all the small cases to then have *two* cases (one
for asm goto with outputs, one without).

These days my patch is much simpler (thanks to Al's simplifications),
and I think making it handle both cases would likely not be too
painful.

And in that case I might just commit it, even if effectively nobody
has the clang version installed to make use of it.

Anyway, just in case people want to see it, I'm attaching my current
unconditional patch.

Note that it requires Al's uaccess cleanups, but I do want to point
out how it actually makes for simpler code:

 arch/x86/include/asm/uaccess.h | 72 +++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 40 deletions(-)

and not only does it delete more lines than it adds, the lines it adds
are shorter and simpler than the ones it deletes.

But that "deletes more lines than it adds" is only because it doesn't
even try to build without that "asm goto with outputs" support..

            Linus

--00000000000043f50705a2058c9c
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k8dld53k0>
X-Attachment-Id: f_k8dld53k0

CiAgICBVc2UgImFzbSBnb3RvIiB3aXRoIG91dHB1dHMgZm9yIGNsYW5nIHRlc3RpbmcKLS0tCiBh
cmNoL3g4Ni9pbmNsdWRlL2FzbS91YWNjZXNzLmggfCA3MiArKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCA0
MCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS91YWNjZXNz
LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS91YWNjZXNzLmgKaW5kZXggYzgyNDdhODQyNDRiLi45
ZThiMDRkNDU2MGEgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaAor
KysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS91YWNjZXNzLmgKQEAgLTI3OSw2NSArMjc5LDUyIEBA
IGRvIHsJCQkJCQkJCQlcCiB9IHdoaWxlICgwKQogCiAjaWZkZWYgQ09ORklHX1g4Nl8zMgotI2Rl
ZmluZSBfX2dldF91c2VyX2FzbV91NjQoeCwgcHRyLCByZXR2YWwsIGVycnJldCkJCQlcCisjZGVm
aW5lIF9fZ2V0X3VzZXJfYXNtX3U2NCh4LCBwdHIsIGxhYmVsKQkJCQlcCiAoewkJCQkJCQkJCVwK
IAlfX3R5cGVvZl9fKHB0cikgX19wdHIgPSAocHRyKTsJCQkJCVwKLQlhc20gdm9sYXRpbGUoIlxu
IgkJCQkJXAotCQkgICAgICIxOgltb3ZsICUyLCUlZWF4XG4iCQkJXAotCQkgICAgICIyOgltb3Zs
ICUzLCUlZWR4XG4iCQkJXAotCQkgICAgICIzOlxuIgkJCQlcCi0JCSAgICAgIi5zZWN0aW9uIC5m
aXh1cCxcImF4XCJcbiIJCQkJXAotCQkgICAgICI0Ogltb3YgJTQsJTBcbiIJCQkJXAotCQkgICAg
ICIJeG9ybCAlJWVheCwlJWVheFxuIgkJCQlcCi0JCSAgICAgIgl4b3JsICUlZWR4LCUlZWR4XG4i
CQkJCVwKLQkJICAgICAiCWptcCAzYlxuIgkJCQkJXAotCQkgICAgICIucHJldmlvdXNcbiIJCQkJ
CVwKLQkJICAgICBfQVNNX0VYVEFCTEVfVUEoMWIsIDRiKQkJCQlcCi0JCSAgICAgX0FTTV9FWFRB
QkxFX1VBKDJiLCA0YikJCQkJXAotCQkgICAgIDogIj1yIiAocmV0dmFsKSwgIj0mQSIoeCkJCQkJ
XAotCQkgICAgIDogIm0iIChfX20oX19wdHIpKSwgIm0iIF9fbSgoKHUzMiBfX3VzZXIgKikoX19w
dHIpKSArIDEpLAlcCi0JCSAgICAgICAiaSIgKGVycnJldCksICIwIiAocmV0dmFsKSk7CQkJXAor
CWFzbV92b2xhdGlsZV9nb3RvKCJcbiIJCQkJCQlcCisJCSAgICAgIjE6CW1vdmwgJTEsJSVlYXhc
biIJCQlcCisJCSAgICAgIjI6CW1vdmwgJTIsJSVlZHhcbiIJCQlcCisJCSAgICAgX0FTTV9FWFRB
QkxFX1VBKDFiLCAlbDMpCQkJCVwKKwkJICAgICBfQVNNX0VYVEFCTEVfVUEoMmIsICVsMykJCQkJ
XAorCQkgICAgIDogIj0mQSIoeCkJCQkJCQlcCisJCSAgICAgOiAibSIgKF9fbShfX3B0cikpLCAi
bSIgX19tKCgodTMyIF9fdXNlciAqKShfX3B0cikpICsgMSkJXAorCQkgICAgIDogOiBsYWJlbCk7
CQkJCQlcCiB9KQogCiAjZWxzZQotI2RlZmluZSBfX2dldF91c2VyX2FzbV91NjQoeCwgcHRyLCBy
ZXR2YWwsIGVycnJldCkgXAotCSBfX2dldF91c2VyX2FzbSh4LCBwdHIsIHJldHZhbCwgInEiLCAi
IiwgIj1yIiwgZXJycmV0KQorI2RlZmluZSBfX2dldF91c2VyX2FzbV91NjQoeCwgcHRyLCBsYWJl
bCkgXAorCSBfX2dldF91c2VyX2FzbSh4LCBwdHIsICJxIiwgIiIsICI9ciIsIGxhYmVsKQogI2Vu
ZGlmCiAKLSNkZWZpbmUgX19nZXRfdXNlcl9zaXplKHgsIHB0ciwgc2l6ZSwgcmV0dmFsLCBlcnJy
ZXQpCQkJXAorI2RlZmluZSBfX2dldF91c2VyX3NpemUoeCwgcHRyLCBzaXplLCBsYWJlbCkJCQkJ
XAogZG8gewkJCQkJCQkJCVwKLQlyZXR2YWwgPSAwOwkJCQkJCQlcCiAJX19jaGtfdXNlcl9wdHIo
cHRyKTsJCQkJCQlcCiAJc3dpdGNoIChzaXplKSB7CQkJCQkJCVwKIAljYXNlIDE6CQkJCQkJCQlc
Ci0JCV9fZ2V0X3VzZXJfYXNtKHgsIHB0ciwgcmV0dmFsLCAiYiIsICJiIiwgIj1xIiwgZXJycmV0
KTsJXAorCQlfX2dldF91c2VyX2FzbSh4LCBwdHIsICJiIiwgImIiLCAiPXEiLCBsYWJlbCk7CQlc
CiAJCWJyZWFrOwkJCQkJCQlcCiAJY2FzZSAyOgkJCQkJCQkJXAotCQlfX2dldF91c2VyX2FzbSh4
LCBwdHIsIHJldHZhbCwgInciLCAidyIsICI9ciIsIGVycnJldCk7CVwKKwkJX19nZXRfdXNlcl9h
c20oeCwgcHRyLCAidyIsICJ3IiwgIj1yIiwgbGFiZWwpOwkJXAogCQlicmVhazsJCQkJCQkJXAog
CWNhc2UgNDoJCQkJCQkJCVwKLQkJX19nZXRfdXNlcl9hc20oeCwgcHRyLCByZXR2YWwsICJsIiwg
ImsiLCAiPXIiLCBlcnJyZXQpOwlcCisJCV9fZ2V0X3VzZXJfYXNtKHgsIHB0ciwgImwiLCAiayIs
ICI9ciIsIGxhYmVsKTsJCVwKIAkJYnJlYWs7CQkJCQkJCVwKIAljYXNlIDg6CQkJCQkJCQlcCi0J
CV9fZ2V0X3VzZXJfYXNtX3U2NCh4LCBwdHIsIHJldHZhbCwgZXJycmV0KTsJCVwKKwkJX19nZXRf
dXNlcl9hc21fdTY0KHgsIHB0ciwgbGFiZWwpOwkJCVwKIAkJYnJlYWs7CQkJCQkJCVwKIAlkZWZh
dWx0OgkJCQkJCQlcCiAJCSh4KSA9IF9fZ2V0X3VzZXJfYmFkKCk7CQkJCQlcCiAJfQkJCQkJCQkJ
XAogfSB3aGlsZSAoMCkKIAotI2RlZmluZSBfX2dldF91c2VyX2FzbSh4LCBhZGRyLCBlcnIsIGl0
eXBlLCBydHlwZSwgbHR5cGUsIGVycnJldCkJXAotCWFzbSB2b2xhdGlsZSgiXG4iCQkJCQkJXAot
CQkgICAgICIxOgltb3YiaXR5cGUiICUyLCUicnR5cGUiMVxuIgkJXAotCQkgICAgICIyOlxuIgkJ
CQkJCVwKLQkJICAgICAiLnNlY3Rpb24gLmZpeHVwLFwiYXhcIlxuIgkJCQlcCi0JCSAgICAgIjM6
CW1vdiAlMywlMFxuIgkJCQlcCi0JCSAgICAgIgl4b3IiaXR5cGUiICUicnR5cGUiMSwlInJ0eXBl
IjFcbiIJCVwKLQkJICAgICAiCWptcCAyYlxuIgkJCQkJXAotCQkgICAgICIucHJldmlvdXNcbiIJ
CQkJCVwKLQkJICAgICBfQVNNX0VYVEFCTEVfVUEoMWIsIDNiKQkJCQlcCi0JCSAgICAgOiAiPXIi
IChlcnIpLCBsdHlwZSh4KQkJCQlcCi0JCSAgICAgOiAibSIgKF9fbShhZGRyKSksICJpIiAoZXJy
cmV0KSwgIjAiIChlcnIpKQorI2RlZmluZSBfX2dldF91c2VyX2FzbSh4LCBhZGRyLCBpdHlwZSwg
cnR5cGUsIGx0eXBlLCBsYWJlbCkJCVwKKwlhc21fdm9sYXRpbGVfZ290bygiXG4iCQkJCQkJXAor
CQkgICAgICIxOgltb3YiaXR5cGUiICUxLCUicnR5cGUiMFxuIgkJXAorCQkgICAgIF9BU01fRVhU
QUJMRV9VQSgxYiwgJWwyKQkJCQlcCisJCSAgICAgOiBsdHlwZSh4KQkJCQkJCVwKKwkJICAgICA6
ICJtIiAoX19tKGFkZHIpKQkJCQkJXAorCQkgICAgIDogOiBsYWJlbCkKIAogI2RlZmluZSBfX3B1
dF91c2VyX25vY2hlY2soeCwgcHRyLCBzaXplKQkJCVwKICh7CQkJCQkJCQlcCkBAIC0zNTYsMTQg
KzM0MywyMSBAQCBfX3B1X2xhYmVsOgkJCQkJCQlcCiAKICNkZWZpbmUgX19nZXRfdXNlcl9ub2No
ZWNrKHgsIHB0ciwgc2l6ZSkJCQkJXAogKHsJCQkJCQkJCQlcCisJX19sYWJlbF9fIF9fZ3VfbGFi
ZWw7CQkJCQkJXAogCWludCBfX2d1X2VycjsJCQkJCQkJXAogCV9faW50dHlwZSgqKHB0cikpIF9f
Z3VfdmFsOwkJCQkJXAogCV9fdHlwZW9mX18ocHRyKSBfX2d1X3B0ciA9IChwdHIpOwkJCQlcCiAJ
X190eXBlb2ZfXyhzaXplKSBfX2d1X3NpemUgPSAoc2l6ZSk7CQkJCVwKIAlfX3VhY2Nlc3NfYmVn
aW5fbm9zcGVjKCk7CQkJCQlcCi0JX19nZXRfdXNlcl9zaXplKF9fZ3VfdmFsLCBfX2d1X3B0ciwg
X19ndV9zaXplLCBfX2d1X2VyciwgLUVGQVVMVCk7CVwKKwlfX2dldF91c2VyX3NpemUoX19ndV92
YWwsIF9fZ3VfcHRyLCBfX2d1X3NpemUsIF9fZ3VfbGFiZWwpOwlcCiAJX191YWNjZXNzX2VuZCgp
OwkJCQkJCVwKIAkoeCkgPSAoX19mb3JjZSBfX3R5cGVvZl9fKCoocHRyKSkpX19ndV92YWw7CQkJ
XAorCV9fZ3VfZXJyID0gMDsJCQkJCQkJXAorCWlmICgwKSB7CQkJCQkJCVwKK19fZ3VfbGFiZWw6
CQkJCQkJCQlcCisJCV9fdWFjY2Vzc19lbmQoKTsJCQkJCVwKKwkJX19ndV9lcnIgPSAtRUZBVUxU
OwkJCQkJXAorCX0JCQkJCQkJCVwKIAlfX2J1aWx0aW5fZXhwZWN0KF9fZ3VfZXJyLCAwKTsJCQkJ
CVwKIH0pCiAKQEAgLTQ5NCwxMSArNDg4LDkgQEAgc3RhdGljIF9fbXVzdF9jaGVjayBfX2Fsd2F5
c19pbmxpbmUgYm9vbCB1c2VyX2FjY2Vzc19iZWdpbihjb25zdCB2b2lkIF9fdXNlciAqcHQKIAog
I2RlZmluZSB1bnNhZmVfZ2V0X3VzZXIoeCwgcHRyLCBlcnJfbGFiZWwpCQkJCQlcCiBkbyB7CQkJ
CQkJCQkJCVwKLQlpbnQgX19ndV9lcnI7CQkJCQkJCQlcCiAJX19pbnR0eXBlKCoocHRyKSkgX19n
dV92YWw7CQkJCQkJXAotCV9fZ2V0X3VzZXJfc2l6ZShfX2d1X3ZhbCwgKHB0ciksIHNpemVvZigq
KHB0cikpLCBfX2d1X2VyciwgLUVGQVVMVCk7CVwKKwlfX2dldF91c2VyX3NpemUoX19ndV92YWws
IChwdHIpLCBzaXplb2YoKihwdHIpKSwgZXJyX2xhYmVsKTsJCVwKIAkoeCkgPSAoX19mb3JjZSBf
X3R5cGVvZl9fKCoocHRyKSkpX19ndV92YWw7CQkJCVwKLQlpZiAodW5saWtlbHkoX19ndV9lcnIp
KSBnb3RvIGVycl9sYWJlbDsJCQkJCVwKIH0gd2hpbGUgKDApCiAKIC8qCg==
--00000000000043f50705a2058c9c--
