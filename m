Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA8FC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 18:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC767206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 18:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ngc/U1DU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgHPSza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 14:55:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:40967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgHPSz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 14:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597604101;
        bh=s32LiC771kRyXcUOPz9RLLRg+/kfXg9U1ul9iSGgodw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ngc/U1DUkEOmBt4o9tEfjQPDnRZcniABNvWXOHuDLWa1IYaVYvfYcpFwNkg+GOpEv
         8gNeGPBDxdZKjY3alFxs0eoXEoyy6HWZRi+tH8o9PVhZTVP3cOy7W7wkOKqNQf2mv8
         XuXAonHJ+K/oMSoC0IMtD439Phvl+AGxW/feJaKg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.43.192] ([80.187.111.70]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6bfq-1kkQgN0PAk-0182yZ; Sun, 16
 Aug 2020 20:55:01 +0200
Subject: Re: [PATCH] parisc: fix PMD pages allocation by restoring
 pmd_alloc_one()
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Meelis Roos <mroos@linux.ee>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20200816142403.15449-1-rppt@kernel.org>
 <20200816144209.GH17456@casper.infradead.org>
 <20200816174343.GK752365@kernel.org>
 <CAHk-=wiPUKCC490nd6Y5A1Sq=VpTpO=Li5cYb0iztp-x19nqiA@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 mQINBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABtBxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+iQJRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2ju5Ag0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAGJAjYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLrgzBF3IbakWCSsGAQQB2kcP
 AQEHQNdEF2C6q5MwiI+3akqcRJWo5mN24V3vb3guRJHo8xbFiQKtBBgBCAAgFiEERUSCKCzZ
 ENvvPSX4Pl89BKeiRgMFAl3IbakCGwIAgQkQPl89BKeiRgN2IAQZFggAHRYhBLzpEj4a0p8H
 wEm73vcStRCiOg9fBQJdyG2pAAoJEPcStRCiOg9fto8A/3cti96iIyCLswnSntdzdYl72SjJ
 HnsUYypLPeKEXwCqAQDB69QCjXHPmQ/340v6jONRMH6eLuGOdIBx8D+oBp8+BGLiD/9qu5H/
 eGe0rrmE5lLFRlnm5QqKKi4gKt2WHMEdGi7fXggOTZbuKJA9+DzPxcf9ShuQMJRQDkgzv/VD
 V1fvOdaIMlM1EjMxIS2fyyI+9KZD7WwFYK3VIOsC7PtjOLYHSr7o7vDHNqTle7JYGEPlxuE6
 hjMU7Ew2Ni4SBio8PILVXE+dL/BELp5JzOcMPnOnVsQtNbllIYvXRyX0qkTD6XM2Jbh+xI9P
 xajC+ojJ/cqPYBEALVfgdh6MbA8rx3EOCYj/n8cZ/xfo+wR/zSQ+m9wIhjxI4XfbNz8oGECm
 xeg1uqcyxfHx+N/pdg5Rvw9g+rtlfmTCj8JhNksNr0NcsNXTkaOy++4Wb9lKDAUcRma7TgMk
 Yq21O5RINec5Jo3xeEUfApVwbueBWCtq4bljeXG93iOWMk4cYqsRVsWsDxsplHQfh5xHk2Zf
 GAUYbm/rX36cdDBbaX2+rgvcHDTx9fOXozugEqFQv9oNg3UnXDWyEeiDLTC/0Gei/Jd/YL1p
 XzCscCr+pggvqX7kI33AQsxo1DT19sNYLU5dJ5Qxz1+zdNkB9kK9CcTVFXMYehKueBkk5MaU
 ou0ZH9LCDjtnOKxPuUWstxTXWzsinSpLDIpkP//4fN6asmPo2cSXMXE0iA5WsWAXcK8uZ4jD
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <71361719-6331-001f-b2c1-e522d97bf317@gmx.de>
Date:   Sun, 16 Aug 2020 20:54:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiPUKCC490nd6Y5A1Sq=VpTpO=Li5cYb0iztp-x19nqiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BOqZG/Zv4ZBoXclXZqTZS5HmardKBOUdjwMJwY/CWS7nidXpxSC
 MczL7k6chS5jRZUmhu/uLLlzGsAIJSuGHnB29em9pDnhKh4ece5/M8QbF0VPBrpYU/6b/qr
 XYcBwn0V4ds+R5/VG4wC78m4G7vuZ9dEN7FtpQkGAjOSQG+eWBjteGj+X/vd1oczsbj88Hb
 zj/T3aIYxSmTVCuklZf9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k4fiNSu9jC4=:xKHNtz1oAPepZyjdV0Hrxv
 MtEdHKsEk/ZzmeF+jsipLSd2ryK4CnJ1pEupOLtAr7MpQiQ1XC79GgyupRCnnCH+EB22a4hnX
 D9PD2b7tf4uVg1yNodfVoJnaRGhkSd4+pcxmlD44JZ7UKNA/QJrUslICvDY3ujhoJX5KF2YbS
 mE68nPDi2emk5wJS/MfiUV1Bz/4ISo89LRAZstddgfTIHeykxhzoMFhBIQ0eqUR8Ybk9q0Itp
 /emSyEBh3QJocgn/7+EuFUjV4b41FBVauzkiq014OmEOWJsgEA+7uUduJKUrn3ejuSpw6azXF
 AC1NNnMn6ocSTxa1naUUuXkujifG2ANf7i3Y3omS9DywVvsn6LwFYKow5LOBthESXo48ae1LL
 A/ymG/vzcEUh8d5FFOIcwbnlWak+WJHbaZbVKurKFu8RF3Sx8GzWxjfDvREWDdacBBgaF7rYo
 H8+9rHoQ1aF5D1RUBNLyO+46BI35pXQbqBofc5XDTEJMAvzuaIQ2RpK5sqR+vXATlIz+x41hk
 b0PJUxRAHwRRnTSduTGSjtcoGavEXfC0iZrHtpopgbRVAT/AtsIdLfN9Sk3BPxubJ7D+RrUQR
 F+FLD9U998enDT1QK3eKzcG0o2Fs2LfUTTxeUtel7EJDfoMEIkmQ8cJhybrgZSZ0IaFR2zJh1
 5b3XRTnQqRXUybCuMAYlz21U5Xv4Wjs8v7WLKt8EQdFJk6hbbJkepa+hD7MjaHdJ39zuan1+g
 LJMGyrXMok+G8DQ2NkzfFRdBqOxbs8Q3YJ4niE8+DX6qMFXQTeUDigMkLGjzLVa7MeJQbwbWc
 +8xapiGs42d8CII+W7ZKXKyk242urhhWebK/3Cs52iTrk3eKP26pTcwDKb2BFnYoR3fXrqJtb
 zbvP+Kbp6UKcKZSKA2pd1ScTU81vN2FhYlus+/qjDwjPtlireRiii0UzIzIHLPhl7Xc7bvS0X
 r3iA/6vQSa3JrLVMiQTKvqDTa2YrItZUcEuJ3VScR0zLIfhscEhNLKu2eNCNMULaU4JBZnCOf
 ANM1OtReQv7SKR7P6TtGL8sPJiMU4lGzqnb/tkSQZLQconkGbKTWSw0q4Q1bOELNEBuyQMUsq
 5jQBmJ5M//mKNGAHGwEoCak1l6KpVFAeXjH8LfLnEZl+3H98hAHW308GgjZunVlPX4HmLHkrY
 BQcnJmr/ifn08p1w2t2Le5KNT2lIk1mV1do1wt1VmmF6KGV5ga/4nfVVC+omSUltvawc0cMg+
 dgMoRtnZv41VN5Se3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.20 19:52, Linus Torvalds wrote:
> On Sun, Aug 16, 2020 at 10:43 AM Mike Rapoport <rppt@kernel.org> wrote:
>>
>> I presume this is going via parisc tree, do you mind fixing up
>> while applying?
>
> I'll take it directly to not miss rc1, and I'll fix up the typo too.

Thanks!
Helge
