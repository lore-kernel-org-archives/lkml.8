Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F65CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B90A2068F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GbuIoss7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgG2VVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgG2VVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:21:14 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC320C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:21:14 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t1so3393837plq.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4cNs+7hBDrJJFF3RZJCU5MjW7BEY57UdmNncqGv7XW0=;
        b=GbuIoss799fpxkZnm0SYdn000h504UOS4nrjBbKfeCyT9pCtSXPAa0yYE+p/Wn2ie7
         wKcW4D3Fby+dXUryis4FKQ3ygnSQrswx1pXMM432XJLt4fzS1Fnqi7d3sdl+odnaMVyW
         wlDmZLNYwfSOKzJvQD4EuAro1lx+/mkhLyNQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4cNs+7hBDrJJFF3RZJCU5MjW7BEY57UdmNncqGv7XW0=;
        b=QNmp8ZA+tm88fVEQ6KNXLuAr5zu9a9nkokMujglJWuU/VPvLzI+i3fvXb1jGAKw/nt
         e/5roiqrXiypRY131j9tKi0DefsBpYRLbR/Fea2CSsrMZh+A6cDVQRFFYWkKUkFxeTeF
         EORAUvnQYaFs9lLUkSFg2v0B3PpxNpiA27g2+uZeHo7xMeGImN0wQhQHmRCAl4Vzt6jk
         K8Mz4USPOONRb7drFnelaVExPTNy14UlO8xWGo2w2EJwTpkijg/erlV7M17VFpKAeVHr
         O+js8fcfz5HHb7F//50GbnXirYBGNfcq+MYwvWyZ+7oi64f0Jt5OFMTPWCNjQtDy0hAK
         ZqdQ==
X-Gm-Message-State: AOAM532CE5ntTPEXUZ6Zzv/MdJ1/UWU633iYK6zQWkMA3bvxmwMNjfUt
        3YJmWUdalMpu5VTsJpAc7TaR5A==
X-Google-Smtp-Source: ABdhPJyPxKNUEd+mjvsAeMJyuXrA+ik1vdTmlRfXsc7r52p7jWmRt6YvoNpG9kjxDlaDg62mR8c0Ug==
X-Received: by 2002:a17:902:cb0f:: with SMTP id c15mr14036676ply.85.1596057674351;
        Wed, 29 Jul 2020 14:21:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s68sm2854361pfb.103.2020.07.29.14.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 14:21:13 -0700 (PDT)
Date:   Wed, 29 Jul 2020 14:21:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     torvalds@linux-foundation.org, lokeshvutla@ti.com,
        tony@atomide.com, daniel.lezcano@linaro.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        davem@davemloft.net, hkallweit1@gmail.com, vkoul@kernel.org,
        grygorii.strashko@ti.com, peter.ujfalusi@ti.com,
        santosh.shilimkar@oracle.com, t-kristo@ti.com,
        zaslonko@linux.ibm.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, Dave.Martin@arm.com, broonie@kernel.org,
        yu-cheng.yu@intel.com, Thinh.Nguyen@synopsys.com,
        felipe.balbi@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] include: Replace HTTP links with HTTPS ones
Message-ID: <202007291420.9AF368B18@keescook>
References: <20200726110117.16346-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726110117.16346-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 01:01:17PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

Jon, do you want to take this?

-- 
Kees Cook
