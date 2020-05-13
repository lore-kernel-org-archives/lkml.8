Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D364C2D0FD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 05:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3789C206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 05:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQGCPXd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgEMFIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 01:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726092AbgEMFIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 01:08:14 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5667DC061A0E;
        Tue, 12 May 2020 22:08:14 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w65so7469997pfc.12;
        Tue, 12 May 2020 22:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gD48qUgTpY5H3y7E/mQ9fNLXyKbI1TMIzyH0EZQrjYY=;
        b=sQGCPXd4N3EjbMUbGnma6DqfPv0qGLNzCrmuPLoJvPHOQktCBX5jb8CJ4pAAz4KVX8
         b8E6XYY6AcJldhyadQuzByieYDB9IdoZGx2Yck8FQo23N7vfP0a8auUC/7h16tYqe6Rg
         sz/Qvk8hV9EhXtBD60xvcLg8DL86wPqLYlY80xoZavrLtfFaTF8jPMfYiocMwh7f2Psr
         Z9WpHrOo/eVNLJ8jg4QnkEO+gqCZchLtx7/Nnj36dLJViqTZvZCqgSxY+J4Gb2QnbZkO
         kt2ZWxmNghdiJbOsR41Mbm0NYMcnrWgi1o0zhZ2O9QNp1Y59XKpxU/nsQjqQnApagr99
         uhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gD48qUgTpY5H3y7E/mQ9fNLXyKbI1TMIzyH0EZQrjYY=;
        b=Q4UXLy/IzoErAvh93yE5e8V0JvKUdlDWbGnGchT1bHVHVu2vCzAZMc7kMGScoCktdH
         clM5nm4dq5oDtFeY/kRBVGy9YQUAUnm7c+29kFyYVrFbnRfIXOJCLjfO/JoEumdZ/i1R
         ANOeb5Ody0d5F2/DEEql8LF1kM3Q4xHXvmgaLlGdHxFTKF3Gnp/2YgFJfVxRFJ848A/i
         l4/Vn2kr1CRZMQ21pxC64HAZKh4LLqJCd2y3vxASkBzitgbDGVOyOUdu2DV4bCn/OGhQ
         YiTEhLmJBvC4r8c1NoWljge879krWFcDL81SwAVa4BS+w76sEODQPSTG+5KCK3FsnPND
         CvuQ==
X-Gm-Message-State: AOAM532l5g52QMsSd6naJ0+n4vGnqBwTMpQQ0Tw+4UHXHZmFrgJPixI/
        uvaU/7GDojFdElg6hdZtryo=
X-Google-Smtp-Source: ABdhPJzzP9klR6bWe3ODCdQtf+NWu5xzVOFpNL1jg2fE1q08uaY9K0pcZkmzTtuVxVp2glcG/Xq8BQ==
X-Received: by 2002:a62:e117:: with SMTP id q23mr3213182pfh.188.1589346493760;
        Tue, 12 May 2020 22:08:13 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id x66sm13642770pfb.173.2020.05.12.22.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 22:08:12 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 13 May 2020 14:08:12 +0900
To:     Kees Cook <keescook@chromium.org>
Cc:     WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v7 07/18] printk: Introduce kmsg_dump_reason_str()
Message-ID: <20200513050812.GK413@jagdpanzerIV.localdomain>
References: <20200510202436.63222-1-keescook@chromium.org>
 <20200510202436.63222-8-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510202436.63222-8-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/10 13:24), Kees Cook wrote:
> The pstore subsystem already had a private version of this function.
> With the coming addition of the pstore/zone driver, this needs to be
> shared. As it really should live with printk, move it there instead.

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
