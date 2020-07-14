Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A53C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DEA722464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594743713;
	bh=4GCjAqSV0Pth3W+zX2LJ36250mtR85mhX18RV+1wKTA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=z9btD1mPUTj9KAJTDoCPCw3jPg2190AQjnekmJ3CQB+fnJhezsjd5eNmKNkhUZcuP
	 qNga3r32xVAsCYUpGr+i+wKrIN45tvG69AnHJd7cF4lWBGNFH7NNA8QZBEMK3oJAFq
	 VdXGQ2KmPeeE96rsWCcnZa4pfFBbqlVKMBJTRBs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgGNQVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgGNQVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:21:50 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6964322525
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 16:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594743710;
        bh=4GCjAqSV0Pth3W+zX2LJ36250mtR85mhX18RV+1wKTA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lvh5REozGm0A78kMxn4keCV1zoNo414fPfMB6OhmQi/ZHxWtdijevQOSEkrXOMlNC
         Q+hEKmvo1Jw1iv6WOLG5812MWxURPui6DhSVPYuPFAWyz7cWHQmoq6KQabNbjMJn7a
         sYJhb21P2ONZnSuVUSwTfgVxoSau/Te2s0RBVdOI=
Received: by mail-oi1-f182.google.com with SMTP id y22so14346519oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:21:50 -0700 (PDT)
X-Gm-Message-State: AOAM530IrdgmFwiO1LEVUDGfW+wagysAIgGcto2y+qyGTu5ttWR0Egv5
        lgQvYJlEPHcfsftJ6Q5lmWjB6qS3S4v3fBgrng==
X-Google-Smtp-Source: ABdhPJxQNyHpMFhZLUbZ6It2n9TDom/e5AntbiNac8EVjdt5Whk+OoOixn+C/FWA1Tt+5scYVLZBxIMBZyLyUfKVYBA=
X-Received: by 2002:aca:4844:: with SMTP id v65mr4504901oia.152.1594743709821;
 Tue, 14 Jul 2020 09:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200714094141.147418-1-thierry.reding@gmail.com>
In-Reply-To: <20200714094141.147418-1-thierry.reding@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 Jul 2020 10:21:37 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+c5+QFpdiNK4K=ROPAhxp=SMYS6iRFuJKooin=NbCiXw@mail.gmail.com>
Message-ID: <CAL_Jsq+c5+QFpdiNK4K=ROPAhxp=SMYS6iRFuJKooin=NbCiXw@mail.gmail.com>
Subject: Re: [PATCH] checkpatch.pl: Allow '+' in compatible strings
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 3:41 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> The current checks will interpret a '+' character as special because
> they use regular expression matching. Escape the '+' character if it
> appears in a compatible string.

Ugg, looks like c6x really liked using '+'. Might need to be added in
schema checks, too. Not sure offhand.

Rob
