Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F50AC433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09E1320720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9TNy1lP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgGUP7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgGUP7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:59:44 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B29FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:59:44 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id h16so16842781ilj.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pArDBhmSzvQPcygvZlwDh8Ur75TqclADaqly7DROXXw=;
        b=C9TNy1lPEuq4LiRJR+jaIk5FzKgHR7rtCTgJoDvVoOyM9pH3VIg9h2Hu9QYjNwiC1E
         lkKAoZYiTQedpbLdJ7bZVqOLK4V4eFz0iGaD+heDybPMO5o4r+Ee9uX/U8O28l8FRNkL
         pxcIrW8nhEmCCFmWCM3JTfwdsbbMKCe9DBJ2/y/oiaGS6i+NaQnmQfFgFNzMu/X94ZZM
         IkJImN33cr1LeNzTCkaQH1hFsH3VP7slHGm74RtGgaU6z6GSPkAGG7KVvh5hWq160hGG
         HZdvnpPaD/hSzBJK6wo2kY+bE3pR4QATlMRiSe55FurbfeXgP5qaz9GSALeHfLiHCngu
         kp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pArDBhmSzvQPcygvZlwDh8Ur75TqclADaqly7DROXXw=;
        b=NArTa8jHnzhy7PKTEA/FbkrbjvCjRJFSTobKMKm5M2XJ/S/pxOGVfiz5+o0SR33jDs
         FNWU2qD3DvP7c7EA5ZXZIDBzYF3ACZQLG6uS6NZpW3IS3iXIWr9vgq+AhNE1vpLuFWoM
         jWBUJ4Tla1e7+E6prJXH9x7Obtqmog6ZOzCPCwkFncDCUjeOjacV7CmEy3a7JsRsxpvr
         gFF74faaGJ02vlNiSUJhCcq3dX6qoGIyoORByLicGYdoDU6ycScbwZVF0NfRSPou3IPC
         wi6b90MLeRA8+LUzwr65q2rYDI3+EC3I1OnznjGS+cfx1+HxMFf6BPqgaslQyyLOV48p
         69FA==
X-Gm-Message-State: AOAM533M0ZpO0lrDj3532wxvpIDViCsMvtofHQuqE6MOjOFtRVrXJzfQ
        vqaFY5CrAbEunbSbK12lQQJ2bjjtAoQxlGKvo+MTcSgM
X-Google-Smtp-Source: ABdhPJx7dl7e0bKCXjY6ssT3xEbqw15V7mbbn6gc35NhjeLtUBkpODsVeS3ishOcaEFFQXHG5p9xbuNhx+pU40ZGVIg=
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr29791283ilj.9.1595347183679;
 Tue, 21 Jul 2020 08:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200721001505.GD19262@shao2-debian>
In-Reply-To: <20200721001505.GD19262@shao2-debian>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 21 Jul 2020 18:59:31 +0300
Message-ID: <CAOQ4uxgq39EDS_k3eDTngEAm8cxHPa7qrkUSW8Rk6qS9cxC18w@mail.gmail.com>
Subject: Re: [fsnotify] c738fbabb0: will-it-scale.per_process_ops -9.5% regression
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
Content-Type: multipart/mixed; boundary="0000000000002d923105aaf5b690"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002d923105aaf5b690
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 21, 2020 at 3:15 AM kernel test robot <rong.a.chen@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed a -9.5% regression of will-it-scale.per_process_ops due to commit:
>
>
> commit: c738fbabb0ff62d0f9a9572e56e65d05a1b34c6a ("fsnotify: fold fsnotify() call into fsnotify_parent()")

Strange, that's a pretty dumb patch moving some inlined code from one
function to
another (assuming there are no fsnotify marks in this test).

Unless I am missing something the only thing that changes slightly is
an extra d_inode(file->f_path.dentry) deference.
I can get rid of it.

Is it possible to ask for a re-test with fix patch (attached)?

Thanks,
Amir.

--0000000000002d923105aaf5b690
Content-Type: text/plain; charset="US-ASCII"; 
	name="fsnotify-pass-inode-to-fsnotify_parent.patch.txt"
Content-Disposition: attachment; 
	filename="fsnotify-pass-inode-to-fsnotify_parent.patch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kcw4gz9c0>
X-Attachment-Id: f_kcw4gz9c0

