Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B62DC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE83B2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mniQknkm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgH0Bvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 21:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgH0Bvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:51:48 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A863C06134F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:51:48 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x143so2239604pfc.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9swG66qCWtjd/cAQzBWYeWwUWndI+SaVUBb1QqNeqWc=;
        b=mniQknkm/yzJo0JXwxc2uTfNGFN7ICDsheIu5LZAWGh8WAsMAAYTLgF1WaNrryJTJs
         o2VBNpdwMIa7Zj8CzN3sOfjIdISa5G5W//OrWpb39SXqwW3Qdvp8fll5fxtPQM7wJT/v
         sseE0SsLTvcd8O7dBT2GIMC8XM2BKAaDp9ILo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9swG66qCWtjd/cAQzBWYeWwUWndI+SaVUBb1QqNeqWc=;
        b=t5eBkRC18qa0BvSL9CSwgEto/UZKUt1wZjmyDzsetsWfk+svhnbz21O1DMaz0ftMgA
         YTH7vxrwBHPyhzcPYdnZTkzs0I5nTt/fOcy9YpP4qKVx4fZtF6XxYY/n4wdqOX3eRHCx
         z8x1U/71UOt39t9Gey4iq2AiLlhaLIfF+pHPD/ngT0yQFn0zv9FQ8rd57RyuHuCF4q94
         a/2PhKK8YQbvaVN0r6asv38yjtp4A6xyLEV55i3fMSUl2W/TrJ5bdZOUQxieQP2d0bnl
         qa3yTKr7S3iKnuXJGdeW03ClCUf5Yxjn/T7z+Vxy3yfd+F/0B50mQ7t3cYK6UvM8NgQ1
         oDsQ==
X-Gm-Message-State: AOAM531MEd/T9wTpJUSl+CxLWc9uvwSx9LCM/V1hfIx/tf869S1B86mQ
        TZFC9m1dlFaZpHL91ZV12zgkcg==
X-Google-Smtp-Source: ABdhPJz/O2B9PnI5PMvHOTbTvsE8RPqNZYxPJBMYmMkzw352ixW1jRwfvARKXhh0cr5G1nPDTZqF9A==
X-Received: by 2002:a62:2ac1:: with SMTP id q184mr14265959pfq.160.1598493108203;
        Wed, 26 Aug 2020 18:51:48 -0700 (PDT)
Received: from localhost ([100.99.132.24])
        by smtp.gmail.com with ESMTPSA id e18sm288283pgr.53.2020.08.26.18.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 18:51:47 -0700 (PDT)
From:   Sean O'Brien <seobrien@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Wei-Ning Huang <wnhuang@google.com>,
        Sean O'Brien <seobrien@chromium.org>
Subject: Re: [PATCH v2] HID: google: add google vivaldi HID driver
Date:   Wed, 26 Aug 2020 18:51:43 -0700
Message-Id: <20200827015143.57364-1-seobrien@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <nycvar.YFH.7.76.2008261311550.27422@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2008261311550.27422@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I actually believe we should follow the standard convention here, and have
> just one hid-<vendor> driver for all google products. Currently we have
> hid-google-hammer, and this would add hid-google-vivaldi. Would you (or
> Wei-Ning, CCing here) object on merging these two together?

I'm a bit reluctant to merge them.  Partly because I'm not familiar with
the hid-google-hammer driver, but mostly because this driver is intended
to handle non-google products which will use a google-defined usage code.
Perhaps I should drop "google" from the driver name?

Thanks,
Sean O'Brien
