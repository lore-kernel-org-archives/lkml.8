Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5DCC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 19:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90DC5207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 19:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="L/1yEubs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgFMT3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 15:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgFMT3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 15:29:09 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113B2C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 12:29:08 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b5so5927826pfp.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xo8ytRHA8kMhSzgaf+vcCOJn1UirQ92SScXvh+BCUB4=;
        b=L/1yEubsRWCHrnfgf6xtbij3KIJa1Fnvz53JJOSpVq9YiCmGymxgD3wLQCsX6X63ao
         B0xS48rjEajSoNmCF7d/rhclbk0EPqpV3/tvUf87IC2FAwJp1lsO+GgAUQBbxLbdeZLl
         SbeFjUa3cap1Ju+49TeV9PH48lqJhL6M9fmw9DwdOsJDIBc95U7/Ss2gcHLUUKDJyWGy
         skT6e6GskED9pC/lurdufttvDWSCDJvjoKPuYzCKl8roKwX3jKWDuuoxDfcCezmwJ8gi
         BQu9lTrTlli7icemq5yXKUVEQ4bo9D4QSmUwY+8TnzQy6TewvmTPMDELsCiMQv+ylAEc
         kaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xo8ytRHA8kMhSzgaf+vcCOJn1UirQ92SScXvh+BCUB4=;
        b=bML6RaHjw+D61ZeoXTwWm8mdd9Y0qb2bqW1dYuuLzC+INxH+ajcWtyYmxpyKu+QHpl
         Z1gkYrwvIrgxNnukAa6iYL58cc4xjSXyjm+tGkx/BiwFx/kUAER4rPXcRipClFIUYBnb
         HC9PjOA9qxONXwBFH2Comngo05FGiBcGq2OGdJmZBS441yKeJMb/RT16Mi74w+/EzMwg
         uNVlhJvBl5qcBH9SEkvgmYee5Cr/Np6IJ5rR2A2IZcW52d/nBX/9Ii+9UbjTJWw4Wqs9
         WMofMcX0E5jZbfpA/scu7mbFCW6q9F1oCCJIxhFbLjEdHaVCrfTjpf4Zn/+9r1eSQHAE
         tQ6w==
X-Gm-Message-State: AOAM533/X4mJnyX8JcaPwV4SfWk31hykj6u8yiEMEzrj8/fYkj9ZhcJI
        E6cR6WX5yPMSdhrvLou0hkafEQ==
X-Google-Smtp-Source: ABdhPJzK5lBTS6eJJybZBFDFzV+Je4R27TUx1fw5wg2waDHRc1M28kVvD4DdIG4PzGMG6/kz0yy3DQ==
X-Received: by 2002:a62:7f58:: with SMTP id a85mr1385838pfd.89.1592076548331;
        Sat, 13 Jun 2020 12:29:08 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id a10sm8313289pgv.72.2020.06.13.12.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 12:29:07 -0700 (PDT)
Date:   Sat, 13 Jun 2020 12:28:59 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Andrea Mayer <andrea.mayer@uniroma2.it>
Cc:     David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Shrijeet Mukherjee <shrijeet@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Donald Sharp <sharpd@cumulusnetworks.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Dinesh Dutt <didutt@gmail.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@cnit.it>,
        Ahmed Abdelsalam <ahabdels@gmail.com>
Subject: Re: [RFC,net-next, 2/5] vrf: track associations between VRF devices
 and tables
Message-ID: <20200613122859.4f5e2761@hermes.lan>
In-Reply-To: <20200612164937.5468-3-andrea.mayer@uniroma2.it>
References: <20200612164937.5468-1-andrea.mayer@uniroma2.it>
        <20200612164937.5468-3-andrea.mayer@uniroma2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020 18:49:34 +0200
Andrea Mayer <andrea.mayer@uniroma2.it> wrote:

> +	/* shared_tables:
> +	 * count how many distinct tables does not comply with the
> +	 * strict mode requirement.
> +	 * shared_table value must be 0 in order to switch to strict mode.
> +	 *
> +	 * example of evolution of shared_table:
> +	 *                                                        | time
> +	 * add  vrf0 --> table 100        shared_tables = 0       | t0
> +	 * add  vrf1 --> table 101        shared_tables = 0       | t1
> +	 * add  vrf2 --> table 100        shared_tables = 1       | t2
> +	 * add  vrf3 --> table 100        shared_tables = 1       | t3
> +	 * add  vrf4 --> table 101        shared_tables = 2       v t4
> +	 *
> +	 * shared_tables is a "step function" (or "staircase function")
> +	 * and is increased by one when the second vrf is associated to a table
> +	 *
> +	 * at t2, vrf0 and vrf2 are bound to table 100: shared_table = 1.
> +	 *
> +	 * at t3, another dev (vrf3) is bound to the same table 100 but the
> +	 * shared_table counters is still 1.
> +	 * This means that no matter how many new vrfs will register on the
> +	 * table 100, the shared_table will not increase (considering only
> +	 * table 100).
> +	 *
> +	 * at t4, vrf4 is bound to table 101, and shared_table = 2.
> +	 *
> +	 * Looking at the value of shared_tables we can immediately know if
> +	 * the strict_mode can or cannot be enforced. Indeed, strict_mode
> +	 * can be enforced iff shared_table = 0.
> +	 *
> +	 * Conversely, shared_table is decreased when a vrf is de-associated
> +	 * from a table with exactly two associated vrfs.
> +	 */
> +	int shared_tables;

Should this be unsigned?
Should it be a fixed size?