RnJvbSAyNmRjM2QyYmZmNjIzNzY4Y2JiZDBjODA1M2RkZDYzOTBmZDgyOGQyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDIxIEp1bCAyMDIwIDE4OjUyOjE4ICswMzAwClN1YmplY3Q6IFtQQVRDSF0gZnNu
b3RpZnk6IHBhc3MgaW5vZGUgdG8gZnNub3RpZnlfcGFyZW50KCkKCldlIGNhbiBnZXQgaW5vZGUg
YnkgZGVyZWZlcmVuY2VpbmcgZGVudHJ5LT5kX2lub2RlLCBidXQgdGhhdCBtYXkgaGF2ZQpwZXJm
b3JtYW5jZSBpbXBhY3QgaW4gdGhlIGZhc3QgcGF0aCBvZiBub24gd2F0Y2hlZCBmaWxlLgoKS2Vy
bmVsIHRlc3Qgcm9ib3QgcmVwb3J0ZWQgYSBwZXJmb3JtYW5jZSByZWdyZXNzaW9uIGluIGNvbmN1
cnJlbnQgb3Blbgp3b3JrbG9hZCwgc28gbWF5YmUgdGhhdCBjYW4gZml4IGl0LgoKUmVwb3J0ZWQt
Ynk6IGtlcm5lbCB0ZXN0IHJvYm90IDxyb25nLmEuY2hlbkBpbnRlbC5jb20+CkZpeGVzOiBjNzM4
ZmJhYmIwZmYgKCJmc25vdGlmeTogZm9sZCBmc25vdGlmeSgpIGNhbGwgaW50byBmc25vdGlmeV9w
YXJlbnQoKSIpClNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5j
b20+Ci0tLQogaW5jbHVkZS9saW51eC9mc25vdGlmeS5oIHwgMTEgKysrKysrLS0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9mc25vdGlmeS5oIGIvaW5jbHVkZS9saW51eC9mc25vdGlmeS5oCmluZGV4
IDMxNmM5YjgyMDUxNy4uZDQ5ZTUzMThhYWQ5IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2Zz
bm90aWZ5LmgKKysrIGIvaW5jbHVkZS9saW51eC9mc25vdGlmeS5oCkBAIC00NiwxMCArNDYsOSBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgZnNub3RpZnlfZGlyZW50KHN0cnVjdCBpbm9kZSAqZGlyLCBz
dHJ1Y3QgZGVudHJ5ICpkZW50cnksCiAKIC8qIE5vdGlmeSB0aGlzIGRlbnRyeSdzIHBhcmVudCBh
Ym91dCBhIGNoaWxkJ3MgZXZlbnRzLiAqLwogc3RhdGljIGlubGluZSBpbnQgZnNub3RpZnlfcGFy
ZW50KHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgX191MzIgbWFzaywKLQkJCQkgIGNvbnN0IHZvaWQg
KmRhdGEsIGludCBkYXRhX3R5cGUpCisJCQkJICBjb25zdCB2b2lkICpkYXRhLCBpbnQgZGF0YV90
eXBlLAorCQkJCSAgc3RydWN0IGlub2RlICppbm9kZSkKIHsKLQlzdHJ1Y3QgaW5vZGUgKmlub2Rl
ID0gZF9pbm9kZShkZW50cnkpOwotCiAJaWYgKFNfSVNESVIoaW5vZGUtPmlfbW9kZSkpCiAJCW1h
c2sgfD0gRlNfSVNESVI7CiAKQEAgLTY4LDcgKzY3LDggQEAgc3RhdGljIGlubGluZSBpbnQgZnNu
b3RpZnlfcGFyZW50KHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgX191MzIgbWFzaywKICAqLwogc3Rh
dGljIGlubGluZSB2b2lkIGZzbm90aWZ5X2RlbnRyeShzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIF9f
dTMyIG1hc2spCiB7Ci0JZnNub3RpZnlfcGFyZW50KGRlbnRyeSwgbWFzaywgZF9pbm9kZShkZW50
cnkpLCBGU05PVElGWV9FVkVOVF9JTk9ERSk7CisJZnNub3RpZnlfcGFyZW50KGRlbnRyeSwgbWFz
aywgZF9pbm9kZShkZW50cnkpLCBGU05PVElGWV9FVkVOVF9JTk9ERSwKKwkJCWRfaW5vZGUoZGVu
dHJ5KSk7CiB9CiAKIHN0YXRpYyBpbmxpbmUgaW50IGZzbm90aWZ5X2ZpbGUoc3RydWN0IGZpbGUg
KmZpbGUsIF9fdTMyIG1hc2spCkBAIC03OCw3ICs3OCw4IEBAIHN0YXRpYyBpbmxpbmUgaW50IGZz
bm90aWZ5X2ZpbGUoc3RydWN0IGZpbGUgKmZpbGUsIF9fdTMyIG1hc2spCiAJaWYgKGZpbGUtPmZf
bW9kZSAmIEZNT0RFX05PTk9USUZZKQogCQlyZXR1cm4gMDsKIAotCXJldHVybiBmc25vdGlmeV9w
YXJlbnQocGF0aC0+ZGVudHJ5LCBtYXNrLCBwYXRoLCBGU05PVElGWV9FVkVOVF9QQVRIKTsKKwly
ZXR1cm4gZnNub3RpZnlfcGFyZW50KHBhdGgtPmRlbnRyeSwgbWFzaywgcGF0aCwgRlNOT1RJRllf
RVZFTlRfUEFUSCwKKwkJCSAgICAgICBmaWxlX2lub2RlKGZpbGUpKTsKIH0KIAogLyogU2ltcGxl
IGNhbGwgc2l0ZSBmb3IgYWNjZXNzIGRlY2lzaW9ucyAqLwotLSAKMi4xNy4xCgo=
--0000000000002d923105aaf5b690--
