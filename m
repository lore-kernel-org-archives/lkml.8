Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7708DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3946420825
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ro64oCe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgEVCJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 22:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgEVCJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 22:09:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D16AC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 19:09:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id o14so10798332ljp.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 19:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:references:mime-version:message-id
         :content-transfer-encoding;
        bh=CI8o49EsDgcTySP1QOrKC2VDnbXkSe0ZjWrR8w9AJe8=;
        b=ro64oCe7AS2btyF08HSXUo2DScd8EZfziPKM07kW2exq0BvXqxoqbOaC5AXf4k+8pG
         sMzKJRkekWsPUzbHrLmj+SUp91giO3jvFUDf9CjvQcU8SykPzsof5PwnzUxe7Yc/eSL7
         I1vWSSRzqj/cFlPvEgixUZ5lGr/0gJkGPWkva5FKhqV47KE7XyO3kEFvBg59yahevvmF
         TgS8FWGeWaqTlzdizygsSBPuoygBwDZ/IG2z3j+V8xb5bdy9URqWsBnjej/QFocCHCZf
         MhrVihT+AsSkmUCAbNFKTDuyck+dqXU9Z/Psoaxtmie+lyBfz9JYSGti1++Trx/0+4xx
         c0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:references:mime-version
         :message-id:content-transfer-encoding;
        bh=CI8o49EsDgcTySP1QOrKC2VDnbXkSe0ZjWrR8w9AJe8=;
        b=jKeXw+Yi88A2sBnrD6fFe0RSKeITz9HuPdbEjrpoCj36FKjmr5ZhFnkbCQkr7ddw1l
         JGjKPdeEvRAatftGO9O2AMPa6hsHu2XP3QKVIXZC/d6tPmHtGyZdWd3P+OA1pWkwXU7P
         rwwyn03Q/oE81JkQvopP0DZlC56jEIeHA7xzPkV3IangLONqAtfANoU1YjikckFdkN16
         GdO8PbtwayMoAtu5Srz5mFAcKNqZ4vy1ed/yHqN78ggnTRqUH+RroYmosb83Sc1UUoJs
         gv0cp5lbO+ECXGofYhOGAyLpuNI6u24RAuEru3S54wGcM/r19yhLrWolgyZIypwh7Dll
         Pmvw==
X-Gm-Message-State: AOAM5302XHk41AGv90ty0MR+kpu04s5bEU78RZlbY5xAVDjPBQPyi+GL
        ZDLgVgT5ROIUOKm8KeMumos=
X-Google-Smtp-Source: ABdhPJy/E3PzWA4d7ab5D2j8/Auflg9it/7l8ndHg3+xe22FrKnmaB4uDmTOMuxTTWU3rkXyQLdhDA==
X-Received: by 2002:a2e:150f:: with SMTP id s15mr6221836ljd.102.1590113383925;
        Thu, 21 May 2020 19:09:43 -0700 (PDT)
