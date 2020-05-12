Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8A5C54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 05:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85232072B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 05:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq2dqmF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgELFVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 01:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgELFVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 01:21:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3944DC061A0C;
        Mon, 11 May 2020 22:21:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y3so13701481wrt.1;
        Mon, 11 May 2020 22:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=iPNWrjCXLG5PobA8YJLbqbttbn3fSW2nFeC8Eks6Lm8=;
        b=bq2dqmF04qwpjjm8fxx3txA1QpoMZXU1/icZ9Lzk+Ur7CL/QanWEh+ELVDAHeu3hiU
         aMhdRWuN309gwOBzR9tmovi6pHfHZyb47UPAL7hqdl4ijuhud869SXUeNVgrQcRwRJlh
         XyAfUWl3qYgLFLZcHU68SQVsBL5iMS5Htdtt5/+haAkFr32uPyjUZZRVrD/obzXQuXx6
         Amob/waiJjU4E/KDCVNidVPbP0lEs93LCm7js3fUJc/p+a2Y6UynPRLnaqVwA8EI1aM6
         ih0yvIil0nIwTrl51Xl5zfbgK2Y+kErLZMtzZDaSjJJbnnto+oH2SyGlEJP8cvEvIj/k
         URaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=iPNWrjCXLG5PobA8YJLbqbttbn3fSW2nFeC8Eks6Lm8=;
        b=ejMEP6fHarbMzCeJU+fNmpq+WjdFKMPBwAZluTqlH7ccggMxdFOanPiS3epq2JhZ6h
         5wEu02UJsQwJ1+jM3c6NyNh3Ckc0BjCxm12xYUnKwdMKSqHd1GjM6HtO6sMcifT4TbTU
         OG+l5i2qe4BSwknpgRsaqQNmx1UdlMUgMWmWjvdRrcXO+U7hS+bZTj1bg7tSw/3Nd26c
         9npiD9M+3Nh6T69QSroN9RvbeoIerxuQ04qhH2Os86UG3+WoZ9vpoLaCEfB7ut7WttTI
         eHuI+SgwRMXrcs4Vc4rVmei1YgYZ0x/dCvTB16BR9CoCMlj9lGdbZlrQ3IWnAh0irUmB
         6XNQ==
X-Gm-Message-State: AGi0PubGdxJMVJWcwe0iiMKvt7g7a85s7i3YdZTUMXYCHd1lQepX7kV4
        rK/9x/il9SxP7YKMh5sqrEAS8G6AIBw=
X-Google-Smtp-Source: APiQypK7ThE8Zug7UHhcpytlSDewjztqnIvLlaa5ZIW10ubZlqdWzCXgNYxxjoFGF+Vxgm23GM0pPg==
X-Received: by 2002:adf:db4c:: with SMTP id f12mr15531337wrj.387.1589260875606;
        Mon, 11 May 2020 22:21:15 -0700 (PDT)
Received: from felia ([2001:16b8:2ddc:4100:5571:bcd0:adce:c7ab])
        by smtp.gmail.com with ESMTPSA id 77sm21471812wrc.6.2020.05.11.22.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 22:21:15 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 12 May 2020 07:21:01 +0200 (CEST)
X-X-Sender: lukas@felia
To:     David Hildenbrand <david@redhat.com>
cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: MAINTAINERS: Wrong ordering in VIRTIO BALLOON
Message-ID: <alpine.DEB.2.21.2005120717260.3701@felia>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

with your commit 6d6b93b9afd8 ("MAINTAINERS: Add myself as virtio-balloon 
co-maintainer"), visible on next-20200508, ./scripts/checkpatch.pl -f 
MAINTAINERS complains:

WARNING: Misordered MAINTAINERS entry - list file patterns in alphabetic order
#17982: FILE: MAINTAINERS:17982:
+F:	include/uapi/linux/virtio_balloon.h
+F:	include/linux/balloon_compaction.h

This is due to wrong ordering of the entries in your submission. If you 
would like me to send you a patch fixing that, please just let me know.

It is a recent addition to checkpatch.pl to report ordering problems in 
MAINTAINERS, so you might have not seen that at submission time.


Best regards,

Lukas
