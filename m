Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D7AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 517EA20874
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="jlAlEokt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGBHTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:19:48 -0400
Received: from mout.web.de ([212.227.15.3]:34971 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbgGBHTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593674375;
        bh=L73sHj2h9ReOcB0fBQ3Vw4wShxH8yb2IL2KxOLyoh3Y=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jlAlEoktcY1X82j+DGfpwmpeqsEruVEpr+Ktv0MM80AaVbTk2lv3XADSAZXK9NBYK
         LoNiQXZQCSyUHVPUD/IQMoeuoQ3EWI0Kyjhf5RkjFZcKnlvSkc4kvWU5EegLWbpO23
         GdO2WFVH0Nt8Ysc9SzCsC0mW8RFoqeeTlSi3BUek=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.138.52]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M09uu-1iwiz51vGG-00uKds; Thu, 02
 Jul 2020 09:19:35 +0200
Subject: Re: [PATCH v4 02/14] irqchip/csky-apb-intc: Fix potential resource
 leaks
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
 <1593569786-11500-3-git-send-email-yangtiezhu@loongson.cn>
 <564ffff9-6043-7191-2458-f425dd8d0c11@web.de>
 <1a0e007a-db94-501b-4ab9-0bb479ec093b@loongson.cn>
 <971c649e-fe07-3771-6fea-f5aaeaf090ad@web.de>
 <c7cc848a-1ce0-e877-aa44-ebafe4b5985c@loongson.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <41b48aa5-e5b2-0257-8b3d-07e1b86634b4@web.de>
Date:   Thu, 2 Jul 2020 09:19:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c7cc848a-1ce0-e877-aa44-ebafe4b5985c@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:kK/QeWcZXtLOWEEoBvnKkNv33DPKk/yPZ8ZQ5iDxIHo6UgWxn2J
 DglVU6EJvbrvvjXS9h3nSMdSnJcF0TiRJAFc7YuoxWtP2/5YpMSCz9BQDTIav/MBiTQLIO5
 b9ujhpPtBcqCdncvBrA3xKyIwm8utoZX7x+/dnqa7hZXr6lQHoqShfk6aseyTahK9km+IQj
 pwL9WOt0z64nQnrS4BxTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZmD6WdfhlwM=:VFsWFp3saLGwJfFsAqf0ZJ
 2dW+ozUZ1rETghxUkzGb1jjeenmDqcIpH7gLY0nWGVPB+dGJJS7iTfJrx8tpAXDZ12VILOuRk
 AjpzFe9wPJAM5HQqlM9HBQgsJwnZlvQGYXFGic5kQzgAJIEvtOgWO0uFIrE5U9DOSat2gNVGJ
 qPnKiftKaHLRRofYCJ17zRh21VzeXqOOgTE14IGD8Jsy49WEkGhhiIjLCVeM3DCH3B6TBrFS7
 K/KaVbY8PtukGNxSy2J5f6Q6NzXgYoWXZIbm3/l1s9T/FnLd9qKjgiufw+rU++cD42J6Dr0ip
 OvT5wdjGChV03zQdlRy5s+ysOACB/d8yV29c7X+r5etPOTq/NWRgZ+GF8jrJFnVk2hYc/hD6W
 QXT3nPqjlHUumzyEkWK8HAKKOVC/vq0+eq+FLSiO4CIcG47Z0us5mGVFoCCD1EIOF3Or/Znqq
 kLzt5gK5qVHffqAxqYnvd2HyQciATmbY3k0cWI4a1mWSICQRE9SyCLbr9wSOVcbV0ku9Gb+T5
 tvHF+TeUcMne2Vn9Jbm2j9BxkWJ9D3emvoT0I3rcvLMcNdXty0jw+cU3GbarOgd460nLugRPw
 5f7xUfcWOzhSMjHWxMHQJBpIHOvyO3CZlnO5tLlL03BmwKtjjPHNnCNBe7LDo725i65xmokn1
 5je6rBkR3Arb32cDhldbcuWyGDpi4FJb45D53tTm+DCSgliLo9b9Ynw6KnYvvckM1l2ONaMV1
 giMHOC8YVGAH/fU8+pGxnd8PktFP+q3rhyTvm/EzY3NOmOGcYLtAcWi0oeAI2UHy9hFP38ne+
 ltgGC9dlAsfAFjr2eSnXxh02wsi33U3OuF6ZxL5RGntqpenwJK6Src5ADj39hHa193tLDitvL
 7YkI3STb2xYZkR7Qq44G42tiGfwLHHrzp+9bOwF3oD+THj6vN54u6KQS4Rx2g9XA/hR61vjOV
 sUpB7BticR5HclRactjjdFZ2KmcT2cjI8WLY8ixHWYu52zTMAKuK+4UOpqqvLfSYZpX7N3Keg
 aWNyItvebWT94kpybMAISudajxNuFlUvH5Rc8TCx93/zvJjfg8qK4UW4bUVFCpyFQHQOxkUG4
 E3N+EY+i2GYh2A5tgpe7p0ZirHlGj6FmfWSL8kQzjVR3N5SP6GgCp+nxsVXS1eS6pCxp88z2l
 dtKeeEV+7kUksVYX0sbZeTIBd9uiKHWMoqXsrUun0b8OxZN46pmVAtsTwsXLo8vuZLhJmQc4V
 2xz2VF3ADsBB9/hNRF98Mnv2/ywL4HyXm+bZ7mg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+ICsrKyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtY3NreS1hcGItaW50Yy5jDQrigKYNCj4+IEkg
