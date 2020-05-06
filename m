Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB89C47258
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5BC20714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgEFJPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:15:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:39992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728559AbgEFJPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:15:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B8440AB89;
        Wed,  6 May 2020 09:15:15 +0000 (UTC)
Message-ID: <1588756482.13662.20.camel@suse.com>
Subject: Re: KASAN: use-after-free Read in usblp_bulk_read
From:   Oliver Neukum <oneukum@suse.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+be5b5f86a162a6c281e6@syzkaller.appspotmail.com>,
        andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, zaitcev@redhat.com
Date:   Wed, 06 May 2020 11:14:42 +0200
In-Reply-To: <Pine.LNX.4.44L0.2004301103500.27217-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.2004301103500.27217-100000@netrider.rowland.org>
Content-Type: multipart/mixed; boundary="=-omYoP5MChuR2jajyK4SQ"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-omYoP5MChuR2jajyK4SQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Am Donnerstag, den 30.04.2020, 11:11 -0400 schrieb Alan Stern:

> KASAN is documented.  The difficulty is that this race is obviously 
> hard to trigger, and without the ability to reproduce it we can't run 
> diagnostics to find the underlying cause.
> 
> We can't even ask syzbot to try running tests for us; without a valid 
> reproducer it won't agree to rerun the original test program.


Very well. We are not going to find it without exceptional luck. Yet
there may be a real issue, too. We simply do not know. How about the
attached patch?

	Regards
		Oliver



--=-omYoP5MChuR2jajyK4SQ
Content-Disposition: attachment; filename="0001-usblp-poison-URBs-upon-disconnect.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="0001-usblp-poison-URBs-upon-disconnect.patch";
	charset="UTF-8"

RnJvbSA1ZWQyM2UwMDI5Y2YxMGNmOGRiZGQ3OTBhMTkwZDdlMjExMzU2MGFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgpEYXRl
OiBXZWQsIDYgTWF5IDIwMjAgMTE6MDU6NDEgKzAyMDAKU3ViamVjdDogW1BBVENIXSB1c2JscDog
cG9pc29uIFVSQnMgdXBvbiBkaXNjb25uZWN0CgpzeXprYWxsZXIgcmVwb3J0ZWQgYW4gVUIgdGhh
dCBzaG91bGQgaGF2ZSBiZWVuIGtpbGxlZCB0byBiZSBhY3RpdmUuCldlIGRvIG5vdCB1bmRlcnN0
YW5kIGl0LCBidXQgdGhpcyBzaG91bGQgZml4IHRoZSBpc3N1ZSBpZiBpdCBpcyByZWFsLgoKU2ln
bmVkLW9mZi1ieTogT2xpdmVyIE5ldWt1bSA8b25ldWt1bUBzdXNlLmNvbT4KLS0tCiBkcml2ZXJz
L3VzYi9jbGFzcy91c2JscC5jIHwgNSArKysrLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NsYXNzL3VzYmxw
LmMgYi9kcml2ZXJzL3VzYi9jbGFzcy91c2JscC5jCmluZGV4IDBkOGUzZjM4MDRhMy4uMDg0YzQ4
YzU4NDhmIDEwMDY0NAotLS0gYS9kcml2ZXJzL3VzYi9jbGFzcy91c2JscC5jCisrKyBiL2RyaXZl
cnMvdXNiL2NsYXNzL3VzYmxwLmMKQEAgLTQ2OCw3ICs0NjgsOCBAQCBzdGF0aWMgaW50IHVzYmxw
X3JlbGVhc2Uoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpCiAJdXNiX2F1
dG9wbV9wdXRfaW50ZXJmYWNlKHVzYmxwLT5pbnRmKTsKIAogCWlmICghdXNibHAtPnByZXNlbnQp
CQkvKiBmaW5pc2ggY2xlYW51cCBmcm9tIGRpc2Nvbm5lY3QgKi8KLQkJdXNibHBfY2xlYW51cCh1
c2JscCk7CisJCXVzYmxwX2NsZWFudXAodXNibHApOwkvKiBhbnkgVVJCcyBtdXN0IGJlIGRlYWQg
Ki8KKwogCW11dGV4X3VubG9jaygmdXNibHBfbXV0ZXgpOwogCXJldHVybiAwOwogfQpAQCAtMTM3
NSw5ICsxMzc2LDExIEBAIHN0YXRpYyB2b2lkIHVzYmxwX2Rpc2Nvbm5lY3Qoc3RydWN0IHVzYl9p
bnRlcmZhY2UgKmludGYpCiAKIAl1c2JscF91bmxpbmtfdXJicyh1c2JscCk7CiAJbXV0ZXhfdW5s
b2NrKCZ1c2JscC0+bXV0KTsKKwl1c2JfcG9pc29uX2FuY2hvcmVkX3VyYnMoJnVzYmxwLT51cmJz
KTsKIAogCWlmICghdXNibHAtPnVzZWQpCiAJCXVzYmxwX2NsZWFudXAodXNibHApOworCiAJbXV0
ZXhfdW5sb2NrKCZ1c2JscF9tdXRleCk7CiB9CiAKLS0gCjIuMTYuNAoK


--=-omYoP5MChuR2jajyK4SQ--

