Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1606FC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81AD206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY+idMKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgA3K6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:58:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37770 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgA3K6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:58:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so3493281wru.4;
        Thu, 30 Jan 2020 02:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TMkBPNx4tlOEBLo19VNSn0NNnvYXgDlZZJMKD8FB0Ss=;
        b=RY+idMKqBCsveQUC4su1JvIbA/sYrL4V3xlMZAeLQZZhjRb3SB+DoMFBcJh3Ee0c02
         E6fjK8R+a7bJecsyTiu1dX36m02RO6BnDH71QDqtRk/qGvJDO9K2W8p2MvPMogQKNF7m
         vOn3ZQ0Ua/asU/3j0IdGyF8Nk0D/+0UhQ2F2zc+Yox7WEr/gXO6jf6LxrHa4Lse+C0mT
         CM9qOqhpw6PyadA/MiIJjAf/crD+m9JeEMYvdwloklrsJIVT1zq1Zd59VeYIvmI+u0i4
         +JlT2pAlmqecIp965lCVRyd3S1PUUdN1ytv6TNsn7FVy0q4AdihWQ3Y/vZVM2IXof34e
         1ZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TMkBPNx4tlOEBLo19VNSn0NNnvYXgDlZZJMKD8FB0Ss=;
        b=WfqwzP5ZVyCJq/CyF/BP/G3zDrtK0/TYXDn06enIbYJ3eIg0ZvmW3rbI+G8Wqns0Cm
         iHVA1F3v21iU9J5WX1D0wY2D0D5lCB5RfibxsY3jxrj5MeGVPl4+xtwXlCBh6P1DCTRO
         IFcFEm1egxriuItGopAKFvk0rfcR+1W6s+Ogh5Z53NciPQqZPojV6vFw0Xn6hSS3YhVK
         JEBQUxf/vKOWDIvd+rnk27Yp3wd6TCmBgEycjUCnvJx4Ri2pCbHDVGVtadBZRf98Vte7
         6zTJypywbfaR3GUczaxN5GzXPRHD2+h5NGDucquzdM5S+v+jpJ8EJLwI3pr7T+bLmLsD
         csTg==
X-Gm-Message-State: APjAAAUe+sk0o8KpLg+3sePIOhpbo5yaG/XSD5lysa7DsI6lY1OsZiUC
        qdXhWtoYryF+zG+M43YRzMU=
X-Google-Smtp-Source: APXvYqwaoP6tylUCVpTAMvvPyval1TMq+/59NbuAF4BPoU1W9Y3LSxFniwT1G6DpI0hQbNn37mokJw==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr5097629wrr.226.1580381886377;
        Thu, 30 Jan 2020 02:58:06 -0800 (PST)
Received: from quaco.ghostprotocols.net (20014C4D19C29300C4AE62814D0D5430.dsl.pool.telekom.hu. [2001:4c4d:19c2:9300:c4ae:6281:4d0d:5430])
        by smtp.gmail.com with ESMTPSA id a22sm6002589wmd.20.2020.01.30.02.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 02:58:05 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 627E040A7D; Thu, 30 Jan 2020 11:58:04 +0100 (CET)
Date:   Thu, 30 Jan 2020 11:58:04 +0100
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        borntraeger@de.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf test: Test case 66 broken on s390 (lib/traceevent
 issue)
Message-ID: <20200130105804.GD3841@kernel.org>
References: <20200124073941.39119-1-tmricht@linux.ibm.com>
 <20200124100742.4050c15e@gandalf.local.home>
 <20200125013153.46f05fc1f617fcd341e7060b@kernel.org>
 <20200124113610.662f4afb@gandalf.local.home>
 <659928a1-95b3-ed0d-7988-745d92b495d6@linux.ibm.com>
 <20200127105553.3cd92ef8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127105553.3cd92ef8@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 27, 2020 at 10:55:53AM -0500, Steven Rostedt escreveu:
> On Mon, 27 Jan 2020 08:34:23 +0100
> Thomas Richter <tmricht@linux.ibm.com> wrote:
> 
> > Steven and Masami,
> > 
> > thanks for the patch, it fixes this issue!
> 
> Thanks for letting me know. I'll add a:
> 
>   Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> 
> to the commit.

So you're taking it, right?

- Arnaldo
 
> > 
> > PS: I should have sent this description earlier, would have saved a week of debugging
> > on my side....
> 
> Heh, I do things like this ofter after triggering bugs in others
> code, and will spend a few days debugging it, then finding out that
> there's already a fix to the bug I find (or presenting the problem
> gives a proper fix). I just calk it up as a learning experience ;-)
> 
> -- Steve

-- 

- Arnaldo
