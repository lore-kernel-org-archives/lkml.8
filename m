Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0787C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B80EF2076B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="MK0b1AZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgDVJhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbgDVJhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:37:46 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE50C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 02:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201912; h=Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:
        References:Cc:To:Subject:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=N2Cp2lBhQ3VSPeWD6ZcL0iegdOnVogin0Dyf0MfpEpQ=; b=MK0b1AZqwx/t0nzvTsvnhIqdfy
        zRHO/QOLQhEjqIZmRdEazDf1qGyW9IxJYZVcg2a1jAbBXYHf2mfPwNf/PQAA0Q7ErV2SRNUL22rIV
        7vq0Wj8QJk2dzgP8EbK/Wihf3FNvt5LaQqf4ewms1Az2Qk7nAmsqE267TdqfxkBZ5bgaf7bnI9loY
        O5Zho5hLbTHy/Yf/Z6eUSA+TkYlVBAKReC9ib2u4fWkwhQBLbsHzUrKxqbERmpbwimvJ+Mn/n7aOH
        ky8r4FXcU8EYYKw16/vLLdh+8c7qhvi+jliOFWtxv55/p90bJMWA4OKjyeUrriBkE9hEwaFppCVPF
        2hBq8S5g==;
Received: from [2a01:79c:cebf:7fb0:d967:6cf9:736f:4613] (port=42938)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1jRBpA-0002TK-DD; Wed, 22 Apr 2020 11:37:44 +0200
Subject: Re: [BISECTED]: Kernel panic (was: Linux 5.7-rc2)
To:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiQsJu-ZFjt7+c9FVD5R40khtZiihrT+7O3UaVvHYz=HQ@mail.gmail.com>
 <428bac87-b6dd-0867-c8f8-622cd606de3e@skogtun.org>
 <CAHk-=wiX+NT2yxtdPszH9U_S96MCNQA56GJFXY45mZc47yG5KQ@mail.gmail.com>
 <20200421212347.GV2483@worktop.programming.kicks-ass.net>
 <1587546150.9537.84.camel@suse.cz>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <aec3c60e-2794-7eb2-eb11-ff2781223e90@skogtun.org>
Date:   Wed, 22 Apr 2020 11:37:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587546150.9537.84.camel@suse.cz>
Content-Type: multipart/mixed;
 boundary="------------684C2B1A00DAD3B7DE78949B"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------684C2B1A00DAD3B7DE78949B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Giovanni Gherdovich [22.04.2020 11:02]:

> Harald, Dave:
> 
> for peace of mind, can you please share the output of
> 
>   turbostat --interval 1 sleep 0

Output from turbostat is attached.

> Harald:
> 
> I'll echo Linus' request of testing that the patch series linked above fixes
> the problem on your machine. Since you're testing -rc kernels and bisecting
> bugs I assume you're comfortable with patching and compiling kernels, but if
> that is not the case I am more than happy to assist by providing either an RPM
> or a DEB package, depending on the distribution you're running. Let me know.

Will try patching first, if I'm not successful, you may compile a DEB
package for me.
-- 
Hilsen Harald

--------------684C2B1A00DAD3B7DE78949B
Content-Type: text/plain; charset=UTF-8;
 name="turbostat.out"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="turbostat.out"

