Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43079C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F13720809
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WioTLJ76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgG0WsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:48:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42542 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726193AbgG0WsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 18:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595890085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g7DpUnhWTHsvoUdwqfxUUOMTIlMH+umWpPN0dIrg5X8=;
        b=WioTLJ76xxvXSfFEqqrUBWMP6hKk3GrSOf3Ci5JNLl9F819MFtpdvcsUrO98wI3aIxuKGU
        7UAbV3nCS+dCIjVL9Q/kUYiC4YCqTBkWrsHG0qB/5jRtTnU59ptE+Sej5Ampu+nG5ZcuxC
        JXUyxxZDqkd8vFPxmJifWxIG3IGRO9Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-ygaste2EPEOpCIUy8FQQSQ-1; Mon, 27 Jul 2020 18:48:01 -0400
X-MC-Unique: ygaste2EPEOpCIUy8FQQSQ-1
Received: by mail-qt1-f198.google.com with SMTP id 15so12501600qtp.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 15:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=g7DpUnhWTHsvoUdwqfxUUOMTIlMH+umWpPN0dIrg5X8=;
        b=lACs9mDHmEk4jlwCWA/xkL2aJAS30MoVP1UWwVTyYGd/0xOSjYedfFP94aF5oENebm
         E6uBxcEbagRovTIPdV5KYM4zfUtQqGb2fQfBcjU+i/vOx+igFyXehTK9vMNxbT4yUKsP
         3DvR4gxovbB1Aiahmh47CoYhHT886Om3F46twahMQOo9zUc/kOgXN/D5vI2njef5AN2J
         EiBP4uP/TJr6sODjTsvACOQJezwhU8q3thJ+9MXPTItyMwMgRNL0KCbhhvxi5ydK8oHW
         n+o3MT3tnCum9Sw1LLbUNXYofeR/fA9cJnThWmbqAXJbSeLHkbJJlYaFzCLPBVHwLBOE
         lSgA==
X-Gm-Message-State: AOAM5306O6Gy15Kb42txs6ku9ZzG9gnThuszlglSBSo9qiBc/JJ4wf1o
        sDstYhN3gdTkNkTm6pPxsztXEuH9A9AgAoLnO5v34i9caj3e79nd/we78wy1P8t3dRPB+h8KZpG
        tXPzEFperIafyVDB4kXDisqwG
X-Received: by 2002:a05:620a:13c4:: with SMTP id g4mr25562809qkl.142.1595890080849;
        Mon, 27 Jul 2020 15:48:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuYLocdQhO8B6g9jpDn6ppAm+zAIH12jWbEP9PdLioydEy0bF3tsSzbG4Iq7w9Rb/5kQHCNg==
X-Received: by 2002:a05:620a:13c4:: with SMTP id g4mr25562791qkl.142.1595890080542;
        Mon, 27 Jul 2020 15:48:00 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id n85sm5167162qkn.80.2020.07.27.15.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 15:47:59 -0700 (PDT)
References: <20200630200636.48600-1-jsnitsel@redhat.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 0/2] iommu: Move AMD and Intel Kconfig + Makefile bits into their directories
In-reply-to: <20200630200636.48600-1-jsnitsel@redhat.com>
Date:   Mon, 27 Jul 2020 15:47:58 -0700
Message-ID: <87d04gshgh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jerry Snitselaar @ 2020-06-30 13:06 MST:

> This patchset imeplements the suggestion from Linus to move the
> Kconfig and Makefile bits for AMD and Intel into their respective
> directories.
>
> v2: Rebase against v5.8-rc3. Dropped ---help--- changes from Kconfig as that was
>     dealt with in systemwide cleanup.
>
> Jerry Snitselaar (2):
>       iommu/vt-d: Move Kconfig and Makefile bits down into intel directory
>       iommu/amd: Move Kconfig and Makefile bits down into amd directory
>
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

Hi Joerg,

Looks like I forgot to cc you on this cover letter for v2.
Does this work for you now?

Regards,
Jerry

