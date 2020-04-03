Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0FBC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7D72082F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EIfxa4Ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389188AbgDCLi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 07:38:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42438 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgDCLi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:38:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id cw6so8856004edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 04:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RpRtMwCbwxDI+qo+/oqeZAlCVAaxxhCpiQv9eibzNMc=;
        b=EIfxa4UxvoyMf6tqDArb/xS4ilQh+kOB2skcCK6Dzrg4ZyA/Tv2iU7k1wFbhTjLnVF
         rJ399tTN/c2J/RKLujyTC6CHnXz0STybq0DPGRTVeEpTizV+Wg0rsNsaEtJiY25Ffi44
         VG6NDqGNE+TsM4HeUPlxJWLBIrDC01SHdbUi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RpRtMwCbwxDI+qo+/oqeZAlCVAaxxhCpiQv9eibzNMc=;
        b=jdAVbYK7f9XW7NdqRlMfSyudPbQUYeqI0FFqt1vRe54PgwOwuyjixskhKWbLYBISFc
         nI4yl0Y56dInM3dMOWRezJR93QW3cIu2HnKMHyD1+fY8dXk2FLy2cP8mTRsmDFmD7S0L
         AKsvj6uGwWNKGbAgnEZIzr2mZ2TD5ZF1Hjf3WsjE5g1zLGt1m4CmxBLoGUF5xvqxnWWD
         6pkKXgAjC7OkvhScT+EVQb/+o8uu+EZ8DwYsQXLvf4/H/CoYMqNwZ3MFrvESJoTIoA7l
         hwFpS0OBPqGq/0+L86SaSjIzGmiSWq37ZYyLvbJwL9wE/Q7S0DT/X4Y/DRH/026MqTsi
         ddTg==
X-Gm-Message-State: AGi0PuYkGC3CXmEN9Gze75esdU0tTstb+dX9FXaq13QKNChyjFaRBmzo
        JZXOf0aLc5vEP+KwKehS82Y8C3tLFHsK0o/WsvxUDA==
X-Google-Smtp-Source: APiQypInp9onjVrzrdeqop63QaB3oXI53ySCB6mpalPlOF6Bwj08Y5bWK16JqM1SDQ1JL/4XLPam0X9W4ZtW9WDM6vQ=
X-Received: by 2002:a17:906:fd7:: with SMTP id c23mr8078187ejk.312.1585913905026;
 Fri, 03 Apr 2020 04:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk> <20200401144109.GA29945@gardel-login>
 <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
 <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net> <20200403111144.GB34663@gardel-login>
In-Reply-To: <20200403111144.GB34663@gardel-login>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 3 Apr 2020 13:38:13 +0200
Message-ID: <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Content-Type: multipart/mixed; boundary="000000000000f44c3b05a2615a67"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f44c3b05a2615a67
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 3, 2020 at 1:11 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> On Fr, 03.04.20 09:44, Ian Kent (raven@themaw.net) wrote:
>
> > > Currently the only way to find the mount id from a path is by parsing
> > > /proc/self/fdinfo/$fd.  It is trivial, however, to extend statx(2) to
> > > return it directly from a path.   Also the mount notification queue
> > > that David implemented contains the mount ID of the changed mount.
>
> I would love to have the mount ID exposed via statx().

Here's a patch.

Thanks,
Miklos

--000000000000f44c3b05a2615a67
Content-Type: text/x-patch; charset="US-ASCII"; name="statx-add-mount-id.patch"
Content-Disposition: attachment; filename="statx-add-mount-id.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k8k45tnj0>
X-Attachment-Id: f_k8k45tnj0

RnJvbTogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+ClN1YmplY3Q6IHN0YXR4
OiBhZGQgbW91bnQgSUQKClN5c3RlbWQgaXMgaGFja2luZyBhcm91bmQgdG8gZ2V0IGl0IGFuZCBp
dCdzIHRyaXZpYWwgdG8gYWRkIHRvIHN0YXR4LCBzby4uLgoKU2lnbmVkLW9mZi1ieTogTWlrbG9z
IFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+Ci0tLQogZnMvc3RhdC5jICAgICAgICAgICAg
ICAgICB8ICAgIDYgKysrKysrCiBpbmNsdWRlL2xpbnV4L3N0YXQuaCAgICAgIHwgICAgMSArCiBp
bmNsdWRlL3VhcGkvbGludXgvc3RhdC5oIHwgICAgNiArKysrKy0KIDMgZmlsZXMgY2hhbmdlZCwg
MTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKLS0tIGEvZnMvc3RhdC5jCisrKyBiL2Zz
L3N0YXQuYwpAQCAtMjIsNiArMjIsNyBAQAogI2luY2x1ZGUgPGFzbS91bmlzdGQuaD4KIAogI2lu
Y2x1ZGUgImludGVybmFsLmgiCisjaW5jbHVkZSAibW91bnQuaCIKIAogLyoqCiAgKiBnZW5lcmlj
X2ZpbGxhdHRyIC0gRmlsbCBpbiB0aGUgYmFzaWMgYXR0cmlidXRlcyBmcm9tIHRoZSBpbm9kZSBz
dHJ1Y3QKQEAgLTE5OSw2ICsyMDAsMTAgQEAgaW50IHZmc19zdGF0eChpbnQgZGZkLCBjb25zdCBj
aGFyIF9fdXNlcgogCQlnb3RvIG91dDsKIAogCWVycm9yID0gdmZzX2dldGF0dHIoJnBhdGgsIHN0
YXQsIHJlcXVlc3RfbWFzaywgZmxhZ3MpOworCWlmICghZXJyb3IpIHsKKwkJc3RhdC0+bW50X2lk
ID0gcmVhbF9tb3VudChwYXRoLm1udCktPm1udF9pZDsKKwkJc3RhdC0+cmVzdWx0X21hc2sgfD0g
U1RBVFhfTU5UX0lEOworCX0KIAlwYXRoX3B1dCgmcGF0aCk7CiAJaWYgKHJldHJ5X2VzdGFsZShl
cnJvciwgbG9va3VwX2ZsYWdzKSkgewogCQlsb29rdXBfZmxhZ3MgfD0gTE9PS1VQX1JFVkFMOwpA
QCAtNTYzLDYgKzU2OCw3IEBAIGNwX3N0YXR4KGNvbnN0IHN0cnVjdCBrc3RhdCAqc3RhdCwgc3Ry
dWMKIAl0bXAuc3R4X3JkZXZfbWlub3IgPSBNSU5PUihzdGF0LT5yZGV2KTsKIAl0bXAuc3R4X2Rl
dl9tYWpvciA9IE1BSk9SKHN0YXQtPmRldik7CiAJdG1wLnN0eF9kZXZfbWlub3IgPSBNSU5PUihz
dGF0LT5kZXYpOworCXRtcC5zdHhfbW50X2lkID0gc3RhdC0+bW50X2lkOwogCiAJcmV0dXJuIGNv
cHlfdG9fdXNlcihidWZmZXIsICZ0bXAsIHNpemVvZih0bXApKSA/IC1FRkFVTFQgOiAwOwogfQot
LS0gYS9pbmNsdWRlL2xpbnV4L3N0YXQuaAorKysgYi9pbmNsdWRlL2xpbnV4L3N0YXQuaApAQCAt
NDcsNiArNDcsNyBAQCBzdHJ1Y3Qga3N0YXQgewogCXN0cnVjdCB0aW1lc3BlYzY0IGN0aW1lOwog
CXN0cnVjdCB0aW1lc3BlYzY0IGJ0aW1lOwkJCS8qIEZpbGUgY3JlYXRpb24gdGltZSAqLwogCXU2
NAkJYmxvY2tzOworCXU2NAkJbW50X2lkOwogfTsKIAogI2VuZGlmCi0tLSBhL2luY2x1ZGUvdWFw
aS9saW51eC9zdGF0LmgKKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3N0YXQuaApAQCAtMTIzLDcg
KzEyMywxMCBAQCBzdHJ1Y3Qgc3RhdHggewogCV9fdTMyCXN0eF9kZXZfbWFqb3I7CS8qIElEIG9m
IGRldmljZSBjb250YWluaW5nIGZpbGUgW3VuY29uZF0gKi8KIAlfX3UzMglzdHhfZGV2X21pbm9y
OwogCS8qIDB4OTAgKi8KLQlfX3U2NAlfX3NwYXJlMlsxNF07CS8qIFNwYXJlIHNwYWNlIGZvciBm
dXR1cmUgZXhwYW5zaW9uICovCisJX191NjQJc3R4X21udF9pZDsKKwlfX3U2NAlfX3NwYXJlMjsK
KwkvKiAweGEwICovCisJX191NjQJX19zcGFyZTNbMTJdOwkvKiBTcGFyZSBzcGFjZSBmb3IgZnV0
dXJlIGV4cGFuc2lvbiAqLwogCS8qIDB4MTAwICovCiB9OwogCkBAIC0xNDgsNiArMTUxLDcgQEAg
c3RydWN0IHN0YXR4IHsKICNkZWZpbmUgU1RBVFhfQkxPQ0tTCQkweDAwMDAwNDAwVQkvKiBXYW50
L2dvdCBzdHhfYmxvY2tzICovCiAjZGVmaW5lIFNUQVRYX0JBU0lDX1NUQVRTCTB4MDAwMDA3ZmZV
CS8qIFRoZSBzdHVmZiBpbiB0aGUgbm9ybWFsIHN0YXQgc3RydWN0ICovCiAjZGVmaW5lIFNUQVRY
X0JUSU1FCQkweDAwMDAwODAwVQkvKiBXYW50L2dvdCBzdHhfYnRpbWUgKi8KKyNkZWZpbmUgU1RB
VFhfTU5UX0lECQkweDAwMDAxMDAwVQkvKiBHb3Qgc3R4X21udF9pZCAqLwogI2RlZmluZSBTVEFU
WF9BTEwJCTB4MDAwMDBmZmZVCS8qIEFsbCBjdXJyZW50bHkgc3VwcG9ydGVkIGZsYWdzICovCiAj
ZGVmaW5lIFNUQVRYX19SRVNFUlZFRAkJMHg4MDAwMDAwMFUJLyogUmVzZXJ2ZWQgZm9yIGZ1dHVy
ZSBzdHJ1Y3Qgc3RhdHggZXhwYW5zaW9uICovCiAK
--000000000000f44c3b05a2615a67--
