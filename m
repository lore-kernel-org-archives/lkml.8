Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35E2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D5F2206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sT8xhrOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbgF2TI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbgF2TCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:02:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13FAC030F1F;
        Mon, 29 Jun 2020 09:32:53 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so6088212pfu.1;
        Mon, 29 Jun 2020 09:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=da39VVe9VP5T/e+C8JHxMlj+Kybnqkg4N1aw6KhL+T4=;
        b=sT8xhrOECEHRXKWwOR2jxn87IGYL2kJ1l4F2kL7ZD8FLaUxwLTYUitf4r5KXgba7es
         2SnRQW0LEpMlgpuCu8aHX3SEnFDMkEn7TnIWKaZv78S0hlUUkPsMIgjs/61BWPw0CG5J
         2ZWj+DWzNjdOzxlwrblgNHO8VW9UU+1h8VwHH7H2txpLbVssWHbCUbv9EKi504IfyZjR
         /tD1K1PoD5yJQTYuTykPekiAmWV7G8JvOXnczhyXUcatx/jcJEbr50NYgI7HdDn38uha
         AunMBNxqmPqNPwDAqehx+oCKqCRiPeEqkl74hCQjq2pk93CR3s+C0tW3LbhWKP5qM3lM
         Z/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=da39VVe9VP5T/e+C8JHxMlj+Kybnqkg4N1aw6KhL+T4=;
        b=J5sz/PrOTaptIdrklWtBjHsPqKYd57QwuvQ3DS7ufLtGlEyGzP5HnhyxYDJ6jdwYbF
         27oywj2dR5ReDLdp2u4gs1GxsRru4ORkZ2YJbmsVfCajD+1bKhIP+7tpp1UHMzF4SdP3
         kbwQNT+j5Z315Ob8UPS2YB9jLA2cVJWfXx9T0mP3Nzxu0QzvR8wM8MIlKmZG1HzreQ1M
         BIA6avPkZKcpl7QmYTIQEMP0tKDoejPQ3nCs598Xm1f3KqOIBQ5LrDQ4Tv8uqQ/xJw3p
         D8SL4+Gk09YdVrexUlriymKKOq0D2p5Ks+CwRsHcBfcKxkgCBnwcQjY791beNcH6ekhZ
         dYZw==
X-Gm-Message-State: AOAM532dZWEH4h88PcmccelCfGSgjn/Lxk/f13DDMdR0OE9ekbPfA1jO
        xpcVxTfUxuGCkrUd/5wI5Os=
X-Google-Smtp-Source: ABdhPJywWQc6qI3490FIO81xYxyg6Iwnhb79XiLfzm1JW/pzgcHctYxrVXg7XCyAWghyw/PXZgzecQ==
X-Received: by 2002:a62:2743:: with SMTP id n64mr14828108pfn.163.1593448373261;
        Mon, 29 Jun 2020 09:32:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h9sm74743pjs.50.2020.06.29.09.32.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jun 2020 09:32:52 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:32:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 6/6] hwmon: pmbus: use more devres helpers
Message-ID: <20200629163251.GA113813@roeck-us.net>
References: <20200629065008.27620-1-brgl@bgdev.pl>
 <20200629065008.27620-7-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629065008.27620-7-brgl@bgdev.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 08:50:08AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Shrink pmbus code by using devm_hwmon_device_register_with_groups()
> and devm_krealloc() instead of their non-managed variants.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter
