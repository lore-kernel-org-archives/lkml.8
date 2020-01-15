Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC50C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7FE2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d/dIDtdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgAOUeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:34:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49186 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOUea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:34:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FKXAZI009978;
        Wed, 15 Jan 2020 20:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=corp-2019-08-05;
 bh=sBCObw1A1wi/BONbBLJTd8p1Tu+qAZHbmzQvDCbI04o=;
 b=d/dIDtdkoKNk0lomS1OwnwqTCPhz7LH09irhZNF32lepKrvKFkVjcWC6XfGHx5r/FK4+
 uWsajmThBlcG2HEYA5lRLxC3oiwbJK+t+6sdgLey40ahDHGL2zZ2L5PxsVbhbuGV1OGp
 aG61VBkEk/8RDBEDSFGoPFSqWiA37s28ACfmaggaZ041XEgYF+J/26yUoltfXEQfn50v
 CKy8f4rZQfxK704pGEgpU97kioaT25pzLXmKvQjnvheswxcYK978f8GkCWtTXjOoAWza
 JympFo86Hp+ZIty+ingOpUX372t8+qLcrcsLJFhBuu/RRq8qivzAUi/26Eklj0I8c8eg YA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xf73ypjyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 20:33:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FKX1hr132576;
        Wed, 15 Jan 2020 20:33:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xj61kcc4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 20:33:47 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00FKXgf8017835;
        Wed, 15 Jan 2020 20:33:42 GMT
