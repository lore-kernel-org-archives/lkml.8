Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138CDC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 02:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D585920737
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 02:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fGTyR1bN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgCZCGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 22:06:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34287 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgCZCGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 22:06:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id a23so1563089plm.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 19:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vlnuxU0Jd+J1XTS9gyIBvTWZ9T9coN3Nnt26SgcjdEs=;
        b=fGTyR1bNh6v3jArHJ+uGOudV2B8Z3SE7Mdp59SLHxcWMD/Mes3HtcrHkrBxG2R4PrX
         xbNG1DiksQ+r1yAFwlA0JPvXUrqFA2FrnP8nFtHCA+4aC8TdijG0wgJbK8W3xCij0a9t
         i2wFwnT//qGc/PmWytoQQM551ctE44xKeNmpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vlnuxU0Jd+J1XTS9gyIBvTWZ9T9coN3Nnt26SgcjdEs=;
        b=myBfX3k246OipqPMJnT7dDooCJIEz5E185YrEFq2HUKRsy05/NGG01bauqVkSeC1mt
         J6pR5zSUCYg4SfSGt0s172B7/fK0pxoLIFtb+wgQvjABmsGLDGY1C+v8rTj7qcGzRUXc
         TQi0bDtYEjtXrE135im5Q61npcMiwg3oZZk1Fiyi+74Xl0KmZXJZhyHVfCMiwpR9ZKpb
         DbJIqJBNZFBLDnOiKcSg+QwOvOAZUR9xjNA5VF2qeWz+aOtVtMPSIjXz6nNxmDUn+1Dl
         KwOK7URoKqKJjRckkloR9lEwe1odYB/S8FZvsFrVKakj24loUW8UAuPrIckFgdU4Y4y7
         mdUw==
X-Gm-Message-State: ANhLgQ0qmL06VDSmJObeOG4+PH6OY6ecYX4ECRhy3vsekuYMDuOFqbtj
        Cyow5XzDR7JfKu3XCYAb73UGeA==
X-Google-Smtp-Source: ADFU+vtwLOI88fBSQtGyR5JaoTXCXFGWWVq1JDhtNRplpCnxPeq1UQjoFZ8pj7Gc2W6YDWdBID3pfg==
X-Received: by 2002:a17:90a:d3d5:: with SMTP id d21mr514689pjw.27.1585188359074;
        Wed, 25 Mar 2020 19:05:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j8sm434011pjb.4.2020.03.25.19.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 19:05:58 -0700 (PDT)
Date:   Wed, 25 Mar 2020 19:05:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kconfig: remove unused variable in qconf.cc
Message-ID: <202003251905.6D43E64@keescook>
References: <20200325031433.28223-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200325031433.28223-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:14:31PM +0900, Masahiro Yamada wrote:
> If this file were compiled with -Wall, the following warning would be
> reported:
> 
> scripts/kconfig/qconf.cc:312:6: warning: unused variable ‘i’ [-Wunused-variable]
>   int i;
>       ^
> 
> The commit prepares to turn on -Wall for C++ host programs.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> 
>  scripts/kconfig/qconf.cc | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
> index 82773cc35d35..50a5245d87bb 100644
> --- a/scripts/kconfig/qconf.cc
> +++ b/scripts/kconfig/qconf.cc
> @@ -309,8 +309,6 @@ ConfigList::ConfigList(ConfigView* p, const char *name)
>  	  showName(false), showRange(false), showData(false), mode(singleMode), optMode(normalOpt),
>  	  rootEntry(0), headerPopup(0)
>  {
> -	int i;
> -
>  	setObjectName(name);
>  	setSortingEnabled(false);
>  	setRootIsDecorated(true);
> -- 
> 2.17.1
> 

-- 
Kees Cook