c3VnZ2VzdCB0byByZWNoZWNrIHRoZSBwYXJhbWV0ZXIgYWxpZ25tZW50IGZvciBzdWNoIGEgZnVu
Y3Rpb24gY2FsbC4NCj4+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9jb2Rp
bmctc3R5bGUucnN0P2lkPTdjMzBiODU5YTk0NzUzNWYyMjEzMjc3ZTgyN2Q3YWM3ZGNmZjljODQj
bjkzDQo+IA0KPiBPSywgdGhhbmsgeW91LCBsaWtlIHRoaXM6DQo+IA0KPiAtwqDCoMKgwqDCoMKg
IHJldCA9IGlycV9hbGxvY19kb21haW5fZ2VuZXJpY19jaGlwcyhyb290X2RvbWFpbiwgMzIsIDEs
DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiY3NreV9p
bnRjIiwgaGFuZGxlX2xldmVsX2lycSwNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIElSUV9OT1JFUVVFU1QgfCBJUlFfTk9QUk9CRSB8IElSUV9OT0FVVE9F
TiwgMCwgMCk7DQo+IC3CoMKgwqDCoMKgwqAgaWYgKHJldCkgew0KPiArwqDCoMKgwqDCoMKgIGlm
IChpcnFfYWxsb2NfZG9tYWluX2dlbmVyaWNfY2hpcHMocm9vdF9kb21haW4sIDMyLCAxLA0KPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiY3NreV9pbnRjIiwgaGFuZGxlX2xldmVsX2lycSwN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSVJRX05PUkVRVUVTVCB8IElSUV9OT1BST0JF
IHwgSVJRX05PQVVUT0VOLCAwLCAwKSkgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcHJfZXJyKCJDLVNLWSBJbnRjIGlycV9hbGxvY19nYyBmYWlsZWQuXG4iKTsNCuKApg0KDQpX
b3VsZCB5b3UgbGlrZSB0byB1c2UgYWxzbyBob3Jpem9udGFsIHRhYiBjaGFyYWN0ZXJzIGZvciB0
aGUgY29ycmVzcG9uZGluZyBpbmRlbnRhdGlvbj8NCg0KUmVnYXJkcywNCk1hcmt1cw0K
