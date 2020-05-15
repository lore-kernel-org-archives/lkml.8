Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CA7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 00:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4B520709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 00:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cPk6Aai/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgEOAcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 20:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728427AbgEOAcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 20:32:06 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2F0C05BD09
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 17:32:06 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r22so150019pga.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 17:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ksohmisiygmMHSWmZNuyiGcxOl23DTxWznhnrAA0Tbc=;
        b=cPk6Aai/Cgvqt0Hw0nAvV2PJi+S+U0lQ3s+kR1zT8quJNLuBg2FCokbhC2GzfDSzJJ
         F5bmAzSUpSBwRoZ1Ym+YE2Zs64UYZ9YUoW+PRgtrsZynF/QJDpka4gEPcaI0pKdfmbQA
         B4Z8rYbMian4pw77PaNRSd1O+Vcxwo0afwBs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ksohmisiygmMHSWmZNuyiGcxOl23DTxWznhnrAA0Tbc=;
        b=J7Nz079BmL8B2K+ZM2DEQZZldVnHFSVrnpkjQA1GqS66wZIfnXL1QIfdMNYKUWhWDe
         yeXh4mGZuw6XhtRIwtY7DdAReMUs05ZwKOxADMaGUHOm1MeZTgSXSsMls/hJnCbv01uQ
         H0ysyyi5Sdg/A/jxbx8kF9X6Gpon4krGGJDwBK7XZnTiAb5gh4Vuf+JDZMGtzRqmtEDJ
         h96P6k/5Gx0JHRdkLjSFPFXESniSDb1ETSY797kB2RQ/tY2HE6+T+bNsxbEwdw2k0baE
         5NTkFbEARa5d7eyJE+kl3kD/tVFZNjD29xinFdrElFVE39FfnuV28Ps4LicyP1TO5cur
         O+Pg==
X-Gm-Message-State: AOAM531V7TjRTRMrP6rpCz8hEPVC5R94fGSz74L+StCDRZDQxVscUlkS
        lcCeIi8MWdindIhNyBgrKJ2L8g==
X-Google-Smtp-Source: ABdhPJxP4fdAV/QiAEsyatfE+OPdd5pusF9BcQ3lUqxkmtep+uuG0U2tNiNsF7/PknZVYJq9lJXrlA==
X-Received: by 2002:a62:8888:: with SMTP id l130mr1187943pfd.140.1589502725382;
        Thu, 14 May 2020 17:32:05 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id z1sm163461pjn.43.2020.05.14.17.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 17:32:04 -0700 (PDT)
Date:   Thu, 14 May 2020 17:32:02 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sharat Masetty <smasetty@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcrouse@codeaurora.org,
        georgi.djakov@linaro.org, Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH 3/6] OPP: Add and export helper to set bandwidth
Message-ID: <20200515003202.GU4525@google.com>
References: <1589453659-27581-1-git-send-email-smasetty@codeaurora.org>
 <1589453659-27581-4-git-send-email-smasetty@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1589453659-27581-4-git-send-email-smasetty@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 04:24:16PM +0530, Sharat Masetty wrote:
> From: Sibi Sankar <sibis@codeaurora.org>
> 
> Add and export 'dev_pm_opp_set_bw' to set the bandwidth
> levels associated with an OPP for a given frequency.

Wait, this looks very much like Sibi's patch from v4 of the "DDR/L3
Scaling support on SDM845 and SC7180 SoCs" series
(https://patchwork.kernel.org/patch/11527571/). Please don't repost
patches from other series (unless the series/patch was clearly
abandonded, which isn't the case here). Instead mention the patch
as a dependency.
