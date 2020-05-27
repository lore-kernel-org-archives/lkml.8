Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67332C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349BE2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590568204;
	bh=75buLZvESPQ2vNGN6NxFbotEmt/FJ2xwhXxYOaC01R0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ktlr0LEZpXNI+9nzx91Q3NPcZL+QmR1DGmSiBvTDeSf04E0JAvRgCypNDTt635kFw
	 hdGXHuxaHRlqpeiJVY3J8K5xJqrlewBQKXjhMeBSI1iMSVGpXDLhWDbx2VbAlBYRZq
	 MmLPryRd/4RZfu+xGq28gZHmia4tgzjddR16Yz6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbgE0IaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:30:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40343 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387707AbgE0IaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:30:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id z13so18183553ljn.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hAfXLP5aOhwBJfVrrYNVrgoUMUX6RfPFH/sGNl7NIf4=;
        b=VQEYzsP99ALv55ppaUdUlnMcMtXUcBA//qDk8Yk3t0tkHCRp0QFqjznJYCC/KK0eVR
         MoK+iKyjgpQHpDgcAg7NblGunwAINLfnx3wZWc3UpSyw2LiNkMcC6JSLUQi+pZKEHuxl
         IBK3X0NuBC6rwLcddwPIDbojhYaQgziRjfGFD14x7U5dhiVB9WLD1IGbdCfpzJKC9DEV
         3B1yXmbHmWuI7ATGi8WUG7AOV8IlFpR11Pima+0K4YBK19z6wOQyX4YrGG5ex3DTYFZW
         S+Zn2rXDlLhDYgxuXxwogNya3JbudiBLD+NOYQJWqYpCdqeZ07D6y+wx+CCCxEsbo54n
         XjuA==
X-Gm-Message-State: AOAM532HQiBalLfamU6Iw/kkRYh39k9f809MnAM/La9agQrJFKOwHR6W
        Ed0kygADihcbBQhf9yp/qaY=
X-Google-Smtp-Source: ABdhPJx/VDN28lm5cqRpc/0i9cdtLEqYARmdbyjGOXVCgPY0oGPfkGvjqMJJI/FhkjiGHXLM7hsEdg==
X-Received: by 2002:a05:651c:2046:: with SMTP id t6mr2369145ljo.227.1590568198137;
        Wed, 27 May 2020 01:29:58 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id z78sm641894lfc.80.2020.05.27.01.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 01:29:57 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jdrRe-0003w4-65; Wed, 27 May 2020 10:29:50 +0200
Date:   Wed, 27 May 2020 10:29:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/2] x86/apb_timer: drop unused TSC calibration
Message-ID: <20200527082950.GI5276@localhost>
References: <20200513100944.9171-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513100944.9171-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 12:09:43PM +0200, Johan Hovold wrote:
> Drop the APB-timer TSC calibration, which hasn't been used since the
> removal of Moorestown support by commit 1a8359e411eb ("x86/mid: Remove
> Intel Moorestown").
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  arch/x86/include/asm/apb_timer.h |  2 --
>  arch/x86/kernel/apb_timer.c      | 53 --------------------------------
>  2 files changed, 55 deletions(-)

Any comments to these two clean ups?

Johan
