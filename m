Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C903C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46AE920659
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgFDUGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:06:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49790 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgFDUGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:06:30 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1jgw8B-0000Vx-QH
        for linux-kernel@vger.kernel.org; Thu, 04 Jun 2020 20:06:27 +0000
Received: by mail-io1-f70.google.com with SMTP id l19so1198517iol.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t8BNrQ5EvO5CN1P54SLRxErq24g55GKkGlzRsUwueE8=;
        b=NZUmGGYllPwJW/7yLbnSfcm5efBaD61Z3aj9vPB6vURoH/D49TSKpMqbb8vwY/lBhe
         HVJbt4hzfxBPIc8rqGOAkGtPgByfUcfCUGwiTx3oPJkSOLIX+ZW7cNpADf0k4LajsD6D
         Ql+E4TfLBk7sd3188O/AEI2Ias8pCsEhoH/Wx2NzzxsaD9vbcncGJgNDVl+Evfmw6G8g
         XngUOw4geaIcUImGHSIOso1fq6jAwrhksxPdQM/ql4WoOxoE3dZ2AWw8afT+49Oe7X1P
         /o1YbTX7O8ylFpkZRxBktkYOCm93kAwDdXHzQnjSYUvCWK1/i+fEPQqM4pTDhNoHq5Si
         l4Bg==
X-Gm-Message-State: AOAM530jjbnGbD3QR727ZyRbV7+WCnKsxZjX2gIi4Cz9JWBQBZKFG+5k
        TqFEvgmo+NcbRpaD/TQMlhPq/5e9d8dYwKlmk6Nmcwvk3xduzKuGpagkuTJgLMMQa1Iu+Au9Z/Z
        BN3yxKF6CJkoN2fLiJe2MkkKMSvtaTqjdxJUu1nRBOg==
X-Received: by 2002:a6b:5915:: with SMTP id n21mr5546984iob.103.1591301186521;
        Thu, 04 Jun 2020 13:06:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbV+LEUf9tEApQ5CzjTpzWgDtZ35W682RhC2YNRXKY30uEF3BNkNH92/6pREx1x5YaL+IOGQ==
X-Received: by 2002:a6b:5915:: with SMTP id n21mr5546945iob.103.1591301185990;
        Thu, 04 Jun 2020 13:06:25 -0700 (PDT)
Received: from localhost ([2605:a601:af9b:a120:2dfd:d485:5170:5d43])
        by smtp.gmail.com with ESMTPSA id z13sm1890628ilh.82.2020.06.04.13.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 13:06:25 -0700 (PDT)
Date:   Thu, 4 Jun 2020 15:06:24 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/ftrace: Use printf instead of echo in
 kprobe syntax error tests
Message-ID: <20200604200624.GD5650@ubuntu-x1>
References: <20200304222009.34663-1-seth.forshee@canonical.com>
 <20200529203704.GA57013@ubuntu-x1>
 <de431b0e-6337-b95a-15c5-1c0c6abe697e@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de431b0e-6337-b95a-15c5-1c0c6abe697e@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 03:26:06PM -0600, Shuah Khan wrote:
> On 5/29/20 2:37 PM, Seth Forshee wrote:
> > On Wed, Mar 04, 2020 at 04:20:09PM -0600, Seth Forshee wrote:
> > > Test cases which use echo to write strings containing backslashes
> > > fail with some shells, as echo's treatment of backslashes in
> > > strings varies between shell implementations. Use printf instead,
> > > as it should behave consistently across different shells. This
> > > requires adjustments to the strings to escape \ and % characters.
> > > ftrace_errlog_check() must also re-escape these characters after
> > > processing them to remove ^ characters.
> > > 
> > > Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> > 
> > Ping. Someone just asked me about this patch, and I noticed that it
> > hasn't been applied or received any feedback.
> > 
> 
> I pulled in this patch from Masami:
> 
> selftests/ftrace: Use printf for backslash included command
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=next&id=8e923a2168afd221ea26e3d9716f21e9578b5c4d
> 
> Looks like a duplicate.
> 
> Seth,
> Is your patch still needed?

Nope, Masami's patch seems to fix the issues addressed by my patch.
Thanks!
