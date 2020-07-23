Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E17C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4891F2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="PG7dIotM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgGWPmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:42:44 -0400
Received: from m1355.mail.163.com ([220.181.13.55]:26949 "EHLO
        m1355.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgGWPmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:42:43 -0400
X-Greylist: delayed 935 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jul 2020 11:42:42 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=xMGRC
        He842IB2MjNA/wba5wNMl7OGehLFqufBXZfZMU=; b=PG7dIotM/a/AhCfZdZ9Uo
        CHxmGc4ztcnr1y4VtZECAvK1SvWZtCo9e6K4ZG50HQEmQldOWUupa0xbNHIPIRge
        ZP9P2TxfsshbCLZehorUfUGrCGWaTXJo9Dnl0H5jInk3LA0ajqrjVByMst8zK1+t
        lQG5aX2/jJOqXgGKX580A8=
Received: from songfengcn$163.com ( [114.222.189.160] ) by
 ajax-webmail-wmsvr55 (Coremail) ; Thu, 23 Jul 2020 23:26:01 +0800 (CST)
X-Originating-IP: [114.222.189.160]
Date:   Thu, 23 Jul 2020 23:26:01 +0800 (CST)
From:   "Song Feng" <songfengcn@163.com>
To:     "Chao Yu" <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re:[f2fs-dev] [PATCH] f2fs: fix use-after-free issue
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
In-Reply-To: <20200723102806.9662-1-yuchao0@huawei.com>
References: <20200723102806.9662-1-yuchao0@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <666af139.9663.1737c480519.Coremail.songfengcn@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: N8GowACndMwJrBlfwDhgAA--.59311W
X-CM-SenderInfo: pvrqwwphqju0i6rwjhhfrp/1tbiRAlqW1SIgShn7QAAsD
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXQgMjAyMC0wNy0yMyAxNzoyODowNiwgIkNoYW8gWXUiIDx5dWNoYW8wQGh1YXdlaS5jb20+IHdy
b3RlOgoKPkZyb206IExpIEd1aWZ1IDxibHVjZS5saWd1aWZ1QGh1YXdlaS5jb20+Cj4KPkR1cmlu
ZyB1bW91bnQsIGYyZnNfcHV0X3N1cGVyKCkgdW5yZWdpc3RlcnMgcHJvY2ZzIGVudHJpZXMgYWZ0
ZXIKPmYyZnNfZGVzdHJveV9zZWdtZW50X21hbmFnZXIoKSwgaXQgbWF5IGNhdXNlIHVzZS1hZnRl
ci1mcmVlCj5pc3N1ZSB3aGVuIHVtb3VudCByYWNlcyB3aXRoIHByb2NmcyBhY2Nlc3NpbmcsIGZp
eCBpdCBieSByZWxjYXRpbmcKdHlwbyBpc3N1ZTogcmVsY2F0aW5nIC0+IHJlbG9jYXRpbmc/Cj5m
MmZzX3VucmVnaXN0ZXJfc3lzZnMoKS4KPgo+W0NoYW8gWXU6IGNoYW5nZSBjb21taXQgdGl0bGUv
bWVzc2FnZSBhIGJpdF0KPgo+U2lnbmVkLW9mZi1ieTogTGkgR3VpZnUgPGJsdWNlLmxpZ3VpZnVA
aHVhd2VpLmNvbT4KPlJldmlld2VkLWJ5OiBDaGFvIFl1IDx5dWNoYW8wQGh1YXdlaS5jb20+Cj5T
aWduZWQtb2ZmLWJ5OiBDaGFvIFl1IDx5dWNoYW8wQGh1YXdlaS5jb20+Cj4tLS0KPiBmcy9mMmZz
L3N1cGVyLmMgfCA1ICsrKy0tCj4gMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKPgo+ZGlmZiAtLWdpdCBhL2ZzL2YyZnMvc3VwZXIuYyBiL2ZzL2YyZnMvc3Vw
ZXIuYwo+aW5kZXggODBjYjdjZDM1OGY4Li5iZjhiZDY0YzgzODAgMTAwNjQ0Cj4tLS0gYS9mcy9m
MmZzL3N1cGVyLmMKPisrKyBiL2ZzL2YyZnMvc3VwZXIuYwo+QEAgLTExNzUsNiArMTE3NSw5IEBA
IHN0YXRpYyB2b2lkIGYyZnNfcHV0X3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpCj4gCWlu
dCBpOwo+IAlib29sIGRyb3BwZWQ7Cj4gCj4rCS8qIHVucmVnaXN0ZXIgcHJvY2ZzL3N5c2ZzIGVu
dHJpZXMgdG8gYXZvaWQgcmFjZSBjYXNlICovCj4rCWYyZnNfdW5yZWdpc3Rlcl9zeXNmcyhzYmkp
Owo+Kwo+IAlmMmZzX3F1b3RhX29mZl91bW91bnQoc2IpOwo+IAo+IAkvKiBwcmV2ZW50IHJlbWFp
bmluZyBzaHJpbmtlciBqb2JzICovCj5AQCAtMTI0MCw4ICsxMjQzLDYgQEAgc3RhdGljIHZvaWQg
ZjJmc19wdXRfc3VwZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYikKPiAKPiAJa3ZmcmVlKHNiaS0+
Y2twdCk7Cj4gCj4tCWYyZnNfdW5yZWdpc3Rlcl9zeXNmcyhzYmkpOwo+LQo+IAlzYi0+c19mc19p
bmZvID0gTlVMTDsKPiAJaWYgKHNiaS0+c19jaGtzdW1fZHJpdmVyKQo+IAkJY3J5cHRvX2ZyZWVf
c2hhc2goc2JpLT5zX2Noa3N1bV9kcml2ZXIpOwo+LS0gCj4yLjI2LjIKPgo+Cj4KPl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj5MaW51eC1mMmZzLWRldmVs
IG1haWxpbmcgbGlzdAo+TGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPmh0
dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2
ZWwKcGxlYXNlIGNoZWNrIHR5cG8gaXNzdWUgZm9yIGNvbW1lbnQ6IHJlbGNhdGluZy0+cmVsb2Nh
dGluZz8=
