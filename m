Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB63C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4FC20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OFMPUsea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgCLPai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:30:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36223 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbgCLPah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:30:37 -0400
Received: by mail-io1-f65.google.com with SMTP id d15so6095714iog.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 08:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lmo32ASE9ohivqUkY5OitA/bM2z15DhGLPCtAAPSDmg=;
        b=OFMPUseas5MCk34LoqOZYwhHYGva+OATtTcImlf8vYOWzbNltQVHDSjMrx38KwHLMf
         6r71sTJakgoCy+XMhS/LZJtVh1zbsx6IKRItq6PjkbP+P3aOTdqWWEhUqnYfnNG8zWWd
         FxLbHdHZo82jtPIuFZvRPVJiUzstiSfcuGAQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lmo32ASE9ohivqUkY5OitA/bM2z15DhGLPCtAAPSDmg=;
        b=Vi/RBXt/Ysae/xaQuZEKAZtnTfYFYyygRWEHYOjYCucqjavdTPuen6jRjMnjPWBxMK
         KVZg3FJy7bpeP2xxoKUI/eS3Il/sYGIDkOviTLolhYyxmre3GnJtpPemTp8INEx+AgHf
         S0WUCqnmXpx6wvo0femqyjBHZCys3SPAnYQ51wrs5ZrxJmdCC5bLuOKK827SOseM3J4t
         aj4DiGQyIlqt0FfpcCwKCXSvIqD1mjD9qWggy0mJhbmeEdKcCcaciKq7HsTGmJFh458l
         HfSah16bWIPTd5UaZpjdnWtNLa8kIs15VX2Pw2L9/PJ8GvMb0eorGXkyGXOU3JdBpmez
         ZBFw==
X-Gm-Message-State: ANhLgQ0jAzinskY/ntBzbJ798xdf79KwpsxfKS5L4wuK2o3ebQsa4r1G
        P6kovaIifxkC2smJsONpxW4jgDWzg93+rVc20i+FnZmkUWk=
X-Google-Smtp-Source: ADFU+vugMg/7D3b5rbHoClNr5PvThruRQpVS5TFiBTg2Z3cEg5iMLa1vant0/+u9mdqtGEAElwAmk50tV+ezvtHj2jQ=
X-Received: by 2002:a02:a813:: with SMTP id f19mr8103601jaj.35.1584027037003;
 Thu, 12 Mar 2020 08:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cc1faf059fcfdc73@google.com>
In-Reply-To: <000000000000cc1faf059fcfdc73@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 12 Mar 2020 16:30:25 +0100
Message-ID: <CAJfpegswE6pLBbBmbkPMjmLPjgvn5z=gDEB6cTpe7o84hOuroA@mail.gmail.com>
Subject: Re: WARNING: lock held when returning to user space in ovl_write_iter
To:     syzbot <syzbot+9331a354f4f624a52a55@syzkaller.appspotmail.com>
Cc:     Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="000000000000dc3e0c05a0aa08d2"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000dc3e0c05a0aa08d2
Content-Type: text/plain; charset="UTF-8"

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
63623fd4

--000000000000dc3e0c05a0aa08d2
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="ovl-fix-lockdep-warning-for-async-write.patch"
Content-Disposition: attachment; 
	filename="ovl-fix-lockdep-warning-for-async-write.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k7owsgf50>
X-Attachment-Id: f_k7owsgf50

