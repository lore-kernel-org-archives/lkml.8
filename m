Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFA8C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B3B20643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UhhAvyj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgEGRw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726558AbgEGRwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:52:24 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6708BC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 10:52:24 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id js4so918680pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4xL4qCa/9s26UIoiJohUrv19oF5tpl0O53OyxD/cm4Y=;
        b=UhhAvyj4mHH32QJxuxUMjF/7MBpTbO2V7BzXH+drxAqVU1Cet9Uwtddk0wRtR7B3qy
         hW65DgYVJ3haf0tOlCt/8wA8qTXRjt59PXiOxIHBFtZ6u9y02NHuz92XK5UsZvX6yCgm
         hBznr/OMaqrgWU78lPZVqJ2RiFBL4KCAywVYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4xL4qCa/9s26UIoiJohUrv19oF5tpl0O53OyxD/cm4Y=;
        b=fbNX/TbULAoovfhOcu+tweVIoAXYHFIzy2njP/0mYqNk+8Ek61SHLPQ6rN4FoRmtOZ
         aXfq0IIDXLLt0vEdCQ1KxvXP0b4hKjadlolvaIjMxE2F1kncjNpP6WxRE7n6oDFuSEYz
         E/Suni10WRO7+w8JawIYStAtWjDb/V3mzoloiu5MJTWVgU8kYK1zJ5XnbfKfRiwcQlUh
         ETcW9sz5fRZAsHJzGssy0pxIcAxQM9mdgdVv7rP4MwIL6NiVR1TdXJl3q6FIx57EekpF
         AOkJyDyK/xGy9XUiaq0NNOpDfJKT+xMmV8n7EYf2FwVJD0eFZU9coS+LnGgaXV1EnY5W
         mzDg==
X-Gm-Message-State: AGi0PuZcLCQ3PZQ1JnOlqS2L+S6HL29IvwUAfXLnIIxrcAs61xao0ZRU
        yMw4nutLTxFQDba3NJnL2IlqQg==
X-Google-Smtp-Source: APiQypIVFtu6ODMFqOmgpEGjuYzYeF05nLLy0dHAEVQxFjNwaL8oFcXIYIe3aR74PKDZ/kzfd4UcUQ==
X-Received: by 2002:a17:902:5996:: with SMTP id p22mr13840844pli.153.1588873943970;
        Thu, 07 May 2020 10:52:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b9sm5429988pfp.12.2020.05.07.10.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 10:52:23 -0700 (PDT)
Date:   Thu, 7 May 2020 10:52:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     cl@linux.com, akpm@linux-foundation.org, arnd@arndb.de,
        willy@infradead.org, aquini@redhat.com, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: expand documentation over __read_mostly
Message-ID: <202005071052.1522C624@keescook>
References: <20200507161424.2584-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507161424.2584-1-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 04:14:24PM +0000, Luis Chamberlain wrote:
> __read_mostly can easily be misused by folks, its not meant for
> just read-only data. There are performance reasons for using it, but
> we also don't provide any guidance about its use. Provide a bit more
> guidance over its use.
> 
> Acked-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
