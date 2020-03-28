Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88ECC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 14:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F7D206DB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 14:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="TRjmpzDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgC1ORA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 10:17:00 -0400
Received: from mout.web.de ([212.227.17.12]:54037 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgC1OQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 10:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585404994;
        bh=Z3vJOyWn1ns5IUXgUb3rWwD4AeV9c3igsgp0JF20gMk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TRjmpzDs95iO6tt3CgkQpEQE9jQEIHmhTSCJcelHTCNhoAszQTFa5IdZ6HCgBBRX+
         8j1X7YPu/mbCpnH5Qixdj5oQ0LK3Rl2sePYXI2wkwJUKXW9aFG4D+z10DgwnjTw9fj
         4cu256Q/RtIvb5+7/bT5ihhZALk2++neu81cRzY8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.150.134]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5OYl-1jRJUr0oP9-00zZZ3; Sat, 28
 Mar 2020 15:16:34 +0100
Subject: Re: [Cocci] [v3 05/10] mmap locking API: Checking the Coccinelle
 software
To:     Julia Lawall <julia.lawall@inria.fr>,
        Michel Lespinasse <walken@google.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Ying Han <yinghan@google.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20200327225102.25061-1-walken@google.com>
 <20200327225102.25061-6-walken@google.com>
 <bc2980d7-b823-2fff-d29c-57dcbc9aaf27@web.de>
 <CANN689H=tjNi=g6M776qo8inr+OfAu8mtL5xsJpu4F=dB6R9zA@mail.gmail.com>
 <3c222f3c-c8e2-660a-a348-5f3583e7e036@web.de>
 <CANN689HyS0dYWZw3AeWGBvN6_2G4hRDzjMJQ_adHMh0ZkiACYg@mail.gmail.com>
 <590dbec7-341a-3480-dd47-cb3c65b023c7@web.de>
 <alpine.DEB.2.21.2003281459020.3005@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4214b545-3549-62ee-4869-3bc43fe2c07c@web.de>
Date:   Sat, 28 Mar 2020 15:16:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003281459020.3005@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cPtfjttOdLXtSeK5ib1saH4gIfLzBr3HOSaEV5xTJvU95sYCfvw
 gzSWnhjfSRrnOY75eQjiHp1aFPUt99/U2J/9sHj2I/mE9ZQDuW8oRQrtkHA3sWOx+tNpwtr
 mBnlzkXZIX1jLJA4nRG59ghA+lK8j1Rmn/eDwfoqvEu4ZtzfIrma6OiGnvgkhGMW4zEtirA
 9+LyQA1Hrz076lsa27Y0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SwkICVRF4yc=:jPgMv8lbxbIpxhw2MK1GMY
 zH+QFW6KH943mNdzMX/JFbu5hQmFtEcSCnxgmqp4qU21/WIUHL8ZVi4cE3VbeJVni/bzc3Kl3
 KUB9GP+3CjzEMMIIKtmjGTT8dBdr8tF0Kq6lEvsnz6+mScHLzXGl5Acr7yGlPvYTKo5uA8ZPM
 h5To2Fm7K9tgv1IXYChVicjJI2xWbnmHWbQ6ffj3si1JA3onzOFsSrgQfohYanDs0Eihc4ouJ
 eKO3vSYisFK5V39ivv4xkuPt+BLiLqCsUfPNZaoPqE/qXTS8oRjlf6q0qwUWJ79QMc/bsiXDj
 mpclnkEXRjGVOEgdSWk6Qx4XF9z2uunkDquE2qDvnMtDS/PmjHF/OrdbdeRhZZMmblti0R2ss
 h/tDQZWUmpRGNgk7hD66AS1nMqwibjNUi6tEcXda1UhCHnwqY3xUMEX5Ahh5iD4s+M0oCHhYn
 6C7/ns7QNbFs7tx17DYw85TLfxFM/5KPGUllFlmxTHtXuyEA8AJ+7Jo3wy6UZbxuUjT9FHtn7
 K70yOXzKDgSe7kIfKwE4cdW+d9sna/uSF4f+AlUpm4XUGudKF9v5QELHjXj0tyyDqlYRtBKQf
 imusICp87MVqQO0OmAylcnTTkul9RUdegrplbSmPyVi+L53gaTxChRg51Nm9/GmmW6gamnRor
 bnXTqgGSB0iiYqxWTlsZjA9mznJ0PM3PxyPXhd7EojYIeHAkpCDlC7ZS5QPrJ6fYdCrVUWZnX
 PA7cQmc6hDjynKhgm1et3ZB5Sg3ipg8ASDVszdyJmLAyMG0gqAj6eWnCO7ZOXO/6NtFWByIjI
 MvguVDP42uEm6qiRTNPqZCoUEXa5pxKucWzC/bE6u5GQw4FilxPehXkqx8m9qRYFJLfsm7vFS
 JyqUv7GNIkX/VLJVHP4tEAii1qjoRdEyAJV9Z0sBE2IJB30N31VdCHfbQVraBlg/BLhbyMh1r
 twOU8CKC5G6DqL8qu5zwfyiV6N4kFQ6H7JdbyBxTcmmb+fph5S6vxL1FXWGsH1pu+KoBBzSut
 /7ajW5fMRwWutQ19RxpCMenq828USlXjjrM2TB/Yd5Hld1Ng+ZpnmJuKyGx0BvlnXkS82HZNU
 mSL+C7/myvfx7eCnhXT9jWLboyX2yzqVSEI6bw96rSVxRDhvvVSVUZhzVg0ZJUVip+WMKJDhy
 nGrjrSfgYtYuL2MfbNuF5D0A1zlVoGQBhA2cznZqNOMjHmt5iXYrDMLbFjLFAD+iawpuEw8l1
 1yGg2uAxOxyrbaSyu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem can be seen with the --debug option:
>
> FLOW: can't jump to VMALLOC_FAULT_TARGET: because we can't find this lab=
el
>
> It's not apparent with the --parse-c option because it's not a parsing p=
roblem.

Thanks for such information.

Can the example be transformed even if extra source code was intentionally=
 deleted
for the easier clarification of the shown software test?

Regards,
Markus
