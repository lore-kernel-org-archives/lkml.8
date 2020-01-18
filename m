Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709EBC33CB6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 03:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEA4208CD
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 03:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msuXdwn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbgARDL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 22:11:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33002 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgARDL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 22:11:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so28482663lji.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 19:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:references:mime-version:message-id
         :content-transfer-encoding;
        bh=mgB84tMLIn0uSAMXfJV2vDYw9z3hFiyT5V5E/BknGRA=;
        b=msuXdwn6zO5wagt6hHPLtl9sV/EISkBb01+VSrUgTCnVo2UglUfxhRn0jwNx3QGsYk
         kDd4liiZcNtMNkE9X6voYL5ICG96s39wYZkUCYDliBB87kDIJ3t/CghwYjmeETK6TBYY
         nyaQ7WysI4Iv4HPoMNE5hrJ7sv7UOHBHme4EUDeYokBdx/VRZ1yNLXMcybbdLODbszYH
         73Jy/zwY2aFOTH2Bh+W5JKK7n/FY0VlJ0rL7egkCzG4q5AUqVEa0DTn2ApDjzeY/9efF
         izPkpk2IkXXcvx2meQwd2Z3b9I/HTVlTTk71wmKEkeyR5cyQIYXUxVwj3HaFGdxSRxgx
         EU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:references:mime-version
         :message-id:content-transfer-encoding;
        bh=mgB84tMLIn0uSAMXfJV2vDYw9z3hFiyT5V5E/BknGRA=;
        b=XU20kBcMrbBqzLRYonNxOe0K0Ks4d5ghTjnqa1KwHU9Mp41KcugocaJa/RHSGXcK2t
         cvB/UPcx04xzyu48I1aPoBTZmc6F1NDGaegkRnLjzTrBgFJGtsivT6Q0WXe17wl7MHCR
         0mpF+cjDaWDxwWCK0T9vnydzOzoLNj6KG0Qkn7Ch3rWO8llajEevL0dHgdVzIGWGEsBA
         wISaKR1H2saZNx94hm27dhr8LYflLeWi/yrjud+ex8M4K8Jw6LLQeVvUUwobmhd4Gen8
         IQst7h4bv+aj8yu2TrNe+mobv+mhxC221soYP34Ukw1hOjQ0xM/NzQ4MFQIivsVCvxAZ
         KwNQ==
X-Gm-Message-State: APjAAAUC9MMGvGLdEfuQpVQXtuyG261eFGMtMBP76CJN+vPfzd7P9/0m
        bLJRolMfUjA+feCq+jxfJMw=
X-Google-Smtp-Source: APXvYqwEanyS+DbC3WqroxXZO6E/a4VVTJccuNDE5snhRDWSWduzFJjy0q3vh1ejMknPWQ0FZdSFxw==
X-Received: by 2002:a2e:721a:: with SMTP id n26mr7453357ljc.128.1579317086164;
        Fri, 17 Jan 2020 19:11:26 -0800 (PST)
