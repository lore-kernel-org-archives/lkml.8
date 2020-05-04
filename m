Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B82C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B4720658
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="AhA/17Mv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgEDJpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 05:45:11 -0400
Received: from mout.web.de ([217.72.192.78]:39131 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgEDJpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588585504;
        bh=TqKV0o7NRrzkmYgQOjgvKkWtXRaRV+n96KVNMYv+V8Q=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=AhA/17Mv3e45iVvMwl3MKrCqdS884byNVsggZtsnITRaxixC/KntGRrQosbNG1Ze5
         cMuZhxxtTLQ5BVLM06gn/rcQai0kv++dXOxH4QkijUH9dDqwSBnBvTseJTP6X33mHv
         EgC9reASTi06c9zA6L0+i9tODJtOSQYCDxGyHchY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.152.69]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQ8ao-1jrUNz3fW4-00MGZn; Mon, 04
 May 2020 11:45:03 +0200
Subject: Re: [PATCH v6] checkpatch: add support to check 'Fixes:' tag format
To:     Wang YanQing <udknight@gmail.com>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org
References: <20200504082002.GA29972@udknight>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Message-ID: <38251b1f-e89b-7b3a-6045-f5ce1dc2596a@web.de>
Date:   Mon, 4 May 2020 11:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504082002.GA29972@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cWhxWqOfXZS3aAPeXGiut3/S25UqYFHgbcxm0tX1X6ECql5E7oG
 zPqVK2BQ6BiodH6pza0ckIyZg7gE6IOF38+PW70H7EAQyIZPfQ5D+QxYZn5JKCWhdaXF97f
 OCWBsFe+lFx20X8MQbhfgtLF3AOJKMywu8BgVxcO8sMvCx13yP2mqa9XxqvzneUcRLpF7Ey
 Sq++yxfFpUaM+gOsICTaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1+fMiIGTrBM=:cYeyIlvYCxD9DPildae736
 yoIT41HEf9x/S5mwR0FICCrsxSEFCuOQaEYnYIAeKLJ+yFmFH5IGpb4oDisH75+LzLpklcZBl
 ULmUKagn0wuFJoUuKdRYqRXz3aHx6ZODz0rdwxU2Z8tuS/03pvXDXW8mzMsb4RoimJrH7BSuE
 +eFv1OHw9HUPxnIzguZiRlxvhWZxLoDBJFszAQsn3Edlk18yR+incQH4vp/9/chucCfb5/z4b
 +U5rXqyU26tT7pIS3FJfxk0JHZEpX4cMWwQ9LxugdgfZV5xBGLLPtelQOtH4a0BZZ5SdMiUlN
 MuDgAa3pdYqynLFUa9dW9M4UiLWt4aApn8lL0uGeO4YccYs3Soe/FdKdSw5/kwRQIK7thLI4g
 coQCnJzmTKCMWPoi8BBVahtz9kbXHTLtZt4hfQesVmdhRfldspIIZPHm3lE2b555YYl6dybGb
 K+y7sPrTMaiQi0SYRzL4ZqtiQdSGNr2cyEfqyznQaV+LuOY70h3rS/CYG3vmwePbls6eYOjG/
 YsMKA2upF9u/YLUjlXbfmNipHXFyeRfdQ825Fex+tnZ/+E8b71vrfrjwNJHxqULOtqtMUY40/
 IHUnLZUWoOiNF5phz1UUcCyafrtpaphRq+xlp7uL2XmG63ZrK8KduOgN7lLHHAt3iJlU5kP2a
 G2G1NcbAzJIKYqot6bMrjlSpAgTtmLfecxEDTM00lGH+rBLX7JlNqdQMYu1z2BqrU0cghkT/N
 hTLby1dqkzZZmOFtNZcjnyAjnGUcx1Y/zOfvBYyPuMqSugLuW8WaiP1P/EtaJTRF2V6Inq4X8
 1IJj/bH5N+jxVW6HBR8qa/+J1Y+TO1wm8CJkLv1Da+uZ6h5e69wa3F4s7Sn10+aN8vDznhvC8
 WkWsig+suq3JmTIiJRWvmr6Nddo131aTEesvoNYHHRf9zp+MIO35ahLXLcjR+OScvUD5lDMFf
 gtobmYl7oLbsum3p1NGAuRcZaqXJdwUu0s3vyYMku9TmFT8g2NfqGLsC+xJuox8AUylj1o9Bj
 vzZkqZF/fyckpUmZsW7BpgD+cwFBizUBQSB+fEVrZqEWQIBtnHbxxRW3bJQZizk6pnrE9ZUo0
 fqx+UMLCXdYRN86EoU3z+FTB0hs9ghld2s7YTJKcD+QXCgM7zkdRFa4l3N7wzt+tBcf7nK9kG
 sqoZM5eo8ipOMeUkv8hXXsX9QFS4iPSPnXVc4GXXuWuqQg/S/nVCyNFjJNI1p1vUcU7Xttakn
 nAzCyBuHRL6xuYeQZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  v6:
=E2=80=A6
>  2: Fix a typo issue, reported by =E2=80=A6
>  3: Reword some diagnostics info.

Such small improvements are nice.


>  4: Add support to check and emit sensible diagnostics
>     info for description which spans across more than
>     two lines.

My software concerns are growing also for the preferred dependency managem=
ent.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D0e698dfa282211e414076f9dc7=
e83c1c288314fd#n138


>  5: Avoid the word "acrosses", suggested by =E2=80=A6

Another bit of collateral evolution.

But it seems that further suggestions and ideas need more efforts
to get the desired software development attention (I hope for a while).
Will the clarification and integration of possibly remaining open issues
continue in constructive ways?

Regards,
Markus
