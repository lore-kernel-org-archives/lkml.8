Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2A0C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49AF215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581473118;
	bh=FFaMZEc4E/x/xophYACoLJfYNCkVhTJ16jaEkNs90pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pBFdAfK0Doc7ob+IF6CChz/ZebWPZldfD4/qNV0mwhcLD/LLLEDaHGT21NCGHy4Wz
	 lQjCqTop188oWFpedGB25Wd1XEadJeQc30hOyWO/W43dlbiLpXgrtO8qwxQRjLxQSw
	 n/4sbFkMAYCRmAgtEIH9Bc0ppWSTQ45mrkvJRSYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgBLCFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:05:17 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37949 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgBLCFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 21:05:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id z9so368329oth.5;
        Tue, 11 Feb 2020 18:05:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SPSyVH5BY8YlezL4QmTEFwwCly81f3R+OHqr47mHZ/A=;
        b=AJ3ZzcaKflJxvWw+G9eT9krptto+5XpaC+PXtD7NXtgTY012UngjUzw4GgiuKKZPgr
         9nxkbqqL2r4THtCQTNhURgNNY6OC3ztG93Rdf0Ki7ZMpkg08eCcLDAE7Cm1HbmE7aZI8
         NrJ37lgB9v3haFujfB2GWwd6ILzrtSK0+uixF96fLbDtB7oXdsl9FcMKzCYqWRVHM3gp
         m4dfNxVpYgMtaBaPeYGw/SdE6D0B7z7CczsIJiRbVwTDiuSLeSf0TGMhxRiuCCWna0h1
         2ePPyYaTZRwduPn7LTwAm/tGHhJDxgrxGGTO9IRkuEdufd74/bAeMRZG1s2ob13FQ3FB
         yxfw==
X-Gm-Message-State: APjAAAWavVMEzwutAmZDYyl5C/kibbxnAlyICnyXM/Hf0BcWz+tZgm1n
        lsYhXlLMl9ozFF4tQdx4oBetzkk=
X-Google-Smtp-Source: APXvYqwOlhfZZBLT289wJr1MHH4C8G3kp95kP+M607Gu437a4Mn8H6ODIDYqfK5ohNHfNspIQls/CQ==
X-Received: by 2002:a05:6830:4a4:: with SMTP id l4mr7597940otd.91.1581473114770;
        Tue, 11 Feb 2020 18:05:14 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n25sm1711611oic.6.2020.02.11.18.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 18:05:14 -0800 (PST)
Received: (nullmailer pid 26689 invoked by uid 1000);
        Wed, 12 Feb 2020 02:05:13 -0000
Date:   Tue, 11 Feb 2020 20:05:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] dt-bindings: Document JZ47xx VPU auxiliary
 processor
Message-ID: <20200212020513.GA24870@bogus>
References: <20200211142614.13567-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211142614.13567-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 11:26:09AM -0300, Paul Cercueil wrote:
> Inside the Video Processing Unit (VPU) of the recent JZ47xx SoCs from
> Ingenic is a second Xburst MIPS CPU very similar to the main core.
> This document describes the devicetree bindings for this auxiliary
> processor.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: Update TCSM0 address in example
>     v3: Change node name to 'video-decoder'
>     v4: Convert to YAML. I didn't add Rob's Ack on v3 because of that (sorry Rob)
>     v5: - Fix 'reg' not in <addr, len> pairs
>         - Add missing include to devicetree example
> 
>  .../bindings/remoteproc/ingenic,vpu.yaml      | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
