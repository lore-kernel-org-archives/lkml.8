Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67516C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417B520702
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="OBqLHdtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbgF2TH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:07:28 -0400
Received: from mout.web.de ([212.227.15.3]:52165 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730566AbgF2THI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593457625;
        bh=pioBlt+k9nGWRixLbuXdhL4vSY3ibRE8urYPEMcMLig=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OBqLHdtE1RTar2bsiaZaWgq/6EYTwnn5RQtTlze2QaWdv48jee1h7YJzgtZ9zBf98
         VFHC4j1pZkSDRnZ2QNy+/o6n6ShMa9jomfj+EUxpHjEECBuQsB9ilP+dZOk+tpJvEu
         iSQS77lq3MMNLQImBizVbLxsoW3SRpwp6Zkv+kFQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.123.16]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LoHKz-1jAY8k26Ab-00gF4W; Mon, 29
 Jun 2020 18:19:43 +0200
Subject: Re: Searching for initialisation of variables by function calls
 before null pointer checks
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
References: <1593410434-19406-1-git-send-email-chunfeng.yun@mediatek.com>
 <1593410434-19406-2-git-send-email-chunfeng.yun@mediatek.com>
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
Message-ID: <5b693ee0-0cb1-7ff3-b562-bac6bcb6aae8@web.de>
Date:   Mon, 29 Jun 2020 18:19:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593410434-19406-2-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MvjbbF8fHz31+atifBksu7NbJVe858VtHtK/6+a8RB2HWH7I2/5
 /x3sQNu8leNfSxDz6S5bcsx/2Z4QtVMIrtB3828HXtbFXJ1PILSSqnTUmycZgQBvGIeuz9s
 aZEUCtPMg3y/HViGEUOqNNA0OU5Z6Jekbq3Mcs8APDnc+aVdI71H8okJT3oH2ZMEDXASYJq
 /OpNfKLL7rR6h9GlJbwtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JjwsdSR3taY=:wMZMDpPnrmBGUZVysW0oMu
 7E8MM7c+GBWZ39RhcWfhbb59uTpWp94ckpTzZHLEw5Gl3L0paITeL6LvtfWCYBx3sR6G7jl+X
 JcZzZqGCdiyDeeiiJY6YWsqYUl+asTOe6Vh/HYX3jIZhb0/+UXPioEuNfzWuUC+CzBNvRiNkW
 nFbRQnGdLMA/ntMezCHDigsYWgkXVphJP8oULrf2KqvFAWZ8P8Dhp37LexEyE0YNGY08U49f2
 JxYkCxFAbJgG6aMwJmTiNjd9PXbf6Krah+LbYrB2xl8CvIzN1EYWfPx70zloyc2JJqSCTr+36
 ht/kG5+26mb4PH6dzYup/cSg/ykHH0qoVSDR6aNsf5X3ocCn//PA9hdmJBAG8PgT6ObrrM4jg
 EBhydM2CmQmoeqg08RWPpZFa7CU4t2eRLTOYrJhOK7QdN9cyRS1fJJKtRi3Vw7jBuWUFOC9il
 x/iRisHbfmawZk05t04AKPQqiRh257I/M0Jv/RpinSrQU62JSxsmEMPX7bwYDOdsZJbYfaJuW
 rWHZM376J6eIC3vOM8V+NXwVvOczk+ofK1rIhVn+drsJCGACEVdlT2Mww5vXHRxROG5oQLyUv
 p+ESYQ8hGQ+n4qeOtXTE22ILcMf/1IV7dNszc7zAlEFhLxAzJYIhOfOZ8UUky9k0CrVWBAzBI
 khUJm7OJ3SVr6NUbelm1YSwdWJ6WsMF4CZxzUAFgi92NVNIUNZPTa58envLcgIbnOmZLpKtXJ
 0LHrBASYhG+pi+kN16/HUfpSKGhx/OAqsOiN7znlOwptTkuhnU1BbT5bXOwfiVsSwf2jjw23j
 Ny/2wbtaKBv+k4IW2vOs6ntCehiqLZrkfzwMbOeCjjsk9rWwha8SD17NN6WNho41pvMCQPAqF
 zOa9VumaVkYuj4U9VsOhw0qj9NqPJr/pimTVOXZWr3g6d/hMnyBtFDEOYKJjvH0+eqIAgnNWS
 b7f3ajQlZSQEMeMDQuzxmtDvcur4EXxHbniXhVUBwwW9TPjXPWdNjbqdjIiMW0s/2f0cGMubf
 D3b+544FchJYBFM0QShKBsW0/qqTIH0H+VIsMIHVzUVV+Ezu21omFhhyivJcUr6RwqfNAyfw9
 XaKEUY7/hNvSWF2XtLXTaoIdmK8EFsVsqx5KEQdIM1zeo42LxkfcOqAlgrYH/C7mAO8tu9cRz
 6hH3QwWXhydckdRRdvx452yRMYGwiHMIRK9IuTg7OGRgoDEyqFCeqAKIO7XiBFn2KRJrRP94b
 H+Oi/O0eTp4WGpREp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Some pointers are dereferenced before successful checks.

