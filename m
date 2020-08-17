Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACDFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 01:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF9A82075D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 01:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k9hjpfv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHQBfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 21:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHQBfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 21:35:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E307C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 18:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=tl115Yxs/qonv0VFoxvHZM9OFNTeqn+xN7j0yiLXxWE=; b=k9hjpfv0uETMVIfYBf1okPeMgy
        dLxMnAob3+b/RZzXLoAYKVE99wBMKDBR5O0Pi/R5/a2SrrUJRWLUDJtt65sz2mjbFJUZQAVcpeTJy
        MJWA7V7IWS6iKoFgRhcY0akYDZFlsYiNUKRklY+5V970j/m3InLb17sWMlbC9aTNug1f7FEKjGGbz
        Tod93/bdz0Bmtn3mhfMuvM7vrTk7mhlnQHV9KZDtuCz5Nmltx3zWT6abDPHVWOEbGuL8bRzRP1cTr
        OLwEMsKRm2RNC9QehNkYosDii7QIV823NXt4txxXnXJPoLpmh57awmvy0IMk6KBLVUCsllmmXnZjs
        Q7ydlu6A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7U3e-0007LR-O1; Mon, 17 Aug 2020 01:35:32 +0000
Subject: Re: Linux 5.9-rc1 (sparse? kernel/time/timekeeping.c)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <CAHk-=wiwfkKp93C+yLqKWAU0ChBdeBDUhgOk09_=UQ8gOKbV3w@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <83b35552-d1a2-e4ce-9a41-2b5cf688ccf0@infradead.org>
Date:   Sun, 16 Aug 2020 18:35:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiwfkKp93C+yLqKWAU0ChBdeBDUhgOk09_=UQ8gOKbV3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xNi8yMCAxOjUwIFBNLCBMaW51cyBUb3J2YWxkcyB3cm90ZToNCj4gVGhpcyBtZXJn
ZSB3aW5kb3cgZmVsdCBhIGxvdCBtb3JlIG5vcm1hbCB0aGFuIDUuOCwgYW5kIGFsbCB0aGUg
c3RhdHMNCj4gY29uZmlybSB0aGFyIGl0IHNlZW1zIHRvIGJlIHRoZSB1c3VhbCBzaXplLg0K
PiANCg0Kb24geDg2XzY0LCBhbGxtb2Rjb25maWc6DQoNCiQgZ2NjIC0tdmVyc2lvbg0KZ2Nj
IChTVVNFIExpbnV4KSA3LjUuMA0KDQokIHNwYXJzZSAtLXZlcnNpb24NCjAuNi4yDQoNCg0K
SSBzZWVtIHRvIGJlIGhhdmluZyBzb21lIHByb2JsZW1zIHdpdGgga2VybmVsL3RpbWUvdGlt
ZWtlZXBpbmcuYywNCmluY2x1ZGluZyBhIHNlZ2ZhdWx0Lg0KDQphLiBJcyBpdCBzcGFyc2Ug
dGhhdCBzZWdmYXVsdHM/DQoNCmIuIHdoYXQgcHJpbnRzIHRoaXMgbWVzc2FnZT8NCm1ha2Vb
M106ICoqKiBEZWxldGluZyBmaWxlICdrZXJuZWwvdGltZS90aW1la2VlcGluZy5vJw0KDQpj
LiBJIHdvdWxkIHByZWZlciB0byBiZSBhYmxlIHRvIHRlbGwgdGhlIHNvdXJjZSBvZiB3YXJu
aW5nL2Vycm9yIG1lc3NhZ2VzLA0KaS5lLiwgZ2NjIG9yIHNwYXJzZS4gRXNwZWNpYWxseSB3
aGVuIHRoZXkgYXJlIGludGVybWl4ZWQuDQpTbyBvbmUgc29sdXRpb24gSU1PIHdvdWxkIGJl
IHRvIGJlIGFibGUgdG8gZG8gYSBmdWxsIHNwYXJzZSBjaGVjayBfb25seV8sDQp3aXRob3V0
IHRoZSBnY2MgYnVpbGQuIFRoYXQgd2F5IHRoZSBtZXNzYWdlcyB3b3VsZCBvYnZpb3VzbHkg
YmUgZnJvbSBzcGFyc2UuDQoNCkFub3RoZXIgcmVhc29uIHRvIGRvIHRoYXQgaXMgdGhhdCBJ
IG9mdGVuIGRvIGdjYyBidWlsZHMgYW5kIHRoZW4gd291bGQgbGlrZQ0KdG8gZm9sbG93IHRo
YXQgdXAgd2l0aCBhIHNwYXJzZSBjaGVjayBidWlsZCwgYnV0IGN1cnJlbnRseSB0aGF0IG1l
YW5zIHRoYXQNCkkgaGF2ZSB0byBkbyB0aGUgZnVsbCBnY2MgKyBzcGFyc2UgYnVpbGQsIHdo
aWNoIGlzIHJlYWxseSB0aW1lIGNvbnN1bWluZw0Kc2luY2UgSSBoYXZlIGEgd2ltcHkgbGFw
dG9wLg0KDQoNCg0KICBDQyAgICAgIGtlcm5lbC90aW1lL3RpbWVrZWVwaW5nLm8NCiAgQ0hF
Q0sgICAuLi9rZXJuZWwvdGltZS90aW1la2VlcGluZy5jDQouLi9rZXJuZWwvdGltZS90aW1l
a2VlcGluZy5jOjQ2MToyMzogd2FybmluZzogdHJ5aW5nIHRvIGNvcHkgZXhwcmVzc2lvbiB0
eXBlIDMxDQouLi9rZXJuZWwvdGltZS90aW1la2VlcGluZy5jOjQ3MDoxODogd2FybmluZzog
dHJ5aW5nIHRvIGNvcHkgZXhwcmVzc2lvbiB0eXBlIDMxDQouLi9pbmNsdWRlL2xpbnV4L3Nl
cWxvY2suaDoyMTQ6MTogd2FybmluZzogdW5yZXBsYWNlZCBzeW1ib2wgJ3MnDQouLi9pbmNs
dWRlL2xpbnV4L3NlcWxvY2suaDoyMTQ6MTogd2FybmluZzogdW5yZXBsYWNlZCBzeW1ib2wg
J3JldHVybicNCi4uL2tlcm5lbC90aW1lL3RpbWVrZWVwaW5nLmM6NDYxOjIzOiB3YXJuaW5n
OiB1bnJlcGxhY2VkIHN5bWJvbCAncycNCi4uL2tlcm5lbC90aW1lL3RpbWVrZWVwaW5nLmM6
NDYxOjIzOiB3YXJuaW5nOiB1bnJlcGxhY2VkIHN5bWJvbCAncmV0dXJuJw0KLi4vaW5jbHVk
ZS9saW51eC9zZXFsb2NrLmg6MjE0OjE6IHdhcm5pbmc6IHVucmVwbGFjZWQgc3ltYm9sICdz
Jw0KLi4vaW5jbHVkZS9saW51eC9zZXFsb2NrLmg6MjE0OjE6IHdhcm5pbmc6IHVucmVwbGFj
ZWQgc3ltYm9sICdyZXR1cm4nDQouLi9rZXJuZWwvdGltZS90aW1la2VlcGluZy5jOjQ3MDox
ODogd2FybmluZzogdW5yZXBsYWNlZCBzeW1ib2wgJ3MnDQouLi9rZXJuZWwvdGltZS90aW1l
a2VlcGluZy5jOjQ3MDoxODogd2FybmluZzogdW5yZXBsYWNlZCBzeW1ib2wgJ3JldHVybicN
Ci9iaW4vc2g6IGxpbmUgMTogMTUxMjYgU2VnbWVudGF0aW9uIGZhdWx0ICAgICAgKGNvcmUg
ZHVtcGVkKSBzcGFyc2UgLURfX2xpbnV4X18gLURsaW51eCAtRF9fU1REQ19fIC1EdW5peCAt
RF9fdW5peF9fIC1XYml0d2lzZSAtV25vLXJldHVybi12b2lkIC1Xbm8tdW5rbm93bi1hdHRy
aWJ1dGUgLURfX3g4Nl82NF9fIC0tYXJjaD14ODZfNjQgLW1saXR0bGUtZW5kaWFuIC1tNjQg
LVdwLC1NTUQsa2VybmVsL3RpbWUvLnRpbWVrZWVwaW5nLm8uZCAtbm9zdGRpbmMgLWlzeXN0
ZW0gL3Vzci9saWI2NC9nY2MveDg2XzY0LXN1c2UtbGludXgvNy9pbmNsdWRlIC1JLi4vYXJj
aC94ODYvaW5jbHVkZSAtSS4vYXJjaC94ODYvaW5jbHVkZS9nZW5lcmF0ZWQgLUkuLi9pbmNs
dWRlIC1JLi9pbmNsdWRlIC1JLi4vYXJjaC94ODYvaW5jbHVkZS91YXBpIC1JLi9hcmNoL3g4
Ni9pbmNsdWRlL2dlbmVyYXRlZC91YXBpIC1JLi4vaW5jbHVkZS91YXBpIC1JLi9pbmNsdWRl
L2dlbmVyYXRlZC91YXBpIC1pbmNsdWRlIC4uL2luY2x1ZGUvbGludXgva2NvbmZpZy5oIC1p
bmNsdWRlIC4uL2luY2x1ZGUvbGludXgvY29tcGlsZXJfdHlwZXMuaCAtRF9fS0VSTkVMX18g
LVdhbGwgLVd1bmRlZiAtV2Vycm9yPXN0cmljdC1wcm90b3R5cGVzIC1Xbm8tdHJpZ3JhcGhz
IC1mbm8tc3RyaWN0LWFsaWFzaW5nIC1mbm8tY29tbW9uIC1mc2hvcnQtd2NoYXIgLWZuby1Q
SUUgLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbiAtV2Vycm9yPWltcGxp
Y2l0LWludCAtV25vLWZvcm1hdC1zZWN1cml0eSAtc3RkPWdudTg5IC1tbm8tc3NlIC1tbm8t
bW14IC1tbm8tc3NlMiAtbW5vLTNkbm93IC1tbm8tYXZ4IC1tNjQgLWZhbGlnbi1qdW1wcz0x
IC1mYWxpZ24tbG9vcHM9MSAtbW5vLTgwMzg3IC1tbm8tZnAtcmV0LWluLTM4NyAtbXByZWZl
cnJlZC1zdGFjay1ib3VuZGFyeT0zIC1tc2tpcC1yYXgtc2V0dXAgLW10dW5lPWdlbmVyaWMg
LW1uby1yZWQtem9uZSAtbWNtb2RlbD1rZXJuZWwgLURDT05GSUdfWDg2X1gzMl9BQkkgLVdu
by1zaWduLWNvbXBhcmUgLWZuby1hc3luY2hyb25vdXMtdW53aW5kLXRhYmxlcyAtbWluZGly
ZWN0LWJyYW5jaD10aHVuay1leHRlcm4gLW1pbmRpcmVjdC1icmFuY2gtcmVnaXN0ZXIgLWZu
by1qdW1wLXRhYmxlcyAtZm5vLWRlbGV0ZS1udWxsLXBvaW50ZXItY2hlY2tzIC1Xbm8tZnJh
bWUtYWRkcmVzcyAtV25vLWZvcm1hdC10cnVuY2F0aW9uIC1Xbm8tZm9ybWF0LW92ZXJmbG93
IC1PMiAtLXBhcmFtPWFsbG93LXN0b3JlLWRhdGEtcmFjZXM9MCAtZm5vLXJlb3JkZXItYmxv
Y2tzIC1mbm8taXBhLWNwLWNsb25lIC1mbm8tcGFydGlhbC1pbmxpbmluZyAtV2ZyYW1lLWxh
cmdlci10aGFuPTIwNDggLWZzdGFjay1wcm90ZWN0b3Itc3Ryb25nIC1Xbm8tdW51c2VkLWJ1
dC1zZXQtdmFyaWFibGUgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaCAtV25vLXVudXNlZC1jb25z
dC12YXJpYWJsZSAtZm5vLXZhci10cmFja2luZy1hc3NpZ25tZW50cyAtcGcgLW1yZWNvcmQt
bWNvdW50IC1tZmVudHJ5IC1EQ0NfVVNJTkdfRkVOVFJZIC1mbm8taW5saW5lLWZ1bmN0aW9u
cy1jYWxsZWQtb25jZSAtZmxpdmUtcGF0Y2hpbmc9aW5saW5lLWNsb25lIC1mYWxpZ24tZnVu
Y3Rpb25zPTMyIC1XZGVjbGFyYXRpb24tYWZ0ZXItc3RhdGVtZW50IC1XdmxhIC1Xbm8tcG9p
bnRlci1zaWduIC1Xbm8tYXJyYXktYm91bmRzIC1Xbm8tc3RyaW5nb3Atb3ZlcmZsb3cgLVdu
by1yZXN0cmljdCAtV25vLW1heWJlLXVuaW5pdGlhbGl6ZWQgLWZuby1zdHJpY3Qtb3ZlcmZs
b3cgLWZuby1tZXJnZS1hbGwtY29uc3RhbnRzIC1mbWVyZ2UtY29uc3RhbnRzIC1mbm8tc3Rh
Y2stY2hlY2sgLWZjb25zZXJ2ZS1zdGFjayAtV2Vycm9yPWRhdGUtdGltZSAtV2Vycm9yPWlu
Y29tcGF0aWJsZS1wb2ludGVyLXR5cGVzIC1XZXJyb3I9ZGVzaWduYXRlZC1pbml0IC1mc2Fu
aXRpemUtY292ZXJhZ2U9dHJhY2UtcGMgLUkgLi4va2VybmVsL3RpbWUgLUkgLi9rZXJuZWwv
dGltZSAtREtCVUlMRF9NT0RGSUxFPScia2VybmVsL3RpbWUvdGltZWtlZXBpbmciJyAtREtC
VUlMRF9CQVNFTkFNRT0nInRpbWVrZWVwaW5nIicgLURLQlVJTERfTU9ETkFNRT0nInRpbWVr
ZWVwaW5nIicgLi4va2VybmVsL3RpbWUvdGltZWtlZXBpbmcuYw0KbWFrZVszXTogKioqIFsu
Li9zY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI4Mzoga2VybmVsL3RpbWUvdGltZWtlZXBpbmcu
b10gRXJyb3IgMTM5DQptYWtlWzNdOiAqKiogRGVsZXRpbmcgZmlsZSAna2VybmVsL3RpbWUv
dGltZWtlZXBpbmcubycNCm1ha2VbM106ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpv
YnMuLi4uDQoNCg0KdGhhbmtzLg0KLS0gDQp+UmFuZHkNCg0K
