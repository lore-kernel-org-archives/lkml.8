Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E03BC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B91320728
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="o4FLdetP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgD0Sqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:46:42 -0400
Received: from mout.web.de ([212.227.15.14]:33461 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgD0Sql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588013192;
        bh=n6UuAwEQ8lGzpi0hPjL9sE87HUEm4F8XXWCeKLzXQ/Y=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=o4FLdetPhe0Npu6X4csMoh9AIih5AduEerKbhBSrV0qhXbXxzgVoe2iv0zqxcQ4LT
         9B/tLwIvz8qQlv92FkM9N2afWSe3QjaX8iGdjHfyFqr6tTXPurqQuGsLQQgC2L7kMk
         /VAulm3fCzic3eKUygXzq/1NmWGjqC05TKv+pKNo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.31] ([89.12.68.2]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MdLcJ-1jjzEa3WBn-00IQSX; Mon, 27
 Apr 2020 20:46:31 +0200
Subject: Re: [PATCH v2 0/5] mfd: RK8xx tidyup
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-rockchip@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
References: <cover.1578789410.git.robin.murphy@arm.com>
 <CANAwSgSFPtdvEvacNf6DhzE2fCabgZSBNnZUf0+nQErDWpErOw@mail.gmail.com>
From:   Soeren Moch <smoch@web.de>
Message-ID: <c7345431-7585-6052-835e-d9c292978b6e@web.de>
Date:   Mon, 27 Apr 2020 20:46:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CANAwSgSFPtdvEvacNf6DhzE2fCabgZSBNnZUf0+nQErDWpErOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Provags-ID: V03:K1:J3sgsNO32AOu5Qc2TXlIFA83VzwJ76ohcZOv1Zmet6fdTcPtQ/0
 4RsP2orl2tRvBXAVaxnDzmQ3IM2ZOv8fm+IzGziq5N6kl0XWLzEWz4DvFNrGcqESyzLojyJ
 gY2gUh5dRsFEx989CX8HE39Ee9lIZ4tE+jh7j/RX7BW0nclSCt+9TLQyW/loX28hPyHWs9W
 5cuz6h4q6uFbfg6y77IAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c+fGa3ZUgT8=:UT3/AWU+oXGeHnzZ3FIo2j
 K2tPHD2ZbFLNXg1rI2KuYZGjUNJAP6k+OVCT1hI6KFGbnBjZ3CmInZEp5dqSMOpogCyMnynuS
 YBB/aVfu93oZjwVd1CkBLkNWWOEux1C81qAjiseTjJyAYLryEqOGh3NIqpH/K+mE991DIuzaa
 JnnyxWIdfQSQz5Lji3zU71EO4ZekZ31NfeL9MuNFnIaEb3kjz0sRkfEtfldqAwmasLEdaqhp/
 hucMsbdcQ+5A2gXFS1ktt5nXtclTcvl6GxcIGbpFQoiCLNx8pJnnI7edLSGheVIL2rxD1gLVw
 ETniqc541O35tToH1wBZPswLH0Dx5KMQ9L1W6zBOTiLYxye/voRu55t/2VGppiX7/0GUZEeAn
 PkQjXIt4ffP3M7oNIh3RJ5yJjUQ4dFJCb89xLgxZml4MZsqRsvleIZYq9iBYvHVtmh1obr5wl
 1MXyICDBmBVEM5BeQpSNVoL0gkparclReq5JIpYHmeLGaYcXj0uVZ00Hvw6eA5XG3QBIsA6FK
 6+vEkHbwzWHt/xX8G+UvAZiNdCIBip2WrC8r2VsSQBnGtP6plLFZ88l7ttZMhdGy090tTkLYU
 VLi7XsbnI+2bL5MgukePqqg4x5Eet32T0+8w4LCir/zL2lzA3RevfxolbOzPfHc1YdMOslTk9
 7dSNovxiFhuX+Qz5Pfv2Fo9B2q2XVqEB095zI+JRkb/BWWkEUGHOs04HbqbKN2QU2cpnk7LaU
 VZ9BQs9gqO7Ho+STtFkpmSJCILAQ7Bem6UozYD2VSW3u53HsvGxNfu+DPK7I5Qg/c65Tn1FCH
 L6d2WV3WtXFav/zhGFyAA+R4YMkSqYk0hKWP5jhw6so5IR56FCxMhy9ghZlBet4ncrfZDeKkC
 eJNjPlFRaouTHoole5YnxqOhUnD3++UC7wsleUNHGVf6jjGtwmGx0An+/yQSqCsD64u4iLGT8
 ZI/I5fpikUw0KWB4Q5XNzwZ5eahbr6a1/iWfPJLBFdbYKrIWWJLupQcFUydk8TX10jrB6DV1Q
 9wjbOcO1W0fJe6sY6sVjv61I8W7yf+7QsbnXVchYeI/YykUoeu8hoUiQcrgf0yTPOsbpC1CU0
 v8tsC5TndhJOegqzV3/yFxjSKp2pEVWUl1M0TSytH5WlalvQKBG0ebBF2Una3a9eRnq5Ve1sD
 GLNBvzPZITNUhq2MrY70nodfojKldmVsbQEYRe22p4oTK+Tm+XZS5ucwYJYmgrQPyMxDg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.04.20 20:41, Anand Moon wrote:
> Hi Robin,
>
> On Sun, 12 Jan 2020 at 07:25, Robin Murphy <robin.murphy@arm.com> wrote:
>> Hi all,
>>
>> Here's a second crack at my RK805-inspired cleanup. There was a bit
>> of debate around v1[1], but it seems like we're now all happy that this
>> is a reasonable way to go. For clarity I decided to include Soeren's
>> patch as #1/5, but since I've rewritten most of my patches I've not
>> included the tested-by tags.
>>
>> Robin.
>>
> Can you re-spin this series, it seem these patches are lost.
>
These patches are already merged as
d8f083a302f7..42679765faf2

Soeren
