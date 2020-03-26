Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27500C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2702076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="oAo+adJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgCZNmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:42:12 -0400
Received: from mout.web.de ([212.227.15.14]:40755 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgCZNmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585230108;
        bh=T42ERXuaUMVKOGPSSgBr30GVsHxoM3BRH22jDKxqvl8=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=oAo+adJIsOf6VDJbN0empgsuItciiNduH/3Pn8Yi4k5v9HRPZb8y4x6cCz2kHJr04
         kT78/wcBxSwCrfaAVGyrccXKsmh6Rkj+XtUYOT9DgGIpet42qds6uH0FrWT/ViZBri
         nbxgQVv8pCuI2l+DV+a9BYNSdKRHkS36SF9d67MM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.12.165]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MgZLb-1ivFLX0t67-00Nz4t; Thu, 26
 Mar 2020 14:41:48 +0100
To:     Michel Lespinasse <walken@google.com>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ying Han <yinghan@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] mmap locking API: convert mmap_sem call sites missed
 by coccinelle
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <02c6dfa8-0e13-d1d7-e335-ad8f1a3ecb1f@web.de>
Date:   Thu, 26 Mar 2020 14:41:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:KT0iTMi17feV47lyGFQUqJYPKeBlG3UMMyJIbndQNFUdLFxiQaa
 vcZljETlqk3EQoYRkxDWNmyS4Sc1VUat3Y4s/QPu3GNRrIi31enwAvrltzpilyLTKLfCcmC
 +COwTBF8gUzYT6QGhlKyb5jcSkmqkYx5pG8l+DXD4+jJ1yw/yBaUc7u2NnAT4nJx3dJg09J
 0ByRLymaBvRBZ4OfLzJfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ctvChQmXX5I=:+d7EIOZV33wJoVKfRDqNTl
 PO/YWova/IkfxsRNfA6QODdNQZZLKmnfOZ4FYetoX/qvWjibXQhawKTnjNA6FtgE2eKYH+KS1
 /0OeG2bpV+T5OWLZQPP+RBeDXzGLiIcq7KV1aToT2VoOQr6M5qLwC+hBDIIefsab5XjekCdkS
 T4uooaeARLgjXG0ftcrWFetXsBqwr6oUXHhbW4T/AQlcVIOZNpFfhW/a5VbW3Tv5X2ElH/W50
 Vi7UEZ5LRrA2q33xKF7XxS0tG85osExAZDCp+46//tQnhT6a99WNPJ6pCcGcL73MeJWhSJY9C
 kmupQ2VPUtov9lx/CDxcBbF5/bjlyCaj8JGjK08Ejg54wG2yXVyZzZYWjEmMNn0LQS4U+VFB/
 1tt1TqFyto5l3nxUBIg+0N5HTtdmSryzbuPYrA47xjX26F8u+Mh40wt3DUhJRoQJeLiSvzABi
 /xcdNkNW7CrZE8WJlxkKvuLvmaJPTwmzjWFR+fARLmFofV+IziN6BZ7GWgc/QArNZBkKzyJVb
 0aUugxl2xCBgbV5bSD2q8tqE9QU9rBlh1TAUNb4CMNI8a+0Oncg53EsVE9qovxwSMz5HuvnaS
 ++JMlbKw7gFAFERSA8mdE0sGNMP3RxFjjZ7974Phag28y2xrlNcjWb2XOjIBdOf0be1SduQ87
 dCo1VjKTI/inLd7s7AOCvE7+Qr2yGmLMomXhsvnUnzRGzVQ2QIVDLr+3czmrvQnwFzKbBZ5Vs
 bBAYGfWN7hMriaojcSh/L1WTu36PW94waVg8GuOMlRffXjOdicoA9SzH772KNHCiUGMqKsrTh
 HdT3qEGewCh//EYWhBc9swKnxdKjDcbdMZL82R8H9xktVEUZNrDzwyrluT2W99II8+ciNYsDT
 9BnaRylYJX9Jc7VoDX+mc5v8V9CPdJ9tbA4niZhluB9+xKHHLDeWEBiF5l7WtKq9XFvv31E9M
 QxhtRTBRfo1foFRV+jc3ktbyKDp5tgZN0e58RddAZppSe6pPg6XGvpl0k/okkCPvIZ7SKKrof
 g1wALSux/qZNZcAZ0IwFIIzdBwfcAuYY5m1Jx49vI7mHhM0Rt0HkewJy5/NZ3jm8zeTD94/Dt
 ndlIiXhn9Vi/vAUP+60oKpWvB6E2c4UocJ9xpIFP9IvoCo4mlq3b1M9U6ItIQWvq5mPLEXyR5
 Z13UhPJ1TFAA6G31RQ0AvMzbLKp3a3NPsG9Ao/NMFLRhouI78D0qBtwXbVghnqq67iGIlrB+f
 qk2xif2La8Vx1i870
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Convert the last few remaining mmap_sem rwsem calls to use the new
> mmap locking API. These were missed by coccinelle for some reason

I find such a software situation unfortunate.
Should the transformation approach be clarified any further?

Regards,
Markus
