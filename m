Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D7AC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8580C2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=stapelberg-ch.20150623.gappssmtp.com header.i=@stapelberg-ch.20150623.gappssmtp.com header.b="m8G5HZMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgBXN33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:29:29 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35499 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgBXN33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:29:29 -0500
Received: by mail-oi1-f196.google.com with SMTP id b18so8918862oie.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 05:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=nXap8ruoJmQKUv4CaZGUjHx6jvvxzBsJg2NNbHNKxQI=;
        b=m8G5HZMbWY4YSd5U1wyMqaxMB37vSbxOyTgmaGDnw+WSPp5PJwEfDTILdQUV8cE6L0
         yNgQ67/h331ehCJAkg5aTWAZnfuX9O4q34SXM+X7/SYEPbYqW34E4KZm2Tkgn3RE3kHz
         510tyHVzQkWBywV5eGhZgkLPkbXSHtV+GGAw7dC61fLBO9B9KedNbgts455XIJYwKScT
         9UoEI1//fRO56ZtkCiL3s1+9duXMATRA0rhVL9kR0SLpHMQWvkSVSgepPBFJjDb3yWz7
         kyO/W4jsxukxctF9aJM8WYUNv7cZ0J9AtS4Od2+Y3hQOzKOdV8oLtn+CgFEVcaDD6Xgz
         8h4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nXap8ruoJmQKUv4CaZGUjHx6jvvxzBsJg2NNbHNKxQI=;
        b=eG3wDt6Fgp59t01ZnzEinbn7k0SVhc6AWycFCCWXj5GepmWeIZMmn81KCnXZ06qb6l
         BtBwYFZlgaTVZwET6S/4rm47fCcglGn3RPelZ7jA2TvMvIyv0Y7hskatYd6nFVpnDRg/
         v6MPvmJz0wMOCtgFL11yQRGGNV3Jvl22fIM7CnwjKnWLkmYJ4HZSMzTPP94WbXjFlC1Q
         3n5SYi+MYwtPcCZ8sOt/nhD1lXYM7c4y7ATgaG8FO2nXQvYhVUeLngKNJSlw2s54fM8f
         0BcOh23aVVwNHF1HwrBf1XqDimF+FtdMZx/TVK+DbjOh+agio6wKOIe4Dv9UbNhjjx57
         Eamg==
X-Gm-Message-State: APjAAAViH2tl/m3IJfqpmsfD+qPsETBZPJVHmGWTKf6W+ujkEBNUcCuY
        Ao03z1PQRl9PRSzTCWjkDz7yYba1iIgYiiNvr9Q4lA==
X-Google-Smtp-Source: APXvYqwECe16deFmFXuBsvDM/qb21glybS3RCWMPqamv7CRpcXexvL/6SRpYwtVSbyfeor9Ee1S/VqTKWSeSMr8H57g=
X-Received: by 2002:aca:cc07:: with SMTP id c7mr12168055oig.165.1582550966813;
 Mon, 24 Feb 2020 05:29:26 -0800 (PST)
MIME-Version: 1.0
From:   Michael Stapelberg <michael+lkml@stapelberg.ch>
Date:   Mon, 24 Feb 2020 14:29:15 +0100
Message-ID: <CANnVG6kZzN1Ja0EmxG3pVTdMx8Kf8fezGWBtCYUzk888VaFThg@mail.gmail.com>
Subject: Writing to FUSE via mmap extremely slow (sometimes) on some machines?
To:     fuse-devel <fuse-devel@lists.sourceforge.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003777a4059f525cbe"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003777a4059f525cbe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

I=E2=80=99m running into an issue where writes via mmap are extremely slow.
The mmap program I=E2=80=99m using to test is attached.

The symptom is that the program usually completes in 0.x seconds, but
then sometimes takes minutes to complete! E.g.:

% dd if=3D/dev/urandom of=3D/tmp/was bs=3D1M count=3D99

% ./fusexmp_fh /tmp/mnt

% time ~/mmap /tmp/was /tmp/mnt/tmp/stapelberg.1
Mapped src: 0x10000  and dst: 0x21b8b000
memcpy done
~/mmap /tmp/was /tmp/mnt/tmp/stapelberg.1  0.06s user 0.20s system 48%
cpu 0.544 total

