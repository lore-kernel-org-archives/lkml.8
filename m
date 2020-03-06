Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0E5C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD87E20848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="S+RTPrtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCFEq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:46:29 -0500
Received: from mail-qv1-f54.google.com ([209.85.219.54]:38266 "EHLO
        mail-qv1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCFEq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 23:46:29 -0500
Received: by mail-qv1-f54.google.com with SMTP id g16so403902qvz.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 20:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UBKVYraVJafD+5M72OxbA74Az8/xjpQYVzDHAoevqLY=;
        b=S+RTPrtdnQmzWOWmi8NpS/9bww7wAefolxmQYpv8rQ7Aqv6L7m2Nb1ctOFVSUXFdHW
         3WFG3fWOohF0DNiHpBLmt0fz/DcAzKqoMLUfiVTbHRc3IiYQmnfzyXqg0EDal48pGYNt
         gLsB/pqqtS/gF+CN4qA5uv6fW39EdkqkUYzKqkVFc6fattitlb6L+oaitb3kc8ETggCA
         zzIoGC2vXPkFRbzFfZc8Wu4FeAwJvG4deyFnIqHwdW4zmOWJRxbKl/aAG50oP6BbJvQd
         UU9cMUy/Wk79FA0pmfCc2XglWLWmyJB5joFwBz57Iz+DGoW2JK53NB6ixX+3JtSlK9JA
         hB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UBKVYraVJafD+5M72OxbA74Az8/xjpQYVzDHAoevqLY=;
        b=hPGIFI7C+TMCdpoFOkUuSu9r2FsSV/oj+SeM0Dsm3BJRWGO9KOIjk8sKrZV0dhUwws
         4k8TRvv6Fp99zUpcc7WsauXEN5jgY1MOdwGOJUtSYm8HCVQP5I8g9oLVFckKBoAxfWRc
         9yjdU1umpJU4F51lU89nDiWVbJsy5h1PbR2/j/jLt60sfKdoTSU8q2fQ11J2ZkSnVnBu
         LPcSIFMO6cWayuMTlK8s+rJ3YQlcO7dbEHjfvE9aulZN4mu0BpYKz3MH+FI9h8JuRRXp
         viPX1GtkZflHBJgwAjhUx0QMnn6V/RKSUAI7tK/prpdQaRoBbGf80krej5wJVaJCLKor
         RSrg==
X-Gm-Message-State: ANhLgQ2qV4cAnI6qT/Juip3ltDpgKatCkF6K4C8MFu0DnvJ84h7UGOKm
        tiFc10A0LkCTXPu+SUpGC/tE+w==
X-Google-Smtp-Source: ADFU+vtoKNHsJH3bmJTMeaiNocfZULc7rj2cK+jFh6bCHUrQ3qSTJcxt4u1K1mpJrDhxSt8LpOREFg==
X-Received: by 2002:ad4:580b:: with SMTP id dd11mr1378634qvb.58.1583469988367;
        Thu, 05 Mar 2020 20:46:28 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j7sm13128661qti.14.2020.03.05.20.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 20:46:27 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [failures] mm-vmscan-remove-unnecessary-lruvec-adding.patch
 removed from -mm tree
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <9eb3efe1-f203-c3b1-679d-5e158fd8639f@linux.alibaba.com>
Date:   Thu, 5 Mar 2020 23:46:26 -0500
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, aarcange@redhat.com,
        daniel.m.jordan@oracle.com, hannes@cmpxchg.org,
        khlebnikov@yandex-team.ru, kirill@shutemov.name,
        kravetz@us.ibm.com, mhocko@kernel.org, mm-commits@vger.kernel.org,
        tj@kernel.org, vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1E0DE356-9F9B-4E00-9F53-85E2FED99CF2@lca.pw>
References: <20200306025041.rERhvnYmB%akpm@linux-foundation.org>
 <211632B1-2D6F-4BFA-A5A0-3030339D3D2A@lca.pw>
 <20200306033850.GO29971@bombadil.infradead.org>
 <97EE83E1-FEC9-48B6-98E8-07FB3FECB961@lca.pw>
 <alpine.LSU.2.11.2003052008510.3016@eggly.anvils>
 <9eb3efe1-f203-c3b1-679d-5e158fd8639f@linux.alibaba.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 5, 2020, at 11:42 PM, Alex Shi <alex.shi@linux.alibaba.com> =
wrote:
>=20
>=20
>=20
> =E5=9C=A8 2020/3/6 =E4=B8=8B=E5=8D=8812:17, Hugh Dickins =E5=86=99=E9=81=
=93:
>> On Thu, 5 Mar 2020, Qian Cai wrote:
>>>> On Mar 5, 2020, at 10:38 PM, Matthew Wilcox <willy@infradead.org> =
wrote:
>>>>=20
>>>> On Thu, Mar 05, 2020 at 10:32:18PM -0500, Qian Cai wrote:
>>>>>> On Mar 5, 2020, at 9:50 PM, akpm@linux-foundation.org wrote:
>>>>>> The patch titled
>>>>>>   Subject: mm/vmscan: remove unnecessary lruvec adding
>>>>>> has been removed from the -mm tree.  Its filename was
>>>>>>   mm-vmscan-remove-unnecessary-lruvec-adding.patch
>>>>>>=20
>>>>>> This patch was dropped because it had testing failures
>>>>> Andrew, do you have more information about this failure? I hit a =
bug
>>>>> here under memory pressure and am wondering if this is related
>>>>> which might save me some time digging=E2=80=A6
>> Very likely related.
>>=20
>=20
> Hi all,
>=20
> Apologize for the trouble!
> And Many thanks for you all for the report!
> Obviously, I missed memory stress testing which I should do. Apologize =
again!
>=20
> Qian Cai,
> Which test case are you using? Could you share the reproduce steps for =
me?


LTP oom01 in a tight loop with swap,

# i=3D0; while :; do echo $((i++)); oom01; sleep 5; done

>=20
> Hugh,
> Many thanks for help! I will seek some memory stress case and waiting =
for your case.
>=20
>=20
> Thank you all!
> Alex

