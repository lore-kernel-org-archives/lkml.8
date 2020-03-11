Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F177BC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A2520873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmVgK6BA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbgCKODS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:03:18 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46192 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbgCKODS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:03:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id t13so1572854qtn.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mlO4uI2WIdTpnINGbX1YTXFE7bC/viLKMH2J9Umxr10=;
        b=ZmVgK6BA6gMFFAgS+3++b6unF0+kXNgrS0goxZGRmWPJyeaAEocJks8DnlrVO0UWg+
         QOCSxdY/ti+BM1cTWkYwRh0YKP6GT4sMEmq3Xhu/hhEsXF2Th9T1Xe9ME+yINE5UqMnz
         Pt/1+lQDeNiUojELXpC2g5PL/RiFTzOt25IyWJ2raeezMlPV/mbG6+Bmpz1jn7o3IlhP
         jalznpwtXJDx9IeNrIh2MS+UNLConv2LSBNJc2GCjVMxJHaFzzKGROqgaEz2ucn0569t
         0x/gg8NDV7x+uOgZoLDIygonr+hGWwwPTnqhBlBNQnatzb0XoKZ/8RDhysdHLx6EJ2Xj
         nLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mlO4uI2WIdTpnINGbX1YTXFE7bC/viLKMH2J9Umxr10=;
        b=jXFvshAVo6Wo8j4wMVFVfsJgPH0xc7TXD7FXBA9Fv876hpEI7whkp7f1M3WH6vYNYc
         3idd55CjZPe2G0g90+FBTzJ0UsnOIRbFAAlnJGMFhIIUYAqzxYLOmurqhFrrSrdAu24D
         gzagHFPTXJVuZFSr15QgzkTwjNLA2bgtLaHqYpXrwA1S89RbCNd7cr/38k7jYBXlV1Si
         iPsPLHcFxUIOhYJoVfZuC03s7fEV2oSWn5NUQn1pS+tzb9vncUBcZ8lmoG0y3OIIkKaL
         5Zd2t9FsXoFUM3600+vJd2GL6s+xe1NO2tzIyud6rNiBP9gqkxkXpIxJnSVFgLWafNoa
         bb7w==
X-Gm-Message-State: ANhLgQ1e2N43bLHpyOpkAbCCjtBVqqZ7yBBVoTdmQVg+3oYRV6irzLly
        BIuJ2PpGnYldK+P5Tqo53r4=
X-Google-Smtp-Source: ADFU+vuZBpl3thsCBc3rcX+aqWfYr3wuEO1NRB3lStZifkeOHayDz/TPXtS2TdK2T21X01T2giXlXg==
X-Received: by 2002:ac8:4906:: with SMTP id e6mr2803718qtq.178.1583935394980;
        Wed, 11 Mar 2020 07:03:14 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id u13sm25106109qtg.64.2020.03.11.07.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 07:03:14 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2A69640009; Wed, 11 Mar 2020 11:03:12 -0300 (-03)
Date:   Wed, 11 Mar 2020 11:03:12 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf intel-pt: Update intel-pt.txt file with new
 location of the documentation
Message-ID: <20200311140312.GE19277@kernel.org>
References: <20200311122034.3697-1-adrian.hunter@intel.com>
 <20200311122034.3697-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311122034.3697-4-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 11, 2020 at 02:20:34PM +0200, Adrian Hunter escreveu:
> Make it easy for people looking in intel-pt.txt to find the new file.

Nice, consider making it possible to do:

$ man intel-pt

And it go to what now is:

$ man perf-intel-pt

Applied the set,

Thanks

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/Documentation/intel-pt.txt | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/perf/Documentation/intel-pt.txt
> 
> diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
> new file mode 100644
> index 000000000000..fd9241a1b987
> --- /dev/null
> +++ b/tools/perf/Documentation/intel-pt.txt
> @@ -0,0 +1 @@
> +Documentation for support for Intel Processor Trace within perf tools' has moved to file perf-intel-pt.txt
> -- 
> 2.17.1
> 

-- 

- Arnaldo
