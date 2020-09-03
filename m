Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEB7C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EDA320658
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599144929;
	bh=KHtF6jW1yNs+WtMsJ/s62xUsUZPXDaPrniUf4rMYIN8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=voPNi57t1opLOT6b4vaHCzStPGErQL2D2HzwyeJhnKGAxMOQFDzda3s9yQnowhhNr
	 5+nHtRcomw6VprDerJuwplUmh0jrAC7rcAEjgfvvUtbygJrJYllb8MB7ra/DcZ5wPN
	 0LxYoVJfJvcUXv2Z3IvrFD/jLwcIM+GmuET1RadQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgICOzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:55:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54974 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbgICOzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:55:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id s13so3194982wmh.4;
        Thu, 03 Sep 2020 07:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHtF6jW1yNs+WtMsJ/s62xUsUZPXDaPrniUf4rMYIN8=;
        b=RBbGhobigFtZvL0OH80J/t7NBPn6u+mORZz/q457iQ1sbf3Q60sa3LzPCfIj3bjwTk
         dd5WLdFXE4wOQeyNk+d4jI5sqe1fdBJsT4L4idlaSJLJt0RHriq+ZAZfQq7XWk9jvaQo
         nakZVnApwQlL0d7+eZA0Yp9VPtt7FXnn+cbrjc/27NtBoCsLuVesfL8UTIuUMWrIuM2h
         xxhUqcb09M4YxFRXlQ8R4trX5aFHbNgqteK16EaNZ7ITxk+GRrKNPUgB0HXUGDgO+gmZ
         pmu69vzMIB0RE5mxGxtkKoVvnbyPmg3o0cVMJ96TGt/vk4noPK+EY2D9BXwv9XBPnSxr
         t6bw==
X-Gm-Message-State: AOAM531sd1mNerp28DDhlVI93dOE/XFBuuphJFq0cs/A18BSOrEfF5z/
        Rlsy5LFxW7n620W/RBTXe6pOXcJjPdVt0Zp9b5c=
X-Google-Smtp-Source: ABdhPJxNlZ3fYDfWt0ezkCFud5BJi/ASATE3oyFZhcJGRRvQ1f/+9eTQFq2L5x6zIS/2tg7mwRaqoIwUvd7AN34N+QY=
X-Received: by 2002:a1c:f311:: with SMTP id q17mr3011868wmq.92.1599144905348;
 Thu, 03 Sep 2020 07:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200902160439.335232-1-kjain@linux.ibm.com> <20200902160439.335232-3-kjain@linux.ibm.com>
In-Reply-To: <20200902160439.335232-3-kjain@linux.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 3 Sep 2020 23:54:54 +0900
Message-ID: <CAM9d7cjDRGDuZhbZ1BJ2tF_hyrS0-b61kaL2=0VHtSFUcJN7sg@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] perf/jevents: Add new structure to pass json fields.
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        pc@us.ibm.com, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Yao Jin <yao.jin@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com, John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 3, 2020 at 1:05 AM Kajol Jain <kjain@linux.ibm.com> wrote:
>
> This patch adds new structure called 'json_event' inside jevents.h

jevents.c ?

Thanks
Namhyung

> file to improve the callback prototype inside jevent files.
> Initially, whenever user want to add new field, they need to update
> in all function callback which make it more and more complex with
> increased number of parmeters.
> With this change, we just need to add it in new structure 'json_event'.
>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
