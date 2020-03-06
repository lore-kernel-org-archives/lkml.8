Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80328C3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529552084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Mt+J531O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCFDun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 22:50:43 -0500
Received: from mail-qv1-f52.google.com ([209.85.219.52]:37777 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFDun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:50:43 -0500
Received: by mail-qv1-f52.google.com with SMTP id c19so365353qvv.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 19:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bi/pjlomuumQO3Vkx3bu0cA+GyAfdfjkfPRzU1zFnyg=;
        b=Mt+J531OlZM/f8whuVep4YwzzJX2LMgSB/SsgN7o/CZfkM9QpaABXbtlIo4zW/Y+Uj
         ZkZTkiPMTnIdrS7Acw4V72MXVStijgNhvmHrbIj2N3boKnKkLhIzUeweL94buBy71vMp
         DBYm6Mfr7TclMhIIdYRFbrcgnlAaJRE+TxtPnblBReHv3hLdw/NrEpKQEJQZ1TLX04Yr
         nV12L1JMUt+76bZMHyMQSycMGAdMQ36w/UtUmjylGh3Ij7Y7Zj59yuGrPI81BWbGhG3w
         o9GlRUCgwh+W9fVxbIwXCPBXQcG+f+dSFsTeuXrDul0ZaOLo0AS9Fax647F/4B9uwowV
         b42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bi/pjlomuumQO3Vkx3bu0cA+GyAfdfjkfPRzU1zFnyg=;
        b=DhskUUL7GBr+tViWkg0OxLqloPYTKiBAXjkKTg5izdgNfYCZxL+ovPcxLfGhHrcOkW
         AoRZ9FF3gZE3EjIA8v1rCAl5OFbSN1cFAti4jAg54IdDE9N76lYLmADM5NmpVkHDzP2q
         ZOxzlNMKwDD2VGFRHm4dPFgxew1tF1zgp2OX2tzAcQ21lkcBnimF/wu3lG+7kJ8L8c9U
         0vpgq3puTVxgXgoiG4MI6A4wXYGCJGQ5Fr2j0rLynZt6ynrJAWVvJxVStGrekkFR+r3y
         w6Fq157i2pr1wCZyLsHNU75iFFVVp3M4F13AtmOFGgaCGOFTyyyo6QZ8kWxs688rHny2
         hcbA==
X-Gm-Message-State: ANhLgQ2AeCqTKa1cJ2LzWnTKMdRjfAoLN1A0PBhTZnR+1EM9e5eD1Voh
        1z2JFM5P0QKybdDfsSupeVIhrA==
X-Google-Smtp-Source: ADFU+vug+tCCJMYqjWN3RP7xCY7Eg0QWUrWTmX9ltIf+FJD8IlpSy+3OW23ZXWfmow7e9PCzJh4yqg==
X-Received: by 2002:a05:6214:928:: with SMTP id dk8mr1262985qvb.170.1583466640383;
        Thu, 05 Mar 2020 19:50:40 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n4sm3670991qkk.88.2020.03.05.19.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 19:50:39 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [failures] mm-vmscan-remove-unnecessary-lruvec-adding.patch
 removed from -mm tree
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200306033850.GO29971@bombadil.infradead.org>
Date:   Thu, 5 Mar 2020 22:50:38 -0500
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, aarcange@redhat.com,
        Alex Shi <alex.shi@linux.alibaba.com>,
        daniel.m.jordan@oracle.com, hannes@cmpxchg.org, hughd@google.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name,
        kravetz@us.ibm.com, mhocko@kernel.org, mm-commits@vger.kernel.org,
        tj@kernel.org, vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <97EE83E1-FEC9-48B6-98E8-07FB3FECB961@lca.pw>
References: <20200306025041.rERhvnYmB%akpm@linux-foundation.org>
 <211632B1-2D6F-4BFA-A5A0-3030339D3D2A@lca.pw>
 <20200306033850.GO29971@bombadil.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 5, 2020, at 10:38 PM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> On Thu, Mar 05, 2020 at 10:32:18PM -0500, Qian Cai wrote:
>>> On Mar 5, 2020, at 9:50 PM, akpm@linux-foundation.org wrote:
>>> The patch titled
>>>    Subject: mm/vmscan: remove unnecessary lruvec adding
>>> has been removed from the -mm tree.  Its filename was
>>>    mm-vmscan-remove-unnecessary-lruvec-adding.patch
>>>=20
>>> This patch was dropped because it had testing failures
>>=20
>> Andrew, do you have more information about this failure? I hit a bug
>> here under memory pressure and am wondering if this is related
>> which might save me some time digging=E2=80=A6
>=20
> See Hugh's message from a few minutes ago:
>=20
> Subject: Re: [PATCH v9 00/21] per lruvec lru_lock for memcg

I don=E2=80=99t see it on lore.kernel or anywhere. Private email?=
