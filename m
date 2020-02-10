Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEABCC2BA83
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 02:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1B42086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 02:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="s2iEyvot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgBJC4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 21:56:40 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:38944 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbgBJC4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 21:56:40 -0500
Received: by mail-qt1-f171.google.com with SMTP id c5so4098923qtj.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 18:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=7dKBn8UdWcwCQViDYynndoxvb9rBXM5UJxoQfv6mJSM=;
        b=s2iEyvot/yEG53CE0INRhwc9T7vqFiGZ106xA0t8V9/kaXBKzOQe6mSkcYR7Hlcrj9
         uPRSZ9nKcvG1fEblg7vR7rUFUjc7MOys1/F/X/4XK+qu3XgJ2K1KqYDAdsRkJfZMuxuX
         7JtWBw7En3jcGw3BLYBPeRq19lOtuWuJpSI2nf28jNI4sdjvdCXff84gvFTQ61IUk4JG
         etlanuwoyIgQRZRmKOzd76AQ3nACKW1FJ4Wle/0AbTOYVLybadtPEgM7Cj4JZKOxeapM
         XeSifCDiZNmHXqKsUvxZ3nhPHnmcSIz68m8w1CRaiOwuDgFB43xTccDihOphbVT7eoDE
         rF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=7dKBn8UdWcwCQViDYynndoxvb9rBXM5UJxoQfv6mJSM=;
        b=EW0E9DGwRnYcHGDlVkTM42lFnbJ9jAK3PJxWmyHo9SGmB/ULKvqtRc2nth5SUoq68g
         3frGOgeUMMbFxonjrjvvO8ONyPp/yRwKfr3y62qrpq/tH01rt7v8n45lLqsNrMm00GaQ
         w2Uo3z4jFblq6T7WX/ULR5ebsOsZOfVbYzvkAE8WBv6ZnFpONPm4wdDVpjRvy1gQIsk/
         1urB0NwPe9d3bTFlIN+XSoObob5SJmUkDWtvIRjBPfBrEXNT4Bpi0G3XvbYV94eSboM9
         Xk2Yh8tKs1P9En1hybnXyQGoompUWa3GY3Ouz2iSgzNjdEZDeLQadlvjpR5Ta7ctBwbU
         ePzA==
X-Gm-Message-State: APjAAAU2A1Kyfm3C22yiZGbXeoVpj0Jeh5XjiJ2npwNevzx2pF65/T/H
        tcCOeHsFmJANlmqhsOFWZf8X2MdwbktARw==
X-Google-Smtp-Source: APXvYqwmuf1/jVbV0Urj6O+iGBztK2zKQJd0+MvljkUfv/UvESzkPAWw3b8JAcQIjhr6fC5UdhcJEA==
X-Received: by 2002:aed:3463:: with SMTP id w90mr8076696qtd.42.1581303399412;
        Sun, 09 Feb 2020 18:56:39 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o187sm5215426qkf.26.2020.02.09.18.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2020 18:56:38 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] mm/swap_state: mark various intentional data races
Date:   Sun, 9 Feb 2020 21:56:38 -0500
Message-Id: <44866E74-9C6A-4B25-9E6E-894FB097F8A4@lca.pw>
References: <20200209180053.784806e3bf028caa8bc584b3@linux-foundation.org>
Cc:     elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
In-Reply-To: <20200209180053.784806e3bf028caa8bc584b3@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 9, 2020, at 9:00 PM, Andrew Morton <akpm@linux-foundation.org> wrot=
e:
>=20
> The data_race() macro appears to be stuck in Paul's linx-next tree.=20
> Can we expect this to be mainlined soon, or is there an issue?

I read Paul is trying to get this merged into the mainline no later than v5.=
7-rc1 or sooner.

lore.kernel.org/lkml/20200131211950.GX2935@paulmck-ThinkPad-P72/=