Received: from localhost.localdomain (/71.198.116.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 12:33:42 -0800
Subject: Re: [PATCH v2 0/3] Introduce per-task latency_tolerance for scheduler
 hints
To:     Parth Shah <parth@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, pavel@ucw.cz, qperret@qperret.net,
        David.Laight@ACULAB.COM, pjt@google.com, tj@kernel.org,
        dietmar.eggemann@arm.com, Chris Deon Hyser <chris.hyser@oracle.com>
References: <20191208060410.17814-1-parth@linux.ibm.com>
From:   Dhaval Giani <dhaval.giani@oracle.com>
X-Pep-Version: 2.0
Message-ID: <5a13d54a-7e16-8d6c-8362-bd5f056004db@oracle.com>
Date:   Wed, 15 Jan 2020 12:33:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191208060410.17814-1-parth@linux.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------B298D4F914E16687385FB757"
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001150157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001150157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B298D4F914E16687385FB757
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 12/7/19 10:04 PM, Parth Shah wrote:
> This is the 2nd revision of the patch set to introduce latency_toleranc=
e as
> a per task attribute.
>
> The previous version can be found at:
> v1: https://lkml.org/lkml/2019/11/25/151
>
> Changes in this revision are:
> v1 -> v2:
> - Addressed comments from Qais Yousef
> - As per suggestion from Dietmar, moved content from newly created
>   include/linux/sched/latency_tolerance.h to kernel/sched/sched.h
> - Extend sched_setattr() to support latency_tolerance in tools headers =
UAPI
>
>
> This patch series introduces a new per-task attribute latency_tolerance=
 to
> provide the scheduler hints about the latency requirements of the task =
[1].
>
> Latency_tolerance is a ranged attribute of a task with the value rangin=
g
> from [-20, 19] both inclusive which makes it align with the task nice
> value.
>
> The value should provide scheduler hints about the relative latency
> requirements of tasks, meaning the task with "latency_tolerance =3D -20=
"
> should have lower latency than compared to those tasks with higher valu=
es.
> Similarly a task with "latency_tolerance =3D 19" can have higher latenc=
y and
> hence such tasks may not care much about latency.
>
> The default value is set to 0. The usecases discussed below can use thi=
s
> range of [-20, 19] for latency_tolerance for the specific purpose. This=

> patch does not implement any use cases for such attribute so that any
> change in naming or range does not affect much to the other (future)
> patches using this. The actual use of latency_tolerance during task wak=
eup
> and load-balancing is yet to be coded for each of those usecases.
>
> As per my view, this defined attribute can be used in following ways fo=
r a
> some of the usecases:
> 1 Reduce search scan time for select_idle_cpu():
> - Reduce search scans for finding idle CPU for a waking task with lower=

>   latency_tolerance values.
>
> 2 TurboSched:
> - Classify the tasks with higher latency_tolerance values as a small
>   background task given that its historic utilization is very low, for
>   which the scheduler can search for more number of cores to do task
>   packing.  A task with a latency_tolerance >=3D some_threshold (e.g, >=
=3D +18)
>   and util <=3D 12.5% can be background tasks.
>
> 3 Optimize AVX512 based workload:
> - Bias scheduler to not put a task having (latency_tolerance =3D=3D -20=
) on a
>   core occupying AVX512 based workload.

Have you been able to adapt any of these use cases to this new interface?=


Does the interface translate well to them?

Do you have any code that you can share?

Dhaval

--------------B298D4F914E16687385FB757
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBF4OZ9IBCACdNNQDqDUiQpugak/HB29Xa9ZiFiNz0hJyhf/GSeMYcs4goT5F
MLVG+XL9qKrSrLx5uYaKFblV60JIWM0pmtfjG5y/bQ7bAOrmGOuuEb1KnPP5gqYU
rLP3B5pEPc0tjtMilB7v7EoQWOfSCZFnfpaGqxqzJpNHeMBSFhzBXAmLZ+LwvEnv
nj66yjl44GwKvycmlUBE84ggU9BtgxukSjrcqakyF0PC50ApxFEH2o6UVHf4n0AO
OqGToN8PMI4AqQkypeCDY8laZ0crT7LlGF3yp42thLeZJToD+xz1APbCqeOnRIzY
WcOipf6ylS2Rv7rWBjD4UDlk+KqaRuaV9/o5ABEBAAG0JkRoYXZhbCBHaWFuaSA8
ZGhhdmFsLmdpYW5pQG9yYWNsZS5jb20+iQFUBBMBCAA+FiEEZ5yVPVzlvslB3bcv
IoAol1COeiQFAl4OZ9MCGwMFCQHhM4AFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AA
CgkQIoAol1COeiQueAf/WxvNLPxqJXv6UiHeh0BY4Ca0w88ilZTowX5hcYsGuYiJ
o3cLjV0+f4BnupasKs+brg7TbHDnEN25EIUVqznuJh7jgc8yGIFquOa9lee7IA4q
SwyS8V6GmeEr9WuFkJbojqEOHwNs0YG6w1b+lGYS+KVD1aQd82M2OyKJk8BDYRfp
4StwdZ2oy2ttSO2m8yQPhTqE3iMH5+fACxDUktFPlXendWV6mNu9L83BOY12HFf8
Opou2pnxHLM8peLZ44acsk1sURIdbjdAAy90Xg3KVqP6K6XLhZcw465Wc8lYefKc
lrtm5gItLG0yPg3Lh3HhUirYZALkn/vEBmnktoCmprkBDQReDmfTAQgAq/J5y2ux
E8xnJWyLcszVqAcUqsKs3gI4hAzPuUcoa0TWYBoU1tlaD8AtBaxP3/VnDzdARt1L
5eq9t5CjBe7BEpsRNJjMw9viokrDvUYhFS5Q73HL5rsaEdhUxyEaZe7yUGSJ5Bh8
YpWBV7P21nw7OX7UwTyswaV4b6d+RqvHfLzPlsX+yLvRN/UCRUhnYFkLRd5CRqT5
DWS8rQhc7YaUzIp5RWbmYSmHlxSrvs9rwEC0m2TeggQLulBrVs+CPEMJGK2HiXBS
syzU7J8PwmWfcRzN13o2qxiWHIDagh2tRExPDzOjTuJmkGxvHgn5MB79YtvBZU7V
x8uwIbQW1Nu1rwARAQABiQE8BBgBCAAmFiEEZ5yVPVzlvslB3bcvIoAol1COeiQF
Al4OZ9MCGwwFCQHhM4AACgkQIoAol1COeiQbEAgAmrtu/4/fkxvk/qWthzj+Uowk
xg0U/ZfwjnVZJeFG6F5NV78HZkjmPzyc1BlWK470i6/xvNovJWDmo18sCgBzbq7e
7G81lCehOLJfduoEK9k6AgkOb8wodg+BtbTIQkdkkG4vsS9Cpd/jxLh59iZ5muNa
9SDAgaM1hnhJpuTuwDa3wBnQlJDx994oSEEH9ppMCObSgwiIpLz4zFabveotawFW
F/KgCeHmLvxsPlym4r08oJjAApoKHc0a3DlpC20oYZNVo+wnxb34tqdPwuHZKhR0
etOB1A89mbZnlcrKywmMP6pUdcDhffHkcWLNqu47PzPA2giXXnKZHXJkCE+ydg=3D=3D
=3DMlPS
-----END PGP PUBLIC KEY BLOCK-----

--------------B298D4F914E16687385FB757--