% time   ~/mmap /tmp/was /tmp/mnt/tmp/stapelberg.1
Mapped src: 0x10000  and dst: 0x471fb000
memcpy done
~/mmap /tmp/was /tmp/mnt/tmp/stapelberg.1  0.05s user 0.22s system 0%
cpu 2:03.39 total

This affects both an in-house FUSE file system and also FUSE=E2=80=99s
fusexmp_fh from 2.9.7 (matching what our in-house FS uses).

While this is happening, the machine is otherwise idle. E.g. dstat shows:

--total-cpu-usage-- -dsk/total- -net/total- ---paging-- ---system--
usr sys idl wai stl| read  writ| recv  send|  in   out | int   csw
  1   0  98   1   0|   0     0 |  19k   23k|   0     0 |  14k   27k
  1   0  98   1   0|   0     0 |  33k   53k|   0     0 |  14k   29k
  0   0  98   1   0|   0   176k|  27k   26k|   0     0 |  13k   25k
[=E2=80=A6]

While this is happening, using cp(1) to copy the same file is fast (1
second). It=E2=80=99s only mmap-based writing that=E2=80=99s slow.

This is with Linux 5.2.17, but has been going on for years apparently.

I haven=E2=80=99t quite figured out what the pattern is with regards to the
machines that are affected. One wild guess I have is that it might be
related to RAM? The machine on which I can most frequently reproduce
the issue has 192GB of RAM, whereas I haven=E2=80=99t been able to reproduc=
e
the issue on my workstation with 64GB of RAM.

Any ideas what I could check to further narrow down this issue?

Thanks,

--0000000000003777a4059f525cbe
Content-Type: text/x-csrc; charset="US-ASCII"; name="mmap.c"
Content-Disposition: attachment; filename="mmap.c"
Content-Transfer-Encoding: base64
Content-ID: <f_k70g91jk0>
X-Attachment-Id: f_k70g91jk0

