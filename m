Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311D3C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0546321734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ePjMJlmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgBLTgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:36:25 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46473 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgBLTgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:36:24 -0500
Received: by mail-io1-f65.google.com with SMTP id t26so3573758ioi.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 11:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vF1+0mkMgv8uSLD957ciD+xbLUTmrDocYchiyPnPgNU=;
        b=ePjMJlmXLyMBcXnZ28rY125HFwKX+Pm+u/efCw6+INu7Fhr1tRJKQ3tXeVUfTKgLYG
         0MNwpgTv3MD298wlCWvtfUVsX53BkIl2bd0zf1klXjZ/yRvEuxdP/1UZwunqrIyDZxGN
         cePKLqgqSYBFyvqn5+b9xk5VQhOs3s4B+qwtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vF1+0mkMgv8uSLD957ciD+xbLUTmrDocYchiyPnPgNU=;
        b=GphSfCoTIeUE1NElCE7B3KZWJBjEi12jSSsR8ZLr6IjMqeJgpaAFzLvJ+KJtcZbU/N
         pFlVVPECwRBJgDUhScMxO0sJSxou0akEFjIvbZsy2qgmMlOY4zHbxq3UPZw/7KyEz9AI
         rh77uUsR+UKPs/bk70/9HnCg0otoVSZuXXQ384N7K4l1mKBmZZ3juUrQ2q6LrZCNxDkA
         UEG1Yx34CLBeAxocifUh21ldt5euW9nh1W47Dt0uxnrggiSx71zDkcG2UsrOR53NPEQm
         iaMdRxDC/jAjxX0X5GcnDHS/R/c0jnGBADUlvAgxOtC2zUZXYrF8bW9qctdT6jrmOrBA
         s8IQ==
X-Gm-Message-State: APjAAAVkRG2axchtF/3aiOOUT80HsMs3W/o348IknCsvfRgNziRgJOs1
        cNtVDemrnfnLx2TmbyfBX/YyReCs3iSFdj++wrJjeg==
X-Google-Smtp-Source: APXvYqwRL2ezbTTfjQSwKBrSzOKn7qAHxMEVdnF4j6X9JlRuKJ4AycIW61MIPbPuxiAA0CvANYfQV/W7cZvj6tf5kbA=
X-Received: by 2002:a6b:6f07:: with SMTP id k7mr19169764ioc.174.1581536183066;
 Wed, 12 Feb 2020 11:36:23 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegtUAHPL9tsFB85ZqjAfy0xwz7ATRcCtLbzFBo8=WnCvLw@mail.gmail.com>
 <20200209080918.1562823-1-michael+lkml@stapelberg.ch> <CAJfpegv4iL=bW3TXP3F9w1z6-LUox8KiBmw7UBcWE-0jiK0YsA@mail.gmail.com>
 <CANnVG6kYh6M30mwBHcGeFf=fhqKmWKPeUj2GYbvNgtq0hm=gXQ@mail.gmail.com>
 <CAJfpegtX0Z3_OZFG50epWGHkW5aOMfYmn61WmqYC67aBmJyDMA@mail.gmail.com> <CANnVG6=s1C7LSDGD1-Ato-sfaKi1LQvW3GM5wfAiUqWXibEohw@mail.gmail.com>
In-Reply-To: <CANnVG6=s1C7LSDGD1-Ato-sfaKi1LQvW3GM5wfAiUqWXibEohw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Feb 2020 20:36:11 +0100
Message-ID: <CAJfpegvBguKcNZk-p7sAtSuNH_7HfdCyYvo8Wh7X6P=hT=kPrA@mail.gmail.com>
Subject: Re: Still a pretty bad time on 5.4.6 with fuse_request_end.
To:     Michael Stapelberg <michael+lkml@stapelberg.ch>
Cc:     fuse-devel <fuse-devel@lists.sourceforge.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000645669059e661691"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000645669059e661691
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2020 at 10:38 AM Michael Stapelberg
<michael+lkml@stapelberg.ch> wrote:
>
> Unfortunately not: when I change the code like so:
>
>     bool async;
>     uint32_t opcode_early =3D req->args->opcode;
>
>     if (test_and_set_bit(FR_FINISHED, &req->flags))
>         goto put_request;
>
>     async =3D req->args->end;
>
> =E2=80=A6gdb only reports:
>
> (gdb) bt
> #0  0x000000a700000001 in ?? ()
> #1  0xffffffff8137fc99 in fuse_copy_finish (cs=3D0x20000ffffffff) at
> fs/fuse/dev.c:681
> Backtrace stopped: previous frame inner to this frame (corrupt stack?)
>
> But maybe that=E2=80=99s a hint in and of itself?

Yep, it's a stack use after return bug.   Attached patch should fix
it, though I haven't tested it.

Thanks,
Miklos

--000000000000645669059e661691
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-fix-stack-use-after-return.patch"
Content-Disposition: attachment; 
	filename="fuse-fix-stack-use-after-return.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k6jps1gs0>
