Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09020C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AAD2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="d/KZFCei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgBDGs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 01:48:58 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:38796 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgBDGs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 01:48:57 -0500
Received: by mail-wr1-f49.google.com with SMTP id y17so21495173wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 22:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kAXZNxonL2vo5mn3WOyL1SDgpcuL3/WC4tHGYNoQMV0=;
        b=d/KZFCeiCZdQPtcj9G8N5DVQ6kXgN+7JFlSSrVqBG8c0ai7XBHuo0B+nct/SD1nOKh
         2Kc1/Ic+G4gU5vMnLTlIH0/+tzHpvX010nsjyRsdcEqKL9PhV3WG3SFpsbenbZE6xicX
         v2xycH5QjxAwCZWNXFotHkEwXG6vJu5DX1jLaAlUZJYWvSfKr5CebIpZtqmaZ7rsWMbv
         Pt59JTbjWkArYaVaSewCuXco7cCvxzuBkrFC++9BfrEcjA37u/0YflEWPQ+zUj6VSSfc
         f3XPQeCF8kpkCgtbG4/eZim91TD9n/YaCp9neacuAZ+xDqNzD+xhXtkY6Ba3/+tuSvCI
         i+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kAXZNxonL2vo5mn3WOyL1SDgpcuL3/WC4tHGYNoQMV0=;
        b=WUHkgNO7PBv42dpJUbspaxVCrqYVe7e+NCndyn19rtn0+lAQJpQsn4IQjecajEC9mS
         zKOiDkR0Y6Ml7PzQiOSLbD5j9rqbe43nz+sU+qCqn0hjEIHQSCcMfRTTxnFqU01hNmTu
         pNK03wjDR1396fBJLMgGmp3kURFcRzUtBKSgjSzSWqZdUB5hkoqIVuHnQx/1qPn2DlN7
         RUsPo5xscvXqQLFuAyQ6GSnyepvVxaridKZyMprCfuU9AlRDmlxd4FHwrI8AULKFK5Yg
         V/Nmeks6H8WnjatSJ1Z7jAoPqQbUYKayvV2sumuOTI/oDZaT3RTJKSGHPAO1Tl8FMkrR
         TPHQ==
X-Gm-Message-State: APjAAAWLYFpEkc8KJ0gm2F2kBFMen6D11keKFtYB8ApCBzeFtUyUH9Bq
        7idjOuRETkwkktmg5P9M94HVLQ==
X-Google-Smtp-Source: APXvYqwb4NZNOIRGxyQyRRUFv7hAT3ekkC210egylcZ1zTFHFkGBAIAZn9gcflFR/QlaoXSYuU1CSg==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr21307843wrv.358.1580798935241;
        Mon, 03 Feb 2020 22:48:55 -0800 (PST)
Received: from localhost (ip-89-177-6-126.net.upcbroadband.cz. [89.177.6.126])
        by smtp.gmail.com with ESMTPSA id b21sm2477376wmd.37.2020.02.03.22.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 22:48:54 -0800 (PST)
Date:   Tue, 4 Feb 2020 07:48:54 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: RFC: Use of devlink/health report for non-Ethernet devices
Message-ID: <20200204064854.GK2260@nanopsycho>
References: <f8e67e40-71d4-f03c-6bc0-6496663af895@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8e67e40-71d4-f03c-6bc0-6496663af895@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Feb 04, 2020 at 12:01:37AM CET, ray.jui@broadcom.com wrote:
>Hi Jiri/Eran/David,
>
>I've been investigating the health report feature of devlink, and have a
>couple related questions as follows:
>
>1. Based on my investigation, it seems that devlink health report mechanism
>provides the hook for a device driver to report errors, dump debug
>information, trigger object dump, initiate self-recovery, and etc. The
>current users of health report are all Ethernet based drivers. However, it
>does not seem the health report framework prohibits the use from any
>non-Ethernet based device drivers. Is my understanding correct?

The whole devlink framework is designed to be independent on
ethernet/networking.


>
>2. Following my first question, in this case, do you think it makes any sense
>to use devlink health report as a generic error reporting and recovery
>mechanism, for other devices, e.g., NVMe and Virt I/O?

Sure.


>
>3. In the Ethernet device driver based use case, if one has a "smart NIC"
>type of platform, i.e., running Linux on the embedded processor of the NIC,
>it seems to make a lot of sense to also use devlink health report to deal
>with other non-Ethernet specific errors, originated from the embedded Linux
>(or any other OSes). The front-end driver that registers various health
>reporters will still be an Ethernet based device driver, running on the host
>server system. Does this make sense to you?

Should not be ethetnet based driver. You should create the devlink
instance in a driver for the particular device you want to report
the health for.


>
>Thanks in advance for your feedback!
>
>Thanks,
>
>Ray
>
>
