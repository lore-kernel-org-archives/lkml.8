Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75E8C81CFF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781D92078C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588029614;
	bh=2FzNr9AYi2Z56St5oDtdr82wY2gpMQyGUJOeexzVjIE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=DZkw+rkISxHzCfCciirugIB2CzYyp9swoANGxz0yi5R055IhJB4gfjli/qirPQwWL
	 XQ2hYRpvxHMS5K8zDA5MWyV4YyZxT/BNrSGr/UKtPtFOlDoeQsqix6Gbd0Kj6kOYfW
	 QP8OWBekc3yBW+iI6LZHreLpntY87nb7CZD9a52g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgD0XUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgD0XUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:20:13 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C031E2075E;
        Mon, 27 Apr 2020 23:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588029612;
        bh=2FzNr9AYi2Z56St5oDtdr82wY2gpMQyGUJOeexzVjIE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=BgZp0SkDI7vO4118g7F0iAARmoGbMGqpVKsNzNqOz6+xieZb2qUIJKRFbwnxLEV3W
         2RxPGBgyEotbGst2iOX00wmj96IV8D5nZmm8sowEA900EIAbG1xB+Y6q6NQ1JS5KNI
         rw/mSAzLb//x9I4m2NqgdEVbMttCC95rtDHOcIN8=
Date:   Mon, 27 Apr 2020 16:20:11 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     jgross@suse.com, boris.ostrovsky@oracle.com
cc:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Dave P Martin <dave.martin@arm.com>,
        Jan Beulich <JBeulich@suse.com>,
        Julien Grall <julien.grall@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        julien.grall@gmail.com
Subject: Re: [Xen-devel] xen/evtchn and forced threaded irq
In-Reply-To: <CAF3u54Ct7nBjoLw9Vzb=aZVu=N5Ccp5_k6GxLo_ZSA=YCsco6A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2004271552430.29217@sstabellini-ThinkPad-T480s>
References: <5e256d9a-572c-e01e-7706-407f99245b00@arm.com> <20190220000209.GA4091@localhost.localdomain> <a872d480-9f1b-6cd7-e507-ac4fcdf705af@arm.com> <21214d47-9c68-e6bf-007a-4047cc2b02f9@oracle.com> <8f7445d7-fa50-f3e9-44f5-cc2aebd020f4@arm.com>
 <15bc52cb-82d8-4d2c-e5a8-c6ae8de90276@oracle.com> <5df8888a-4a29-fccd-bac2-a9c170244029@arm.com> <1574a7fe-a5ac-4bc2-d3f0-967d8d01e5f1@oracle.com> <1100e6b1-6fa8-06f0-8ecc-b0699a2ce5f4@arm.com> <20190221080752.zy2qlzb4vi7tbu3p@Air-de-Roger>
 <CAF3u54Ct7nBjoLw9Vzb=aZVu=N5Ccp5_k6GxLo_ZSA=YCsco6A@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1847598456-1588028657=:29217"
Content-ID: <alpine.DEB.2.21.2004271607590.29217@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1847598456-1588028657=:29217
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.2004271607591.29217@sstabellini-ThinkPad-T480s>

On Thu, 21 Feb 2019, Julien Grall wrote:
> Hi Roger,
> 
> On Thu, 21 Feb 2019, 08:08 Roger Pau Monné, <roger.pau@citrix.com> wrote:
>       FWIW, you can also mask the interrupt while waiting for the thread to
>       execute the interrupt handler. Ie:
> 
> 
> Thank you for providing steps, however where would the masking be done? By the irqchip or a custom solution?
> 
> 
>       1. Interrupt injected
>       2. Execute guest event channel callback
>       3. Scan for pending interrupts
>       4. Mask interrupt
>       5. Clear pending field
>       6. Queue threaded handler
>       7. Go to 3 until all interrupts are drained
>       [...]
>       8. Execute interrupt handler in thread
>       9. Unmask interrupt
> 
>       That should prevent you from stacking interrupts?

Sorry for coming late to the thread, and thanks Julien for pointing it
out to me. I am afraid I was the one to break the flow back in 2011 with
the following commit:

  7e186bdd0098 xen: do not clear and mask evtchns in __xen_evtchn_do_upcall

Oops :-)


