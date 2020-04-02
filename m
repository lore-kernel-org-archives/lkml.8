Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA3EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEDD206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VWkIwk/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389933AbgDBRAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:00:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35806 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387700AbgDBRA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:00:29 -0400
Received: by mail-io1-f65.google.com with SMTP id o3so4427311ioh.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yAXnATgltKUt8JMPeZQ2QoLKhjD+I0oS+JV71CRscYo=;
        b=VWkIwk/U438PU8PFC5RLXzJh+UiWU35S9JxG0hJvmhEm2bVrSQ5PeaOcvJekQUU9RR
         v9KO+X9c1YK2DPHsRPRQPNs+zLx6pEv+Nba5jUV/kpaKd4nYkJe4YmJnAU8FkoZyolD7
         RDh+IXARR7NRquZpMHtBg31E/8HjPHu/pifwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yAXnATgltKUt8JMPeZQ2QoLKhjD+I0oS+JV71CRscYo=;
        b=cBHmqf72w3XAMzZXA1Ez53zdDfaH2CqkbeFiN5CD9KoRE9HLUPphu9J95o8XSSBCyZ
         AW3U15GhcKTGDdqkTRStTZCd125g5mS/IVMZY4Iy5Y7Okc115jIq8DexN32MSRsa8c4h
         Ar6sAiPDHiw1AxqiHFTwu7PMHEq6Sl2SjtuASLo2LxNUSX0GrNRsW9wp6OxlvNjf/n17
         oldPfCX+1KIjXCPPF2oIu1MMdSQmix77fjSQ0c5kBKTZ3/8rLBBfWLDc7fq2wCcqGewY
         r5C8TesJqEzSZaqMIv32ZlBzuM9i/kmUjFs99fiWLJQuAUXxDRBsg6gMh9RzKXZHar7L
         voqA==
X-Gm-Message-State: AGi0PuYqspq+E0UlqVtjBA6fx+fVc8eMH/OeeAPmx+u4fvXp9NQeyCS9
        jpPRzOk8rF89miAMcFVyOWZ5WD3cj+s=
X-Google-Smtp-Source: APiQypIz7b/oSIUrwaoLClHm8OdvDNvKemMx6ISIohK4hi5qr2+d8eLWebwwTK1rPoeLdk3k9WcZdQ==
X-Received: by 2002:a6b:e81a:: with SMTP id f26mr3746040ioh.20.1585846827953;
        Thu, 02 Apr 2020 10:00:27 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id 8sm1641847ion.33.2020.04.02.10.00.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 10:00:25 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id r5so4327790ilq.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:00:24 -0700 (PDT)
X-Received: by 2002:a92:35db:: with SMTP id c88mr4163161ilf.187.1585846823937;
 Thu, 02 Apr 2020 10:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <1585660782-23416-1-git-send-email-mkshah@codeaurora.org> <1585660782-23416-5-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1585660782-23416-5-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 2 Apr 2020 10:00:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X1t5bxgDqg5uPz4NrxfFMSCrGVwMgtnE5snDu330s78Q@mail.gmail.com>
Message-ID: <CAD=FV=X1t5bxgDqg5uPz4NrxfFMSCrGVwMgtnE5snDu330s78Q@mail.gmail.com>
Subject: Re: [PATCH v15 4/7] soc: qcom: rpmh-rsc: Save base address of drv
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

On Tue, Mar 31, 2020 at 6:20 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Add changes to save drv's base address for rsc. This is
> used to read drv's configuration such as solver mode is
> supported or to write into drv's registers.
>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh-internal.h |  2 ++
>  drivers/soc/qcom/rpmh-rsc.c      | 11 +++++------
>  2 files changed, 7 insertions(+), 6 deletions(-)

I still see no usage of "drv->base" outside of the probe function even
after applying your whole patch series.  That implies that it can just
stay as a local variable.

If you have a later patch series that needs "drv->base" in some other
RPMH function then this patch should be moved to the front of that
series.  Until then it feels like it should be dropped.


-Doug
