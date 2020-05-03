Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED2DC47247
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 12:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B3820757
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 12:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ECmljAsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgECMyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 08:54:40 -0400
Received: from mout.web.de ([212.227.15.14]:59513 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728230AbgECMyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 08:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588510472;
        bh=9FumUi+lt8UvbeMMdDLgKgHsvnkbteiv5PoK4ODKbiQ=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=ECmljAsiF9ailistrD1x5v0nSbBSs3122egn/2iy5eA6ti/Kz6SZBdH2CSKMjuIi+
         ZfrWqDc62BwwtaHlXWRoadwuGP5mI2B3KNc9Pzvyr4a7eYM3+u1vCQRpiJy7qYi7i9
         cACfKu3wt+/9h3sebDenBprLXWEHT9vBSO1mfNDA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.26.31]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Le4js-1io82831mm-00pxTM; Sun, 03
 May 2020 14:54:32 +0200
Subject: Re: [PATCH v2] checkpatch: fix can't check for too long invalid
 commit id
To:     Wang YanQing <udknight@gmail.com>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org
References: <20200503115406.GB10332@udknight>
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e108fe75-440e-8349-eda1-c28814997a5c@web.de>
Date:   Sun, 3 May 2020 14:54:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200503115406.GB10332@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:3TPm0eIkeVSP7dRWQrgq7zKLyD35opWOVw8fknKm/rKwAAXw107
 IcYXO4NltXZ7Vy5N66VZfvfB0fqTXv77nOSR1eNBKTSzqQkxgvJwYWQ7+fV0fH8vzecuGAj
 1Czbs554iQ8jluxY9zEL4QA8H9Iiyf/DQrLufR493MTP2n0sPF+aWl8wEwoJd/ROOFQAvmn
 gDjUiVwzoP494K6s5wH0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SSLLQOKGIPk=:emCK3WkfREfYyqRnjYPcAB
 D8gGp25bPbdZjWBtu+eBWVc1pXFEGCIEMLHcIOofT4QX+0w6mGItnRV6pGIuJLThlWhUlpxzn
 tkeCtQEumGB8LKD4ZTXSF8vlnnkd0TE0KEBSOYPkRKwIFr71j/54qkzpQosUe/oiJnsAlxWmB
 WbnI2bBZZNgQOrQ6yLiZc1n6GrI4eq8kQ7TNmxtrQBsQQTkHDETfho4g5S1LCbzRUQ7MpTlJm
 NktIdgqNHbIumJ/voI7LcxWh1D/cE6Gwkjyp5cc3h0c2WXFJ9H3PLKFosxfxDUdiJWMwKTbtI
 1yfBm3pfdJYkjIF5524adXiD6RD/X3q47AZHD+VUe6GLC+NNWlTyoy2mb05ifb5q+OflHni9a
 R6zf7x2fa3XH2Zsz6deuXX88Mm7rK3xp5xaVuUpdHffAt0ezHXLZGlhOEKil11FsvhLb7cg6Y
 ge4p75d5NaTvikISRtcImnSNaX3vlSplOQT5MnqupEd4HInxjNJyX3TUgv45LHbkehGG/B+Wr
 HxrrZZuL7UzffSBXN75GUKqFyPZ2o19HUw7Ij5xkmBhSatQH8S+Amlt4ok3IG8uijFrwAkjKp
 bFo+qLgFayZay6RYC0ijqDKFsh08IZJiFcOWKc4xJm2tFPfmwH18Z0iPIV4PdkejJbmpTq2eJ
 eIs8yBnW/sLCdClNRUnWDIBTRRSwWycSnUt8Q3h+AG1q6WDR1fx0Jpv0DgE9UqEHshC4N9bc8
 9e6cjC5LbC6eevCHam/6r8ZWT8sE3nJvR2qS0XRZCuSChkvamo3kzX0F8sLk2dCz2yxwHsDt3
 D0drA/SDUlFU4JJFtGrV4mCB9Zbb+bYorCSwkVrzyPhriDcQ48iUb83ZI6KX2x/7DFvj7DSqf
 QhaZ/RSOJvTPNah+Wu2O367L2J8a7+ogFO2amrJU/lLkulL6aBJFFnX+R5wb/W1yy3ES5rsQg
 o3PJ4JeP+JNzB/MG9xIPzRNf4RBi2GKVcFkPz5ZL9G0oZj8CewjdvJBdmHy8fj8taerg82/TV
 JMu+g9ke27hUoHIPJmamBGBDARiey/p2eajIBmtaosIEXFCaSFa0U9ifTi98vsx3Ilu0N4AN0
 81+pvkoroclzG7N7VqJVQEd/sPjk9noVYh9wUsmhZrM3/dtzT76fAvrq2LtrEnGAoCneap+Vx
 +Nf1j9uwwxXezzde8YFKNm4ue2XdogXGpCWgF4tDSNUQfXl2V4gObFJ8DNyGHpRnmdZr9CZSG
 X+bMyT4SAMn9QVUFG
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> it willn't warn anything about it due to 41+ length commit will never

I suggest to reconsider also this wording.

Alternatives:
* will not
* won't


> This patch moves the unknown commit id check for normal commit description
> to GIT_COMMIT_ID, and uses ERROR instead of WARN, because unknown commit
> id is total useless to track change history in changelog, it deserves the
> ERROR.

Can such a software adjustment trigger any more improvements?

Regards,
Markus
