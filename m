Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D110C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC8C2253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YYLLczpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgAWWzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:55:19 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36262 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgAWWzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 17:55:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so228975ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 14:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RvfS7+Fsc/eieI6rBQof74MincBvvBD6LwXZdidYyBU=;
        b=YYLLczpgQOlnXOLDv9csihbQn/ZgD2WlgEYBHaHRdjKx5jpKdyDfOIAnJF3cacZIZ4
         XbTvtmZ6TFJInnwglMMY1JvFSvkXTeZVaWWfa6k5uqO5AL+KoYg6m2clDBwRj0W37QMh
         2FRuAAV4AkTDaT1s4pP0s85aSMcd3qlTQpQsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RvfS7+Fsc/eieI6rBQof74MincBvvBD6LwXZdidYyBU=;
        b=iup8l+4+w4WGtxdz0wiitF1BInXVFkAuqRk2yNfZUuf4iUX7R3LP9F79A/w79fCwAt
         EpC65J90v8LPqrf8kzPQ4297fw1eNRMn9YHAaXL55oJVDaSWvnABoRgaPLGtUimYP5fn
         AyEJSnSu8mDL0Dxk/BFN49E9JPOjSZp8PB69jTrKmHlqrW4SokKRf77exo6crEllWDS+
         CDq8hvHUroXAs2UFkaebyPHgUhxbq/FIm+dC6NwexMN/eC0cRNvayCDPKS3e6muiJ9qu
         o6dfm5CUM8UlGp/q7Ycivze+wIroAEzoA99ox+DM6i8diN75rVMFVIiNRVlnK6A1ZYBX
         BV0w==
X-Gm-Message-State: APjAAAX/mm+C3qhNrGHvrUBd2HXxJR5ptP5eTgsk3seeJkRMk5BTjTw6
        V6oZagI+bTjnOo1nNJeNKut1ecmipFQ=
X-Google-Smtp-Source: APXvYqzLd0WlA8ea+ArA3owz+zNkybwvQq4yDuOdUKHup74QmzjL2rtNUiJz41qMdboyq8flapynSw==
X-Received: by 2002:a2e:8758:: with SMTP id q24mr400017ljj.157.1579820116876;
        Thu, 23 Jan 2020 14:55:16 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id h14sm1831566lfc.2.2020.01.23.14.55.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 14:55:16 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id b15so3593416lfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 14:55:15 -0800 (PST)
X-Received: by 2002:a19:c205:: with SMTP id l5mr31538lfc.159.1579820115268;
 Thu, 23 Jan 2020 14:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20200123131236.1078-1-sibis@codeaurora.org> <20200123131236.1078-3-sibis@codeaurora.org>
In-Reply-To: <20200123131236.1078-3-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 23 Jan 2020 14:54:39 -0800
X-Gmail-Original-Message-ID: <CAE=gft7H6-jAfPAqeU74D1VPS81vLPgQ6w+JO09C4w1bzwYduw@mail.gmail.com>
Message-ID: <CAE=gft7H6-jAfPAqeU74D1VPS81vLPgQ6w+JO09C4w1bzwYduw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] remoteproc: qcom: q6v5-mss: Improve readability of reset_assert
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ohad Ben Cohen <ohad@wizery.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 5:13 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Define AXI_GATING_VALID_OVERRIDE and fixup comments to improve readability
> of Q6 modem reset sequence on SC7180 SoCs.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Very nice, thank you!

Reviewed-by: Evan Green <evgreen@chromium.org>
