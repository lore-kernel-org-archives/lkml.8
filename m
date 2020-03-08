Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84711C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 14:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58575206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 14:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAWBuuJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgCHOh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 10:37:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46322 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgCHOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 10:37:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id w12so2924186pll.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 07:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZYVFbkhMFh7Q0f7ZMrKM6r5jxZ50xPHAjFHMzZBJVLE=;
        b=FAWBuuJyJnb0NCGICYm+pWXGjnZH+yeaOcMfWKB33vWBCmIWDEXSk9ZV9oviWiIHev
         uWiszCglTPEw97Qoi0L3k5uowJ2QnSFDJchAilvgfhbBCFqICYrNLnchO04qBWor27ch
         /r8fo+YrsbBBJDvSxiTHpPmwJijqeIUR9HnfCwLI56UF1SKj2NuzIZR5iCrrpASqoj1a
         844O81CTkii6fjudlJ/e4POiXsWIH8pM8gx4N8SWx5zsVoycacTHGDZ7FMUxtLzgbBgB
         rTJHsuRfdCOrtwHLq9sGrSTRE8VAU0mvBCJH6pYsHvVk9+lJgiSU1fu9S2pig/QslAJp
         pmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZYVFbkhMFh7Q0f7ZMrKM6r5jxZ50xPHAjFHMzZBJVLE=;
        b=V+jqDOu1oIr250JOszhthULgndFjXTP+T2YohSNPC8x3ZUOjZ72Zh/v6YLqQnvdM17
         51UFeuPgdm+LXG5q6AS44/yP+i5TvmGpggjV9MXWCFti33MnM8lxbsov1fsZLZYHvTW4
         LRddBgO7Tzn141hZwNoyqD27pk/6ONAd5uk984O6TtQYvje5qtw/idgPkuzaVc/lpSWN
         fv65Fn/vGhDkfjpgTembuqOaO2rsxhCCNXFQGWwb6s/zsKlW8NBg7BVIm3c6YGuuX242
         ebulhfX0K48Qvcjn3iT05liVni8g4mHy4bHhQqbq3eBcJRrYF0AbUyMMkA+q4d6t3Pe2
         LsXw==
X-Gm-Message-State: ANhLgQ2+Es65LGTK2Iz0CuAqy597Z45jp91xBFeT+sBr4QsPROsVxN2D
        3N3CNM7W82xJ78kUgZjzrjo=
X-Google-Smtp-Source: ADFU+vvRLMf3D//8srvzeibpXcqRHedhPTmb4KyO5c15Zeig8uYs4qGmosI/bcR7bBGqVCCqgF+5pg==
X-Received: by 2002:a17:90a:950e:: with SMTP id t14mr11640629pjo.123.1583678277934;
        Sun, 08 Mar 2020 07:37:57 -0700 (PDT)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id g18sm42475905pfi.80.2020.03.08.07.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Mar 2020 07:37:57 -0700 (PDT)
Date:   Sun, 8 Mar 2020 20:07:55 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: orion: replace setup_irq() by request_irq()
Message-ID: <20200308143755.GC6903@afzalpc>
References: <20200301122330.4296-1-afzal.mohd.ma@gmail.com>
 <20200301154435.GJ6305@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301154435.GJ6305@lunn.ch>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Jason, Sebastian, Gregory,

Please let me know the way upstream for this patch

On Sun, Mar 01, 2020 at 04:44:35PM +0100, Andrew Lunn wrote:

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks Andrew

Regards
afzal
