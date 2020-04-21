Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA272C55189
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56D7206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RhuXK7Ns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgDUVyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:54:43 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:36622
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726606AbgDUVyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587506072; bh=LIZ+w6k1ownPO2wlWYc5nTuNJh/NXt4NJ/uchHZY8dM=; h=Subject:From:To:References:Date:In-Reply-To:From:Subject; b=RhuXK7Nss1Aw+l4fQ3YclAsEP8hW60S4DzAO5IXvGnS0aCAVV6LkJABrQTuJ+DRjKWnPxhmbCWdihTCYjUokx4B0Qo8lqUy1po9ROU6EaCPQApg9gaT57wisamfA2/rc68OYio6ge0pVIt/6RsTxVY01VmlTunQTuSa/wb4eAusnwS/b2u5s6N8jzFQND9R6teZYV2OWwA79OUmfvUs9pWjXdyLxT+iECT0QZw4S72fFFrQrVfCgiUX+CkSr0ug/H6OFvCjnjhkNkl5SnEWww5R/acLRELAvZOrdY5XvHB7GFDPBvZNZ94+EIbPtB15kTWphXqS9RuUN9n+KBYZ1yA==
X-YMail-OSG: ncDvGvMVM1nM4VWPfwKZpTIYswTathy0T04aSKWs0gTMAjZ8ySg4N52shGhwVjN
 NPSOc19a1Tt.JJvzhMhU4.o22hCB.asliOlxRF1nTXO1TNWGURAFDTtVQ3Cxsk2hefgfh3mVVk6f
 O6B6oJg9l_j9gemlt2dBLOYqf999bWao2JG37gLZ5n5uWFZDgrQ0lDTBbiLbSqljq40g5GTSDSYH
 U3oiPi6k5m6NA6md1tBPWtIFQE8qOXLFX0MZ12TOtUT6eJfwlZWqR6heqVMjRApUw2KsF46sW9ly
 XfbLOXIFNESRAR78r_SDBpRWaBAu2CYFOVcx4NuQP8lBSZgolEmkoU07i3HFi.Xx6_7WvPHf8ndy
 Mkr59oKSHZzI2OZyG1TjFtRH2BJsVLlNEO0i7NGWPeyf3wAyBv8UgGnXooxVJSmZzr2D0iXEhFhc
 oFWhaACY6ga..IGYAmgC1GJ8rXzwpv5RnfFETYXn4bN8rihFkigxJNoPDbvaXSalny1wJ95sbUe4
 i_puxxS1_gDENilUr7EgbihoGxFZubpwhujQe4Cj0DJWxyqlR4fq5sbJWm.NcQtAgZmpsmIceIXL
 w2Us_yw_UeHGpGnlMe9Y8dZIZp5ycSpKMjpJ1l_gk4FitISVv2.Drs7gygpensHANXvwUxH1kqCH
 mTpxE4n4oO2KPxdbrSDjdtSo_p1LU0Z4nYaJIsfONaHH3eXowc7lN5SElNlKqZsLg3kCxtXwu8Pt
 xstoeBWBtEUF.XtXoccGwN0vwyjwVZ3v3s.pupwFuLpWjaPP8kLjcG7Ofj7K02HMtTmpf.JLuaIC
 5ogVuHf9ijsjRFhcUDKDjmOzMHG1y2uhuq721PIXq4TrVidvPg3QU_FcFV33TEGXsQ6P6SJlez.5
 Wyt8TwFZTUBPrSG0U51y0z1RowN4uY6e_Ac7HIimr8__AMhHpg9NKrcnGKZZTwqUXrsT1mk4cqqu
 JRetwwsy1MD1d8Wv.EK8NBwaZ6txt9QlOeaGR8tXBd9qXa_HXO845mgP8szndlBpPjmXknc3J8RC
 x_jLqQy_UGoqzv3zBKtQK46R4QUbpfjYgEq9.ptNyr3.46rSc3zuOZQ3I0xnFAgGEvrayJFU9L7L
 O8sTIUh7r_vCpD6WoPi1aHThJ1p8sP8AWEafh2kvDVG4PJLbvEHS.32mDKtIfkFpeozverJy3ZE0
 FAj9u_2ebnFQDARuzXNb4QzmyDOP8ZefsdBQDcjqwPmIRgPjAl6QtPJWvIU7K6vjNVr6mLnvDGex
 LpkprubsfcUuYvtLO.T_MKyGg3OC15MAboGR5bB5UNYcH_2kR6rdBkrtkdkxbgWz1EYwEMJJv99x
 rxqlNTAayxAfptRjoaJstydsl5pwjfP1AcIC1yZkwJxID2RFouGJtERpqxG2g97ZU0MfX3ktlYAm
 Z5ka.EOOHB5bEnwv7PEQ7U1j8GQH6bUvh_DeJN1.ISg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 Apr 2020 21:54:32 +0000
Received: by smtp423.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b010878ddf1b67f43e77c2a22313e6d5;
          Tue, 21 Apr 2020 21:54:28 +0000 (UTC)
Subject: Re: [lss-pc] [PATCH] Documentation: LSM: Correct the basic LSM
 description
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     Linux Security Summit Program Committee 
        <lss-pc@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
References: <4c053d72-2d58-612f-6d6b-f04226d0181e.ref@schaufler-ca.com>
 <4c053d72-2d58-612f-6d6b-f04226d0181e@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <94baec8d-7d8e-6ec3-2c87-ff1a0b15be3c@schaufler-ca.com>
Date:   Tue, 21 Apr 2020 14:54:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4c053d72-2d58-612f-6d6b-f04226d0181e@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15739 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/2020 2:48 PM, Casey Schaufler wrote:

> This is a first pass at updating the basic documentation on
> Linux Security Modules (LSM), which is frighteningly out of date.
> Remove untrue statements about the LSM framework. Replace them
> with true statements where it is convenient to do so. This is
> the beginnig of a larger effort to bring the LSM documentation
> up to date.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>


Need I say ... oops.

