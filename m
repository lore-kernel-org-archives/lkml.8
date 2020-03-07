Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABCEC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 03:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7034A2070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 03:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="au7G1ywR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCGDbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 22:31:45 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:46660 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCGDbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 22:31:44 -0500
Received: by mail-qk1-f182.google.com with SMTP id u124so4295939qkh.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 19:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XARr/VuKYkjywi+JPn9ik9fPAL21/k/URnFAwAE8TVA=;
        b=au7G1ywRJ1+LtrW503dRu7ZJvf1oPXt2rKOlSxg03AjtVDfObsrhae+pMIOWBAgwZI
         TU7OSYijFgxEyvMAuENsaGqPF5sOU+kW1/0SyhpkBAthPV+LMyAqBMPWYg6rCFlNFVnC
         fLPU/FbhRHpt73IzAvJ1x0S5SX/pJuuK9YNAUxTHrjg6o8hiRJDcYDLTtGkUcsAtlyNB
         6lGxfEbBi9bOtsDAj0Wt0mZnazDwidXkWAEyU+yLQnrSvyDq1ENCs5t+fMvUUpg7Xe6M
         b4H3UBkLH8PPinXCvkyQgob6DZt4wlpOr07QaKqDQXYgvDKK2P3Ccd3QBvfn6Pyem8uo
         zkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XARr/VuKYkjywi+JPn9ik9fPAL21/k/URnFAwAE8TVA=;
        b=diUriEd/mtx/KnYHFHWANckbF1SzM02eJSp5tPRT0wDXYxMK+suP8pgpN2UkVjzWlo
         VIyzdtTEcBirxu2bO8x1ohozY3xpfJeI5TAIQYGlKTYybhVEjo+npjcQFeaAu5Bgeo15
         HkA5nhHg2z2e+W/7pwpDXWQMZ0RAL8A9lprizjXuspT3slLONNv1j4owYdmsLxvzSAxL
         OG7cCOK5Hgb3Q4bRhC3V11hvFbW+1Wa5IWoZIYDKjlvafaS9r2YUxnoMoaAKMaV1Unme
         1twPAOrwCL+9f8T/g6oJzT8fBql452t1ktxoUuQmBd4khvJrXS/YDXxdGOOre3AIorqb
         0Z7g==
X-Gm-Message-State: ANhLgQ0KIrGtPV857uxPlBLVyFcn+ajBgrz39NFoSKRFVgRlH8nyNWuF
        Lq0lMsSbHx7n6CIZeSDDiviIKQ==
X-Google-Smtp-Source: ADFU+vshDVZSnam9ehuBOhF0vtYT+YiAcDoo1MLfZ+6JO6CHZ7hA5P/pIMQII9H+GfI1jDU/tBjBfg==
X-Received: by 2002:a37:cc5:: with SMTP id 188mr6142295qkm.161.1583551901437;
        Fri, 06 Mar 2020 19:31:41 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 79sm18940433qkf.129.2020.03.06.19.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2020 19:31:40 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [failures] mm-vmscan-remove-unnecessary-lruvec-adding.patch
 removed from -mm tree
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <7149d2fb-2ff2-d251-2ed1-b4e6d81748ee@linux.alibaba.com>
Date:   Fri, 6 Mar 2020 22:31:39 -0500
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, aarcange@redhat.com,
        daniel.m.jordan@oracle.com, hannes@cmpxchg.org, hughd@google.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name,
        kravetz@us.ibm.com, mhocko@kernel.org, mm-commits@vger.kernel.org,
        tj@kernel.org, vdavydov.dev@gmail.com, willy@infradead.org,
        yang.shi@linux.alibaba.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C10223BC-1156-43FB-B7D9-674076AFDE19@lca.pw>
References: <20200306025041.rERhvnYmB%akpm@linux-foundation.org>
 <211632B1-2D6F-4BFA-A5A0-3030339D3D2A@lca.pw>
 <b123f1d8-eab0-4689-9400-ba1f853728b7@linux.alibaba.com>
 <f37b9b6b-730b-09b0-dd6b-5acba53e71e6@linux.alibaba.com>
 <792CE873-A64B-4FA6-A258-A8B6B951E698@lca.pw>
 <7149d2fb-2ff2-d251-2ed1-b4e6d81748ee@linux.alibaba.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 6, 2020, at 10:26 PM, Alex Shi <alex.shi@linux.alibaba.com> =
wrote:
>=20
> =E5=9C=A8 2020/3/7 =E4=B8=8A=E5=8D=8810:27, Qian Cai =E5=86=99=E9=81=93:=

