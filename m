Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD435C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA9320757
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOFpITAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgD1RuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgD1RuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:50:08 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764E1C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:50:08 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c63so22725356qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IO10IaEZnZ3+2CD5x/8DkaNmjwG6l+xlu6W8mVUoegQ=;
        b=YOFpITAAgodND7TYQsJ1rrh55GlKANe+tM8iX2EwqRMLPdEiS9Wo4eQMBVyI0OlM33
         XG5yeygKJdBRM+nJqfG2GbCMwbrz+2KvJuoGf984AtdtcLLSprEUAaGHwkjEJTcadnuO
         1GxWop+jQsNFpmQWZiRrVPVUoEnBCMMV7imI0J7KhdAygf4nidkf4QfckKKgYohJOV21
         43u6JAg8+AAdhdoIp90Uh+Fx4cAa3/XmmONGIJCXlBNWLa8IhKKSFNR8Jnk0RTfvtKrS
         bnjzMGLdfbIEN7ewp90Q0rFKFh5dzDgu+qxmTdM57XV8wkMwZT9aA2+10HVQBk0Ptflv
         yPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IO10IaEZnZ3+2CD5x/8DkaNmjwG6l+xlu6W8mVUoegQ=;
        b=FaxsjXl3WkhOtlIbb92dbVdKt6kefHPXYU948xluaTu0JiI7W/UjwESiXH2RywI+qB
         Qdn5czP7JmOAhtl1A/23Q4haG9G425w7mR+kY84D0NOjU/SdD9eWrT1tbS8H0ZubRBGy
         Hqo1EI4a34iVvvq3EjqcKU5OGL7LbeM+8wrJZfUzzY8Ci8+rXhvoV1oieBsC/2anUSNk
         VVCIZARRiJHOEYWoWJkFCCEwxeYeSUvQlypvcOBbH/jO+uo6fMaw+MQqzU6516/XFrTP
         sXMk8D5ZMMkc6O8YNjm4E5fJOxStEWR7q/Y4dSJIW4Gk5b3V9TqWC2AqgcR2Y5IaMzHJ
         rEaQ==
X-Gm-Message-State: AGi0Pub+WwcBP8+bapUAl1KtIQXABI+paCjb/ruo1b4J382cdsNVthu4
        9LtiPGJEfpBVHd+mDK1p6/8=
X-Google-Smtp-Source: APiQypK6A6qu5+Y8OFMa14BEt1MJpLR+NTGN9Uf6EUPl0nbSigFkjAhNbVKaEoDUqauUNz9E4HCSaA==
X-Received: by 2002:a37:a702:: with SMTP id q2mr27949790qke.150.1588096207645;
        Tue, 28 Apr 2020 10:50:07 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id h13sm12401160qti.32.2020.04.28.10.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 10:50:07 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 37B6F409A3; Tue, 28 Apr 2020 14:50:05 -0300 (-03)
Date:   Tue, 28 Apr 2020 14:50:05 -0300
To:     Zou Wei <zou_wei@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] perf tools: Remove unneeded semicolon
Message-ID: <20200428175005.GC5460@kernel.org>
References: <1588065523-71423-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588065523-71423-1-git-send-email-zou_wei@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 28, 2020 at 05:18:43PM +0800, Zou Wei escreveu:
> Fixes coccicheck warnings:
> 
> tools/perf/builtin-diff.c:1565:2-3: Unneeded semicolon
> tools/perf/builtin-lock.c:778:2-3: Unneeded semicolon
> tools/perf/builtin-mem.c:126:2-3: Unneeded semicolon
> tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c:555:2-3: Unneeded semicolon
> tools/perf/util/ordered-events.c:317:2-3: Unneeded semicolon
> tools/perf/util/synthetic-events.c:1131:2-3: Unneeded semicolon
> tools/perf/util/trace-event-read.c:78:2-3: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Thanks, applied.