Received: from N-20L6PF1KTYA2 ([131.228.2.20])
        by smtp.gmail.com with ESMTPSA id z13sm2060023ljz.30.2020.05.21.19.09.42
        (version=TLS1_2 cipher=AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 19:09:43 -0700 (PDT)
Date:   Fri, 22 May 2020 10:09:42 +0800
From:   "Li Xinhai" <lixinhai.lxh@gmail.com>
To:     "Tom Zanussi" <zanussi@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix events.rst section numbering
References: <90ea854dfb728390b50ddf8a8675238973ee014a.camel@kernel.org>
X-Priority: 3
X-GUID: 170B6D81-1F88-486F-A95F-28F02C82B751
X-Has-Attach: no
X-Mailer: Foxmail 7.2.13.365[cn]
Mime-Version: 1.0
Message-ID: <2020052210094049322420@gmail.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMC0wNS0xOcKgYXQgMDI6MjnCoFRvbSBaYW51c3NpwqB3cm90ZToKPlRoZSBpbi1rZXJu
ZWwgdHJhY2UgZXZlbnQgQVBJIHNob3VsZCBoYXZlIGl0cyBvd24gc2VjdGlvbiwgYW5kIHRoZQo+
ZHVwbGljYXRlIHNlY3Rpb24gbnVtYmVycyBuZWVkIGZpeGluZyBhcyB3ZWxsLgo+Cj5TaWduZWQt
b2ZmLWJ5OiBUb20gWmFudXNzaSA8emFudXNzaUBrZXJuZWwub3JnPgo+UmVwb3J0ZWQtYnk6IExp
IFhpbmhhaSA8bGl4aW5oYWkubHhoQGdtYWlsLmNvbT4KPi0tLQo+IERvY3VtZW50YXRpb24vdHJh
Y2UvZXZlbnRzLnJzdCB8IDI4ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0KPiAxIGZpbGUg
Y2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCj4KPmRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL3RyYWNlL2V2ZW50cy5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYWNlL2V2
ZW50cy5yc3QKPmluZGV4IGVkNzliMjIwYmQwNy4uMWEzYjc3NjJjYjBmIDEwMDY0NAo+LS0tIGEv
RG9jdW1lbnRhdGlvbi90cmFjZS9ldmVudHMucnN0Cj4rKysgYi9Eb2N1bWVudGF0aW9uL3RyYWNl
L2V2ZW50cy5yc3QKPkBAIC01MjYsOCArNTI2LDggQEAgVGhlIGZvbGxvd2luZyBjb21tYW5kcyBh
cmUgc3VwcG9ydGVkOgo+Cj7CoMKgIFNlZSBEb2N1bWVudGF0aW9uL3RyYWNlL2hpc3RvZ3JhbS5y
c3QgZm9yIGRldGFpbHMgYW5kIGV4YW1wbGVzLgo+Cj4tNi4zIEluLWtlcm5lbCB0cmFjZSBldmVu
dCBBUEkKPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+KzcuIEluLWtlcm5lbCB0cmFj
ZSBldmVudCBBUEkKPis9PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4KPiBJbiBtb3N0IGNh
c2VzLCB0aGUgY29tbWFuZC1saW5lIGludGVyZmFjZSB0byB0cmFjZSBldmVudHMgaXMgbW9yZSB0
aGFuCj4gc3VmZmljaWVudC7CoCBTb21ldGltZXMsIGhvd2V2ZXIsIGFwcGxpY2F0aW9ucyBtaWdo
dCBmaW5kIHRoZSBuZWVkIGZvcgo+QEAgLTU1OSw4ICs1NTksOCBAQCBmb2xsb3dpbmc6Cj7CoMKg
IC0gdHJhY2luZyBzeW50aGV0aWMgZXZlbnRzIGZyb20gaW4ta2VybmVsIGNvZGUKPsKgwqAgLSB0
aGUgbG93LWxldmVsICJkeW5ldmVudF9jbWQiIEFQSQo+Cj4tNi4zLjEgRHlhbWljYWxseSBjcmVh
dGluZyBzeW50aGV0aWMgZXZlbnQgZGVmaW5pdGlvbnMKPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+KzcuMSBEeWFtaWNhbGx5IGNyZWF0aW5n
IHN5bnRoZXRpYyBldmVudCBkZWZpbml0aW9ucwo+Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+Cj4gVGhlcmUgYXJlIGEgY291cGxlIHdheXMgdG8g
Y3JlYXRlIGEgbmV3IHN5bnRoZXRpYyBldmVudCBmcm9tIGEga2VybmVsCj4gbW9kdWxlIG9yIG90
aGVyIGtlcm5lbCBjb2RlLgo+QEAgLTY2NSw4ICs2NjUsOCBAQCByZWdpc3RlcmVkIGJ5IGNhbGxp
bmcgdGhlIHN5bnRoX2V2ZW50X2dlbl9jbWRfZW5kKCkgZnVuY3Rpb246Cj4gQXQgdGhpcyBwb2lu
dCwgdGhlIGV2ZW50IG9iamVjdCBpcyByZWFkeSB0byBiZSB1c2VkIGZvciB0cmFjaW5nIG5ldwo+
IGV2ZW50cy4KPgo+LTYuMy4zIFRyYWNpbmcgc3ludGhldGljIGV2ZW50cyBmcm9tIGluLWtlcm5l
bCBjb2RlCj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KPis3LjIgVHJhY2luZyBzeW50aGV0aWMgZXZlbnRzIGZyb20gaW4ta2VybmVsIGNvZGUKPist
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPgo+IFRvIHRy
YWNlIGEgc3ludGhldGljIGV2ZW50LCB0aGVyZSBhcmUgc2V2ZXJhbCBvcHRpb25zLsKgIFRoZSBm
aXJzdAo+IG9wdGlvbiBpcyB0byB0cmFjZSB0aGUgZXZlbnQgaW4gb25lIGNhbGwsIHVzaW5nIHN5
bnRoX2V2ZW50X3RyYWNlKCkKPkBAIC02NzcsOCArNjc3LDggQEAgc3ludGhfZXZlbnRfdHJhY2Vf
c3RhcnQoKSBhbmQgc3ludGhfZXZlbnRfdHJhY2VfZW5kKCkgYWxvbmcgd2l0aAo+IHN5bnRoX2V2
ZW50X2FkZF9uZXh0X3ZhbCgpIG9yIHN5bnRoX2V2ZW50X2FkZF92YWwoKSB0byBhZGQgdGhlIHZh
bHVlcwo+IHBpZWNld2lzZS4KPgo+LTYuMy4zLjEgVHJhY2luZyBhIHN5bnRoZXRpYyBldmVudCBh
bGwgYXQgb25jZQo+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQo+KzcuMi4xIFRyYWNpbmcgYSBzeW50aGV0aWMgZXZlbnQgYWxsIGF0IG9uY2UKPistLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4KPiBUbyB0cmFjZSBhIHN5bnRo
ZXRpYyBldmVudCBhbGwgYXQgb25jZSwgdGhlIHN5bnRoX2V2ZW50X3RyYWNlKCkgb3IKPiBzeW50
aF9ldmVudF90cmFjZV9hcnJheSgpIGZ1bmN0aW9ucyBjYW4gYmUgdXNlZC4KPkBAIC03NzksOCAr
Nzc5LDggQEAgcmVtb3ZlIHRoZSBldmVudDoKPgo+wqDCoMKgwqDCoMKgwqAgcmV0ID0gc3ludGhf
ZXZlbnRfZGVsZXRlKCJzY2hlZHRlc3QiKTsKPgo+LTYuMy4zLjEgVHJhY2luZyBhIHN5bnRoZXRp
YyBldmVudCBwaWVjZXdpc2UKPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCj4rNy4yLjIgVHJhY2luZyBhIHN5bnRoZXRpYyBldmVudCBwaWVjZXdpc2UKPistLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+Cj4gVG8gdHJhY2UgYSBzeW50
aGV0aWMgdXNpbmcgdGhlIHBpZWNld2lzZSBtZXRob2QgZGVzY3JpYmVkIGFib3ZlLCB0aGUKPiBz
eW50aF9ldmVudF90cmFjZV9zdGFydCgpIGZ1bmN0aW9uIGlzIHVzZWQgdG8gJ29wZW4nIHRoZSBz
eW50aGV0aWMKPkBAIC04NjMsOCArODYzLDggQEAgTm90ZSB0aGF0IHN5bnRoX2V2ZW50X3RyYWNl
X2VuZCgpIG11c3QgYmUgY2FsbGVkIGF0IHRoZSBlbmQgcmVnYXJkbGVzcwo+IG9mIHdoZXRoZXIg
YW55IG9mIHRoZSBhZGQgY2FsbHMgZmFpbGVkIChzYXkgZHVlIHRvIGEgYmFkIGZpZWxkIG5hbWUK
PiBiZWluZyBwYXNzZWQgaW4pLgo+Cj4tNi4zLjQgRHlhbWljYWxseSBjcmVhdGluZyBrcHJvYmUg
YW5kIGtyZXRwcm9iZSBldmVudCBkZWZpbml0aW9ucwo+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPis3LjMgRHlhbWljYWxs
eSBjcmVhdGluZyBrcHJvYmUgYW5kIGtyZXRwcm9iZSBldmVudCBkZWZpbml0aW9ucwo+Ky0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Cj4KPiBUbyBjcmVhdGUgYSBrcHJvYmUgb3Iga3JldHByb2JlIHRyYWNlIGV2ZW50IGZyb20ga2Vy
bmVsIGNvZGUsIHRoZQo+IGtwcm9iZV9ldmVudF9nZW5fY21kX3N0YXJ0KCkgb3Iga3JldHByb2Jl
X2V2ZW50X2dlbl9jbWRfc3RhcnQoKQo+QEAgLTk0MCw4ICs5NDAsOCBAQCB1c2VkIHRvIGdpdmUg
dGhlIGtwcm9iZSBldmVudCBmaWxlIGJhY2sgYW5kIGRlbGV0ZSB0aGUgZXZlbnQ6Cj4KPsKgwqAg
cmV0ID0ga3Byb2JlX2V2ZW50X2RlbGV0ZSgiZ2VuX2twcm9iZV90ZXN0Iik7Cj4KPi02LjMuNCBU
aGUgImR5bmV2ZW50X2NtZCIgbG93LWxldmVsIEFQSQo+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCj4rNy40IFRoZSAiZHluZXZlbnRfY21kIiBsb3ctbGV2ZWwgQVBJCj4r
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4KPiBCb3RoIHRoZSBpbi1rZXJu
ZWwgc3ludGhldGljIGV2ZW50IGFuZCBrcHJvYmUgaW50ZXJmYWNlcyBhcmUgYnVpbHQgb24KPiB0
b3Agb2YgYSBsb3dlci1sZXZlbCAiZHluZXZlbnRfY21kIiBpbnRlcmZhY2UuwqAgVGhpcyBpbnRl
cmZhY2UgaXMKPi0tCj4yLjE3LjEKPiAKCkl0IGxvb2tzIGNvcnJlY3QgdG8gbWUuClJldmlld2Vk
LWJ5OsKgTGkgWGluaGFpIDxsaXhpbmhhaS5seGhAZ21haWwuY29tPgoKPg==