I2luY2x1ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8c3lzL3N0YXQuaD4KI2luY2x1ZGUgPHN5
cy9tbWFuLmg+IAojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVk
ZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CgovKgog
KiBBbiBpbXBsZW1lbnRhdGlvbiBvZiBjb3B5ICgiY3AiKSB0aGF0IHVzZXMgbWVtb3J5IG1hcHMu
ICBWYXJpb3VzCiAqIGVycm9yIGNoZWNraW5nIGhhcyBiZWVuIHJlbW92ZWQgdG8gcHJvbW90ZSBy
ZWFkYWJpbGl0eQogKi8KCi8vIFdoZXJlIHdlIHdhbnQgdGhlIHNvdXJjZSBmaWxlJ3MgbWVtb3J5
IG1hcCB0byBsaXZlIGluIHZpcnR1YWwgbWVtb3J5Ci8vIFRoZSBkZXN0aW5hdGlvbiBmaWxlIHJl
c2lkZXMgaW1tZWRpYXRlbHkgYWZ0ZXIgdGhlIHNvdXJjZSBmaWxlCiNkZWZpbmUgTUFQX0xPQ0FU
SU9OIDB4NjEwMAoKaW50IG1haW4gKGludCBhcmdjLCBjaGFyICphcmd2W10pIHsKIGludCBmZGlu
LCBmZG91dDsKIGNoYXIgKnNyYywgKmRzdDsKIHN0cnVjdCBzdGF0IHN0YXRidWY7CiBvZmZfdCBm
aWxlU2l6ZSA9IDA7CgogaWYgKGFyZ2MgIT0gMykgewogICBwcmludGYgKCJ1c2FnZTogYS5vdXQg
PGZyb21maWxlPiA8dG9maWxlPlxuIik7CiAgIGV4aXQoMCk7CiB9CgogLyogb3BlbiB0aGUgaW5w
dXQgZmlsZSAqLwogaWYgKChmZGluID0gb3BlbiAoYXJndlsxXSwgT19SRE9OTFkpKSA8IDApIHsK
ICAgcHJpbnRmICgiY2FuJ3Qgb3BlbiAlcyBmb3IgcmVhZGluZ1xuIiwgYXJndlsxXSk7CiAgIGV4
aXQoMCk7CiB9CgogLyogb3Blbi9jcmVhdGUgdGhlIG91dHB1dCBmaWxlICovCiBpZiAoKGZkb3V0
ID0gb3BlbiAoYXJndlsyXSwgT19SRFdSIHwgT19DUkVBVCB8IE9fVFJVTkMsIDA2MDApKSA8IDAp
IHsKICAgcHJpbnRmICgiY2FuJ3QgY3JlYXRlICVzIGZvciB3cml0aW5nXG4iLCBhcmd2WzJdKTsK
ICAgZXhpdCgwKTsKIH0KIAogLyogZmluZCBzaXplIG9mIGlucHV0IGZpbGUgKi8KIGZzdGF0IChm
ZGluLCZzdGF0YnVmKSA7CiBmaWxlU2l6ZSA9IHN0YXRidWYuc3Rfc2l6ZTsKIAogLyogZ28gdG8g
dGhlIGxvY2F0aW9uIGNvcnJlc3BvbmRpbmcgdG8gdGhlIGxhc3QgYnl0ZSAqLwogaWYgKGxzZWVr
IChmZG91dCwgZmlsZVNpemUgLSAxLCBTRUVLX1NFVCkgPT0gLTEpIHsKICAgcHJpbnRmICgibHNl
ZWsgZXJyb3JcbiIpOwogICBleGl0KDApOwogfQogCiAvKiB3cml0ZSBhIGR1bW15IGJ5dGUgYXQg
dGhlIGxhc3QgbG9jYXRpb24gKi8KIHdyaXRlIChmZG91dCwgIiIsIDEpOwogCiAvKiAKICAqIG1l
bW9yeSBtYXAgdGhlIGlucHV0IGZpbGUuICBPbmx5IHRoZSBmaXJzdCB0d28gYXJndW1lbnRzIGFy
ZQogICogaW50ZXJlc3Rpbmc6IDEpIHRoZSBsb2NhdGlvbiBhbmQgMikgdGhlIHNpemUgb2YgdGhl
IG1lbW9yeSBtYXAgCiAgKiBpbiB2aXJ0dWFsIG1lbW9yeSBzcGFjZS4gTm90ZSB0aGF0IHRoZSBs
b2NhdGlvbiBpcyBvbmx5IGEgImhpbnQiOwogICogdGhlIE9TIGNhbiBjaG9vc2UgdG8gcmV0dXJu
IGEgZGlmZmVyZW50IHZpcnR1YWwgbWVtb3J5IGFkZHJlc3MuCiAgKiBUaGlzIGlzIGlsbHVzdHJh
dGVkIGJ5IHRoZSBwcmludGYgY29tbWFuZCBiZWxvdy4KICovCgogc3JjID0gbW1hcCAoKHZvaWQq
KSBNQVBfTE9DQVRJT04sIGZpbGVTaXplLCAKCSAgICAgUFJPVF9SRUFELCBNQVBfU0hBUkVEIHwg
TUFQX1BPUFVMQVRFLCBmZGluLCAwKTsKCiAvKiBtZW1vcnkgbWFwIHRoZSBvdXRwdXQgZmlsZSBh
ZnRlciB0aGUgaW5wdXQgZmlsZSAqLwogZHN0ID0gbW1hcCAoKHZvaWQqKSBNQVBfTE9DQVRJT04g
KyBmaWxlU2l6ZSAsIGZpbGVTaXplICwgCgkgICAgIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsIE1B
UF9TSEFSRUQsIGZkb3V0LCAwKTsKCgogcHJpbnRmKCJNYXBwZWQgc3JjOiAweCV4ICBhbmQgZHN0
OiAweCV4XG4iLHNyYyxkc3QpOwoKIC8qIENvcHkgdGhlIGlucHV0IGZpbGUgdG8gdGhlIG91dHB1
dCBmaWxlICovCiBtZW1jcHkgKGRzdCwgc3JjLCBmaWxlU2l6ZSk7CgogcHJpbnRmKCJtZW1jcHkg
ZG9uZVxuIik7CgogLy8gd2Ugc2hvdWxkIHByb2JhYmx5IHVubWFwIG1lbW9yeSBhbmQgY2xvc2Ug
dGhlIGZpbGVzCn0gLyogbWFpbiAqLwo=
--0000000000003777a4059f525cbe--
