Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D6DC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2928321D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="a/0OAUs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgCJTBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:01:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:36905 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgCJTBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583866850;
        bh=6XEkt56OSWTxFiSSocYC6agWwF+aHvNBJV+AZ+tcLAI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=a/0OAUs/pEhJG6HSeyZfrnV8Vp+hPp3RxsvF0hnxhIvv+dtJoIA3TPNigBISMM7vG
         LWYBUkID9UxyBBXSDJPOzcvUc/MTxKHwxE/ELao4xEgWLQyYTu22zA1ytWcvfqoMww
         kXmqPofd+eM5R2boEYy0VQ6L7LOysTlNDxBds1OY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.202] ([95.91.236.254]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Gj-1jFKcr1gYt-005HmT; Tue, 10
 Mar 2020 20:00:50 +0100
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
To:     Roman Gushchin <guro@fb.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
References: <20200310002524.2291595-1-guro@fb.com>
 <5cfa9031-fc15-2bcc-adb9-9779285ef0f7@oracle.com>
 <20200310180558.GD85000@carbon.dhcp.thefacebook.com>
 <4b78a8a9-7b5a-eb62-acaa-2677e615bea1@oracle.com>
 <1b5ada08-1baf-4f2d-3ecd-b940e7ee0e0d@gmx.de>
 <20200310185652.GE85000@carbon.dhcp.thefacebook.com>
From:   Andreas Schaufler <andreas.schaufler@gmx.de>
Autocrypt: addr=andreas.schaufler@gmx.de; keydata=
 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
 pMd1zB+/DJ0=
Message-ID: <fa2403bf-743f-add7-9692-7f5e22195b4c@gmx.de>
Date:   Tue, 10 Mar 2020 20:00:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310185652.GE85000@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Sk25sU6ksbYSh5W8FEw9uP3pd9g8N5z4xaORftETkR15T+ZM3C
 b+lXdSIl4c4OVOaZ7S4uTBkrK0fLS77n7vaX3Vh4kodoiZw4e9OoMw7fJn3a5iBMl5GOKUR
 KNpBAzax/w12GCuZ29ysFqu6dbs5tr7Jcsp1hJlsa7LwW3KFhnsIdbr5w0Q6+ZSZ9zHi2Ko
 z/e7Yvu/XUWU79mAIqLuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4zAhCbuOMx8=:PplO7Vv8qQAu4oFmht7ygn
 ZGb6XcbAYQgbG8xS9KkUyKCLEwoSNtklwbIUgV8R8Tr1V8oLGJ7mI4jqw0NQtsoHiB4CNjIiS
 ogNsnrMjz3rXYoOJ9oUqwLQgtx+a9h/OJL0qg+p3TdCia4rFvDKLeEHFBc0vHZIMdQThCt8RB
 kGZwOB0kMjiIo3MCOKqlRLty65dbzNsq2p56rpNLUTIL/WWYZ3cqqyq8qXo+T/r09KnNj6jBE
 sOLZ26Ru+lYl9rnJnqTcpNR513kCES1BxTDwMLoyHJqSplLSOn1IvnMg4PmP4boFvmrbhZDc1
 V7nmSswfMY+VcVWitRGi1m0ggUgCYYoo9cQ/jJlksLPD4dE7bHOO6FbasOawXzK0DOiBC+RhD
 S8cHuJV8fEADJtxOmq/g1p79cfTrblfyGNjwLhMb+mxc+J+CvYQmmVmAxWY7RQLz/yB+tbk3g
 j7HbDV1BeDLalfaX9qzVKBgsVauMLgkcBfDapy/wpJgA7U35T8MeshxdBq1lBsxBKONZwxqe1
 QfyfgBgoZOaOIpgAfL26o7Ih9gBMcAKn5o/zQurBF1G5SKX3t3aeHAbrZ+vcWoFRaWPUE20UC
 cJ/GWuqEOBxM3rNLPV8IRrVljk+S6Tq2PRLcSAvbL8YcTn8uCOViXFB8zRRFWVV34eDlfumR+
 Ro+1E8pu5Wn9AZ+BXSX4ykU1mLeBlPS6fkPT2QV83VjsbOBbOO+JlG0n/2KMpkNylpEmBdBSY
 hoby0KyvNAzTQDsUU2U2U1jzOiDdjSTW07LIv46Z/w5jQjTbdcVEilpUY03sD6GtoQ69FWj87
 6H8IU9V78d+Roj8wv43t78VuOuY53hxUBKTXGtYMK1FNMBy3pFDB3pNFLXpEFpYYR7Gc3y49Z
 tCwhXKwGW0GkeN7V24MQcsQGSwgg30tTSKjnmbTblOct7E1CchQM78cdDoyI8OHBAvl3XKrcO
 mR0UbwDAmHOfqNixGqPqAuJ9KUBLn7CCyRUOh7u8n3+VVidoYP4I3EBFHOFqtadOxTUuIIfhV
 G6hfb5UEkU5JImI1iC3yZVcFDuHO6+g5/hW75VHbu2DsEpTbB+iAxYokPTNRryoRDOsKOCVpQ
 KFqX7smDAqtvAQq6rgLoW+1JT8+yABqNk9hSQTCtvV82pwtidZQrXzdJ8L8z2K6qEGzlWPVC/
 kK2vJ+ZUT9ntuCHuY+mb6xEQ4S5t3vGkJAghpRkqNhwit8O8JMDP9uyvnu3ofwRUMU2hmZ2FS
 m68InUrQ7AAUnojRn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.03.2020 19:56, Roman Gushchin wrote:
> On Tue, Mar 10, 2020 at 07:54:58PM +0100, Andreas Schaufler wrote:
>> Hi all,
>>
>> sorry for bumping into this discussion, but this is exactly the feature
>> I am currently looking for on ARM64. You may browse under
>> linux-arm-msm@vger.kernel.org for a message I posted there recently.
>>
>> I read somewhere in this thread that it should be easily portable to
>> other architectures than x86. I am ready to give it a try, but I would
>> need a few pointers where to hook in in the ARM64 code.
>
> I'll try to add arm support in the next version and will really
> appreciate if you'll be able to test it.
>
> Thanks!
>

Excellent. Thanks. Just let me know.
