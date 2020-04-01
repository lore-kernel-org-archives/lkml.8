Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE1BC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499F720719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m/yww7rD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733112AbgDAV3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:29:05 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:40625 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732527AbgDAV3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 17:29:05 -0400
Received: by mail-pj1-f54.google.com with SMTP id kx8so618626pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 14:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cTFpqA5tG+WWT9sTreQ1YOunwJV7A8zTcn5uhSzjIZ8=;
        b=m/yww7rDfQ3kktZhAjrnmc6g3M4Vsz4wORWt61gOe6FYkfHbNCzUioxpSDF3MPmBdV
         Wz+TOWpWbgLz2bg1u9mPRpg/hmCCA6zHm4OXJnKbK+jRgPKHnQZcf9KXcaH2m7MmbV/r
         RdUAXoiZP27scBBR04rsv7Id1hAiTQjJ2EeYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cTFpqA5tG+WWT9sTreQ1YOunwJV7A8zTcn5uhSzjIZ8=;
        b=FI7hRMacKDu8TE+SNsy2zt/PPXt7cGGoZY+pDInxl6AioRZDEpKLvMCNvkLJGlvt+a
         zJG3X2z3vGemAdNF9mIOvti2gEevyr3VfNTRPlGPAcsNMzmOMAIIlweGikhaUQPJ5d9b
         ksDTj9hL8lymZKHrq14EwtVzTGTo+o/VWWpB89FjfCu7YQVkQTBC828TamERXZWulslf
         XMfClfUmZNKs04wBuXgmZuUawZoADtWBboQY2k47mBt3cw+g8fHQZYyljgCV8sIzbCUJ
         1BE+IpcQzuzlQzbiLbybDqQQsFM21UyT1K9nou0fH0zWMaO7CYvFuZCEFhHtEBKiZRQj
         vxqw==
X-Gm-Message-State: AGi0PuYJxBR9Rq0BQaTefRyTGxokaDd+6RJTGCVyq3rvb/o6VTX1RV8Y
        D26TjKQr17IdrPLcTFCRctS0dw==
X-Google-Smtp-Source: APiQypLQF/i0d5RT+vCgKNX8CwUXkL5ru4KsrEREbSGlX8uxuXDitKjdh2D609gtDGT9DRBZaS55xw==
X-Received: by 2002:a17:90b:4910:: with SMTP id kr16mr5297pjb.142.1585776543567;
        Wed, 01 Apr 2020 14:29:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id d3sm2337317pjz.2.2020.04.01.14.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 14:29:03 -0700 (PDT)
Date:   Wed, 1 Apr 2020 14:29:01 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Krishna Manikandan <mkrishn@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        kalyan_t@codeaurora.org, nganji@codeaurora.org
Subject: Re: [v1 3/3] arm64: dts: sc7180: define interconnects for sc7180
 target
Message-ID: <20200401212901.GN199755@google.com>
References: <1585732665-29492-1-git-send-email-mkrishn@codeaurora.org>
 <1585732665-29492-2-git-send-email-mkrishn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1585732665-29492-2-git-send-email-mkrishn@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 02:47:45PM +0530, Krishna Manikandan wrote:

> Subject: arm64: dts: sc7180: define interconnects for sc7180 target

Please be more specific about which interconnect entries are added.
Also no need to repeat 'sc7180', it is already clear from the prefix.
