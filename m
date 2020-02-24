Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC463C35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBE120828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnUz2hwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgBXNQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:16:39 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42583 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgBXNQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:16:39 -0500
Received: by mail-vs1-f68.google.com with SMTP id b79so5615352vsd.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 05:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOTOEEcJr7rQLnFDlUYMQgFpypdNN6QFoaJIjORW4cs=;
        b=KnUz2hwBsJD+dNwgbike0bztFldk0jHTSM0g54BzXJ7jxPwEKfhKTHbSvDKYr2pepH
         /nujD+M8kpmeNGA07Ryu+uhgeSvtRZyfg93KTnscqq1AqEYnShSsObmAWcz8m1WvsWmF
         xpMaA+EocRrnu0ZhldEjprmvh4PQNeWhA53EEvh5QUcIw0MjKDlar0neN+BPbxzGWag8
         o4F65HaTGkdzsv/hTJEy7yMNGWMUgFPojeEOwMGmdlaaqaxN7uBuR24zpzxwCnwGqYlF
         sNbCxOtO9MYAU/5HSLfvhhis8Sl3mLv190x5aW6mTkz5rkLVDh9k8Kymd9UNZIvBzUNf
         O/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOTOEEcJr7rQLnFDlUYMQgFpypdNN6QFoaJIjORW4cs=;
        b=sEnFuLSrxPki7AWdFMKRCSAHzD13XR7w7iviZWRW8o8YowSjrrv7RThodO2o3XThg3
         iSV5yPp6dPD7lgBTaqo6YzVdGkaoVdDPDWRg+XqkF8ixpd12daJkfOTMGZiJuB9a68B5
         cilsuAWxQZhgXLkCRBQdsnx8JECq5BWTxg04WeyfRZ7if/EX1+0D09ugS9/IueiFpCYy
         JGlA51uGtOXDxLsd+EcVWRZ3WqVIdyG0xX9kB3J9x7crWGkjlmkb2U+dtDDdq7O6CYMZ
         pK/YJOwCvJnC13JG5OEFyGH/jMusVVK/jQwI2yrUKImqyX+vXX+3+z+qVjfvxxE+v9Yd
         3L0w==
X-Gm-Message-State: APjAAAUPTaMNeMQ2VjHnhMfbA2xsoXmyRlWw5ucDiH+Wfe/Bx+OTOl6o
        TdGwPkGSSSeTCHmx6JmdbXrHiC2NubMLPIpDESwilAFzTiA=
X-Google-Smtp-Source: APXvYqxrIe3+OqZ+A1GsOx/kQ9OY1tQILX3AgVcfwTMKFdaFdrQnqMBaVBWtNo53Pw0AQNC42G6qdvHRI17em09EAvw=
X-Received: by 2002:a05:6102:535:: with SMTP id m21mr24976628vsa.95.1582550197643;
 Mon, 24 Feb 2020 05:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20200106151655.311413-1-christian.gmeiner@gmail.com>
In-Reply-To: <20200106151655.311413-1-christian.gmeiner@gmail.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 24 Feb 2020 14:16:26 +0100
Message-ID: <CAH9NwWeWZ8BSZ6wNhWZtiLxuNQzAYb5ZKX0_+3XWu2ieqhJLBw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] update hwdw for gc400
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gentle ping

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