X-Attachment-Id: f_k6jps1gs0

LS0tCiBmcy9mdXNlL2Rldi5jICAgIHwgICAgNiArKystLS0KIGZzL2Z1c2UvZnVzZV9pLmggfCAg
ICAyICsrCiAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkK
Ci0tLSBhL2ZzL2Z1c2UvZGV2LmMKKysrIGIvZnMvZnVzZS9kZXYuYwpAQCAtMjc2LDEyICsyNzYs
MTAgQEAgc3RhdGljIHZvaWQgZmx1c2hfYmdfcXVldWUoc3RydWN0IGZ1c2VfYwogdm9pZCBmdXNl
X3JlcXVlc3RfZW5kKHN0cnVjdCBmdXNlX2Nvbm4gKmZjLCBzdHJ1Y3QgZnVzZV9yZXEgKnJlcSkK
IHsKIAlzdHJ1Y3QgZnVzZV9pcXVldWUgKmZpcSA9ICZmYy0+aXE7Ci0JYm9vbCBhc3luYzsKIAog
CWlmICh0ZXN0X2FuZF9zZXRfYml0KEZSX0ZJTklTSEVELCAmcmVxLT5mbGFncykpCiAJCWdvdG8g
cHV0X3JlcXVlc3Q7CiAKLQlhc3luYyA9IHJlcS0+YXJncy0+ZW5kOwogCS8qCiAJICogdGVzdF9h
bmRfc2V0X2JpdCgpIGltcGxpZXMgc21wX21iKCkgYmV0d2VlbiBiaXQKIAkgKiBjaGFuZ2luZyBh
bmQgYmVsb3cgaW50cl9lbnRyeSBjaGVjay4gUGFpcnMgd2l0aApAQCAtMzI0LDcgKzMyMiw3IEBA
IHZvaWQgZnVzZV9yZXF1ZXN0X2VuZChzdHJ1Y3QgZnVzZV9jb25uICoKIAkJd2FrZV91cCgmcmVx
LT53YWl0cSk7CiAJfQogCi0JaWYgKGFzeW5jKQorCWlmICh0ZXN0X2JpdChGUl9BU1lOQywgJnJl
cS0+ZmxhZ3MpKQogCQlyZXEtPmFyZ3MtPmVuZChmYywgcmVxLT5hcmdzLCByZXEtPm91dC5oLmVy
cm9yKTsKIHB1dF9yZXF1ZXN0OgogCWZ1c2VfcHV0X3JlcXVlc3QoZmMsIHJlcSk7CkBAIC00NzEs
NiArNDY5LDggQEAgc3RhdGljIHZvaWQgZnVzZV9hcmdzX3RvX3JlcShzdHJ1Y3QgZnVzZQogCXJl
cS0+aW4uaC5vcGNvZGUgPSBhcmdzLT5vcGNvZGU7CiAJcmVxLT5pbi5oLm5vZGVpZCA9IGFyZ3Mt
Pm5vZGVpZDsKIAlyZXEtPmFyZ3MgPSBhcmdzOworCWlmIChhcmdzLT5lbmQpCisJCXNldF9iaXQo
RlJfQVNZTkMsICZyZXEtPmZsYWdzKTsKIH0KIAogc3NpemVfdCBmdXNlX3NpbXBsZV9yZXF1ZXN0
KHN0cnVjdCBmdXNlX2Nvbm4gKmZjLCBzdHJ1Y3QgZnVzZV9hcmdzICphcmdzKQotLS0gYS9mcy9m
dXNlL2Z1c2VfaS5oCisrKyBiL2ZzL2Z1c2UvZnVzZV9pLmgKQEAgLTMwMSw2ICszMDEsNyBAQCBz
dHJ1Y3QgZnVzZV9pb19wcml2IHsKICAqIEZSX1NFTlQ6CQlyZXF1ZXN0IGlzIGluIHVzZXJzcGFj
ZSwgd2FpdGluZyBmb3IgYW4gYW5zd2VyCiAgKiBGUl9GSU5JU0hFRDoJCXJlcXVlc3QgaXMgZmlu
aXNoZWQKICAqIEZSX1BSSVZBVEU6CQlyZXF1ZXN0IGlzIG9uIHByaXZhdGUgbGlzdAorICogRlJf
QVNZTkM6CQlyZXF1ZXN0IGlzIGFzeW5jaHJvbm91cwogICovCiBlbnVtIGZ1c2VfcmVxX2ZsYWcg
ewogCUZSX0lTUkVQTFksCkBAIC0zMTQsNiArMzE1LDcgQEAgZW51bSBmdXNlX3JlcV9mbGFnIHsK
IAlGUl9TRU5ULAogCUZSX0ZJTklTSEVELAogCUZSX1BSSVZBVEUsCisJRlJfQVNZTkMsCiB9Owog
CiAvKioK
--000000000000645669059e661691--
