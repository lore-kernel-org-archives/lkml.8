Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61B0C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C49921D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="coBTIYDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgATQzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:55:53 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45269 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgATQzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:55:53 -0500
Received: by mail-lj1-f195.google.com with SMTP id j26so34494506ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4VxE8v5dH+QpdIZbYSbZopov06646USn27k3epy+Wdg=;
        b=coBTIYDt1doh8KwTjQ/LrQPzlHL/KqyHV+iOe8tFqs2rkm3AdXRv0oYpAL4/w6j0UD
         JskKUR3tiw2dUXjOLKEVj93VQKqlG9q59G+vAq5bQ0xgIcKXA6IKmQDzGBbXssGxwVf0
         OfSh7b9NPR47TSBOL5h0cWvl6yjgD6nh5mnAsmvadQLomfsqFTmhrNiTCVojNx6mePx2
         y3yIWwUWU9aKrgkA9/gARzvUhl0exvfwqgg2cmRbGYdCvcoq5EXALjWKYKp324r0P+TF
         BI1fkvJL08rSTHsvnRsDTvbK2ckjmRC3xYWKmjFqV6pYVWsmSpDz3euXeIp8MXnS4Bw3
         AbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4VxE8v5dH+QpdIZbYSbZopov06646USn27k3epy+Wdg=;
        b=nO+Qmkktb1oy82aKszk5hdyIJ6H8lxn5EUfCn2qroPgKl2bUBrB8+ksFio64HjISsG
         D0seYMZSlWrgRilLHKE9G0adhirZ7ZSpCeEqPyrlsaE08y8WhTEwpiz9OfcOshFvrVfb
         m58xc6ZYPJbM8046L0yGK2ujhRfhABCCtz/vmIkRCFOs0FBDWTq5YOP9x1wgbqqhpzq8
         6tTan6utDYo+BvOgWmAN15FVqppTkwvarf6h/Y5e7OPeIsdvzS+mEz6vZw67FEoYEGeL
         hTak30bQboEI5FtUjwg+cccUnDwoz30RMKjNEyJI0CxGR3uaWmGYyoO+nlRI5T6gAy7Q
         FQTA==
X-Gm-Message-State: APjAAAWSoZ1OgM293uxcZQ16GuQmG6nPDFQzTj08aXWythAQMFJGiuTX
        /26q0j9wwH5QNSvpEfADyuxfUw==
X-Google-Smtp-Source: APXvYqz8+d8e8/ZKTOPzWyN5EtzNhFN+4Vbr9CW0QzOcMtDjDg3K7YXAP35itBVxIkjfThj9Hh9lwQ==
X-Received: by 2002:a2e:7e05:: with SMTP id z5mr13061141ljc.99.1579539351341;
        Mon, 20 Jan 2020 08:55:51 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r12sm16971664ljh.105.2020.01.20.08.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:55:50 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id AFEAA10028A; Mon, 20 Jan 2020 19:55:51 +0300 (+03)
Date:   Mon, 20 Jan 2020 19:55:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        acme@kernel.org, brendan.d.gregg@gmail.com, corbet@lwn.net,
        mgorman@suse.de, dwmw@amazon.com, amit@kernel.org,
        rostedt@goodmis.org, sj38.park@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Introduce Data Access MONitor (DAMON)
Message-ID: <20200120165551.codmosqc2pkcunpa@box>
References: <20200120162757.32375-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120162757.32375-1-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 05:27:49PM +0100, SeongJae Park wrote:
> This patchset introduces a new kernel module for practical monitoring of
> data accesses, namely DAMON.

Looks like it's not integrated with perf at all right? Why?
Correlating measurements from different domains would help to see the
bigger picture.

-- 
 Kirill A. Shutemov
