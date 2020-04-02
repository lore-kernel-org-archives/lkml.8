Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E512C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043CC20675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cKiCEtpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733265AbgDBCAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 22:00:36 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:43032 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732498AbgDBCAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:00:35 -0400
Received: by mail-qv1-f66.google.com with SMTP id c28so901389qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 19:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qfoLXrnqNbdNMc/qg2fQn2VjZnT5IOOCPmT892IlYdk=;
        b=cKiCEtpAG53uMWAllPIubuUVMZlkf3zGEeenWXGZmNb+BHlxsZBGyKew+FTU9oQ0DK
         McD3eNpxPXKTXQPqLWrgQdam04yznD9HI+ZfpUVD4+6oU/EnkDneahxLSct/AcGOF4gG
         uheCdgHsaoKysYe8jmBDL5RQYET+jwYiCS8TGbjMxhAArzztsmCasWUrhDVQx5cbzEiC
         46MaPsstwXUfybIOU50IHy4Ix+1AtX+LmS7afvx+O+PlAXsZ+jUibdRobmcBTI6f7Jxi
         MgjCUnelx9ep+I9n1ADEJjzAxCwlrKMWRT47dVTrQnjx7fRr/mKa6yMLmmnXJqb/GFsW
         Zg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qfoLXrnqNbdNMc/qg2fQn2VjZnT5IOOCPmT892IlYdk=;
        b=Pd9NDu8SQ8w8gYe9t1Bo3/y9JvICQO6FxJitdFX2YDDxI/zVA0eAmnHpreeDjzS4/V
         0Os0045dZYChR3p1+GATEO9uAmsgc0mPEeUDkhghhYQhmo734/rC8HFslmWNqBR4s/a/
         +HDJi3DAJuH5pXs4rBAhYj1JLeytpPk4jcSDQH5Ed9n4lJsu0VfrXvKbmWJcWUOZGbWe
         XdyC8oycr8lJIBvRkv9JdUJW64Kqimn6irrAuhrHM7+p+I7g3oe/lDt9Bq8YBUB29bxR
         2PsE1LZAqjkBFXkJBMD59nCS3VY4xPjeg1e12tCrw4HchduSemjJnTTqzx2eFDoexSsE
         SSKQ==
X-Gm-Message-State: AGi0PuZgIDY0nfNZDZUafalPyjxEe7on7pEOr/kFvcDdvL3mipgPE0Vv
        QTj2UYJZQCN9hzHLEyouoXMJRg==
X-Google-Smtp-Source: APiQypKt76w7m6e5xoRV81SkiAPCm2e1rthecIHWTZSulTpArjqfbhWp7Y/79CYWcsS260luE96bsg==
X-Received: by 2002:a0c:90aa:: with SMTP id p39mr1075930qvp.38.1585792834408;
        Wed, 01 Apr 2020 19:00:34 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s56sm2889238qtk.9.2020.04.01.19.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 19:00:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Deadlock due to "cpuset: Make cpuset hotplug synchronous"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200325191922.GM162390@mtj.duckdns.org>
Date:   Wed, 1 Apr 2020 22:00:31 -0400
Cc:     Prateek Sood <prsood@codeaurora.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6AD62381-394F-4742-816B-12DE67DE9788@lca.pw>
References: <F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw>
 <20200325191922.GM162390@mtj.duckdns.org>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 25, 2020, at 3:19 PM, Tejun Heo <tj@kernel.org> wrote:
>=20
> On Wed, Mar 25, 2020 at 03:16:56PM -0400, Qian Cai wrote:
>> The linux-next commit a49e4629b5ed (=E2=80=9Ccpuset: Make cpuset =
hotplug synchronous=E2=80=9D)
>> introduced real deadlocks with CPU hotplug as showed in the lockdep =
splat, since it is
>> now making a relation from cpu_hotplug_lock =E2=80=94> cgroup_mutex.
>=20
> Prateek, can you please take a look? Given that the merge window is =
just around
> the corner, we might have to revert and retry later if it can't be =
resolved
> quickly.

Tejun, can you back off this commit now given it seems nobody is trying =
to rescue it?

