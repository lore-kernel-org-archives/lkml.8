Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8A3C433E3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7E8206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0c3mwbvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgGAHuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbgGAHuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:50:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941E1C03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:50:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r12so22697074wrj.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CfSOQZOCfz6gCDKuvjXMYCRd33V6cPuHHjdlMHJzj+c=;
        b=0c3mwbvC7eS2Qd1C0f0hkO1J/zDAPYcItwKSER2fVqfmEBSOi/QCL4hXL218NwIOa0
         /xCVpDbGda0G91xQV3cc+72ICti6QGQFXCGct6Ch/se2RIrK5mb8I49uwjHlQWwMcmUe
         nicdftao1p/hAZSnrw1V3jCH4QbVl9UKWKri401C0vYbviLlnE6OhXIyFDjVUABEgngn
         /Ta7z7nKahBWSXi69V9y/a/znJGhfkH9G58wjdbipTOd06rPAsLzNVkxAJ50dVrgMisv
         rf9cc2PDE1Ck9XlOn3or2I0oK9ntT0purAYA802FqXgxrWqI7hWVb9uq4SjFJ0HADb+1
         Enhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CfSOQZOCfz6gCDKuvjXMYCRd33V6cPuHHjdlMHJzj+c=;
        b=CflcljoWfdr2uF2V61ZtyL5+DbbgaGA15xFkSH2DZv2HD6hyKQx3WKyHsk7ZPpbVqe
         2jPzuPBuQ43k+qoPa2sSG6zosgJZ5c4sQhiH9j0UhyhbCxVyUROS6fVmf9Ha9E1nmDhQ
         P3jL2JzCcxrTcxj/hrYnFvuXoB0RvJTn/F/H1pa0Vah1ARlHAEQ2daJBNEWOcY/Z5ypA
         zUUmH/I+GSm5hKjxRJo/9XgeuQQZx6mtq+gPmSzvi//O6twEe/8c89A/fsGcIl+loiFv
         q/A1dkSrbVzSDCcyMdmoj/Vr1jfLlLKYMxYMmqucs09EvLwTkaaezjazuPe4WIIg4FXX
         nyrg==
X-Gm-Message-State: AOAM531APSqbwTRJZ5/EMgJSuCMwioeuJtkqgLodvyNlbZhFbt9lb4/l
        3MMLoqEsxAxyldALC+qFTQaFgA==
X-Google-Smtp-Source: ABdhPJyMbmvKuw2o6HP/fWAktFqGbLrrlmhfr878Yf0WF93YKUoJ+Kr1riIShO8o8AHIempV+slXXA==
X-Received: by 2002:adf:b312:: with SMTP id j18mr23975841wrd.195.1593589812089;
        Wed, 01 Jul 2020 00:50:12 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:7023:727a:c688:cf9b? ([2a01:e35:2ec0:82b0:7023:727a:c688:cf9b])
        by smtp.gmail.com with ESMTPSA id r3sm7018280wrg.70.2020.07.01.00.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 00:50:11 -0700 (PDT)
Subject: Re: [PATCH v9 00/11] Genericize DW MIPI DSI bridge and add i.MX 6
 driver
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Philippe CORNU <philippe.cornu@st.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yannick FERTRE <yannick.fertre@st.com>,
        Andrzej Hajda <a.hajda@samsung.com>, linux-imx@nxp.com,
        kernel@collabora.com, linux-stm32@st-md-mailman.stormreply.com
References: <20200609174959.955926-1-adrian.ratiu@collabora.com>
 <c6f10db1-7f56-a156-36a1-125e764c8c1a@baylibre.com>
 <87lfk3kaj4.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <268c1219-87cb-e611-ea13-e55e0feacea0@baylibre.com>
