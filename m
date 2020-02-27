Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30922C3F2C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D6D246A2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R9wmRG8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgB0Vxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:53:34 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41613 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbgB0Vxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:53:34 -0500
Received: by mail-lf1-f68.google.com with SMTP id y17so542208lfe.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 13:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TciHlSTKGVGSwBjPpE6GdszVZvGGFdsKopsqP1eqA44=;
        b=R9wmRG8Zsj0hupJPPywP6/bpn+fXxWpBBjyuLdxnZKe76Pvx+79KpCZfPuJ6m9zgIB
         83dRXWqAbdH8mdUA2m5R6w1L5Jt/Nectudrnnm3VTIY8OxyPthplqvxqfFcG5SmgXxwL
         hEhb8GB0mIoGzRzN/dD6W9G//QmE5GgVN2PmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TciHlSTKGVGSwBjPpE6GdszVZvGGFdsKopsqP1eqA44=;
        b=EgvxlqAf72/dqooKcwZiBv+bQGU3n8+WrVGCpbrkavziYE9I7b/uQPcmrx5e0DNFid
         9f8F+T9G1DyNFnLf4FqaPZyeEtXR4qOamZXwlmQuQYmyMqXZzUS94cWNYeBiGPGMDZcW
         IedXrv6ghVA4jkEk5kIY0IAKlK04l7LKsfbzlv57LqHcFdHRUWxuADAIgUW2dOyXeccS
         Jl6upZvy2BuATIn68MKUjLprqzlY8K5ATR8rN4HpfRxVIb3Dt1CwOkfou4kfe8XX4MTO
         ddBEzIRckJH11XLMkKUxfmf1fUquWkEnzHoQaXR8fSw0tw5tMAZvAv8+CBuBcz1CFbmV
         aVDg==
X-Gm-Message-State: ANhLgQ1wTCVMKGT+e9HJQALgqrD16UNQ5d4FexhuujrZjoZTobmrtKMO
        zjoeUMXbGh9c+0vvY2TmtQd1lT0kmYo=
X-Google-Smtp-Source: ADFU+vtBvOE6h4p1dvMBmSGyU9hV6mOEA3/k3UDJ+rznxOZ4G2lTKZs32+zfx3Ie9P+HBV4+o5J/7g==
X-Received: by 2002:ac2:5388:: with SMTP id g8mr766652lfh.168.1582840411985;
        Thu, 27 Feb 2020 13:53:31 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id z67sm3520531lfa.50.2020.02.27.13.53.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 13:53:31 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id q8so932010ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 13:53:31 -0800 (PST)
X-Received: by 2002:a2e:8702:: with SMTP id m2mr734336lji.278.1582840410701;
 Thu, 27 Feb 2020 13:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20200209183411.17195-1-sibis@codeaurora.org> <20200209183411.17195-7-sibis@codeaurora.org>
In-Reply-To: <20200209183411.17195-7-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 27 Feb 2020 13:52:54 -0800
X-Gmail-Original-Message-ID: <CAE=gft5YrX9idSOgam5JR3m_R8OZ0ZG6KKe-w6GmtmxY83OPnQ@mail.gmail.com>
Message-ID: <CAE=gft5YrX9idSOgam5JR3m_R8OZ0ZG6KKe-w6GmtmxY83OPnQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] arm64: dts: sdm845: Redefine interconnect provider
 DT nodes
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Dai <daidavid1@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 9, 2020 at 10:35 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> From: David Dai <daidavid1@codeaurora.org>
>
> Add the DT nodes for each of the Network-On-Chip interconnect
> buses found on SDM845 based platform and redefine the rsc_hlos
> child node as a bcm-voter device to better represent the hardware.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
