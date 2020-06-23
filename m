Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2627C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C32320780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTEbyCt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbgFWXiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387532AbgFWXiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:38:06 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1737EC061573;
        Tue, 23 Jun 2020 16:38:05 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ga4so476904ejb.11;
        Tue, 23 Jun 2020 16:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WAlGtflVitmJXuNlmDW6UOmiaJ2HTYTbPo7tYgORBNI=;
        b=ZTEbyCt6/p3jSFT8nfBxXvUjHSMgVh1qfYNLNrYOZzqPXrTC9DKJ9A63vRxgF33PZ8
         qWx5nk3/M/sCWoW0uqpgz9bT0JNDAC3r9DOy5VQB/C2yVLWQfgULAj9v2tLFuxPvoCEd
         BdnvogcrHVJys21kq9EQbm/caWASnMzQpmoB0cX5sjABDL0fqMSP85b4FK6gzyGcGPg1
         OpeYKjf2cws8K/13Gs5arGH7KzMd/3/uUIBi5b78PjBu2HnxujuGj4uw+8h2sHzRhTbm
         vIAt9+LqRQ6CVEhuM3vrd50580m5DH49IIBmcyAmUl7AWFTNw8QxSeregJbYc26UMPij
         DeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WAlGtflVitmJXuNlmDW6UOmiaJ2HTYTbPo7tYgORBNI=;
        b=O7xyBeqTF0Hz8A1I3WoqB+AEXHmkVOlH2qFmmuEmlypxgnEGzV6Azo13pOcLo1F962
         DSxlB7Ku3qiB5iXJYek+UA0RtECmjeeR5FG2Kb8ZVF3+vyoKckyMTs49bhyvso4F3WIG
         WIYpWaULV9a2CUyvQV9d/qxy7wh15RA0dktRbi95CEmBW+nBiZ+N4+x3AxcbrSyT+MaC
         63wf4h8fvZmHMo3FjdEZXoKs/d1SqZyGeORY8aFJSTr8I6fLnnDqZKm/67BHMXK5AbdK
         ptIUl0OCOPilYkXaZo3kURDsQml1HunVfel7OZNzE6DjxFovPmQIVRarb5BG0Er5eH5Y
         NYsA==
X-Gm-Message-State: AOAM533v0CzJGc2/ww2aJf0GByAU6/YXOGG7biVYbXZcXDxNkD9QZLRu
        rsVuAMCvoMhQ/m5v7vfydKIWGrTp81As30MVB7s=
X-Google-Smtp-Source: ABdhPJyNBbk6RsvVnJ127Hf8zhghQyoKS3AzX62P8JfPXQPWIoJCgq+NaviMpPRUa3h0YXZVC01WX0K7+vBm802j6Fs=
X-Received: by 2002:a17:906:fa13:: with SMTP id lo19mr13899382ejb.213.1592955483750;
 Tue, 23 Jun 2020 16:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200531172804.256335-1-konradybcio@gmail.com>
 <20200531172804.256335-5-konradybcio@gmail.com> <CAOCOHw7ZhDPOxOG4dy91JEQ9U7y=3tabd60THj8NUcZE1fCgtQ@mail.gmail.com>
In-Reply-To: <CAOCOHw7ZhDPOxOG4dy91JEQ9U7y=3tabd60THj8NUcZE1fCgtQ@mail.gmail.com>
From:   Konrad Dybcio <konradybcio@gmail.com>
Date:   Wed, 24 Jun 2020 01:37:28 +0200
Message-ID: <CAMS8qEUNfeBs30GrjLvBmzpCgF6Zb6QQ4BhD1MxD_15Cwr90-w@mail.gmail.com>
Subject: Re: [PATCH 04/14] firmware: qcom_scm: Add msm8992 compatible
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have in fact submitted a binding patch here: [1]

Perhaps I shouldn't have split it since it's just a one-liner.

[1] https://patchwork.kernel.org/patch/11580841/

Regards
Konrad
