Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91804C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B802088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Du8oCqtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407333AbgE1Um5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407238AbgE1Umy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:42:54 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F507C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:42:54 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a45so996879pje.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zdyzLimXPKb8loA9eaNOpZUzWfyNaM5PR6IwlYxpXo4=;
        b=Du8oCqtJwgbtosFY4o395cLSrMzX/msg37UKQjYvLS6QQ7YLGyN638DSsEQsaeeY2f
         bqbrcEjJlSpY6oGKOTay+04QHpGFV1ORhJ2E99xg625at5WwGQU/jk9eV7vTuwMOTN6p
         1mVDkyGnQ7Q/uF/evtjPW1Vaf4PbR95+GWbNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zdyzLimXPKb8loA9eaNOpZUzWfyNaM5PR6IwlYxpXo4=;
        b=JS2MFKlOhunfMEbbNejEAIeD0AM17C0rZbRPw96RRrOGVc/MRrb61b2SK9flaMjTtc
         r8Z7GbU8oAmqUoRvIiPcwWW26EMd0GwMosTOeIFhKdp7iFYdwoKckDDGP6c7PI2zoWvE
         Zp3El19vWirH6DolyflHKBlMKqXyHZlWWSm5YE/mmuNPxEksR2r7FIvhAH8H7pCECqwI
         nVKLzbmo9La/idGqhmPwxPVJoNPlzMoPlL8M3vnwtk0lInjggUwfI/fv133UiqekJNkl
         g7PYNNTl02ro36ubY/d5kcH+HGvS4iXX5cZJMGZOvOWUu+SHoOHwpmmMyhtsFk3witbQ
         VfWg==
X-Gm-Message-State: AOAM533ieIo0H7vebxHnGJyAImRn1iGzn/zrr3kAmm6c+Rz/8IS4jtb5
        ISZxEb8Snz6UrRZenhnbt6rHOQ==
X-Google-Smtp-Source: ABdhPJyc5Y33yZEJNPHkyz6Y9xrbOnyBsYt39W75M0ByokE/SZClzan4j2p7o8JcmfA/bBrPWvSJPw==
X-Received: by 2002:a17:90a:23e7:: with SMTP id g94mr6003805pje.210.1590698573489;
        Thu, 28 May 2020 13:42:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id m12sm5860434pjf.44.2020.05.28.13.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 13:42:52 -0700 (PDT)
Date:   Thu, 28 May 2020 13:42:51 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org, stable@kernel.org, tientzu@chromium.org
Subject: Re: [PATCH v2] bluetooth: hci_qca: Fix suspend/resume functionality
 failure
Message-ID: <20200528204251.GM4525@google.com>
References: <1590697867-7618-1-git-send-email-zijuhu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1590697867-7618-1-git-send-email-zijuhu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 04:31:07AM +0800, Zijun Hu wrote:
> @dev parameter of qca_suspend()/qca_resume() represents
> serdev_device, but it is mistook for hci_dev and causes
> succedent unexpected memory access.
> 
> Fix by taking @dev as serdev_device.
> 
> Fixes: 41d5b25fed0 ("Bluetooth: hci_qca: add PM support")
> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
