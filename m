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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BC2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A6B20884
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="XRRiBhaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgGBHTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:19:55 -0400
Received: from mout.web.de ([212.227.15.4]:42241 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgGBHTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593674376;
        bh=L73sHj2h9ReOcB0fBQ3Vw4wShxH8yb2IL2KxOLyoh3Y=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XRRiBhaEjW7ldflas2Bl28hfOJbbw3uvi+H5hleWQOAwEQRr2k8oVP1FF7GgkRKfE
         VAL8R2qU+S7HjnsUrBa8wQhxyN94HpHiDZs08CH+wDSCPS1TLM5Z5UkaydqwOWYTVs
         2+5L2+uYYyWifBjZKrwX/jk1jQMeXClslsZVGTLg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.138.52]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0McBct-1jYXho3dNn-00JeSm; Thu, 02
 Jul 2020 09:19:36 +0200
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
Message-ID: <0467b59f-d3ec-619f-fdc6-eba1a9920fd0@web.de>
Date:   Thu, 2 Jul 2020 09:19:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c7cc848a-1ce0-e877-aa44-ebafe4b5985c@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:yszIQcaXyF3mA0MiNWAtK4Ql7e5cGHvBKi5oREG0WSCOc4AIH+K
 IVEaM01DhWeWOnoLhZkYTARAXHEBCx1rilKAjDAnKPWdyCKFm45eL52+4dL9dJy749hDjuw
 nOKLU+PFR6sJwPj1V/4T5TeD7x39lTtb/cU29EXlhv2rifZLQXX1ByTU9VKHMSgM7/vRF9r
 8+mxED+ZB3jKUvW8YWpQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Et30WzAWpsY=:s9w6cdqkm79dpUjUktcj8A
 9WdOiHxPj3cWqbOgacSI/69kdwYqxLtZYAkebzPQoLqQohi+U2hcwlv5tbxeDqSfUVHX4A/IQ
 sHHpXbBgPyhTOjfrjOrZg+L2HSrPtDWupVxuHYjuEYyC4uHxdNMIgP8KBJ9nfqEz8aLed9XmW
 Ac/0tjX2u70XwhOIvILSeyZ4+zPDwDlS4QVoSqTHo4kQsUcOpxsyA1e1hO3y89hkQnGoU13bE
 rAFvP/4caO2O930A8GXhSqSmDCbIbHIhAmDz+RN564Cc1ayhwHuI8gWSRoscr7d0lLj5oVfJz
 baS0/Cr7vY658uTWvGv1FZWAD1c6+lnYa0DpHMGTK2XmxN3/rUcMDj++evIDBeYkxzMW4IFWG
 a6fsI5RCt5MjgnjjaT0D5X888Y8768PaoHTdZ3H89Yvn7dIQVsgj849F7f1NLTcpYVjvB4m1t
 0ESxGAli0936G7pdPPJ6bCJZagG7cVB1t4e/JxelSpd9GMIjWVTZsRJ0fYJ4Lh/b6nX8WRTzp
 a9Zdr+EjNzyzIJz3EA7wgZWLNoCe4SkUdpgCScMCbCFWO1CbjB51nKsprOOtjSYnL5FbCjkY+
 Ys58UFY+BEoYS2t3StGKsWDT0DiVvsJmtyMJMbDcEcvyiJuMioBPYXKAGDdaIqe3O5bLW1aN4
 z0j8PGtpa1LnsR4iZimbkjdwVl89IAgbe+dFa/mKNUy6U4GxbCBRCB9MB4261bO1q6hgv48Hc
 fjGbrYMEyDd1V0sLW1nJ6h2P05EV2EpLX6k5306vS8wEWkLuB7WapdODFpJFNgEij1nzv5H+W
 22zTs1BdZAUas8C1CuA/Lwm2tz57xH2fiMj1N1s79FDBSpiQxRZH5ANsc0XQgy0jAWOAuYkkj
 8j1a1pOp2ladhizurhzUa1exg7Dg7rq+6GCa+5nVVlrXMT3F3QlIxYGXd6aic5tYhDyZe/2Lg
 pH479dHNLSzwMzxmRP00gYWLv3p/6PgC5J4w9Uipq31Ca3jGv22ScSbY0aIfniAUB/JxPwNAY
 IB04h5M7Db+A2TDqqc67FWbYuKzoQIMSEWRNGnBqRes27GUBakVx+/Y9//iNyPq1+T2i8q5sD
 HGCaC01inLpf0Tw35Hd+UKqO/IaOKdl7D26WzYKpViT4mW7/qxeimBdLa3euG4tVyWAlo+aKr
 LhVeif8lppujiItXvUcZJpDAbklIEZw7lOP87Gvz8aRK+VONhVWX51R+TgOtFDaLUbW/twAjK
 yQANHXZVdUM/FECDU
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
