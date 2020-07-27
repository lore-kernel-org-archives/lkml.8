Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E394C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F2A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RxslYgCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgG0MVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgG0MVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:21:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3041BC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:21:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so14664409wrl.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pq1ET4NeB9RomAbsurjDGpllwmR8q23My4GbeazFctg=;
        b=RxslYgCzUp24ps37t5tlcbtukh5HBY2gz6DM/5CtdbQfE851RX+lF3b6YXu4hkEPSw
         LiHLUuA/LfwQPz9HAg9qK8uvB9tWnsNKFRwBRfRFPOWTRAaBfjb86rv3clMhe926LEwE
         vDiVz+Wxxu2W9w2EZ+Ehr6i/bw6yc+/p4RBerJ2CVWS99+THB4CLkHAvpoQib7O6UnHl
         UYzW3txmIOY9gMveuWLO/I0+6a5HOTgt3qI5cV50CN+sr/RCkbpwbv9KWJPy1u5sbGVq
         Fax8XWSNjxaYLM+yx91mlELxzpopp4kNnwqUFR+LLXULM5fDBzbQc4Rc/aMhoTuDLe1b
         QbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pq1ET4NeB9RomAbsurjDGpllwmR8q23My4GbeazFctg=;
        b=V4Cty4I1H7nt7F0Q6R0yHZF1JZJySQdqOuqKUI7MbmtiTvnF+PUbBaCyQekAaSl9rm
         iHWFCh1nLB7LXxiIRxaMALumCsoRy+DWYkBL3XtNvcgUnr3k/+WfYa1A205hwZfDBojt
         N5S9qPIROaI/yYqBfJdvjcYPnOU+6rDH16UJoq1/NMpk77Yx8jhDXqEBtei+LJmFGw9s
         btnzYx9o7U1JlYNUm4g3KXGEb9AoBxImY7nVIP5OjerRDtO+qbVHY4+0nsb0xIhvj3NS
         kDsLKFwxz5yQjPqKI4Sn7ECXr+NOE3UroG4dREiSyTw7UG+Z4YgGvyFPm2wSKanxZo/y
         9owg==
X-Gm-Message-State: AOAM530W+1CYFVH9E6ttWQHAwOmtCwMBv51g6sQSrHopv0NYmLHa6/u9
        62UMMmF/f8vKyK2D2ZIF3f7Mow==
X-Google-Smtp-Source: ABdhPJyUbsfFbNt5s9bDOFEt/5mlBl8zmfH9uJA2kUAGXFJxr+iNBvBeHJmG26RIXYLYOgE7QsGFfQ==
X-Received: by 2002:a5d:4bc8:: with SMTP id l8mr19740256wrt.159.1595852501921;
        Mon, 27 Jul 2020 05:21:41 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id c24sm12625308wrb.11.2020.07.27.05.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 05:21:41 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:21:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 6/9] mfd: mt6360: Rename mt6360_pmu by mt6360
Message-ID: <20200727122139.GM1850026@dell>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594983811-25908-7-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594983811-25908-7-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Rename mt6360_pmu by mt6360, because of including
> not only PMU part, but also entire MT6360 IC
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/mt6360-core.c | 41 ++++++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
