Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BEBC33CB0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206D52084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578901938;
	bh=soxPPP1ZI0ONRGIE6bmBJhnEMY0uT/RfAdWeC6j5b0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LCM4XPf0TtuhCAF91Qu8YKBjcem712u2PowtVTVofKZGdDp1l7EW62NOWw+ITw9k4
	 P8ZqGYc0W4r4zJdg5yVhG5NfBjhuoiuZ9zlwXCCu48wgh3Vc+DTXyXgohdc5YNRI7Q
	 mnxGB1amfkWenF/GArlGGEV6imvXnR47U/yq69vc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgAMHwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 02:52:17 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:45633 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgAMHwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 02:52:17 -0500
Received: by mail-ed1-f52.google.com with SMTP id v28so7591180edw.12;
        Sun, 12 Jan 2020 23:52:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=soxPPP1ZI0ONRGIE6bmBJhnEMY0uT/RfAdWeC6j5b0E=;
        b=Tgy0RsXLOyZDrlw6l4V568dDaz/KtijZVTJ+nAA4Kv4p3jyVC+micLNzr2spsrb67k
         wntjwDN22LvVBlLnqkpeykvJ1HO0Kydhu60JOuCGHvucTih8uiroN1dmn48K5XcqLuH2
         WDHuaUTg9lAg7/wo7sUH7gqtG6SlMehvQctTnPMePnhtHodqwOE0VqBGKISpcrncUWaK
         Dy/n18JqtjR5zr4uDsBftz7E71ISiRkosxMZ1AcxJtVv+kKizoKoenf4aJ4FYsIcRsC4
         AR5jq2/97l9r5y0YtqGUoZct3NyhKXf/GSd6cpccgCSPIE6R8wMJQwumgGT35UsFu75x
         Ll+w==
X-Gm-Message-State: APjAAAVOnOrUP76QtCmagtOS9s1+Ses1T4EDN6Lz9iOGm7WEGm8xVfaW
        5ZtBgibN0DRYcAIkdXYJOIPv8F1wvWA=
X-Google-Smtp-Source: APXvYqygRlTjwBeD/K++XU6RwcobqP3LASm8y+JWasFBexgo6vO46tqs9Hx9bUNGjyxeTXmev9FWyQ==
X-Received: by 2002:a17:906:2892:: with SMTP id o18mr15492554ejd.312.1578901935058;
        Sun, 12 Jan 2020 23:52:15 -0800 (PST)
Received: from pi3 ([194.230.155.229])
        by smtp.googlemail.com with ESMTPSA id qc1sm388327ejb.49.2020.01.12.23.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 23:52:14 -0800 (PST)
Date:   Mon, 13 Jan 2020 08:52:12 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RFT] media: exynos4-is: add missed
 clk_disable_unprepare in remove
Message-ID: <20200113075212.GA1218@pi3>
References: <20191219074824.15047-1-hslester96@gmail.com>
 <f253eb6e-5e21-fd9b-8c2f-371beea66afa@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f253eb6e-5e21-fd9b-8c2f-371beea66afa@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 02:40:21PM +0100, Hans Verkuil wrote:
> Anyone able/willing to test this patch?

I do not have the hardware with FIMC/camera so I cannot provide testing.
However it looks good, so I propose to just take it:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

