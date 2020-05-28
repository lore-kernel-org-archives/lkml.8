Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C30EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 779142073B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T7eZHHor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407322AbgE1Ugq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407237AbgE1Ugh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:36:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2947DC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:36:37 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bg4so47650plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vRratM29kdQLg6OaUHiYE8TMO8cnRbvNntJYzvfFXSk=;
        b=T7eZHHorrBd8JFM+hOZZRuALMG/zzJsIFsg+LxOKQwBMyAHrC262d4inPtrnaJt+va
         yLEq0Qez19ig8V3/ALoOaNLZPEJbfrEWnUbvJDIATCHuvynuk0yuEpDMOIKeHMPTYzuD
         yIYJU60JDMPHw6GSHpcbJISLoidt1oq371dSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vRratM29kdQLg6OaUHiYE8TMO8cnRbvNntJYzvfFXSk=;
        b=TbfQsdnSnA6e/a/jp7901XXwJ+VocAByjiCC/DrbIHml2YcEHlHi1ZIAwVrMd7E7iQ
         9hs3OLBEjYh63q+2fDXZmhjqq6wuAx8g/A4pxy/XamTsGLmQRg+h615hMFM+6vJ2j+Kv
         nWieN8WH7Caw7BwRynX5VFh9P/bXkaQNgIx7LK9Hy7tJKm6yu7BnBAay4KrBbwPRGQSU
         Kbxumtqd7LNLfyQshApV8QPf87HgR+4EOroqF0ZVmd/cIzCYzOzxLMH6lAih9ugC3fia
         70LH8j3xMO9m+c7w2hFIqFl76E5FH3ezZ9UEnest/83RfHwdHFtGzrVuLcq4XrO6fZs9
         MmyQ==
X-Gm-Message-State: AOAM531zXVqhv/q8gdwhyGWLnWy3juAPs/CPx9686DEb+RGTxQmx94P3
        wzVz7f5g2e59h/AmzFsRUV2yvg==
X-Google-Smtp-Source: ABdhPJz0vzCp28UVxFHgxO6i1oU9ENre+0ToKo3mus4i/ki7fmTgbriZthiFUhxD0Bpkb4yypDwBjA==
X-Received: by 2002:a17:90a:1b41:: with SMTP id q59mr5462545pjq.218.1590698196726;
        Thu, 28 May 2020 13:36:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id w26sm5411392pfj.20.2020.05.28.13.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 13:36:36 -0700 (PDT)
Date:   Thu, 28 May 2020 13:36:34 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org
Subject: Re: [PATCH v3] Bluetooth: hci_qca: Improve controller ID info log
 level
Message-ID: <20200528203634.GL4525@google.com>
References: <1590663797-16531-1-git-send-email-zijuhu@codeaurora.org>
 <20200528151700.GI4525@google.com>
 <f336a66a-d392-c995-e28d-34c9cc465371@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f336a66a-d392-c995-e28d-34c9cc465371@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 03:42:54AM +0800, Zijun Hu wrote:
> 
> 
> On 5/28/2020 11:17 PM, Matthias Kaehlcke wrote:
> > On Thu, May 28, 2020 at 07:03:17PM +0800, Zijun Hu wrote:
> >> Controller ID info got by VSC EDL_PATCH_GETVER is very
> >> important, so improve its log level from DEBUG to INFO.
> >>
> >> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
> > 
> > Please add the tags from earlier version unless the new patch has
> > substantial changes.
> > 
> actually, this v3 patch is only to correct the code stye issue pointed
> by you. let me resend it.

no need to resend it, it was just a reminder to do it in the futre.
