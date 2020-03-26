Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1388C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987642073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LtzmbQSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgCZSbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 14:31:23 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35832 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbgCZSbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:31:23 -0400
Received: by mail-vs1-f68.google.com with SMTP id u11so4577579vsg.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pFD2geY/p5iC2VmMRUkKBQnxSUg98rzcJbPJ8Ag8rBY=;
        b=LtzmbQSWi7E8xrMVFZUuf3+ZY3zKzZyjFkbR5rMsSufZB1jjjmP7JnP/DRAB6g/GCa
         3au0hWHYh202QGgie7YzjX4sl1PiqzVViyQljvphZEmGuRU85N38r3uy6rlkcIsPHIZw
         BPSL+KenIgtH7flGoOkYGdbW0ieQ9fpPcYktY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pFD2geY/p5iC2VmMRUkKBQnxSUg98rzcJbPJ8Ag8rBY=;
        b=IuNxY7AWra2LE368PuYO6lx61NRxzEVlhYoqNezgEuuDwcqIna++vG/hknFhDu0Xh2
         1HcIzDOGW6UQ2HI7ny5xBfB4KnEaeV5GmvtstTEh7RrPpG8sP76lwyAtdz5LFCbIxope
         nLjMd99FJ2t6SKLxm7+TBdawSExZwiXZzhz2nNIUxByHScNM5TWMompzKTOuu25nsyt4
         KjyJE6vIE6HBctKxjB+RnWefl6dtYoynSpDt7dWiowAaTJZZsx7y/O2SmS2TNcdZ26sH
         Q2oODFbNn/NYBFg1u+ihWvJWfmc9KrB98rCE6nuR1BwZWuQP85JVit3Nw2JjfTA5yNFw
         1hXQ==
X-Gm-Message-State: ANhLgQ1oNR8o+XUNEZ1KD4/PNHUq59+F5TF4uVMIHKHGpxbwj3/r3Qc5
        OzIoVmmtQggE/DsJ438Hye6inA3Yj9k=
X-Google-Smtp-Source: ADFU+vvtX0XEQ74gfoHyJxmuYQSZpgBCrQJ5nTxXfcoKg3MQaQ5Oonzflt9llK+3zieiU6/Cp/E5BA==
X-Received: by 2002:a67:907:: with SMTP id 7mr8006294vsj.42.1585247482129;
        Thu, 26 Mar 2020 11:31:22 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id z79sm1346700vkd.35.2020.03.26.11.31.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 11:31:21 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id y138so4564324vsy.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 11:31:21 -0700 (PDT)
X-Received: by 2002:a67:694f:: with SMTP id e76mr7497123vsc.73.1585247480800;
 Thu, 26 Mar 2020 11:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <1585244270-637-1-git-send-email-mkshah@codeaurora.org> <1585244270-637-4-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1585244270-637-4-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 26 Mar 2020 11:31:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xwhz=N5dd5u2pYxKXyv5_PKhSZ5xZdvo+YXdk8THz_Wg@mail.gmail.com>
Message-ID: <CAD=FV=Xwhz=N5dd5u2pYxKXyv5_PKhSZ5xZdvo+YXdk8THz_Wg@mail.gmail.com>
Subject: Re: [PATCH v14 3/6] soc: qcom: rpmh: Invalidate SLEEP and WAKE TCSes
 before flushing new data
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 26, 2020 at 10:38 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
>  /**
> - * rpmh_invalidate: Invalidate all sleep and active sets
> - * sets.
> + * rpmh_invalidate: Invalidate sleep and active sets in batch_cache

s/and active/and wake/

...with that, feel free to add my Reviewed-by tag.

-Doug