Date:   Wed, 1 Jul 2020 09:50:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87lfk3kaj4.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGVpa28sDQoNCkRvIHlvdSB0aGluayBzb21lb25lIGNhbiBoYXZlIGEgdHJ5IG9mIHRo
aXMgcGF0Y2hzZXQgb24gYSBSSyBTb0MgPw0KDQpUaGFua3MsDQpOZWlsDQoNCk9uIDAxLzA3
LzIwMjAgMDg6MzUsIEFkcmlhbiBSYXRpdSB3cm90ZToNCj4gSGkgTmVpbCwNCj4gDQo+IE9u
IE1vbiwgMjkgSnVuIDIwMjAsIE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJl
LmNvbT4gd3JvdGU6DQo+PiBIaSBBZHJpYW4sDQo+PiBPbiAwOS8wNi8yMDIwIDE5OjQ5LCBB
ZHJpYW4gUmF0aXUgd3JvdGU6DQo+Pj4gW1JlLXN1Ym1pdHRpbmcgdG8gY2MgZHJpLWRldmVs
LCBzb3JyeSBhYm91dCB0aGUgbm9pc2VdwqAgSGVsbG8gYWxsLMKgIHY5IGNsZWFubHkgYXBw
bGllcyBvbiB0b3Agb2YgbGF0ZXN0IG5leHQtMjAyMDA2MDkgdHJlZS4gdjkgZG9lcyBub3Qg
ZGVwZW5kIG9uIG90aGVyIHBhdGNoZXMgYXMgdGhlIGxhc3QgYmluZGluZyBkb2MgaGFzIGJl
ZW4gbWVyZ2VkLsKgwqAgQWxsIGZlZWRiYWNrIHVwIHRvIHRoaXMgcG9pbnQgaGFzIGJlZW4g
YWRkcmVzc2VkLiBTcGVjaWZpYyBkZXRhaWxzIGluIGluZGl2aWR1YWwgcGF0Y2ggY2hhbmdl
bG9ncy4gVGhlIGJpZ2dlc3QgY2hhbmdlcyBhcmUgdGhlIGRlcHJlY2F0aW9uIG9mIHRoZSBT
eW5vcHN5cyBEVyBicmlkZ2UgYmluZCgpIEFQSSBpbiBmYXZvciBvZiBvZl9kcm1fZmluZF9i
cmlkZ2UoKSBhbmQgLmF0dGFjaCBjYWxsYmFja3MsIHRoZSBhZGRpdGlvbiBvZiBhIFRPRE8g
ZW50cnkgd2hpY2ggb3V0bGluZXMgZnV0dXJlIHBsYW5uZWQgYnJpZGdlIGRyaXZlciByZWZh
Y3RvcmluZ3MgYW5kIGEgcmVvcmRlcmluZyBvZiBzb21lIGkuTVggNiBwYXRjaGVzIHRvIGFw
cGVhc2UgY2hlY2twYXRjaC7CoMKgIFRoZSBpZGVhIGJlaGluZCB0aGUgVE9ETyBpcyB0byBn
ZXQgdGhpcyByZWdtYXAgYW5kIGkuTVggNiBkcml2ZXIgbWVyZ2VkIGFuZCB0aGVuIGRvIHRo
ZSByZXN0IG9mIHJlZmFjdG9yaW5ncyBpbi10cmVlIGJlY2F1c2UgaXQncyBlYXNpZXIgYW5k
IHRoZSByZWZhY3RvcmluZ3MgdGhlbXNlbHZlcyBhcmUgb3V0LW9mLXNjb3BlIG9mIHRoaXMg
c2VyaWVzIHdoaWNoIGlzIGFkZGluZyBpLk1YIDYgc3VwcG9ydCBhbmQgaXMgcXVpdGUgYmln
IGFscmVhZHksIHNvIHBsZWFzZSwgaWYgdGhlcmUgYXJlIG1vcmUgcmVmYWN0b3JpbmcgaWRl
YXMsIGxldCdzIGFkZCB0aGVtIHRvIHRoZSBUT0RPIGRvYy4gOikgSSBpbnRlbmQgdG8gdGFj
a2xlIHRob3NlIGFmdGVyIHRoaXMgc2VyaWVzIGlzIG1lcmdlZCB0bw0KPj4+IGF2b2lkIHR3
byBjb21wbGV4IGludGVyLWRlcGVuZGVudCBzaW11bHRhbmVvdXMgc2VyaWVzLiANCj4+DQo+
PiBUaGlzIGhhcyBiZWVuIGFyb3VuZCBoZXJlIGZvciBhIGxvbmcgdGltZSBhbmQgeW91IHNl
ZW0gdG8gaGF2ZSBhZGRyZXNzZWQgYWxsIHRoZSByZXZpZXdzLg0KPj4+IMKgQXMgYWx3YXlz
IG1vcmUgdGVzdGluZyBpcyB3ZWxjb21lIGVzcGVjaWFsbHkgb24gUm9ja2NoaXAgYW5kIFNU
TSBTb0NzLiANCj4+DQo+PiBJdCBoYXMgYmVlbiB0ZXN0ZWQgb24gU1RNLCBidXQgSSdkIGxp
a2UgYSBmZWVkYmFjayBvbiBSSyBwbGF0Zm9ybSBiZWZvcmUgYXBwbHlpbmcgdGhlIGJyaWRn
ZSBwYXJ0cy4NCj4+IENhbiB0aGUgaW14ICYgc3RtIHBhdGNoZXMgYmUgYXBwbGllZCBzZXBh
cmF0ZWx5ID8NCj4gDQo+IFllcyB0aGUgSU1YIGFuZCBTVE0gcGF0Y2hlcyBjYW4gYmUgYXBw
bGllZCBzZXBhcmF0ZWx5LCB0aGV5IGp1c3QgYm90aCBkZXBlbmQgb24gdGhlIGNvbW1vbiBy
ZWdtYXAgcGF0Y2hlcy4NCj4gDQo+IFRoZSBiaW5kaW5nIEFQSSByZW1vdmFsIGNoYW5nZSB3
aGljaCBkaXJlY3RseSB0b3VjaGVzIFJLIGNhbiBhbHNvIGJlIGFwcGxpZWQgc2VwYXJhdGVs
eSwgYnV0IHVuZm9ydHVuYXRlbHkgSSBkbyBub3QgaGF2ZSBhY2Nlc3MgdG8gYSBSSyBib2Fy
ZCB3aXRoIGEgRFNJIGRpc3BsYXkgdG8gdGVzdCBpdCAob3IgdGhlIGJyaWRnZSByZWdtYXAg
bG9naWMgb24gUksgYnR3Li4uKSwgSSBqdXN0ICJleWUtYmFsbGVkIiB0aGUgUksgY29kZSBi
YXNlZCBvbiB0aGUgcHVibGljIGRvY3MgYW5kIGl0IExHVE0uDQo+IA0KPj4gTmVpbA0KPj4N
Cj4+Pg0KPj4+IEJpZyB0aGFuayB5b3UgdG8gZXZlcnlvbmUgd2hvIGhhcyBjb250cmlidXRl
ZCB0byB0aGlzIHVwIHRvIG5vdywNCj4+PiBBZHJpYW4NCj4+Pg0KPj4+IEFkcmlhbiBSYXRp
dSAoMTEpOg0KPj4+IMKgIGRybTogYnJpZGdlOiBkd19taXBpX2RzaTogYWRkIGluaXRpYWwg
cmVnbWFwIGluZnJhc3RydWN0dXJlDQo+Pj4gwqAgZHJtOiBicmlkZ2U6IGR3X21pcGlfZHNp
OiBhYnN0cmFjdCByZWdpc3RlciBhY2Nlc3MgdXNpbmcgcmVnX2ZpZWxkcw0KPj4+IMKgIGRy
bTogYnJpZGdlOiBkd19taXBpX2RzaTogYWRkIGRzaSB2MS4wMSBzdXBwb3J0DQo+Pj4gwqAg
ZHJtOiBicmlkZ2U6IGR3X21pcGlfZHNpOiByZW1vdmUgYmluZC91bmJpbmQgQVBJDQo+Pj4g
wqAgZHQtYmluZGluZ3M6IGRpc3BsYXk6IGFkZCBpLk1YNiBNSVBJIERTSSBob3N0IGNvbnRy
b2xsZXIgZG9jDQo+Pj4gwqAgQVJNOiBkdHM6IGlteDZxZGw6IGFkZCBtaXNzaW5nIG1pcGkg
ZHNpIHByb3BlcnRpZXMNCj4+PiDCoCBkcm06IGlteDogQWRkIGkuTVggNiBNSVBJIERTSSBo
b3N0IHBsYXRmb3JtIGRyaXZlcg0KPj4+IMKgIGRybTogc3RtOiBkdy1taXBpLWRzaTogbGV0
IHRoZSBicmlkZ2UgaGFuZGxlIHRoZSBIVyB2ZXJzaW9uIGNoZWNrDQo+Pj4gwqAgZHJtOiBi
cmlkZ2U6IGR3LW1pcGktZHNpOiBzcGxpdCBsb3cgcG93ZXIgY2ZnIHJlZ2lzdGVyIGludG8g
ZmllbGRzDQo+Pj4gwqAgZHJtOiBicmlkZ2U6IGR3LW1pcGktZHNpOiBmaXggYmFkIHJlZ2lz
dGVyIGZpZWxkIG9mZnNldHMNCj4+PiDCoCBEb2N1bWVudGF0aW9uOiBncHU6IHRvZG86IEFk
ZCBkdy1taXBpLWRzaSBjb25zb2xpZGF0aW9uIHBsYW4NCj4+Pg0KPj4+IMKgLi4uL2Rpc3Bs
YXkvaW14L2ZzbCxtaXBpLWRzaS1pbXg2LnlhbWzCoMKgwqDCoMKgwqDCoCB8IDExMiArKysN
Cj4+PiDCoERvY3VtZW50YXRpb24vZ3B1L3RvZG8ucnN0wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDI1ICsNCj4+PiDCoGFyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZxZGwuZHRzacKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA4ICsNCj4+
PiDCoGRyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvS2NvbmZpZ8KgwqDCoMKgwqDC
oCB8wqDCoCAxICsNCj4+PiDCoGRyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHct
bWlwaS1kc2kuYyB8IDcxMyArKysrKysrKysrKystLS0tLS0NCj4+PiDCoGRyaXZlcnMvZ3B1
L2RybS9pbXgvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqDCoCA4ICsNCj4+PiDCoGRyaXZlcnMvZ3B1L2RybS9pbXgvTWFrZWZpbGXCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPj4+IMKgZHJpdmVycy9ncHUv
ZHJtL2lteC9kd19taXBpX2RzaS1pbXg2LmPCoMKgwqDCoMKgwqDCoCB8IDM5OSArKysrKysr
KysrDQo+Pj4gwqAuLi4vZ3B1L2RybS9yb2NrY2hpcC9kdy1taXBpLWRzaS1yb2NrY2hpcC5j
wqDCoCB8wqDCoCA3ICstDQo+Pj4gwqBkcml2ZXJzL2dwdS9kcm0vc3RtL2R3X21pcGlfZHNp
LXN0bS5jwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTYgKy0NCj4+PiDCoDEwIGZpbGVzIGNoYW5n
ZWQsIDEwNTkgaW5zZXJ0aW9ucygrKSwgMjMxIGRlbGV0aW9ucygtKQ0KPj4+IMKgY3JlYXRl
IG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5
L2lteC9mc2wsbWlwaS1kc2ktaW14Ni55YW1sDQo+Pj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9ncHUvZHJtL2lteC9kd19taXBpX2RzaS1pbXg2LmMNCj4+Pg0KDQo=