Received: from N-20L6PF1KTYA2 ([131.228.2.21])
        by smtp.gmail.com with ESMTPSA id q186sm13248007ljq.14.2020.01.17.19.11.23
        (version=TLS1_2 cipher=AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jan 2020 19:11:25 -0800 (PST)
Date:   Sat, 18 Jan 2020 11:11:23 +0800
From:   "Li Xinhai" <lixinhai.lxh@gmail.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        akpm <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Mike Kravetz" <mike.kravetz@oracle.com>, mhocko <mhocko@suse.com>
Subject: Re: [PATCH v4] mm/mempolicy,hugetlb: Checking hstate for hugetlbfs page in vma_migratable
References: <1579147885-23511-1-git-send-email-lixinhai.lxh@gmail.com>, 
        <20200116095614.GO19428@dhcp22.suse.cz>, 
        <20200116215032206994102@gmail.com>, 
        <20200116151803.GV19428@dhcp22.suse.cz>, 
        <20200116233817972969139@gmail.com>, 
        <20200117111629898234212@gmail.com>
X-Priority: 3
X-GUID: E767262C-3C28-41B6-B896-3352AB226DA2
X-Has-Attach: no
X-Mailer: Foxmail 7.2.13.365[cn]
Mime-Version: 1.0
Message-ID: <20200118111121432688303@gmail.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMC0wMS0xN8KgYXQgMTE6MTbCoExpIFhpbmhhacKgd3JvdGU6Cj5PbiAyMDIwLTAxLTE2
wqBhdCAyMzozOMKgTGkgWGluaGFpwqB3cm90ZToKPj5PbiAyMDIwLTAxLTE2wqBhdCAyMzoxOMKg
TWljaGFsIEhvY2tvwqB3cm90ZToKPj4+T24gVGh1IDE2LTAxLTIwIDIxOjUwOjM0LCBMaSBYaW5o
YWkgd3JvdGU6Cj4+Pj4gT24gMjAyMC0wMS0xNsKgYXQgMTc6NTbCoE1pY2hhbCBIb2Nrb8Kgd3Jv
dGU6Cj4+Pj4gPk9uIFRodSAxNi0wMS0yMCAwNDoxMToyNSwgTGkgWGluaGFpIHdyb3RlOgo+Pj4+
ID4+IENoZWNraW5nIGhzdGF0ZSBhdCBlYXJseSBwaGFzZSB3aGVuIGlzb2xhdGluZyBwYWdlLCBp
bnN0ZWFkIG9mIGR1cmluZwo+Pj4+ID4+IHVubWFwIGFuZCBtb3ZlIHBoYXNlLCB0byBhdm9pZCB1
c2VsZXNzIGlzb2xhdGlvbi4KPj4+PiA+Cj4+Pj4gPkNvdWxkIHlvdSBiZSBtb3JlIHNwZWNpZmlj
IHdoYXQgeW91IG1lYW4gYnkgaXNvbGF0aW9uIGFuZCB3aHkgZG9lcyBpdAo+Pj4+ID5tYXR0ZXI/
IFRoZSBwYXRjaCBkZXNjcmlwdGlvbiBzaG91bGQgcmVhbGx5IGV4cGxhaW4gX3doeV8gdGhlIGNo
YW5nZSBpcwo+Pj4+ID5uZWVkZWQgb3IgZGVzaXJhYmxlLgo+Pj4+Cj4+Pj4gVGhlIGNoYW5nZWxv
ZyBjYW4gYmUgaW1wcm92ZWQ6Cj4+Pj4KPj4+PiB2bWFfbWlncmF0YWJsZSgpIGlzIGNhbGxlZCB0
byBjaGVjayBpZiBwYWdlcyBpbiB2bWEgY2FuIGJlIG1pZ3JhdGVkCj4+Pj4gYmVmb3JlIGdvIGFo
ZWFkIHRvIGlzb2xhdGUsIHVubWFwIGFuZCBtb3ZlIHBhZ2VzLiBGb3IgaHVnZXRsYiBwYWdlcywK
Pj4+PiBodWdlcGFnZV9taWdyYXRpb25fc3VwcG9ydGVkKHN0cnVjdCBoc3RhdGUgKmgpIGlzIG9u
ZSBmYWN0b3Igd2hpY2gKPj4+PiBkZWNpZGUgaWYgbWlncmF0aW9uIGlzIHN1cHBvcnRlZC4gSW4g
Y3VycmVudCBjb2RlLCB0aGlzIGZ1bmN0aW9uIGlzIGNhbGxlZAo+Pj4+IGZyb23CoHVubWFwX2Fu
ZF9tb3ZlX2h1Z2VfcGFnZSgpLCBhZnRlciBpc29sYXRpbmcgcGFnZSBoYXMKPj4+PiBjb21wbGV0
ZWQuCj4+Pj4gVGhpcyBwYXRjaCBjaGVja3MgaHN0YXRlIGZyb20gdm1hX21pZ3JhdGFibGUoKSBh
bmQgYXZvaWRzIGlzb2xhdGluZyBwYWdlcwo+Pj4+IHdoaWNoIGFyZSBub3Qgc3VwcG9ydGVkLgo+
Pj4KPj4+VGhpcyBzdGlsbCBleHBsYWlucyB3aGF0IGJ1dCBub3Qgd2h5IHRoaXMgaXMgcmVsZXZh
bnQuIElmIGJ5IGlzb2xhdGluZwo+Pj5wYWdlcyB5b3UgbWVhbiBpc29sYXRlX2xydV9wYWdlIHRo
ZW4gdGhpcyByZWFsbHkgYSBub29wIGZvciBodWdldGxiCj4+PnBhZ2VzLiBPciBkbyBJIHN0aWxs
IG1pc3JlYWQgeW91ciBjaGFuZ2Vsb2c/Cj4+Cj4+SSBtZWFuwqBpc29sYXRlX2h1Z2VfcGFnZSB3
aWxsIHF1ZXVlIHBhZ2VzIGZvciBtb3ZpbmcsIGFuZAo+PnVubWFwX2FuZF9tb3ZlX2h1Z2VfcGFn
ZSB3aWxsIGNhbGwKPj5odWdlcGFnZV9taWdyYXRpb25fc3VwcG9ydGVkIHRoZW4gcmVmdXNlIG1v
dmluZy4KPj4KPgo+Rm9yZ290IHRvIG1lbnRpb24gdGhhdCB0aGlzIHBhdGNoIGhhcyBubyByZWxl
dmFudCB3aXRoIHRoaXMgb25lCj5odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEx
MzMxNjM5LyzCoAo+Cj5Db2RlIGNoYW5nZSBhdCBoZXJlIGlzIGNvbW1vbiBmb3IgYXZvaWRzIHdh
bGtpbmcgcGFnZSB0YWJsZSBhbmQKPmlzb2xhdGUgaHVnZXBhZ2UgaW4gY2FzZSBhcmNoaXRlY3R1
cmUgb3IgcGFnZSBzaXplIGFyZSBub3Qgc3VwcG9ydGVkCj5mb3IgbWlncmF0aW9uLiBDb21tZW50
cyBmcm9tIGNvZGUgYXJlIGNvcGllZCBoZXJlOgo+Cj5zdGF0aWMgaW50IHVubWFwX2FuZF9tb3Zl
X2h1Z2VfcGFnZSguLi4pCj57Cj4JLyoKPgkqIE1pZ3JhdGFiaWxpdHkgb2YgaHVnZXBhZ2VzIGRl
cGVuZHMgb24gYXJjaGl0ZWN0dXJlcyBhbmQgdGhlaXIgc2l6ZS4KPgkqIFRoaXMgY2hlY2sgaXMg
bmVjZXNzYXJ5IGJlY2F1c2Ugc29tZSBjYWxsZXJzIG9mIGh1Z2VwYWdlIG1pZ3JhdGlvbgo+CSog
bGlrZSBzb2Z0IG9mZmxpbmUgYW5kIG1lbW9yeSBob3RyZW1vdmUgZG9uJ3Qgd2FsayB0aHJvdWdo
IHBhZ2UKPgkqIHRhYmxlcyBvciBjaGVjayB3aGV0aGVyIHRoZSBodWdlcGFnZSBpcyBwbWQtYmFz
ZWQgb3Igbm90IGJlZm9yZQo+CSoga2lja2luZyBtaWdyYXRpb24uCj4JKi8KPglpZiAoIWh1Z2Vw
YWdlX21pZ3JhdGlvbl9zdXBwb3J0ZWQocGFnZV9oc3RhdGUoaHBhZ2UpKSkgewo+CXB1dGJhY2tf
YWN0aXZlX2h1Z2VwYWdlKGhwYWdlKTsKPglyZXR1cm4gLUVOT1NZUzsKPgl9Cj59Cj4KPkZvciBj
dXJyZW50IGNvZGUgY2hhbmdlLCB3ZSBhcmUgYWJsZSB0byBrbm93IHRoZSAnaHN0YXRlJyBiZWNh
dXNlIHdlIGhhdmUgJ3ZtYScsIHNvCj5kbyBlYXJseSBjaGVjayBpbnN0ZWFkIG9mIGxhdGVyLgo+
IAoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vMjAyMDAxMTcxMTE2Mjk4OTgyMzQy
MTJAZ21haWwuY29tLwoKUmV2aXNlIHdpdGggbW9yZSBkZXRhaWxzIG9uIGNoYW5nZWxvZyBmb3Ig
cmVhc29uIHdoeSB0aGlzIHBhdGNoCmlzIG5lZWQuIFRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4K
Ci0tLQp2bWFfbWlncmF0YWJsZSgpIGlzIGNhbGxlZCB0byBjaGVjayBpZiBwYWdlcyBpbiB2bWEg
Y2FuIGJlIG1pZ3JhdGVkCmJlZm9yZSBnbyBhaGVhZCB0byBmdXJ0aGVyIGFjdGlvbnMuIEN1cnJl
bnRseSBpdCBpcyB1c2VkIGluIGJlbG93IGNvZGUKcGF0aDoKLSB0YXNrX251bWFfd29yayAoa2Vy
bmVsXHNjaGVkXGZhaXIuYykKLSBtYmluZCAobW1cbWVtcG9saWN5LmMpCi0gbW92ZV9wYWdlcyAo
bW1cbWlncmF0ZS5jKQoKRm9yIGh1Z2V0bGIgbWFwcGluZywgdm1hIGlzIG1pZ3JhdGFibGUgb3Ig
bm90IGlzIGRldGVybWluZWQgYnk6Ci0gQ09ORklHX0FSQ0hfRU5BQkxFX0hVR0VQQUdFX01JR1JB
VElPTgotIGFyY2hfaHVnZXRsYl9taWdyYXRpb25fc3VwcG9ydGVkCgpJc3N1ZTogY3VycmVudCBj
b2RlIG9ubHkgY2hlY2tzIGZvciBDT05GSUdfQVJDSF9FTkFCTEVfSFVHRVBBR0VfTUlHUkFUSU9O
LgoKVGhpcyBwYXRjaCBjaGVja3MgdGhlIHR3byBmYWN0b3JzIHRvIGltcG92ZSBjb2RlIGxvZ2lj
LiBCZXNpZGVzLCBjYWxsZXIKb2Ygdm1hX21pZ3JhdGFibGUgY2FuIHRha2UgYWN0aW9uIHByb3Bl
cmx5IGluIGNhc2UgYXJjaGl0ZWN0dXJlIGRvbid0CnN1cHBvcnQgbWlncmF0aW9uLCBlLmcuLCBt
YmluZCBkb24ndCBnbyBmdXJ0aGVyIHRvIHRyeSBpc29sYXRpbmcvbW92aW5nCnBhZ2VzLCBidXQg
Y3VycmVudGx5IGl0IGRvIGNvbnRpbnVlIGJlY2F1c2Ugdm1hX21pZ3JhdGFibGUgc2F5IHllcy4K
Ck5vIGFkZGluZyBmb3IgRml4IHRhZywgc2luY2Ugdm1hX21pZ3JhdGFibGUgd2FzIGltcGxlbWVu
dGVkIGJlZm9yZQphcmNoX2h1Z2V0bGJfbWlncmF0aW9uX3N1cHBvcnRlZCwgaXQgaXMgdXAgdG8g
dGhlIGNhbGxlciB0byB1c2UgaXQuCi0tLQoKCj4+Pi0tCj4+Pk1pY2hhbCBIb2Nrbwo+Pj5TVVNF
IExhYnM=

