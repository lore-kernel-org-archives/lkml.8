Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA6AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 03:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F26206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 03:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DGITtrcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGIDai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 23:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgGIDah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 23:30:37 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BE3C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 20:30:37 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id j21so267639ual.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 20:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3UE7RbCMzeCTWKWR3FKIJGU02RygMbupk5QpwvNDfX0=;
        b=DGITtrcNDA2p6QMEiL83uxlFiT3okK/t54evn0UHEw8MPIwkU3xNSX9mLDbO9GmE3U
         oOdoiCPW/0IAnXc1egKoy07oDP5qWY0AZNZpQWqHTS4tWWsKh1NUtHHMClVZJAb31U5H
         DyBydGoU6b92zSFFP7H5VM4Ge0Im8f14PFVj8F1K4ok01MzLIXn/hlSv0Mirb5KGIYiO
         kPC86hxGbxnUdcOrO8xbjAEj4n6sfqkMmay0tMg7pWT0yIV8ShKmjzoTr3Wj3UuBpi/T
         N0XG04BBHymwC5va7fOp92nLM+lUKyotqxLQrmBUgFLVOKHNQV+8D2Wvs3dRJaE0QIM1
         UqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3UE7RbCMzeCTWKWR3FKIJGU02RygMbupk5QpwvNDfX0=;
        b=e82QMzn4DrVLH2M9IXmTmPS1w0I0hP/1uq43yan1JaSgj+4yOWJ9cUMejQ/ocs4PbC
         9GvhedziBoGDnsli8HRYhK4CPM5EsJ+u+EBEqs2yCDueZy3k3U67mc8mDBb1JX4NOOMK
         AuKEsIrV5ThWyvFJhtVaAd/+xwdEQbuvkD5ZpfDMv6b8ZAPphb6C9Y2hOqTR4dgxYYhs
         JZl1ABAdH5V8ku49/3fbOR02zwAUYGUcwh/dpJlyCyPmDRGJQjKd8kidRQsyPEekqdXg
         /B3E1qamXfFwgjZveSjuqbdeg22CatqVcnlO6H4Uf6Kolqq/4VLfEdZ3WQz1lFEzcM9J
         xjfQ==
X-Gm-Message-State: AOAM531kUWYtM9L02WMRmnI/utxKR99d9IQQ1BkzyAW5nB+Ptf0sSaJA
        odyuZ6Fwf7ySWdkbQlCpW9Ekgh0esS0YK1Taw7NkZegQ
X-Google-Smtp-Source: ABdhPJw55RL6qPA11nWYNULw1+4SqXgr2FPFwDANVI4NjEU90cA9PpkhYPr/X1GBTccI20Y+wCLWZ9W22Rfg4yjlm2E=
X-Received: by 2002:ab0:6e8e:: with SMTP id b14mr49497543uav.0.1594265436434;
 Wed, 08 Jul 2020 20:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200708235306.3854404-1-linchuyuan@google.com> <a219c4ba-23ec-f6a0-1bbb-593e54dd11be@roeck-us.net>
In-Reply-To: <a219c4ba-23ec-f6a0-1bbb-593e54dd11be@roeck-us.net>
From:   Chu Lin <linchuyuan@google.com>
Date:   Wed, 8 Jul 2020 20:30:25 -0700
Message-ID: <CAKCA56DrA30WATZqCv6dDbj0siUW3Uvub0P1_6xRO-aPsMMPVg@mail.gmail.com>
Subject: Re: [PATCH] hwmon: adm1275: Make sure we are reading enough data for
 different chips
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kais Belgaied <belgaied@google.com>,
        Jason Ling <jasonling@google.com>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhongqi Li <zhongqil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 5:33 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/8/20 4:53 PM, Chu Lin wrote:
> > Issue:
> > When binding adm1272 to the adm1275 driver, PEC error is reported.
> > See blow:
>
> s/blow/below/
>
> Also, unless I am missing something, the error is only seen if PEC is
> enabled.

This is correct.

Regards,
Chu
