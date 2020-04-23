Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49667C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 03:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D2E20747
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 03:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vM2gdpRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgDWDtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 23:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726002AbgDWDtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 23:49:12 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD8DC03C1AB;
        Wed, 22 Apr 2020 20:49:10 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a21so4689277ljb.9;
        Wed, 22 Apr 2020 20:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4JM7We6bunIz+g6XmvFn1IEzfMjm4CKv4LN0v2ntOLM=;
        b=vM2gdpRXS9VtLSOzF1MYlXw9uRJK2iCEMOidXL7Cd2m1r+l6JqVIcz4yw7Sn6kEpxz
         YhUiOFl1DrRtCb3wSY3quz2bfebzhZlp/m050rTL3759vJE6jvvS/smNxar46rWz5XP5
         57HvP9A7GQTrQaG3CVBFsyxZHknrZePnfrdpNTE8+7ZaiXB8tgfsZ8pRZwKoKMupswIa
         OLolrwraOT4lIwVEBt6Owhd4Uq1hC8PCP1jHjdnS1f6sk+0Ta+8DKgAl6KYyl063vqqP
         bTg1/DF5z/YUI/tzRbm9r+GGW0pioNenPecD9i6WzEhLyGUsUkfgy90/8Xjxse6aBHzv
         F4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4JM7We6bunIz+g6XmvFn1IEzfMjm4CKv4LN0v2ntOLM=;
        b=bNArH43vF7o2dg62KynGJYeQas8SG3CC8bPIEiaO+pFdDOCqruvpZGWHu+ldglvvde
         /W+gZFA1q1Tex9fpnUsL6uazG0vpraaX2cP1BdZRKsBxOx81znjHcismQeGBPEjz0lJB
         pqDQUKxAWcaiAGPI9IQ9hXSWx2DtjnrhEQnyiA87jpzTZd7gMVejVNnPcjdFZ+1gpbRs
         WVHvqg7MfW/FOhcZr4JEG+JNixj6zXLlnBa4L7dkqRZ3H/Y8hegAYNcoZZP1dyXgb1D0
         sb25kBXd2XqVcM4CGBw4PVmFyAsyG8nEkBsz2S7GzsOP4VsD38e07Dz4KBr+WzQPqCQF
         bOag==
X-Gm-Message-State: AGi0PuZLAKdPoB3bIkOpPjQcSqyiRkTCltVeGj8GhbF/QKHWMdAuKMj3
        oJeMYEOadrnM+pa9wDozIGIJPkLCtd+YwtbcrFQ=
X-Google-Smtp-Source: APiQypLcgS5aDreN0N3Msp5Q4hhsUyS9j9GgWbpEW9yptpqpZXWyGyn6hEXXB3uaEmRS6JG5VFOSwC3Mfg8DKu1GKa4=
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr1071769ljg.269.1587613748658;
 Wed, 22 Apr 2020 20:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200324144324.21178-1-aford173@gmail.com> <20200423031002.GH8571@dragon>
In-Reply-To: <20200423031002.GH8571@dragon>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 23 Apr 2020 00:49:52 -0300
Message-ID: <CAOMZO5B3OL3_Ow_gy_a4PD=E6xaOWvOAHw-aDDB54E51UajQ4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: vendor-prefixes: Add Beacon vendor prefix
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On Thu, Apr 23, 2020 at 12:10 AM Shawn Guo <shawnguo@kernel.org> wrote:

> Hi Rob,
>
> Are you okay with this?

Rob has already applied it:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/Documentation/devicetree/bindings/vendor-prefixes.yaml?h=next-20200422&id=f756619f26edf74ad55d2151a6757a260e660fa8
