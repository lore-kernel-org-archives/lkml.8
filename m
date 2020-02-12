Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC10C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D9F2465D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hsJzu2yh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgBLUxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:53:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54930 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgBLUxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:53:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id g1so3866906wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kFOHrpvoYdP7OqqBcaBxRlx/UgtY/2nbvrQxY1R/DAQ=;
        b=hsJzu2yhhXMvBUkPigrLXe6r7tNTYcLNI8czQb7YGNMNUOEZl5OW1NdrKk+kmGJvpZ
         sUNELcaTxujQJCz/UxlG1InPNOJy4wzeB0zIK8QM0vLOmkAPa84cOEFBbheGU8kxRhSL
         XvZ1HIUHxWUOaiZLQk5GKgZcGsqWG+Ifzcvmog12TJATUGov6vz4Qr9OGZbIvC2c4LNI
         Asus77RqJ5tUvMoqR+CHbz4urEYz4BQ/xRB/NT+Nr+nbtpnHl0a5dGVZfxTDxt9U/HPR
         vh5hdtxbJ/fRfchmu+ePxUJiD10Nyii8EbwIaA4NsLHk+RU1/euhwLs7/pnxZPKfSYZl
         zxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kFOHrpvoYdP7OqqBcaBxRlx/UgtY/2nbvrQxY1R/DAQ=;
        b=HU8xOiKdsxTe0Dg0+X6y3PT/OpN5D4Y6n7lYKlRHPImESoJ7o1jqnoGAfkdZ4/Pk+G
         ylwWM8QA19DKwyHXfHKDHqLOyhlHOcKDcTygErHzZL3sEupfJ2d+GvYzdzHgM64XpuYE
         4VYCTjhYbAdsuWB3UyrAAsdkKNJzlEizaCpM4Wyp9+8/ji3vLer8huP/SQfT2sxpbyWA
         iH67Gadcft5QgUuhrL9Vj7uA5JxzCUmySdHos5yiIOiSXKnglXD8muX+FNFS/TEYEdlR
         KJcYhvGNNkt+iy3lll9xokjZpngC0wRFqThXfPGAwGUwpw984prJXxKBS+EpRB4wR14I
         sqqQ==
X-Gm-Message-State: APjAAAUXAjlb0zCDj8/nfBfmirK6IRYfX6I6tiifR4EJSGp+MJMz/VTi
        FP0wZHmvmVj/Ysxmdk5cxaoc3Q==
X-Google-Smtp-Source: APXvYqyuffDl7NHzkrxWTOSB46ChHm25e1ar7WZ4d+epLaumvdvfi15LiCYsabhSOva/hebgpfTjvA==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr944970wmk.172.1581540790749;
        Wed, 12 Feb 2020 12:53:10 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id r1sm1996023wrx.11.2020.02.12.12.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 12:53:10 -0800 (PST)
Date:   Wed, 12 Feb 2020 20:53:07 +0000
From:   Quentin Perret <qperret@google.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, maennich@google.com,
        kernel-team@android.com, jeyu@kernel.org, hch@infradead.org
Subject: Re: [PATCH v4 0/3] kbuild: allow symbol whitelisting with
 TRIM_UNUSED_KSYM
Message-ID: <20200212205307.GA148347@google.com>
References: <20200212202140.138092-1-qperret@google.com>
 <nycvar.YSQ.7.76.2002121545120.1559@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.2002121545120.1559@knanqh.ubzr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 Feb 2020 at 15:48:50 (-0500), Nicolas Pitre wrote:
> For the whole series:
> 
> Acked-by: Nicolas Pitre <nico@fluxnic.net>

Thanks!
Quentin
