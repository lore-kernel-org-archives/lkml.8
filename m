Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C660FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 06:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28F52081A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 06:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="jM6ioFuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgFEGnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 02:43:31 -0400
Received: from mout.web.de ([212.227.15.4]:56007 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgFEGnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 02:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591339398;
        bh=N8Q7hyBR5uvg6/uWiiaPsqnWwBDvfxFBrSltitvHp84=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=jM6ioFuuPsygCIbvBdZK8ajH1uKl3ssnPD30NbQqci7MZ7iUhjTWtYJWEA9tllE03
         zRvejLxszdI+m0MrIvSsn5BtifR9D0QaeocRFaBvK8q0cjwLiTGbTeHIMNC5OIYxVD
         K7SxhMEKGC3OjTL5v3J63xoafZggc3L1D7i4h0J0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.102.114]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNfYN-1jJ7Az1XFz-00P2uM; Fri, 05
 Jun 2020 08:43:18 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] coccinelle: api: add kzfree script
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Message-ID: <99e0349e-9392-b610-05b6-8f90986073fa@web.de>
Date:   Fri, 5 Jun 2020 08:43:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:3n1lKZLlK2kY4L3XBHhB2QdV5UADpledGUkfuQpGdeA+FeLYtzN
 uKJeyTjsw20wWmwHzvid9FeZSyBv1KTU/Ea/dBBrKCgBUL2K8BwBu0LXD5M0Etts7giBUiR
 LtagjbkV3xa+I/T/zIaCA2eOuHb9CPPcqKahn572RgM019RzwOwjCCAiz1do6ZJqVy4Uwbq
 yFYBHizQ9bVBLr2OG60Gw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+1aJiyAWN4M=:n0ofJPYKAz1rQmuaCclxBQ
 PjXtksTLyy2E+HoYb24bPnF6lpW8pYfDf3guaT4abcQudyYWkA1K3qUZLvIhbQzq9oVtUcKD/
 YAEWL3Jg+GZ40BDeJrZW49G4n6Ut5V6w4M8+eIlRozUCqXi3Ir897yhZbQN3P7AvUi3rIsvK8
 UniBNjpSVC9HI6KCz4EkOzNHoVeI3iaEtNFExM4KkNMjjl3fZGfA+We0C7fbX2MiEZUEquSJJ
 u0FwoE5cFZBoEsk5fUgdmcdCR9IIZh0UTABfwSGyN5L2sWK1EqIKlqMwpL/N1uVPNtHMZHLlu
 /wrtgMA4BlMkTat6Hm2hUvIQEEh4w0heOb065PKeMCfTVRlzOOmIbMCgebbM7eIecUhCjY67d
 qAVB68ULRmZcQ1LnrnWeKzyy34OQF6vxWvWEj6/5JCJ9o3qxBhAa/B39djb9iJSV1T484R791
 2vZ43V9+Ur3ReqsxDJ6oEwMtmSdiezsGUSZzpwTeG5X/8VOkKkfQYvaRR8wSxdEabMT96Smos
 gtME9vG2cp9xIvKx06R8xr3XpF8SkG6TKl+riQMx2852aItX5EfsW8pF8lHwmgNhMbwSGkacO
 JI6BSYlfbhStp6IYhxMe1pykCUtKe3P+haNL2WYlpnp/wxmiNrTebQW+CZ+WMBQosnmFaAL/q
 oDGrAlSwAQQCr03jPUSoTDIxOl27/xsFwJT+QWx8BN/hj7+Pnkjvrz+/F4EG6KcWPrBJkWbiJ
 H1mGgWCZC3NYj+rpGxZJ1lqPQgr5NIjfCeF0oDTRrQiOk+jMH99wxPbZyV1XMUidykrJ7y1n0
 44KjN/qyI2wYXCXrklXKhxRwqPCZiLXMTfswkZwj/V6mZi9RCZFVa7IAMvi1Bq44wSz47grt/
 26wygLRwdmSqf6+NF6IDgAd2Pe0JYmky8Sc7dB215PUfLpnSo0irm07YMOzmVOtwS1KYqfEBR
 U2ayhjMeiL8NDXxiUD9KjYrY4xq8vajFdgIuCMNjvFVi3x28EHQwPVkt0xpEiqao/366JszcS
 fCnlCvJeZWGWnaggkNBx47H5mOJ71GWjAwNjBM+DxukA5VvTWlUCp3ARvWPqz40O+GwMNARPS
 Hx/OmVX7EVMi8wDHUammaIEC0Vf5sddsY6E6aKm5sxFvX4KXta8fshDdA102walDqGcc6HQse
 hmUn9C4waWFozFESmvtehuJBFcDbbrMKtxk9KCDgqYQ///sWkJyC3PsAeDkpdjMTW2mhFA23K
 rwY257wlg6l2eOHle
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Check for memset()/memset_explicit() with 0 followed by
> kfree()/vfree()/kvfree().

Another software evolution will become interesting here.


> +/// memset_explicit with 0 followed by kfree

How do you think about to extend this comment?


Would you like to take the following SmPL code variants into account?


> +virtual context
> +virtual org
> +virtual report
> +virtual patch

+virtual context, org, report, patch


> +(
> +- kfree(E);
> ++ kzfree(E);
> +|
> +- vfree(E);
> ++ kvfree_sensitive(E, size);
> +|
> +- kvfree(E);
> ++ kvfree_sensitive(E, size);
> +)

+(
+-kfree
++kzfree
+      (E);
+|
+-vfree
++kvfree_sensitive
+      (E
++      , size
+      );
+|
+-kvfree
++kvfree_sensitive
+       (E
++       , size
+       );
+)


Regards,
Markus
