Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC44C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39EC20760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="HlXEUEc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbgGANEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:04:45 -0400
Received: from mout.web.de ([212.227.15.3]:50267 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730556AbgGANEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593608661;
        bh=jPFV0ur8nLdZEhj2YuZemYbcE6QQWuflBtFcXaEDR6A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HlXEUEc+a36n7ZM0qXKO9FJPSPcLRK+rW6h2cQe6vIrMJOOkrBY4ZAY4oFPHwVcPI
         Q5G3hQoWdDWGtAtvgFQQA1Hp6OQ1t68mpZVGymQLmK/isdFhYXO12TqPJW/7nxRUaW
         SqNT9VTMP8O+VIzfE8ZaKzyn0yw7wMtmjVO7ZI4E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.41.17]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M9oW8-1jfe3x30DQ-00B3t3; Wed, 01
 Jul 2020 15:04:21 +0200
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
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <971c649e-fe07-3771-6fea-f5aaeaf090ad@web.de>
Date:   Wed, 1 Jul 2020 15:04:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1a0e007a-db94-501b-4ab9-0bb479ec093b@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:7OSzFhibVDDC5R7IvBZIWSm0D8FFC3b0BzYmHzqIz4rVZSakt7C
 DWOPJRWuiQIppjtS5ZM3cUO+ou1IFMjsw4eecnFecR5eDrlQwrzyCAIytmHVszNHKcBiBYT
 0zRFF/L05OE74VYLX5Hq1I/6wU8a3c4dyzchDpAYc3TPsTyUaMZo7oRTT4wIwEG1QBMWPHU
 WFpTbXngAVMDOFMZcji9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rRv+FrSsC84=:8PN88Oo4zaAewqDtfw913A
 4jSKBXudv+VDTbAlEgxQeFJwSjbo+5F1VuktlebnN59PA6Sk5gmEcvD8CVU+ithlMfk7zaew7
 fH97clj4QwLhsl7Es/4r9k21j8ndz1tZSVmI4V7gtyM1u7PQYVRQzOgxq5BdNEA9DYhs9fa//
 KLAPUB0e6Tg23rK0UW/46tGfgowyEjG4FGfSUCbbxiX7SEmY7Bw0IYamDVGR4fdmH9Is59sCh
 lsZgyu8XeXcTTbPtKqMbxwR3lSNs0VETeCr0qdnGP3TNbsADsq6HE/U4kIbSN/xEf+0pNZNRj
 Z7GA6EowIA4ZrrZz5oFioh0HDUhCNob1iSPprnnJ1Ceyu5wYvnWS5KsUymCMbtqBQJNnbfdV1
 SkxhjOW92FoBd68vVFLmY/EKaSKR1/10+Yg3CoprUjohJBSBTN9IKucXQbdkY0T2OQolzqEXF
 WXWT3P3nGIQli60iQO4zitQTmV7fBzq0p18E/jtgGS5i5IqtJlrowBgxPe93v0tHd2vEWsh4H
 lPud2Cao0FRrGqGXHtJwnBxIh7SOXYcORxsF+UI6NltYyjE6F9ALKzQdahFcI7Ou9ifici6hQ
 bn00MeJreoFdg1Ho+wGxnXdH9gJrdo0c2DQ+ZYTtHMmo/PYm8Cc+IVB8zKoeWhBSqUc8MsTia
 TZjhWmSsKns6iK20RtYTEnVBhwl0tah6Asup0oUnRE8ZhdzDO1N9F6GBH7D5ptVkzugxwzNSG
 KwK8hJa7t8SO4w4FcE5xRtxt3AM8JD/489Au2s3Qq6QvLcw47P/EoOIXtoyDyY3L2BYfhznfk
 KOP8+8RlmANf3TpkjKvLBWMNubkLTv2IgAD8DAu3Ztq7+Di+yZhcWemX2/GiJed9epu80oNG5
 JdC5dJT5nRCrxf2ZuazJHXNz3GConX4sOE1BV2j07e9klizuU9Rn3L4RCOOOl//X8N2z7PM9t
 CzeG26gmdgnYth4eUC4+b6t67YYV7Ryu1UiWIfuBGlRvdBSmpTu0oofYUj2K5gYyS0tR4t5v+
 PMBMuR4/uzhBYcshtYu9zw2L5bMca611Kpdm9phIOlLlmNCq97MhEQI4l1P6KYuGiKyxkCZj9
 29m5zXCCmFL0Pkb2mKVcBXxMZXlqA2sXJxP5n1MqnttcFv5s8Ar1oO/SC8fKbPUJvZjHepA8S
 GgxobDGMrL6Wgdcz52tWYL/ZD8TePNhxOBHhlf5HKgfnpdVtnzHVDWykZJef0GungbLQs2VEt
 wXcNtYTMZVzskegUQxR0I3ZOgAgu33cI9n0P3hA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJZiByZW1vdmUgdGhlIGxvY2FsIHZhcmlhYmxlICJyZXQiLMKgIGl0IHdpbGwgbG9vayBsaWtl
IHRoaXM6DQrigKYNCj4gKysrIGIvZHJpdmVycy9pcnFjaGlwL2lycS1jc2t5LWFwYi1pbnRjLmMN
CuKApg0KPiBAQCAtMTE4LDE4ICsxMTYsMjMgQEAgY2tfaW50Y19pbml0X2NvbW0oc3RydWN0IGRl
dmljZV9ub2RlICpub2RlLCBzdHJ1Y3QgZGV2aWNlX25vZGUgKnBhcmVudCkNCuKApg0KPiAtwqDC
oMKgwqDCoMKgIHJldCA9IGlycV9hbGxvY19kb21haW5fZ2VuZXJpY19jaGlwcyhyb290X2RvbWFp
biwgMzIsIDEsDQo+ICvCoMKgwqDCoMKgwqAgaWYgKGlycV9hbGxvY19kb21haW5fZ2VuZXJpY19j
aGlwcyhyb290X2RvbWFpbiwgMzIsIDEsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgImNza3lfaW50YyIsIGhhbmRsZV9sZXZlbF9pcnEsDQo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJUlFfTk9SRVFVRVNUIHwg
SVJRX05PUFJPQkUgfCBJUlFfTk9BVVRPRU4sIDAsIDApOw0KPiAtwqDCoMKgwqDCoMKgIGlmIChy
ZXQpIHsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIElS
UV9OT1JFUVVFU1QgfCBJUlFfTk9QUk9CRSB8IElSUV9OT0FVVE9FTiwgMCwgMCkpIHsNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX2VycigiQy1TS1kgSW50YyBpcnFfYWxsb2Nf
Z2MgZmFpbGVkLlxuIik7DQrigKYNCg0KSSBzdWdnZXN0IHRvIHJlY2hlY2sgdGhlIHBhcmFtZXRl
ciBhbGlnbm1lbnQgZm9yIHN1Y2ggYSBmdW5jdGlvbiBjYWxsLg0KaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvRG9j
dW1lbnRhdGlvbi9wcm9jZXNzL2NvZGluZy1zdHlsZS5yc3Q/aWQ9N2MzMGI4NTlhOTQ3NTM1ZjIy
MTMyNzdlODI3ZDdhYzdkY2ZmOWM4NCNuOTMNCg0KUmVnYXJkcywNCk1hcmt1cw0K
