Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3821C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C3A22C9C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="jnhOwfXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgGULCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:02:00 -0400
Received: from mout.web.de ([212.227.15.14]:58851 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgGULB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595329308;
        bh=3mWqkbTgKPrAGYk8E4y9ccWnbPH4+BJyKkViIIAEh9o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jnhOwfXOwmKiXgyckbG0LNrqtSjxgZ2EpZlRhJga/70amOBW7+3NYCXlfAqVm15oK
         ulndtFYAR9XAsVhjxGxlxDGfr1wrso8l20Wp030wiirL2+Qge/TF9TWlCcuWrFXFaP
         OyzwIdHET4sXd2Vr6aX4P6E+SgjPrC4IcWWbwoc8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.170.58]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M24rL-1kqLI03lD1-00u1J4; Tue, 21
 Jul 2020 13:01:48 +0200
Subject: Re: [v3 2/3] coccinelle: api: extend memdup_user rule with
 vmemdup_user()
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <e3d2ffb9-2a47-3d77-0501-9d48845435bd@web.de>
 <alpine.DEB.2.22.394.2007211158310.2487@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <94c24411-f829-fee8-8204-03a0cf8c5445@web.de>
Date:   Tue, 21 Jul 2020 13:01:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2007211158310.2487@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:qxcyx120ULZ1VDCM1sg0PScHuCWOI6MNHOrg7AfVrv7UzXzbpFn
 ayFV8TuuXHy3GA51csqJ00h24CfqLT7szYB+pmBL2VWrP238R/DjBo7cEXifWU1kpHf39eR
 xSfEOOgG11xIQgBp7rlztvM+uLo3xfcvufe5oZI1IRRQ9yqdEmW6jIrOa9g7SDBtmLPUUr5
 3KT6vZw1fUrVJBrbZfWzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ck8RWgDu9VI=:WAxpIEd5ZHKzgglRVAYIwg
 BDUAvsFnM21MbN5uiRVzkoYidr+oScmdnlvulM2vmTypslLfevop/Qu+GMDDT4H7YJiYn2QyL
 vt2ixr9uU8MUhr9UCMmVja/lL00IeLL79Tgmcn3uRLmzZfwznCCokGu+Yk0tVbgNJeNfIRcC7
 vMuM24xE5wLBl7pFSqoGsBwxJIIDDfBm15TW0pRo9khrejEHCCXBIYo24ZZhR/+k0rPI6fo0Y
 GzLj2SP2PhXSy7U2yUZg2gvPn8TKqN22dbgsbNeB5Zr/rhlR3AEaQq5UCcrEBY3HgXBKAL1N0
 havnbhVEfQ7UGr1CrqYS5SHMlhbb2Pznl1DtF8/KyxIzYTquaVkbBW66BdzSwalxOoa5dJ+UX
 YCyXIxvbkHOblnwHeY+mI0c8rQF5Q6fGHovXA/DEF6Xt0d9Dy4AvCTk8ycesyzB2aLKb2Vs8K
 QCV19vwMfJg4/ivpQENhYr0pmh8OJ3gNpSrxLkdtCdgcaY72ldCKAXlyc70pL1GFWGXXU/Gi0
 KgTDNiNX2iGyxyWijCzuXofkdxVsAQ+k/1FIgZoKtyw56DH8ASR/E+apC6UQBsvAhJimiKv4I
 rKVhU773FALKQoxmQuqMMm7NcffTJWzXPwfdd8T1z3w0huZhOtywxCfdI8PROM86VL71m5Qrf
 87GZfKD93NbHRnGeSG9xRGUESmbzqFpxRZ0jlFzLuDzBG44sdu+ebhzk0DChv2/+mIFJsVQyr
 ghDuy/lBfYX9TxFn/B/ybTs3MsimvCaJN+gu2GvtyMnII+pL2qJI06G+Qpq9ckvFzV9JgMVz6
 apGOgPwhfhLz9xq5Sj6Rq6fCOOIogcgXbAfA269dit2gZn3ASIO7r20Bo9KXr1qvm1PzymKyL
 wa484lJCgodyoW8EvdPqG1s2fE1zpnDteS/YVOea1Wpmuoj+QW5ukYF67DypL0A5HqYsrdr18
 h01pijuS8SyjfOBgXkOdKTvNVx3tYP0lTQg0R+meTmQwdm0DkOMsFjvpES2YdwJpZiEQo5vSL
 I8vnf9gSLiCRk1XLXLmPnlmKY9SmKObhCiBX18N50iRvbWzx4cWypkFTuTFa8xmeYYISDUh4N
 uOK82cUbQYwI11UkGPQAHGKbjmnaE8fd1NyhYHPwb4GSeRegdDUyU1+JWcGKKKvcTz/NM6C5z
 fSLXngN+pGSJOwPqTulsJLyZJVGFoNVFtQnewEEBtSdvlUVzF6G4PIbIzramGqEZ7kqYDDh5n
 0/5LB++AqM70KKo3qwdWn6MWIm0CZNy7oNXloZg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is fine as is in all three aspects.

I have tried again to point specific data processing consequences out
for operation modes of scripts in the semantic patch language.

Regards,
Markus
