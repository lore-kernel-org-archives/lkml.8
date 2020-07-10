Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191D1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E090E2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="sGGNolFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgGJTKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgGJTKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:10:51 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5440FC08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:10:51 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t4so5646247oij.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rz/02I+ZskpSCMTSI0IcvBf3VlpD9Jd130lPfA38WiI=;
        b=sGGNolFeaesQIbKnHTeWVUXUk0pE0EIShd3U98UpPPudUck9xZUw6iesxMBvhPuLzG
         A5abXs5mkn3Kmz1pI3s+M9PhkBgETvo22u2JuapWfC4pnPaXQMpNWcWton1MSdjfFog1
         PK44HgeOe6oUhRUFoIEdeZDWVRzbSoSbVdKn1XMgOX/XeVJ6NS7lm5+BA15Y8LXN4YYu
         OgZEruf3By3uZ0mx9dlmG4dNUSrgbPExksEmumVD/so2gUfryVM0wQOkA8bkfNvxZzcm
         BnMSt7wYH4Py8vcg/8i9zp4UGhs1NRU/hSsRQ2PK8N/0X+n6xdcB3DBqv4Bo/avjWT/j
         CjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rz/02I+ZskpSCMTSI0IcvBf3VlpD9Jd130lPfA38WiI=;
        b=j4+4EX2YExbCqu5tKcg/MqxzO40UW5J8kJZbqrzkcBvdJCeaMJOLU9OOIxhJ0+YNG/
         PgXd8iO5VGkG2x869b85TjNqsErrUmRY/WF67pCZ8sU0d7BAL7N7Xtn4rKL+P95jENaz
         RzsuwsamnPr4fNd83dQtaKWrvOA7RpcHBZCquwviapkCEaEdYq0I2sUjIok6i3Uq0YdC
         2PC6MM9q6yv3fUIvmpnHV1E/XQmYT6u5V5FqsPUvXB1/WaAZxQbvO4lBrNNLEAPNeXV+
         DPo8QbaUI0LyrSrLXTaDh3yQcCsJVa9RFa9X/YI+utIEsG9J77Xe10q99p0QUAQxi2JW
         shQg==
X-Gm-Message-State: AOAM532cSvf/++bL3/iDARhTW11pYe0ie0vod5pX4yNg3hUTzSlui1YB
        ArmcNQbw1v+fz7EysXiK8HLH8g==
X-Google-Smtp-Source: ABdhPJyxK9fK/cSfgwjezpCoT9KuqQhSySRFPg3ISip4/u5XnxCkuDoFTx3smoQ2rqj13mRjZl/TFw==
X-Received: by 2002:aca:ecc7:: with SMTP id k190mr5152013oih.92.1594408250568;
        Fri, 10 Jul 2020 12:10:50 -0700 (PDT)
Received: from cisco ([2601:282:902:b340:dd70:9e19:5b5e:7f32])
        by smtp.gmail.com with ESMTPSA id f16sm1238255otp.47.2020.07.10.12.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:10:49 -0700 (PDT)
Date:   Fri, 10 Jul 2020 13:10:48 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next/seccomp 2/2] selftests/seccomp: Set NNP for
 TSYNC ESRCH flag test
Message-ID: <20200710191048.GB2700617@cisco>
References: <20200710185156.2437687-1-keescook@chromium.org>
 <20200710185156.2437687-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710185156.2437687-3-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 11:51:56AM -0700, Kees Cook wrote:
> The TSYNC ESRCH flag test will fail for regular users because NNP was
> not set yet. Add NNP setting.
> 
> Fixes: 51891498f2da ("seccomp: allow TSYNC and USER_NOTIF together")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Tycho Andersen <tycho@tycho.ws>
