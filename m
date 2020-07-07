Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A54EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7EF3206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDpGjwrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgGGPfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgGGPf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:35:29 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B889C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 08:35:29 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j19so13307661pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FubiaJrJ/ejtjKW9q0vU+V2MToP8DXY+XUIRZUJinp8=;
        b=fDpGjwrr9PbxsqA9cOKIZCO9++B3t8yE7X3wFtUdSvnwuOSuA/ciPhpme3sBYfY9Qy
         2twgcO/+i43ksLjp+auYoXYzztBJemEitU6isiEdS2WHqp9+V4RbGb6soj2TUTQ5AG4S
         lEcP2OdKa4iy/x5u/nOcTi259UG24jMuLAEFVZBNiHvzdEUVg0gLijlKTFXwfHj3sEzH
         WAQ2+Aw+qI9KaoFewznJRFD69JlPiisgZJ71gbXlv4l+4jfDSxF/jZLPGWEnwVLwHWEL
         2/v7/gdmZFCMSJExmXi+K9zMIqCRYqNcg4t+0fO/F/ZnsQZ7RbQfzz4SO9fh5sXHL6Jj
         V02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FubiaJrJ/ejtjKW9q0vU+V2MToP8DXY+XUIRZUJinp8=;
        b=dU2fW51wzKDJM7Rs0tWq+WmkDUEnAqMRiuBSHwE6MfnRbncsnRHmrtrlMbJMnZSeyF
         +VkUv5JdPWtH61sZMJtIQPg498KveaY4KzubS3V+MrETeThnv8cfFm72QDVPsMpfM4SN
         7Svn4RCDTO3GGV8qtvwgbKEJ65g6rMtzBK20wFiKOLzlHZhK+TvGDU1EiqlcX9SVrzWf
         TdwzmZXLx17sHdzWB2Nb9SF2jpHAqhZgumBX82IFYhrSDL8fs2pzg1YZIJWpyhfQh41N
         6EM9A24/nol21IBZ6XdtZ/lt39kmLgRxsntIFEL0k8TDbaXM2sGwSTfZRcCDhazWpVtS
         cVYw==
X-Gm-Message-State: AOAM533IAVrOdSspk5QQFcE+f4B8/iUGrt2kk3giilQTAExKy6h972jm
        c/CfMUumWKTm9uopIaf7MVs=
X-Google-Smtp-Source: ABdhPJxfDRkoabybBrIBVSG5Vg6B1nRTmRF9OWfqRj7CS3EeQRWMW7xDlvyYADkw+MurDMSfrck2sA==
X-Received: by 2002:a63:e057:: with SMTP id n23mr44598167pgj.368.1594136129095;
        Tue, 07 Jul 2020 08:35:29 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q6sm22773719pfg.76.2020.07.07.08.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:35:27 -0700 (PDT)
Date:   Tue, 7 Jul 2020 23:35:14 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/15] perf ftrace: add support for trace option
 sleep-time
Message-ID: <20200707152539.ldhgqf6vmnttqnfn@mail.google.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
 <20200627133654.64863-11-changbin.du@gmail.com>
 <CAM9d7chsn9_5FBR5nPW_gc+k0hq9whOGSa67uZ2XKzM147OaLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chsn9_5FBR5nPW_gc+k0hq9whOGSa67uZ2XKzM147OaLg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 03:40:59PM +0900, Namhyung Kim wrote:
> On Sat, Jun 27, 2020 at 10:38 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > This adds an option '--graph-nosleep-time' which allow us only to measure
> > on-CPU time. This option is function_graph tracer only.
> 
> I'd suggest --graph-sleep-time instead and set it by default.
> Then we can have --no-graph-sleep-time as well.
>
If so can we make --graph-sleep-time as default. Seems there is no something
like OPT_BOOLEAN_DEFAULT().

> By the way,  didn't we agree to have something like --graph-opts instead?
>
As I mentioned in previous version, --graph-opts make the parsing a little
complex.
	--graph-opts depth=<n>,nosleep_time,noirqs,no_tail,verbose

While the exsiting style is '--graph-depth <n>'. The cons is we must type more
characters. The pros is don't need to reimplement parsing and align with old
behaviour.
	--graph-depth <n>
	--graph-nosleep-time
	--graph-noirqs
	--graph-notail
	--graph-verbose

> Thanks
> Namhyung
> 
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> >

-- 
Cheers,
Changbin Du
