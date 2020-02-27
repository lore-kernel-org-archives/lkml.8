Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41A3C4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9312469D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyhz8yWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgB0NLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:11:07 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40085 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729111AbgB0NLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:11:07 -0500
Received: by mail-qt1-f196.google.com with SMTP id v25so2182144qto.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cbSIwpkavg4kITor88L2sAsKTXTdWps4nQbxlvRwwMw=;
        b=oyhz8yWOy1WOzEKqbMMTkdoBeQmWd22fvW20Iom0jbYFKm9tM9j1C/e2ybBUxEDPyq
         khWdPTJmDs0aTrjihtaVdYmomLRg+hHjJCdKfi2kM281VZLQjNXlY5hlJbmKFWSCP5rZ
         YUwhrL5FazXaK5YWRusEh9n7QoJCcr269SVnFf0TszU8QywmHQlp+ya3xd66hwSLVW7f
         i/dJtwNmhjP2UI3Jfz8/nqluKk+sr3fF0XHeln6xmLOJ20Mh84rxjrH+3KJ+I9LtBjXK
         /o7PDFkrEjdOvEPbIzAfDpxKu2v5uBwBiHPXH/2VcE3zXNMqMk7EjSLjJoSu9h/Jp9mZ
         GJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cbSIwpkavg4kITor88L2sAsKTXTdWps4nQbxlvRwwMw=;
        b=DzK9jd8HIp8l1Ea+q9f7typvugU8+Z+TUgBopUj2Ltp/2KMIxUG4Crznj57cwL/M34
         oxR4EptWFyZYwvXS7dwWnh7I7OO32VzvDLjIfqJra7QDYDg9ucicxkJVYxGFWlH/4Q20
         GB08l1m8vosSbgF8ceRvXcKz0TL4hXtAGZMEzkhXUOtguxEAm7EFOhiIGUbWCCteC3AD
         7wcrDpahibNFsjL73xhfRqNcp0ibyAJHgDrJ+hu5HCba8aatBwPSRVJ45BR6aaB4Ho+W
         MxKZ91W8f9BY3QeUjqVXiSl4tBhXs9mn+GLTXqOvepqqa2SP9m7aKhVS7l1TMn7p1NHp
         Shzw==
X-Gm-Message-State: APjAAAUtX2k6h/rdhtRvS44ijP5ANxPTU+Xzh/VMjDBzVNrR086XSKYe
        Cn9Pn7tDLfh7OVUiJNS8snw=
X-Google-Smtp-Source: APXvYqzehLFvLUyTtax/gsckG4VxxhRc5Sf2wQqfWAKFoIXYPPdaZxLWAtg1JodzRbkORHgbFB9Iyw==
X-Received: by 2002:ac8:607:: with SMTP id d7mr4820194qth.271.1582809062941;
        Thu, 27 Feb 2020 05:11:02 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id w21sm3309296qth.17.2020.02.27.05.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:11:02 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 60CDC403AD; Thu, 27 Feb 2020 10:11:00 -0300 (-03)
Date:   Thu, 27 Feb 2020 10:11:00 -0300
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     jolsa@redhat.com, xieyisheng1@huawei.com,
        alexey.budankov@linux.intel.com, treeze.taeung@gmail.com,
        adrian.hunter@intel.com, tmricht@linux.ibm.com,
        namhyung@kernel.org, irogers@google.com, songliubraving@fb.com,
        yao.jin@linux.intel.com, changbin.du@intel.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] perf annotate/tui: Re-render title bar after
 switching back from script browser
Message-ID: <20200227131100.GB9899@kernel.org>
References: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
 <20200213064306.160480-2-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213064306.160480-2-ravi.bangoria@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 13, 2020 at 12:12:59PM +0530, Ravi Bangoria escreveu:
> Perf annotate tui browser provides a hot key 'r' to switch to script
> browser. But the annotate browser title bar becomes hidden while
> switching back from script browser. Fix it.

Reproduced, tested fix, applied, thanks.

- Arnaldo
 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  tools/perf/ui/browsers/annotate.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index badbddbb30f8..0dbbf35e6ed1 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -754,10 +754,9 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  		"?             Search string backwards\n");
>  			continue;
>  		case 'r':
> -			{
> -				script_browse(NULL, NULL);
> -				continue;
> -			}
> +			script_browse(NULL, NULL);
> +			annotate_browser__show(&browser->b, title, help);
> +			continue;
>  		case 'k':
>  			notes->options->show_linenr = !notes->options->show_linenr;
>  			break;
> -- 
> 2.24.1
> 

-- 

- Arnaldo