Xen event channels have their own workflow; the one Roger wrote above.
They used to be handled using handle_fasteoi_irq until 7e186bdd0098,
then I switched (almost) all of them to handle_edge_irq.

Looking closely at irq handling again, it doesn't look like we can do
what we need with handle_edge_irq today: we can't mask the event channel
before clearing it. But we can do that if we go back to using
handle_fasteoi_irq.

In fact, I managed to verify that LinuxRT works fine as dom0 with the
attached dynamic.patch that switches back xen_dynamic_chip IRQs to
handle_fasteoi_irq.


From the rest of this thread, it looks like the issue might appear with
PIRQs as well. Thus, I wrote a second patch pirqs.patch to switch back
to handle_fasteoi_irq PIRQs as well. However, Xen on ARM does not use
PIRQs so I couldn't test it at all. I would appreciate if Boris/Juegen
tested it. Let me know what you want me to do with the second patch.
--8323329-1847598456-1588028657=:29217
Content-Type: text/x-diff; name=dynamic.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.2004271620110.29217@sstabellini-ThinkPad-T480s>
Content-Description: 
Content-Disposition: attachment; filename=dynamic.patch

RnJvbSBjZTI2YzM3MWE4ZmY3YjQ5Yzk4YTNiOGM3YjU3MTk5MTU0Y2JjYTU5
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogU3RlZmFubyBTdGFi
ZWxsaW5pIDxzc3RhYmVsbGluaUBrZXJuZWwub3JnPg0KRGF0ZTogTW9uLCAy
NyBBcHIgMjAyMCAxNjoxNToyNiAtMDcwMA0KU3ViamVjdDogW1BBVENIXSB4
ZW46IHVzZSBoYW5kbGVfZmFzdGVvaV9pcnEgdG8gaGFuZGxlIHhlbiBldmVu
dHMNCg0KV2hlbiBoYW5kbGluZyBYZW4gZXZlbnRzLCB3ZSBuZWVkIHRvIG1h
a2Ugc3VyZSB0aGUgZm9sbG93aW5nIHNlcXVlbmNlIGlzDQpmb2xsb3dlZDoN
Cg0KLSBtYXNrIGV2ZW50DQotIGhhbmRsZSBldmVudCBhbmQgY2xlYXIgZXZl
bnQgKHRoZSBvcmRlciBkb2VzIG5vdCBtYXR0ZXIpDQotIHVubWFzayBldmVu
dA0KDQpJdCBpcyBub3QgcG9zc2libGUgdG8gaW1wbGVtZW50IHRoaXMgZmxv
dyB3aXRoIGhhbmRsZV9lZGdlX2lycSwgc28NCnN3aXRjaCBiYWNrIHRvIGhh
bmRsZV9mYXN0ZW9pX2lycS4gUGxlYXNlIG5vdGUgdGhhdCBYZW4gZXZlbnQg
aXJxcyBhcmUNCk9ORVNIT1QuIEFsc28gbm90ZSB0aGF0IGhhbmRsZV9mYXN0
ZW9pX2lycSB3YXMgaW4tdXNlIGJlZm9yZSB0aGUNCmZvbGxvd2luZyBjb21t
aXQsIHRoYXQgaXMgcGFydGlhbGx5IHJldmVydGVkIGJ5IHRoaXMgcGF0Y2g6
DQoNCjdlMTg2YmRkMDA5OCB4ZW46IGRvIG5vdCBjbGVhciBhbmQgbWFzayBl
dnRjaG5zIGluIF9feGVuX2V2dGNobl9kb191cGNhbGwNCg0KUElSUSBoYW5k
bGluZyBpcyBsZWZ0IHVuY2hhbmdlZC4NCg0KVGhpcyBwYXRjaCBmaXhlcyBh
IGRvbVUgaGFuZyBvYnNlcnZlZCB3aGVuIHVzaW5nIExpbnV4UlQgYXMgZG9t
MCBrZXJuZWwuDQoNCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xr
bWwvNWUyNTZkOWEtNTcyYy1lMDFlLTc3MDYtNDA3Zjk5MjQ1YjAwQGFybS5j
b20vDQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIFN0YWJlbGxpbmkgPHN0ZWZh
bm8uc3RhYmVsbGluaUB4aWxpbnguY29tPg0KLS0tDQogZHJpdmVycy94ZW4v
ZXZlbnRzL2V2ZW50c19iYXNlLmMgfCAxMyArKystLS0tLS0tLS0tDQogMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jh
c2UuYyBiL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jDQppbmRl
eCA0OTllZmY3ZDNmNjUuLjVmOWI4MTA0ZGJjZiAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jDQorKysgYi9kcml2ZXJz
L3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYw0KQEAgLTg0NSw3ICs4NDUsNyBA
QCBpbnQgYmluZF9ldnRjaG5fdG9faXJxKHVuc2lnbmVkIGludCBldnRjaG4p
DQogCQkJZ290byBvdXQ7DQogDQogCQlpcnFfc2V0X2NoaXBfYW5kX2hhbmRs
ZXJfbmFtZShpcnEsICZ4ZW5fZHluYW1pY19jaGlwLA0KLQkJCQkJICAgICAg
aGFuZGxlX2VkZ2VfaXJxLCAiZXZlbnQiKTsNCisJCQkJCSAgICAgIGhhbmRs
ZV9mYXN0ZW9pX2lycSwgImV2ZW50Iik7DQogDQogCQlyZXQgPSB4ZW5faXJx
X2luZm9fZXZ0Y2huX3NldHVwKGlycSwgZXZ0Y2huKTsNCiAJCWlmIChyZXQg
PCAwKSB7DQpAQCAtOTc4LDcgKzk3OCw3IEBAIGludCBiaW5kX3ZpcnFfdG9f
aXJxKHVuc2lnbmVkIGludCB2aXJxLCB1bnNpZ25lZCBpbnQgY3B1LCBib29s
IHBlcmNwdSkNCiAJCQkJCQkgICAgICBoYW5kbGVfcGVyY3B1X2lycSwgInZp
cnEiKTsNCiAJCWVsc2UNCiAJCQlpcnFfc2V0X2NoaXBfYW5kX2hhbmRsZXJf
bmFtZShpcnEsICZ4ZW5fZHluYW1pY19jaGlwLA0KLQkJCQkJCSAgICAgIGhh
bmRsZV9lZGdlX2lycSwgInZpcnEiKTsNCisJCQkJCQkgICAgICBoYW5kbGVf
ZmFzdGVvaV9pcnEsICJ2aXJxIik7DQogDQogCQliaW5kX3ZpcnEudmlycSA9
IHZpcnE7DQogCQliaW5kX3ZpcnEudmNwdSA9IHhlbl92Y3B1X25yKGNwdSk7
DQpAQCAtMTM3NywxMiArMTM3Nyw2IEBAIHN0YXRpYyB2b2lkIGFja19keW5p
cnEoc3RydWN0IGlycV9kYXRhICpkYXRhKQ0KIAkJY2xlYXJfZXZ0Y2huKGV2
dGNobik7DQogfQ0KIA0KLXN0YXRpYyB2b2lkIG1hc2tfYWNrX2R5bmlycShz
dHJ1Y3QgaXJxX2RhdGEgKmRhdGEpDQotew0KLQlkaXNhYmxlX2R5bmlycShk
YXRhKTsNCi0JYWNrX2R5bmlycShkYXRhKTsNCi19DQotDQogc3RhdGljIGlu
dCByZXRyaWdnZXJfZHluaXJxKHN0cnVjdCBpcnFfZGF0YSAqZGF0YSkNCiB7
DQogCXVuc2lnbmVkIGludCBldnRjaG4gPSBldnRjaG5fZnJvbV9pcnEoZGF0
YS0+aXJxKTsNCkBAIC0xNTg1LDggKzE1NzksNyBAQCBzdGF0aWMgc3RydWN0
IGlycV9jaGlwIHhlbl9keW5hbWljX2NoaXAgX19yZWFkX21vc3RseSA9IHsN
CiAJLmlycV9tYXNrCQk9IGRpc2FibGVfZHluaXJxLA0KIAkuaXJxX3VubWFz
awkJPSBlbmFibGVfZHluaXJxLA0KIA0KLQkuaXJxX2FjawkJPSBhY2tfZHlu
aXJxLA0KLQkuaXJxX21hc2tfYWNrCQk9IG1hc2tfYWNrX2R5bmlycSwNCisJ
LmlycV9lb2kJCT0gYWNrX2R5bmlycSwNCiANCiAJLmlycV9zZXRfYWZmaW5p
dHkJPSBzZXRfYWZmaW5pdHlfaXJxLA0KIAkuaXJxX3JldHJpZ2dlcgkJPSBy
ZXRyaWdnZXJfZHluaXJxLA0KLS0gDQoyLjE3LjENCg0K