dHVyYm9zdGF0IHZlcnNpb24gMTguMDcuMjcgLSBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9y
Zz4KQ1BVSUQoMCk6IEdlbnVpbmVJbnRlbCAweGIgQ1BVSUQgbGV2ZWxzOyAweDgwMDAwMDA4
IHhsZXZlbHM7IGZhbWlseTptb2RlbDpzdGVwcGluZyAweDY6MjU6MiAoNjozNzoyKQpDUFVJ
RCgxKTogU1NFMyBNT05JVE9SIC0gRUlTVCBUTTIgVFNDIE1TUiBBQ1BJLVRNIEhUIFRNCkNQ
VUlEKDYpOiBBUEVSRiwgVFVSQk8sIERUUywgTm8tUFRNLCBOby1IV1AsIE5vLUhXUG5vdGlm
eSwgTm8tSFdQd2luZG93LCBOby1IV1BlcHAsIE5vLUhXUHBrZywgTm8tRVBCCmNwdTI6IE1T
Ul9JQTMyX01JU0NfRU5BQkxFOiAweDAwODUwMDg5IChUQ0MgRUlTVCBNV0FJVCBQUkVGRVRD
SCBUVVJCTykKQ1BVSUQoNyk6IE5vLVNHWApjcHUyOiBNU1JfTUlTQ19QV1JfTUdNVDogMHgw
MDQwMDAwMCAoRU5hYmxlLUVJU1RfQ29vcmRpbmF0aW9uIERJU2FibGUtRVBCIERJU2FibGUt
T09CKQpjcHUyOiBNU1JfUExBVEZPUk1fSU5GTzogMHg5MDAyMDAxMTEwMAo5ICogMTMzLjMg
PSAxMjAwLjAgTUh6IG1heCBlZmZpY2llbmN5IGZyZXF1ZW5jeQoxNyAqIDEzMy4zID0gMjI2
Ni42IE1IeiBiYXNlIGZyZXF1ZW5jeQpjcHUyOiBNU1JfSUEzMl9QT1dFUl9DVEw6IDB4MDAw
MDAwMDAgKEMxRSBhdXRvLXByb21vdGlvbjogRElTYWJsZWQpCmNwdTI6IE1TUl9UVVJCT19S
QVRJT19MSU1JVDogMHgwMDAwMTMxMwoxOSAqIDEzMy4zID0gMjUzMy4zIE1IeiBtYXggdHVy
Ym8gMiBhY3RpdmUgY29yZXMKMTkgKiAxMzMuMyA9IDI1MzMuMyBNSHogbWF4IHR1cmJvIDEg
YWN0aXZlIGNvcmVzCmNwdTI6IE1TUl9QS0dfQ1NUX0NPTkZJR19DT05UUk9MOiAweDAwMDAw
NDAzIChVTmxvY2tlZCwgcGtnLWNzdGF0ZS1saW1pdD0zIChwYzYpKQpjcHUyOiBQT0xMOiBD
UFVJRExFIENPUkUgUE9MTCBJRExFCmNwdTI6IEMxOiBNV0FJVCAweDAwCmNwdTI6IEMxRTog
TVdBSVQgMHgwMQpjcHUyOiBDMzogTVdBSVQgMHgxMApjcHUyOiBDNjogTVdBSVQgMHgyMApj
cHUyOiBjcHVmcmVxIGRyaXZlcjogYWNwaS1jcHVmcmVxCmNwdTI6IGNwdWZyZXEgZ292ZXJu
b3I6IHVzZXJzcGFjZQpjcHVmcmVxIGJvb3N0OiAxCmNwdTA6IE1TUl9JQTMyX1RFTVBFUkFU
VVJFX1RBUkdFVDogMHgwMDY5MGEwMCAoMTA1IEMpCjAuMDAyNzU3IHNlYwpOb2RlCUNvcmUJ
Q1BVCUF2Z19NSHoJQnVzeSUJQnp5X01IeglUU0NfTUh6CUlSUQlTTUkJUE9MTAlDMQlDMUUJ
QzMJQzYJUE9MTCUJQzElCUMxRSUJQzMlCUM2JQlDUFUlYzEJQ1BVJWMzCUNQVSVjNglDb3Jl
VG1wCVBrZyVwYzMJUGtnJXBjNgotCS0JLQkzMjQJMjYuMzQJMTI1MQkyMjMxCTgJMAkwCTAJ
MAk1CTcJMC4wMAkwLjAwCTAuMDAJNDkuMzMJMjQuMTIJMjkuNTIJMjkuOTkJMTQuMTUJMzYJ
MC4wMAkwLjAwCi0xCTAJMAkxNzkJMTEuMzMJMTYyNQkyMjA0CTEJMAkwCTAJMAkxCTEJMC4w
MAkwLjAwCTAuMDAJNzEuNTYJMTUuNjcJNTcuNzMJMjAuNjIJMTAuMzEJMzYJMC4wMAkwLjAw
Ci0xCTAJMQk2NjUJNTYuNDEJMTIxMQkyMjA0CTUJMAkwCTAJMAkyCTEJMC4wMAkwLjAwCTAu
MDAJMzAuMTEJMTIuNzcJMTIuNjQKLTEJMgkyCTE0NQkxMi4yMAkxMjAwCTIyNTAJMQkwCTAJ
MAkwCTEJMgkwLjAwCTAuMDAJMC4wMAk1NC4xNQkzNC40MgkzMC41NgkzOS4yOQkxNy45Ngky
OQotMQkyCTMJMzA5CTI1LjcyCTExOTkJMjI2OAkxCTAJMAkwCTAJMQkzCTAuMDAJMC4wMAkw
LjAwCTQxLjU3CTMzLjY2CTE3LjQ3Cg==
--------------684C2B1A00DAD3B7DE78949B--
