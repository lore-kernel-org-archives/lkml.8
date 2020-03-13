Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A473DC1975A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F68D206E7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584061116;
	bh=KRUP2Jr49QuLD8NGFM8nmKqVqM9NcsMD88+bvEw/3ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=llREWwROSeTympf1uOAweWT66KK38zJQtTQk+rkar5WNZQJO9pLxz89qDC32vGYox
	 THssV0hTniK/+XwWKPyxk7B/xhzUj7lvT8pjXVVsIrE4ScxTtLlz/fsn8vZ9t3pzqw
	 j9p1TE/c3XlnZtpncVXFRH8VPUoZPE0e+QCQLtIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCMA6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:58:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37635 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgCMA6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 20:58:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id a32so3098164pga.4;
        Thu, 12 Mar 2020 17:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w2dJvjqoKaCtDbJSbP6GfunKVqsuAQLMGA6TusRI3Wg=;
        b=c/xE1nEGVu2X1lDgqT8UkwcPolQfeZcjJ0bAB4B19OOzOqxC3cFdJv2hGERPprzl3y
         14TJs4reJsVoTInnGFG24YSfMD7qaDpCZAejmgG9pyAldag1QGfzMI6BSWh0TON7uKAD
         sOa0EH59+ySAoDM+TPovVHFMBCB2trUfdMTm5we7H9xzYtFvjjs3xGtn0eoVowMOW9ny
         fw4o07fSHvRpTpFZo5uWYBEDN0Pmdchrequkn1gH3tGNUE4KOvy5qXOFk9rfV4U5e5ln
         /JFUI2si040GswDyxSlmuFowszh8SPqrpfW8AVX1keNfr2TC57rR+aHCUiQZsqwMssRu
         AVxA==
X-Gm-Message-State: ANhLgQ0ZGz8fQGVZ3u/OA3x6W0K5zx308/bN6neR34Ue03QVome9Fhkd
        1VXH+cNFSWwv1cLO8QfpwXyNuM7b3Mk=
X-Google-Smtp-Source: ADFU+vtWUix6nYJK2rz2o2/xQxYRepdItn+tkMt206rx3HLLDhOKIdDLRVknWVyQQDA/duk96z7vFw==
X-Received: by 2002:a63:a807:: with SMTP id o7mr10087694pgf.407.1584061113397;
        Thu, 12 Mar 2020 17:58:33 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x12sm45523818pfi.122.2020.03.12.17.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 17:58:31 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 2B1244028E; Fri, 13 Mar 2020 00:58:31 +0000 (UTC)
Date:   Fri, 13 Mar 2020 00:58:31 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] fs/filesystems.c: downgrade user-reachable
 WARN_ONCE() to pr_warn_once()
Message-ID: <20200313005831.GR11244@42.do-not-panic.com>
References: <20200312202552.241885-1-ebiggers@kernel.org>
 <20200312202552.241885-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312202552.241885-3-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 01:25:50PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> After request_module(), nothing is stopping the module from being
> unloaded until someone takes a reference to it via try_get_module().
> 
> The WARN_ONCE() in get_fs_type() is thus user-reachable, via userspace
> running 'rmmod' concurrently.
> 
> Since WARN_ONCE() is for kernel bugs only, not for user-reachable
> situations, downgrade this warning to pr_warn_once().
> 
> Cc: stable@vger.kernel.org
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jeff Vander Stoep <jeffv@google.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: NeilBrown <neilb@suse.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