>>> Compare to this patch's change, the 'c8cba0cc2a80 mm/thp: narrow lru =
locking' is more
>>> likely bad. Maybe it's due to lru unlock was moved before =
ClearPageCompound() from
>>> before remap_page(head); guess this unlock should be move after =
ClearPageCompound or
>>> move back to origin place.
>> I can only confirmed that after reverted those 6 patches, I am no =
long be able to reproduce it.
>>=20
>=20
> Hi Qian,=20
>=20
> Thanks for response!
> Could you like just try to revert the patch: 'mm/thp: narrow lru =
locking'? or would you like to
> share me info of your tests and let me reproduce it? like kernel =
config, system ENV, machine type.
> I had run hundreds cycle of oom01, but akpm kernel(f2cbd107a99b) still =
survived.

https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config

HPE ProLiant DL385 Gen10
AMD EPYC 7601 32-Core Processor
65536 MB memory, 400 GB disk space

Processors	128
Cores	64
Sockets	2

linux-next 20200306

>=20
> I got my ltp mm testing results, it run total 75 cases, failed 2, skip =
9 and others are success
> and kernel works well after test on yesterday's akmp head: =
f2cbd107a99b.
>=20
> Many Thanks for help!
> Alex
>=20
> =3D=3D=3D=3D=3D
>=20
> Test Start Time: Fri Mar  6 20:49:59 2020
> -----------------------------------------
> Testcase                                           Result     Exit =
Value
> --------                                           ------     =
----------
> mm01                                               PASS       0
> mm02                                               PASS       0
> mtest01                                            PASS       0
> mtest01w                                           PASS       0
> mtest05                                            PASS       0
> mtest06                                            PASS       0
> mtest06_2                                          PASS       0
> mtest06_3                                          PASS       0
> mem01                                              PASS       0
> mem02                                              PASS       0
> mem03                                              PASS       0
> page01                                             PASS       0
> page02                                             PASS       0
> data_space                                         PASS       0
> stack_space                                        PASS       0
> shmt02                                             PASS       0
> shmt03                                             PASS       0
> shmt04                                             PASS       0
> shmt05                                             PASS       0
> shmt06                                             PASS       0
> shmt07                                             PASS       0
> shmt08                                             PASS       0
> shmt09                                             PASS       0
> shmt10                                             PASS       0
> shm_test01                                         PASS       0
> mallocstress01                                     PASS       0
> mmapstress01                                       PASS       0
> mmapstress02                                       PASS       0
> mmapstress03                                       PASS       0
> mmapstress04                                       PASS       0
> mmapstress05                                       PASS       0
> mmapstress06                                       PASS       0
> mmapstress07                                       PASS       0
> mmapstress08                                       PASS       0
> mmapstress09                                       PASS       0
> mmapstress10                                       PASS       0
> mmap10                                             PASS       0
> mmap10_1                                           PASS       0
> mmap10_2                                           PASS       0
> mmap10_3                                           PASS       0
> mmap10_4                                           PASS       0
> ksm01                                              FAIL       2
> ksm01_1                                            FAIL       1
> ksm02                                              CONF       32
> ksm02_1                                            CONF       32
> ksm03                                              PASS       0
> ksm03_1                                            PASS       0
> ksm04                                              CONF       32
> ksm04_1                                            CONF       32
> ksm05                                              PASS       0
> ksm06                                              CONF       32
> ksm06_1                                            CONF       32
> ksm06_2                                            CONF       32
> oom01                                              PASS       0
> oom02                                              CONF       32
> oom03                                              PASS       0
> oom04                                              PASS       0
> oom05                                              PASS       0
> swapping01                                         PASS       0
> thp01                                              PASS       0
> thp02                                              PASS       0
> thp03                                              PASS       0
> vma01                                              PASS       0
> vma02                                              PASS       0
> vma03                                              CONF       32
> vma04                                              PASS       0
> vma05                                              PASS       0
> overcommit_memory01                                PASS       0
> overcommit_memory02                                PASS       0
> overcommit_memory03                                PASS       0
> overcommit_memory04                                PASS       0
> overcommit_memory05                                PASS       0
> overcommit_memory06                                PASS       0
> max_map_count                                      PASS       0
> min_free_kbytes                                    PASS       0
>=20
> -----------------------------------------------
> Total Tests: 75
> Total Skipped Tests: 9
> Total Failures: 2
> Kernel Version: 5.6.0-rc4-06724-gf2cbd107a99b
> Machine Architecture: x86_64
> Hostname: alexshi-test
>=20

