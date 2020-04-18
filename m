Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A0EC38A2E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B6221D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="sRR3q8ll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgDRNBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 09:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725804AbgDRNBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 09:01:39 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ADDC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 06:01:38 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id v7so5544200qkc.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=yTjNxrSOgcyuq+6eZ9Gw7+GF3CnNW6GYqtu3CqLSbFk=;
        b=sRR3q8llUmWoiuLGukaAvAd8ViBMaW0dyX5Og+bGaC42zmPYb/ZW6zWdIgPScBt0ds
         zpLlsfOzDRrviKxJxEAdf9cG1QnTXxZ4Kj0eX41qVbEg0T42+q2aD+6jXoeOwSjlvGMR
         jwENh72TZLCM9mRN0kqJWbQUn04Xh2Sdb0QdGzTUx98aX4efZ5NwsQdVdXRq8XQhz+Un
         7SXQHQq+ooXENYwFRJsQ2vysSgqrqhGZ3dZryMSmgZ2sopKC9KhQ35Y/77EmCFYbUmDQ
         r+WT0AqwRkaBkUfpwO697ie2Q3ILmUT9vpLhXE6UgUYaKnYNfx4xQT7dIXdYTIIHbxqK
         FNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=yTjNxrSOgcyuq+6eZ9Gw7+GF3CnNW6GYqtu3CqLSbFk=;
        b=jKg7IORnDZrT918FHDpTnIZIW4uegcJTJCGsGufgd+uc7ffI3OKUB2ES9jbCqphkEd
         XrGSKw69bAhtH6MjjhwLbohdNLevi9584kanZTXAraLE1raK3iJlEU4hlds7+QxNEOxR
         rTI4c/th1sstBqvp1O4eOeDFJxXfbEys58t+MgFCKOMtTa64guu1iCxktZd0udZJ0wXC
         TaMhCCUZH9TXGCvFrF5RNPgQEcZGOz5lESt4FpKRCS/QrCXwTgj22TR9gTXivhVpdhex
         YIrd0qWp+qyMLFvwFJpwN7lb/iNtLpkPuMU6zx0jOtRFs1xR/ET5B9ExomM73xOgMetz
         1/AQ==
X-Gm-Message-State: AGi0PuY2yPtmOTrx7DSHlC9wGwbFegy1ecciHimnWPivg2jHAMj0OszM
        2G86nUcimxcdtS5/vcSnZojQF78aJQE54g==
X-Google-Smtp-Source: APiQypIspR2qhGzlW2OI6PuNYwZwwXUdXzmx1HzknFwwaTPdiVUaZkDU0LHydRgegDMwl+ENDrnfYg==
X-Received: by 2002:a37:3d4:: with SMTP id 203mr7653513qkd.306.1587214896901;
        Sat, 18 Apr 2020 06:01:36 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b126sm18827100qkc.119.2020.04.18.06.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 06:01:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
Date:   Sat, 18 Apr 2020 09:01:35 -0400
Message-Id: <57CBF6B2-4745-4E36-9AA5-7E0876E3DA8F@lca.pw>
References: <20200418121022.GA6113@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200418121022.GA6113@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 18, 2020, at 8:10 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> Yes, your patch still looks racy. You need to atomically read
> domain->pt_root to a stack variable and derive the pt_root pointer and
> the mode from that variable instead of domain->pt_root directly. If you
> read the domain->pt_root twice there could still be an update between
> the two reads.
> Probably the lock in increase_address_space() can also be avoided if
> pt_root is updated using cmpxchg()?

Hard to tell without testing further. I=E2=80=99ll leave that optimization i=
n the future, and focus on fixing those races first.=
