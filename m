Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BE7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 201A520672
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594235137;
	bh=aaYK61D2dba1tdgulaTSDb0XcVB63hreHbj7DH35NsI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gBE4R/5JGnYVbQJVLrLGeWQZOORYB2qvwF4c3u6LYJOssSXr0AvhM6Rl00Cu+SisU
	 ufODk6Accov8vcjejnQp7GL8brrq44ffVFuYKoqaJIvsBDVajamkt9c0u5hbWXfLHx
	 GQb2R9alPMmaO1PtqpLQWEVWzEcdyYJ8Fm/fjxrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgGHTFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgGHTFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:05:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AA9C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 12:05:35 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e8so21229727ljb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 12:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pkDFbbuq3q2W1lHJjvEjj/xgyCF9z52iptQfPftmTAM=;
        b=HtfmUDGx2rNdsQOsn0yMpe+lX6pcF1XlTKPk2+SSS34TYeLBmOCv+2DzaSgwpR/DuO
         9WFvZDZnHLeA9A8dhSTORzcJ8AUHWFqPNczkXRVlHUp872ci9/51LVRhKDSFziM5QM34
         wZ/UjaxcGUXNmbkIqyvtwcbfni2VvnT6fsHGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pkDFbbuq3q2W1lHJjvEjj/xgyCF9z52iptQfPftmTAM=;
        b=aMiaXS/WFIQ/I+0wMefXnKR69zoCDyonPyPmhhHMcqs6F7CSAAuSJc58KP/SF7iSIK
         lLhdzcddocU0DTrKF6HRTC1cTvXHX9wzjjNMdYH9HMURy5zG6WEi05G1tnCKht7JHcFx
         HrSrALtJbvobTUc5E6GaFyHE6juAHe29ohP/H2m1PB2U0XNCZ3wqNB/IibhMiBHkUbkX
         ON/ITv2Z4XVmOymlqWtBIGIIKwh1NN4f9FD+HF2Po5J3FwNBjgYVbdoX79cUHGKJe2zi
         JUv/M8d7puE+bYBF1AaeyMfMXjYLhW2qjJvJwuMAY1GK8xqhHe3CkAT3BkgTaGkVB7dt
         Qx1A==
X-Gm-Message-State: AOAM532n29uktlqPMGyKYP3j0Eqd0Rkv4QqBTX4U3rIsHGNL9T3OMjVu
        1HUeaqaB0XOs4J3DaJ2PkULSEmDkCyU=
X-Google-Smtp-Source: ABdhPJzdjUDLzqajnZCyimHWgj88BeGeS3ltBDGxFxy1b9FqgnD+YLe0Vms6SXaFOTyMcPBJQlMDkQ==
X-Received: by 2002:a05:651c:1b5:: with SMTP id c21mr9256202ljn.82.1594235133707;
        Wed, 08 Jul 2020 12:05:33 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id n9sm200740lfd.60.2020.07.08.12.05.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 12:05:33 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id y18so27496991lfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 12:05:32 -0700 (PDT)
X-Received: by 2002:a05:6512:3f1:: with SMTP id n17mr37754883lfq.125.1594235132296;
 Wed, 08 Jul 2020 12:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <a98e9c26-5405-3894-6197-3f5e388a5698@infradead.org>
 <CAHk-=whkuOeHvA_ws=usQt=rYq_M2vh448mDxY7kYhUmp_Lomw@mail.gmail.com> <1ac6b3ba-ad54-a227-94d3-06cdf4fa4c91@infradead.org>
In-Reply-To: <1ac6b3ba-ad54-a227-94d3-06cdf4fa4c91@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Jul 2020 12:05:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1W=g_oUUfN6aqbWhsicuFLikHZ4B8UkT1RfEa351J_A@mail.gmail.com>
Message-ID: <CAHk-=wg1W=g_oUUfN6aqbWhsicuFLikHZ4B8UkT1RfEa351J_A@mail.gmail.com>
Subject: Re: [PATCH] Documentation: update for gcc 4.9 requirement
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 12:04 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Should I resend it?

Nah. I'm just wondering if I should apply it directly or let it go through Jon.

                   Linus
