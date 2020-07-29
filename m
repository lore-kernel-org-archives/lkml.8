Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D1CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB4820809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xd04k/SG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgG2UNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:13:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60560 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgG2UNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:13:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TK73Zf063041;
        Wed, 29 Jul 2020 20:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=qzSfUS/Rp2ulvqyMDe+EvIgqFbdpJi8rxeigqDoBeG0=;
 b=Xd04k/SGT5Z6oX9HuCCvn9/3ErOREEK8s62CyZ3AltBiRyGcTwcpBDJudQhdpzubwDBZ
 cTf/BggPDv/vo/qqjPTUX3hS7m8+b6gyAsihm7Fr3lHqlIRBX8bVzBoAaDgf5Hc49wbl
 Nl85U80Dm3NtCShVNoBxmMbST1KpK663Xp4QrgVBwNflnS5KO1RoaRBVuUt9xJNMYX8r
 osnVFHD+TbsmIvI1NUDWuABdnOmHIu4z9U62syn7XoXDwS4tV3lWaMZCp3nlF91oC3mZ
 b8mqbe0eJGf7BUC03kZYQpaVJDn6sL9aHvZYiZlzJdiYnB+BrkqOvM4NMkWyB8Jx0vZ3 Dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32hu1jfv9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 20:12:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TK8mHx185741;
        Wed, 29 Jul 2020 20:12:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32hu5wae0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 20:12:43 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06TKCft9026114;
        Wed, 29 Jul 2020 20:12:41 GMT
Received: from localhost.localdomain (/10.159.247.173)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 13:12:41 -0700
To:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        chris hyser <chris.hyser@oracle.com>,
        vincent.guittot@linaro.org,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        bristot@redhat.com, rostedt@goodmis.org,
        Juri Lelli <juri.lelli@redhat.com>