LS0tCiBmcy9vdmVybGF5ZnMvZmlsZS5jIHwgICAxMCArKysrKysrKystCiAxIGZpbGUgY2hhbmdl
ZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgotLS0gYS9mcy9vdmVybGF5ZnMvZmls
ZS5jCisrKyBiL2ZzL292ZXJsYXlmcy9maWxlLmMKQEAgLTI0Myw3ICsyNDMsMTEgQEAgc3RhdGlj
IHZvaWQgb3ZsX2Fpb19jbGVhbnVwX2hhbmRsZXIoc3RydQogCiAJaWYgKGlvY2ItPmtpX2ZsYWdz
ICYgSU9DQl9XUklURSkgewogCQlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZmlsZV9pbm9kZShvcmln
X2lvY2ItPmtpX2ZpbHApOworCQlzdHJ1Y3QgaW5vZGUgKnJlYWxfaW5vZGUgPSBvdmxfaW5vZGVf
cmVhbChpbm9kZSk7CiAKKwkJV0FSTl9PTihyZWFsX2lub2RlICE9IGZpbGVfaW5vZGUoaW9jYi0+
a2lfZmlscCkpOworCQkvKiBTZWUgYWlvX2NvbXBsZXRlX3J3KCkgKi8KKwkJX19zYl93cml0ZXJz
X2FjcXVpcmVkKHJlYWxfaW5vZGUtPmlfc2IsIFNCX0ZSRUVaRV9XUklURSk7CiAJCWZpbGVfZW5k
X3dyaXRlKGlvY2ItPmtpX2ZpbHApOwogCQlvdmxfY29weWF0dHIob3ZsX2lub2RlX3JlYWwoaW5v
ZGUpLCBpbm9kZSk7CiAJfQpAQCAtMzExLDYgKzMxNSw3IEBAIHN0YXRpYyBzc2l6ZV90IG92bF93
cml0ZV9pdGVyKHN0cnVjdCBraW8KIHsKIAlzdHJ1Y3QgZmlsZSAqZmlsZSA9IGlvY2ItPmtpX2Zp
bHA7CiAJc3RydWN0IGlub2RlICppbm9kZSA9IGZpbGVfaW5vZGUoZmlsZSk7CisJc3RydWN0IGlu
b2RlICpyZWFsX2lub2RlID0gb3ZsX2lub2RlX3JlYWwoaW5vZGUpOwogCXN0cnVjdCBmZCByZWFs
OwogCWNvbnN0IHN0cnVjdCBjcmVkICpvbGRfY3JlZDsKIAlzc2l6ZV90IHJldDsKQEAgLTMyMCw3
ICszMjUsNyBAQCBzdGF0aWMgc3NpemVfdCBvdmxfd3JpdGVfaXRlcihzdHJ1Y3Qga2lvCiAKIAlp
bm9kZV9sb2NrKGlub2RlKTsKIAkvKiBVcGRhdGUgbW9kZSAqLwotCW92bF9jb3B5YXR0cihvdmxf
aW5vZGVfcmVhbChpbm9kZSksIGlub2RlKTsKKwlvdmxfY29weWF0dHIocmVhbF9pbm9kZSwgaW5v
ZGUpOwogCXJldCA9IGZpbGVfcmVtb3ZlX3ByaXZzKGZpbGUpOwogCWlmIChyZXQpCiAJCWdvdG8g
b3V0X3VubG9jazsKQEAgLTM0Niw2ICszNTEsOSBAQCBzdGF0aWMgc3NpemVfdCBvdmxfd3JpdGVf
aXRlcihzdHJ1Y3Qga2lvCiAJCQlnb3RvIG91dDsKIAogCQlmaWxlX3N0YXJ0X3dyaXRlKHJlYWwu
ZmlsZSk7CisJCVdBUk5fT04ocmVhbF9pbm9kZSAhPSBmaWxlX2lub2RlKHJlYWwuZmlsZSkpOwor
CQkvKiBTZWUgYWlvX3dyaXRlKCkgKi8KKwkJX19zYl93cml0ZXJzX3JlbGVhc2UocmVhbF9pbm9k
ZS0+aV9zYiwgU0JfRlJFRVpFX1dSSVRFKTsKIAkJYWlvX3JlcS0+ZmQgPSByZWFsOwogCQlyZWFs
LmZsYWdzID0gMDsKIAkJYWlvX3JlcS0+b3JpZ19pb2NiID0gaW9jYjsK
--000000000000dc3e0c05a0aa08d2--