A source code place can be pointed out in an acceptable time frame for
a single file by the following script variant for the semantic patch langu=
age.


@display@
expression action1, action2;
expression* pointer1, pointer2;
identifier result1, result2;
statement is, es;
type t1, t2;
@@
 t1 result1 =3D <+...
*             action1(..., pointer1, ...)
              ...+>;
 ... when any
     when !=3D pointer1
 t2 result2 =3D <+...
*             action2(..., pointer2, ...)
              ...+>;
 ... when any
     when !=3D pointer1
     when !=3D pointer2
*if (!pointer1 || !pointer2 || ...)
    is
 else
    es


elfring@Sonne:~/Projekte/Linux/next-patched> time spatch --profile --no-lo=
ops drivers/usb/mtu3/mtu3_gadget.c ~/Projekte/Coccinelle/janitor/show_poin=
ter_usage_before_null_check11.cocci
=E2=80=A6
@@ -332,14 +332,11 @@ error:

 static int mtu3_gadget_dequeue(struct usb_ep *ep, struct usb_request *req=
)
 {
-	struct mtu3_ep *mep =3D to_mtu3_ep(ep);
-	struct mtu3_request *mreq =3D to_mtu3_request(req);
 	struct mtu3_request *r;
 	unsigned long flags;
 	int ret =3D 0;
 	struct mtu3 *mtu =3D mep->mtu;

-	if (!ep || !req || mreq->mep !=3D mep)
 		return -EINVAL;

 	dev_dbg(mtu->dev, "%s : req=3D%p\n", __func__, req);
=2D--------------------
profiling result
=2D--------------------
Main total                               : 2.030205 sec          1 count
Main.outfiles computation                : 1.648542 sec          1 count
=E2=80=A6
real	0m2,122s
user	0m1,977s
sys	0m0,037s


I have tried this analysis approach out also for source files from
the software =E2=80=9CLinux next-20200626=E2=80=9D.

elfring@Sonne:~/Projekte/Linux/next-patched> XX=3D$(date) && spatch --no-l=
oops --timeout 12 -j 4 --chunksize 1 -dir ~/Projekte/Linux/next-patched ~/=
Projekte/Coccinelle/janitor/show_pointer_usage_before_null_check11.cocci >=
 ~/Projekte/Bau/Linux/scripts/Coccinelle/null/next/20200626/show_pointer_u=
sage_before_null_check11.diff 2> ~/Projekte/Bau/Linux/scripts/Coccinelle/n=
ull/next/20200626/show_pointer_usage_before_null_check11-errors.txt; YY=3D=
$(date) && echo "$XX | $YY"
Mo 29. Jun 13:54:54 CEST 2020 | Mo 29. Jun 17:22:37 CEST 2020


Unfortunately, a lot of =E2=80=9Cexceptional=E2=80=9D data processing resu=
lts were logged then.

elfring@Sonne:~/Projekte/Bau/Linux/scripts/Coccinelle/null/next/20200626> =
grep 'EXN: Coccinelle_modules.Common.Timeout' show_pointer_usage_before_nu=
ll_check11-errors.txt | wc -l
454


Will such a test run trigger any further development considerations?

Regards,
Markus