From:   Dhaval Giani <dhaval.giani@oracle.com>
Subject: [CFP LPC 2020] Scheduler Microconference
Autocrypt: addr=dhaval.giani@oracle.com; keydata=
 mQINBFkDk9kBEADB/Ni5u8+mXjrOGA2PqmTX1PqF0vxqip9k1qHCFjF1vS8mn4VcfxQMrdGJ
 GXgh2RHzCXrVTHJJLRAvtcPGsf+tIwCRylEqM55HqQ8RCv/4Vy3pU/tsovGibgUy1IG4SGuh
 VnD5lJog7tJz8sVT0R+BKXvyGch5DTA0EZUHMXg/NmpWe273W76+u/I/kYhpAuPRHgg8mRnF
 CJAWIeGlXvN6FKmgKJIyNB5PMsHOVFcE+7W2aEL8XrzfI8j6kcF/nh1pvI30WybeBB6kMeSh
 FWaNpeAo2zSFPVNoC3gQjmuteC/nanFaIHNUqw3VYdOmHapZvVMldxJQaAYcUziUspQl5gH0
 dqe3tl3dWV1qcgDbx0qHO8N74ejNk/WP9RVnzrE5oSGIB/ONNvHnqv8d66lumVTnrNCp3x5N
 lZWclrUyjsPvpJdtXnXc05weQhDTfqf2bXbfdjVtYKyfDieHOld+43HlKXrR4PZBIQ2hfynT
 MCPqbbAU0hpvarZtHitcv34QIv5YDyF9uBbV3KKRmFol2wIhb29GD99Zq1KEzpH8OgaLubgY
 2iT3dcG8gS0fq+QoEpSg1i9ruW4Yw2tFHPdSVe+RFhUNeftssgIePNu00vPTlctMLwUGnmzH
 ckYD03PpyAqUUAR1znGRQsyUzBX8x3hAXgz472o18pP4TUoo9QARAQABtCZEaGF2YWwgR2lh
 bmkgPGRoYXZhbC5naWFuaUBvcmFjbGUuY29tPokCVwQTAQgAQQIbIwUJCWYBgAULCQgHAgYV
 CAkKCwIEFgIDAQIeAQIXgBYhBGnGioErPag5+1p2xyQykcrAUmFOBQJesgOrAhkBAAoJECQy
 kcrAUmFOFC8P/0W54s3000KvYajS4D/d+5Eh+R8KezyldpvGYu4eOfQzcjg5N53iD2FU+a6I
 BVmksU5LG7szkTnipAJLtQzo8m6btlDdYWJ72ElbZ1W4FRaOUTd33Tv9C/ih/LmZPPbksYSl
 nq1ReR2LJoTZoGPZ3y1/ZyQ8HxkyR72QfbXiqSz5zGxhtH7C1ym6pT3mxiH2WPoZAcCOjjey
 7XAMYi1427m0WrPuZIYmQ1JIj35e9gNqCp1N5tj2RmWowoDlShUsxZ80L6L/WhqSVWGNo7tN
 Mk2D9LJKNB8XcTx5VOgxkU5xRpu4ZA/LCWZod8EHQIadlt73jgTAVfHoo4mf3dFOtY29xBrT
 UivAJPHaiyV1M60/bv4IrkPC62cOh3iuuZl9EbC46EHc6BhMeC2BzRxIkjwE5VB1h8sU9CHr
 DMHRFNbM6Syi+UHyU4rGig6Q25Lm4whDgUTWAmGw/GMuDswUAIxyvLCaUMFgVHt+/9R2vuTz
 z/8p/DROZ5hUNGvLLG/ZdBr59Y+jLYtnr6aWgPoaryvuaYXCjFd91hV9Jl3HEXUmuRv3M/tx
 loiJgbzO9qQBQOo4zY3T24dS+oUdqHg6qr+/MfaaxrX/AgRX4e8GxhuNUClACNZNFtFy+N/G
 4PNIJ2+kMb3az4gaOaD/v1qGEBFtjd7U/soWTKC1+sP5f5kTuQINBFkDk9kBEADtcVL8M863
 0J0zur9TtbN+olDtcxNjOfWgxLSX/WxyQZlVfQBRpRX9mMAKAPFNEwotiUQtuP48/5T5rxsA
 fNllcLPFJjUH3N8WZ+wFJnfdF7FanoCpudeiU36fDDOQ9oCdK3jMr9JzBgur9bnT1SUDRd5E
 /5dophZUj2XrHSFENCsW3bRem3QVxLay13vBIH6AWwW3zwhhsMCZ3cNVmsIc43fsw4x24uC/
 kzVIZbNDNDDyxB4De1jp9JiMCZE27Cq+hFzprGVkI1n3QSPWKXLrOg7o5d9rYCAVHqIdvdSs
 sshVmL32nS7IVCY6Sj/mgKZ6PnLCAprL4y8sTq+4G+XdWW/h+n+ZyBWD6ztELbSd+jdRKIHo
 ccMf8lsyUE0dc9If99zS4tB4oBFYZpNdwNOgG78DG33uYasWxV5CAKLXjPakx7IJtfcT3TRE
 byc/svH5N+TqZ7zhP3uQLKAoQ95uZCzRo3vMl+GYNn3t+WW3xnhT0Bv7GP7AsfZDnwHGeseT
 vgjk44OPRXzfTbnUpsD1scScsawWW2nobBG8N4JJFhWCY9FC4mSGYnM7XThR/WEqWYNAiu0J
 bVzGtxS8pWq96ypgEU98ox+so7dTgE/EsRYzEUnDvcEanOzao23oN6inpmPlQE8gHiCrJWrh
 jl0eVM3HRZgQlIHDrFVqrzfR1wARAQABiQIlBBgBCAAPBQJZA5PZAhsMBQkJZgGAAAoJECQy
 kcrAUmFOOPEP/3HrwqKAUOJ692JLRJQEDD9VoLQ61eEbq7zMnfuNcFmw5D+cNyg/sXwbtptt
 GAI5JIMPQSpAnDtq6ueUnbUYGOzF5aUzTwv3R1629phk86knOqPJV5NpWGFUonBhj1rxUK7z
 p3rKAQKIV+uncAyb2ouTNuVtpcS5LQcrC7pdF/L5/bTFxyL3isHac02tMd9mIM/EKHsGzKYg
 o3E9jLceYVa/vq5FugkGMl8oDlh9m4TlOoTs47kawl5jJSAptepX1GpvsxKRX2hmMAFoH3YT
 BJpxOc03fJnsGxGI1QrbpzjLpGfcEJJPbPdYdkW7lmgLtLouU6j21PbmQ7sMrkeUCoWq2gG+
 yxmncaoXM03k1Vzw0i9yePFzzSBRkzR6T2SeWpFg70Eebsiie5/damD/hYZkLm5OTYxWGk/s
 yPKvAHFv4zXXIeMiz7kYKswjfcJaJ8xEPbNggIrI6zMvSrIj8S+RNI9ta4RZpPVP+lYq9akE
 b3EmdoxSDT9tB2+haJzI5T743S/n2W6W6ZPzAUXPxrJ0RFHHi5SfzmPUOTtsIq9eAfxQlod9
 CPFoFbWKB+7YvGAjRHoTJK13adgMH5NE0OpGW7Fa+cMNOz1y5wscxPQXVqVJR8Oni6GG4cyB
 /JUM/mISU2UjKDefHknVDHIHkbrxmDvq+lcLoppn+SoVGDiX
Message-ID: <c65e5cdc-6027-9159-ba7d-4b6acaeaabcf@oracle.com>
Date:   Wed, 29 Jul 2020 13:12:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We are pleased to announce the Scheduler Microconference has been
accepted at LPC this year.

Please submit your proposals on the LPC website at:

https://www.linuxplumbersconf.org/event/7/abstracts/#submit-abstract

And be sure to select "Scheduler MC" in the Track pulldown menu.


Topics we are interested in, but certainly not limited to, this year are,

- Load Balancer Rework
- Idle Balance optimizations
- Flattening the group scheduling hierarchy
- Core scheduling
- Proxy Execution for CFS
- What was formerly known as latency nice

Please get your submissions in by Aug 7th!

Thanks!
The organizers of the Scheduler Microconference

