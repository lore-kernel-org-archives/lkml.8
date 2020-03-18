Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C785C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF042076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l81RBBfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgCROdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:33:23 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:44089 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgCROdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:33:23 -0400
Received: by mail-lj1-f176.google.com with SMTP id w4so12587752lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XF5S4XxJDvzuKvczlMPC3brfPAk78vzQeXC6ETpLBZI=;
        b=l81RBBfzP7Dw/gUWj2/x/6CbwsAtfF9hI/+ROQMlzJ85+02CYWcRou9ncfaDyyssCH
         ejEaoS7axwEdCEbJloyWnQjeAqyRLvzQPTQki2cVvGGVBObg6nbjUI64ao/WLfuA5U9V
         dThsCy8N5yaveHKJJ4S4jgBYVh2kN1FJsKoYa8cD5sLXMFgVrwKNSUhentKpaLvGTrPD
         S5eTslz9LLWRlpgJAPV0IHN6wC5Ro5sTTVgd0MoI+UXvgw86dJMiUfB1Jl9Z8IDE1J3Z
         UGcz0WMMx3dVmMhIu5o39jMKy+PheMk3gWKIlLJLoKqhzotkG3Ev4x6rwpaAHFq0Rqoo
         w0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XF5S4XxJDvzuKvczlMPC3brfPAk78vzQeXC6ETpLBZI=;
        b=gvs90HIXmcG/NZU6UjN5FNAHj96Zj/+Tsf8osg3vM5ZqcN9iap1A8rUf0YlB68W0kU
         dj1LOil7oYKzO3q1Ff+CzFU4hdNh/7ND2JCYePekRW2IVeaHAcuMBj52IkRNCa1DrD1o
         2w/C0KBNCdbMwOwXLkIYjcZLzimT3IWrvpZzbhnKAbNMOWYbME/weQbrLkx/fsZcbVXB
         yATOqxqqztmTKyaB6foafvlVxsunu/4Z8/5X/vEzSIkE/ihDO7141zPqFB6Lggj0z1w8
         kt5lUgNHAxvGrgdAN4RKhyjnqAEKYGI+SqnfpLtAgFAwDHEKALHZ2wUxpbF1t4+Fsd+I
         9uUQ==
X-Gm-Message-State: ANhLgQ0qxfGao+bOw9qO3/SOa1ZM8tTWQsFVUQRU7sXxW1tl46mi7oUr
        v0YfQBzTEnpieFy2jLUfDzkwXrmz6kDHG1TZy1uGUlavoI10qA==
X-Google-Smtp-Source: ADFU+vvDUw2azv5wuxvYN1sBPD4zgg6lx6ShyeW7lx3uJBMBnxMuGtEecjIe9jUXO8NzsyMmVaCSoFcH62+sHNrNuOY=
X-Received: by 2002:a05:651c:285:: with SMTP id b5mr2500039ljo.165.1584542000262;
 Wed, 18 Mar 2020 07:33:20 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 18 Mar 2020 20:03:09 +0530
Message-ID: <CA+G9fYtk0jCB1M=MeYP4SshXjyyhLJbHuSzpOkq0OPVjSRpqZg@mail.gmail.com>
Subject: mm: hugetlb.c:5449:62: error: expected ';' before '{' token
  for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL)
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     lkft-triage@lists.linaro.org, Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>, andreas.schaufler@gmx.de,
        js1304@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux next build failed on arm beagleboard x15.

Build error:
/mm/hugetlb.c: In function 'hugetlb_cma_reserve':
/mm/hugetlb.c:5449:3: error: implicit declaration of function
'for_each_mem_pfn_range'; did you mean 'for_each_mem_range'?
[-Werror=implicit-function-declaration]
   for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
   ^~~~~~~~~~~~~~~~~~~~~~
   for_each_mem_range
/mm/hugetlb.c:5449:62: error: expected ';' before '{' token
   for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {

config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/am57xx-evm/lkft/linux-next/718/config
                                                              ^
full build url:
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/727/consoleText

-- 
Linaro LKFT
https://lkft.linaro.org