--8323329-1847598456-1588028657=:29217
Content-Type: text/x-diff; name=pirqs.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.2004271620111.29217@sstabellini-ThinkPad-T480s>
Content-Description: 
Content-Disposition: attachment; filename=pirqs.patch

ZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5j
IGIvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMNCmluZGV4IDVm
OWI4MTA0ZGJjZi4uNTdhMjljOTRmZWZjIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMNCisrKyBiL2RyaXZlcnMveGVu
L2V2ZW50cy9ldmVudHNfYmFzZS5jDQpAQCAtNDk4LDEyICs0OTgsNiBAQCBz
dGF0aWMgdm9pZCBlb2lfcGlycShzdHJ1Y3QgaXJxX2RhdGEgKmRhdGEpDQog
CX0NCiB9DQogDQotc3RhdGljIHZvaWQgbWFza19hY2tfcGlycShzdHJ1Y3Qg
aXJxX2RhdGEgKmRhdGEpDQotew0KLQlkaXNhYmxlX2R5bmlycShkYXRhKTsN
Ci0JZW9pX3BpcnEoZGF0YSk7DQotfQ0KLQ0KIHN0YXRpYyB1bnNpZ25lZCBp
bnQgX19zdGFydHVwX3BpcnEodW5zaWduZWQgaW50IGlycSkNCiB7DQogCXN0
cnVjdCBldnRjaG5fYmluZF9waXJxIGJpbmRfcGlycTsNCkBAIC02ODQsMTMg
KzY3OCw5IEBAIGludCB4ZW5fYmluZF9waXJxX2dzaV90b19pcnEodW5zaWdu
ZWQgZ3NpLA0KIAl9DQogDQogCXBpcnFfcXVlcnlfdW5tYXNrKGlycSk7DQot
CS8qIFdlIHRyeSB0byB1c2UgdGhlIGhhbmRsZXIgd2l0aCB0aGUgYXBwcm9w
cmlhdGUgc2VtYW50aWMgZm9yIHRoZQ0KLQkgKiB0eXBlIG9mIGludGVycnVw
dDogaWYgdGhlIGludGVycnVwdCBpcyBhbiBlZGdlIHRyaWdnZXJlZA0KLQkg
KiBpbnRlcnJ1cHQgd2UgdXNlIGhhbmRsZV9lZGdlX2lycS4NCi0JICoNCi0J
ICogT24gdGhlIG90aGVyIGhhbmQgaWYgdGhlIGludGVycnVwdCBpcyBsZXZl
bCB0cmlnZ2VyZWQgd2UgdXNlDQotCSAqIGhhbmRsZV9mYXN0ZW9pX2lycSBs
aWtlIHRoZSBuYXRpdmUgY29kZSBkb2VzIGZvciB0aGlzIGtpbmQgb2YNCi0J
ICogaW50ZXJydXB0cy4NCisJLyogV2UgdXNlIGhhbmRsZV9mYXN0ZW9pX2ly
cSBmb3IgUElSUXMgYmVjYXVzZSB3ZSB3YW50IHRvIGtlZXANCisJICogdGhl
IGV2dGNobiBtYXNrZWQgd2hpbGUgaGFuZGxpbmcgYW5kIGNsZWFyaW5nIHRo
ZSBldmVudC4NCisJICogVW5tYXNraW5nIHRoZSBldnRjaG4gc2hvdWxkIG9u
bHkgaGFwcGVuIGFmdGVyIGNsZWFyaW5nIGl0Lg0KIAkgKg0KIAkgKiBEZXBl
bmRpbmcgb24gdGhlIFhlbiB2ZXJzaW9uLCBwaXJxX25lZWRzX2VvaSBtaWdo
dCByZXR1cm4gdHJ1ZQ0KIAkgKiBub3Qgb25seSBmb3IgbGV2ZWwgdHJpZ2dl
cmVkIGludGVycnVwdHMgYnV0IGZvciBlZGdlIHRyaWdnZXJlZA0KQEAgLTY5
OSwxMiArNjg5LDggQEAgaW50IHhlbl9iaW5kX3BpcnFfZ3NpX3RvX2lycSh1
bnNpZ25lZCBnc2ksDQogCSAqIGhhc24ndCByZWNlaXZlZCBhbiBlb2kgeWV0
LiBUaGVyZWZvcmUgdXNpbmcgdGhlIGZhc3Rlb2kgaGFuZGxlcg0KIAkgKiBp
cyB0aGUgcmlnaHQgY2hvaWNlIGVpdGhlciB3YXkuDQogCSAqLw0KLQlpZiAo
c2hhcmVhYmxlKQ0KLQkJaXJxX3NldF9jaGlwX2FuZF9oYW5kbGVyX25hbWUo
aXJxLCAmeGVuX3BpcnFfY2hpcCwNCi0JCQkJaGFuZGxlX2Zhc3Rlb2lfaXJx
LCBuYW1lKTsNCi0JZWxzZQ0KLQkJaXJxX3NldF9jaGlwX2FuZF9oYW5kbGVy
X25hbWUoaXJxLCAmeGVuX3BpcnFfY2hpcCwNCi0JCQkJaGFuZGxlX2VkZ2Vf
aXJxLCBuYW1lKTsNCisJaXJxX3NldF9jaGlwX2FuZF9oYW5kbGVyX25hbWUo
aXJxLCAmeGVuX3BpcnFfY2hpcCwNCisJCQloYW5kbGVfZmFzdGVvaV9pcnEs
IG5hbWUpOw0KIA0KIG91dDoNCiAJbXV0ZXhfdW5sb2NrKCZpcnFfbWFwcGlu
Z191cGRhdGVfbG9jayk7DQpAQCAtNzM5LDcgKzcyNSw3IEBAIGludCB4ZW5f
YmluZF9waXJxX21zaV90b19pcnEoc3RydWN0IHBjaV9kZXYgKmRldiwgc3Ry
dWN0IG1zaV9kZXNjICptc2lkZXNjLA0KIAkJZ290byBvdXQ7DQogDQogCWZv
ciAoaSA9IDA7IGkgPCBudmVjOyBpKyspIHsNCi0JCWlycV9zZXRfY2hpcF9h
bmRfaGFuZGxlcl9uYW1lKGlycSArIGksICZ4ZW5fcGlycV9jaGlwLCBoYW5k
bGVfZWRnZV9pcnEsIG5hbWUpOw0KKwkJaXJxX3NldF9jaGlwX2FuZF9oYW5k
bGVyX25hbWUoaXJxICsgaSwgJnhlbl9waXJxX2NoaXAsIGhhbmRsZV9mYXN0
ZW9pX2lycSwgbmFtZSk7DQogDQogCQlyZXQgPSB4ZW5faXJxX2luZm9fcGly
cV9zZXR1cChpcnEgKyBpLCAwLCBwaXJxICsgaSwgMCwgZG9taWQsDQogCQkJ
CQkgICAgICBpID09IDAgPyAwIDogUElSUV9NU0lfR1JPVVApOw0KQEAgLTE1
OTYsOSArMTU4Miw3IEBAIHN0YXRpYyBzdHJ1Y3QgaXJxX2NoaXAgeGVuX3Bp
cnFfY2hpcCBfX3JlYWRfbW9zdGx5ID0gew0KIAkuaXJxX21hc2sJCT0gZGlz
YWJsZV9keW5pcnEsDQogCS5pcnFfdW5tYXNrCQk9IGVuYWJsZV9keW5pcnEs
DQogDQotCS5pcnFfYWNrCQk9IGVvaV9waXJxLA0KIAkuaXJxX2VvaQkJPSBl
b2lfcGlycSwNCi0JLmlycV9tYXNrX2FjawkJPSBtYXNrX2Fja19waXJxLA0K
IA0KIAkuaXJxX3NldF9hZmZpbml0eQk9IHNldF9hZmZpbml0eV9pcnEsDQog
DQotLSANCjIuMTcuMQ0KDQo=

--8323329-1847598456-1588028657=:29217--
