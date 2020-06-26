Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE31C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 05:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC76F207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 05:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzpIWVvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgFZFMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 01:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgFZFMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 01:12:51 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5ECC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 22:12:51 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id u12so6597638qth.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 22:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wfBF13BglTF4RwewMZ1ym14rhoAm3O65QPSsX/aig1Q=;
        b=tzpIWVvYXKuc6g7aJh3lrInOqTb4/9NJBgy8cjV8iaiZwqcyKu3Wk9Ic2NRMBRyQxb
         0xVFjKC7OGee6zjm4eml4+rJgw2oVmvzZqGwnYB7yj2BhpQVs3SwWaK2uC5LNR4EGK4k
         FFYz4N/1yqGXSAHbbVU5ljHV3c6R3K3bdl53hZPSdO6F3+67ypTbMVnFlU9tF8RlaLUm
         2u/nIsDA9npZr89dfJIsWIMdGwDV4tcxGe8rIf2b1zPc0ViD8E91Pk/l5eCO+deNHbPl
         O+HsDHlK55Ylst81pGtzaGShrsKJP4jeSX0mOarC25ibwmor+11hvl3i+rvTK6Kh0WSC
         xhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wfBF13BglTF4RwewMZ1ym14rhoAm3O65QPSsX/aig1Q=;
        b=ihDbGgNBQKkcqO70dcfk8wBS6NOfYKlqFXJHOvtJbrQr1Go31fmPy29DZs2AUQFlMn
         kD0T66Hre9uN2P39LXAVBOm4NHgXWAyUdARaRfFlMIgLjWKdtP+RDbpQiVMqJUBm4PD+
         mj0fRTg4YnfU5pEn4Hb+MCum3cTx9rKm4H3XfBKVXZc+sgRRdMtw/KYF9AHnEWIsxoUm
         4OOA0l8dUvO+W6sq2NQNnoq7FbxfuN2LuY7Q6pPtPTQ5ey+PvxfIHzVO7Rwte+jU/sp5
         kmsz6zUxlAem6jGEy1WuB5ngMflCz4yjNXd0ykXfB/zZS2k1FWWUWMYh+GZ343EEzQRI
         CoSw==
X-Gm-Message-State: AOAM532OTvkcJnRQA7RjHRZfM3pdLrG6x4wPm0BDzzu5V1vxZoT5owfT
        um3hlkE9A5CkolmYWGeCnjN6yCTNNXuGy6zIUZM=
X-Google-Smtp-Source: ABdhPJwKA2jCIFGeMliZNN/1HC23Yxz7U2N9HCSHBYVpZLPiXf3d+MD6I/V+N2uubX2eypI4abaLXeM1u9PWUdQK+GQ=
X-Received: by 2002:ac8:5691:: with SMTP id h17mr1077390qta.35.1593148370803;
 Thu, 25 Jun 2020 22:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
In-Reply-To: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 26 Jun 2020 14:12:40 +0900
Message-ID: <CAAmzW4PrUQ2ivC8gVwL0boLL+z3dpg8W18aPQ-JtSsQP2juNZg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] workingset protection/detection on the anonymous
 LRU list
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 17=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 2:26, <=
js1304@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Hello,
>
> This patchset implements workingset protection and detection on
> the anonymous LRU list.
>
> * Changes on v6
> - rework to reflect a new LRU balance model
> - remove memcg charge timing stuff on v5 since alternative is already
> merged on mainline
> - remove readahead stuff on v5 (reason is the same with above)
> - clear shadow entry if corresponding swap entry is deleted
> (mm/swapcache: support to handle the exceptional entries in swapcache)
> - change experiment environment
> (from ssd swap to ram swap, for fast evaluation and for reducing side-eff=
ect of I/O)
> - update performance number

Hello, Johannes.

Could you review the v6 patchset?

Some minor things have changed so it's really welcome if you review the pat=
chset
again. Especially, "mm/swap: implement workingset detection for anonymous L=
RU"
doesn't get any ack yet. :)

Thanks.
